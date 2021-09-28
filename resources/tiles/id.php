exec('''<?php
// $ py id.php works ok
file_put_contents($f="id.py",
<<<PYTHON
#!/usr/bin/env python
"""
tutorial/test for ID system

btw all the classes here are just prototypes, not for actual use.
unless its good enough and actuall .png resource management is added.
currently it only is checking names and matching them.

# @todo [Further tileHandler class testing by Import. But I'd rather
		spend that time in C# in Unity...]
"""

if "Console colour formatter classes from another project":
	__builtins__.__import__("os").system("color") # Activator
	letters= list(enumerate(
		["k", "r", "g", "y", "b", "m", "c", "w",
		"K", "R", "G", "Y", "B", "M", "C", "W"]
	))

	"""
		Console text formatter
			Usage:
				fm[int]("string")
			0 = reset
			1 = bold
			2 = darken
			3 = italic
			4 = underlined
			5 = blinking
			6 = un-inverse colour
			7 = inverse colour
			8 = hide
			9 = crossthrough
	"""
	fm = {i: ("\033["+str(j)+"m{}\033[0m").format for i, j in
	zip([*range(10), "r", "b", "u", "i"], [*range(10), 0, 1, 4, 8])}

	class fg:
		"""
			Console foreground colouriser
			Usage:
				fg.color("string")
			k = black
			r = red
			g = green
			y = yellow
			b = blue
			m = magenta
			c = cyan
			w = white

				fg.d["colour"]("string")


			capital = light
		"""
		d = {}
		for num, letter in letters[:8]:
			d[letter] = "\033[{}m{}\033[0m".format(num+30, "{}").format
			exec(letter+"= d['"+letter+"']")
		for num, letter in letters[8:]:
			d[letter] = "\033[{}m{}\033[0m".format(num+82, "{}").format
			exec(letter+"= d['"+letter+"']")

	class bg:
		"""
		Console background colouriser
			Usage:
				bg.color("string")
			k = black
			r = red
			g = green
			y = yellow
			b = blue
			m = magenta
			c = cyan
			w = white

				bg.d["colour"]("string")


			capital = light
		"""
		d = {}
		for num, letter in letters[:8]:
			d[letter] = "\033[{}m{}\033[0m".format(num+40, "{}").format
			exec(letter+"= d['"+letter+"']")
		for num, letter in letters[8:]:
			d[letter] = "\033[{}m{}\033[0m".format(num+92, "{}").format
			exec(letter+"= d['"+letter+"']")


try:
	import yaml
except Exception:
	exit("Requires pip install pyyaml")

try:
	from pprint import pprint
except Exception:
	print("pprint module not found.")
	class _: __call__=__bool__=__nonzero__=lambda s, *_: False # CONSUME
	pprint = _()

import base64
from io import BytesIO
from PIL import Image
from os import path
from sys import argv
from dataclasses import dataclass
from typing import *

nl = chr(10)
""" PHP compatibility.
#	We don't want the PHP interpreter to expand the \n As it could misplace statements after it,
#	such as the part just above out of a comment into the next line.
#	(not needed if inside a multiline string)

# ... the \n As it ...

# Into

# ... the
  As it ... <-- causes exception!
"""

def get_yaml(file_name: str = "id.yaml") -> str:
	if not file_name: exit()
	try:
		with open(file_name, "r") as f:
			return f.read()
	except FileNotFoundError:
		print(fg.r("id.yaml not found"))
		return get_yaml(input("Location: "))

class resourceHandler(dict):
	def byID(self, ID): return self[ID]


@dataclass
class tile:
	def __init__(self, id: int, name: str, category_path: str):
		""" 'loads' image into memory """
		self.id = id
		self.name = name
		self.path: str = category_path + "/" + name + ".png"
		#super().__init__() # call the original __init__ of the @dataclass
		try:
			with open(self.path, "rb") as f:
				self.image = base64.b64encode(f.read())
		except FileNotFoundError:
			self.image = None

	def __repr__(self) -> str:
		return self.name

	def __add__(self, other, r=False):
		if type(other) not in [str, self.__class__]: raise NotImplementedError
		return (str(other)+self.name) if r else (self.name + str(other))
	def __radd__(self, other):
		return self.__add__(other, r=True)
	__str__ = __repr__


class tileCategory(dict):
	""" for each category in the tiles yaml """
	def __init__(self, id_offset, data: dict = None):
		if data is None: return

		# super strict check, don't need.
		# these two are from the yaml
		if list(data.keys()) != ["dir", "list"]: raise KeyError

		self.dir: str = data["dir"]
		self.list: list = [
			i.strip() if type(i) == str else i for i in data["list"]
		]
		# self.list = [tile(ID, name, data["dir"]) for ID, name in self.list]

		self.tiles: Dict[int, tile] = {}

	def delete_category(self, name: str) -> None:
		del self[name]
	
	def new_category(self, name: str, data) -> None:
		self[name] = data

class tileHandler(resourceHandler):
	def p(s, *_): print(*_)
	""" singleton handler class for all tiles """
	def __init__(self, raw: str, debug = False):
		self.raw: str = raw
		self.name_list: list = self.load_by_name() # Get ID by name
		self.category: dict = {}
		self.tiles: dict = {}

		if not debug:
			self.p = lambda *_: None

		self.data: dict	= yaml.safe_load(raw) # Will raise exception if invalid YAML

		invalid_categories: list = []
		self.missing = []
		for category, entry in self.data.items():
			# length of all previous lists combined
			offset = sum([i.list for i in list(self.category.values())], []).__len__()
			try:
				self.category[category] = tileCategory(offset, entry)
			except KeyError:
				# KeyError from self.dir: str = data["dir"] from tileCategory.__init__
				invalid_categories.append(category)
			else:
				for ID, tile_name in enumerate(entry["list"]):
					ID += offset

					# Adds new tile object to both tileHandler.tiles and category tiles
					self.tiles[ID] = \
					self.category[category].tiles[ID] = \
					\
					tile(ID, tile_name[0], tile_name[1]) \
					if type(tile_name) == list else \
					tile(ID, tile_name, entry["dir"])

					if self.tiles[ID].image is None:
						self.missing.append(self.tiles[ID].path)

		if invalid_categories: exit(
			"There are categories with invalid structures."+nl+
			"Bad categories:"+nl*2+nl.join(invalid_categories)
		)


	def load_by_name(self) -> Dict[str, int]:
		""" enumerates all ids from the top of the .yaml file """

		# return [
		# 	line[5:].strip() for line in self.raw.split(chr(10))
		# 	if line[:5] == "    -"
		# ]
		
		tiles = {}

		for ID, line in enumerate([line for line in self.raw.split(nl) if line[:5] == "    -"]):
			line = yaml.safe_load(line[5:])
			tiles[
				line[1] if type(line) is list else line
			] = ID

		return tiles


	def load_all(self) -> list:
		"""
		'loads' all resources, Empty list on success
		Scans for "    -" in yaml
		"""
		self.p(bg.b(fg.W(nl+"--LOADING ALL--")))
		self.p(fg.Y("Prepended ")+fg.r("exclamation mark")+fg.Y(" if missing"))
		missing = []
		ID = 0
		for name, cat in self.category.items():
			self.p(fg.y(name))
			self.p(" at dir: "+fg.B(cat.dir+"/"))

			for tile in cat.list:

				loc = '"'+cat.dir+"/"
				loc += tile if type(tile) is str else (tile[0]+"/"+tile[1])
				loc += '.png"'

				if not (path.isfile(loc.strip('"'))):
					# raise FileNotFoundError(loc)
					missing.append(loc.strip('"'))
					self.p(fg.r("! ")+str(ID)+fg.r("\t"+loc))
				else:
					self.p("  "+str(ID)+"\t"+fg.g(loc))

				ID += 1
		self.p(bg.b(fg.W(nl+"--LOAD ALL FINISH--")))
		return missing


	def print_missing(self) -> bool:
		""" Print out missing tiles from load_all. True for OK """
		if self.missing: self.p(nl+"missing: ")
		else: self.p("All tiles found")
		for i in self.missing:
			self.p(i)

		return not bool(self.missing)


	def report_all(self) -> bool:
		""" True once everything is OK """
		return (not self.missing == self.load_all()) and not self.missing



def interactive(tileHandler: tileHandler, yaml_location, original, _inp: list=None) -> None:
	""" Interactive tile testing """

	def open_img(image):
		# return NotImplemented
		Image.open(image.path).show()

	user: list = ["help"] if _inp is None else _inp[:0:-1] + ["help"]
	arged: bool= bool(_inp)

	if not arged: print(nl+fg.m("Entering Interactive Mode"))

	# List contains elements and the next one is not empty
	while user and user[-1].strip(): # user and (inp := user.pop.strip())
		inp = user.pop().strip()

		if "exit" in inp:
			exit()

		elif inp in ["help", "help()", "?", "/?","/help",
			"-?", "-help", "--?", "--help"]:
			print(
				"Type number or name of tile to open the image" +
				nl + "Type exit or nothing to quit"
			)


		elif inp.isdigit():
			try:
				print("Tile name of ID "+inp+": "+tileHandler.tiles[int(inp)])
			except IndexError:
				print("IndexError, Tile not found")
				continue
			if tileHandler.tiles[int(inp)].image is None:
				print("Image Missing")
			elif not arged and input("Type anything to show "):
				open_img(tileHandler.tiles[int(inp)])

		elif "check" in inp:
			if arged or input("Type anything to reload data "):
				tileHandler = original(get_yaml())
			print("Everything is OK" if tileHandler.report_all() else
				fg.Y("There are errors or data missing"))

		elif inp == "php": pass
		else:
			try:
				print("ID of name of "+inp+" is "+str(tileHandler.name_list[inp.strip()]))
				if arged or input("Type anything to show"): open_img(tileHandler.tiles[tileHandler.name_list[inp.strip()]])
			except KeyError:
				print("Unknown command: " + inp)

		if not arged: user = [input(fg.M("> "))]

if __name__ == "__main__":
	raw = get_yaml()
	
	_tileHandler = tileHandler(raw, debug=pprint)

	if pprint: print(
		nl+"Flattened into: "+nl+
		fg.Y("{")+nl+
		(","+nl).join(['  {}: "{}"'.format(fg.B(str(i)), j) for
			i,j in _tileHandler.tiles.items()])
		+nl+fg.Y("}")
	)

	_tileHandler.report_all()

	# todo: display tileHandler.category stuff and more

	print(fm["u"](fg.G(nl+"test finished!")))
	interactive(
		_tileHandler,
		raw,
		original=tileHandler,
		_inp = None if len(argv) < 2 else argv
	)
	del _tileHandler

PYTHON
);
// $_GET >> SHELL EXEC EXTREMELY DANGEROUS IF YOU HOST THIS ONLINE!!! localhost please!
// ?? is PHP>=8.0?
echo '<pre>'.preg_replace("/\033\[\d*./m","",shell_exec("python ".$f." php ".$_GET["args"] ?? ""))."</pre>";
unlink(realpath($f));
?><style>body{color:transparent;user-select:none;}pre{color:initial;user-select:text;}</style><form method="GET"><input name="args" placeholder="args, enter to submit"></form>'''[

69:420

*-1])
