exec('''<?php
file_put_contents($f="id.py",
<<<PYTHON
#!/usr/bin/env python
"""
tutorial/test for ID system

btw all the classes here are just prototypes, not for actual use.
unless its good enough and actuall .png resource management is added.
currently it only is checking names and matching them.

# @todo get tile by ID and Name
# @todo open image from ID or Name
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


class resourceHandler(dict):
	def byID(self, ID): return self[ID]


@dataclass
class tile:
	def __init__(self, id: int, name: str, category_path: str):
		""" 'loads' image into memory """
		self.id = id
		self.name = name
		self.image_path: str = category_path + "/" + name + ".png"
		#super().__init__() # call the original __init__ of the @dataclass
		try:
			with open(self.image_path, "rb") as f:
				self.image = base64.b64encode(f.read())
		except FileNotFoundError:
			self.image = None

	def __repr__(self):
		self.name

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
		for ID, name in enumerate(data["list"]):
			ID += id_offset
			if type(name) == list:
				self.tiles[ID] = tile(ID, name[0], name[1])
			else:
				self.tiles[ID] = tile(ID, name, data["dir"])
		

class tileHandler(resourceHandler):
	def p(s, *_): print(*_)
	""" singleton handler class for all tiles """
	def __init__(self, raw: str, debug = False):
		self.raw: str = raw
		self.name_list: list = self.id_flatten() # Get name of tile by ID
		self.category: dict = {}

		if not debug:
			self.p = lambda *_: None

		try:
			self.data: dict	= yaml.safe_load(raw)
		except Exception as e:
			print(e)
			exit("Invalid yaml")

		invalid_categories: list = []
		for name, value in self.data.items():
			try:
				offset = sum([i.list for i in list(self.category.values())], []).__len__()
				self.category[name] = tileCategory(offset, value)
			except KeyError:
				# KeyError from self.dir: str = data["dir"] from tileCategory.__init__
				invalid_categories.append(name)
		if invalid_categories: exit(
			"There are categories with invalid structures."+chr(10)+
			"Bad categories:"+chr(10)*2+ chr(10).join(invalid_categories)
		)

		self.missing = self.load_all()


	def id_flatten(self) -> Dict[int, str]:
		""" enumerates all ids from the top of the .yaml file """
		# return [
		# 	line[5:].strip() for line in self.raw.split(chr(10))
		# 	if line[:5] == "    -"
		# ]
		
		tiles = []

		for line in [line for line in self.raw.split(chr(10)) if line[:5] == "    -"]:
			line = yaml.safe_load(line[5:])
			tiles.append(
				line[1] if type(line) is list else line
			)

		return tiles


	def load_all(self) -> list:
		""" 'loads' all resources, Empty list on success """
		missing = []
		for name, cat in self.category.items():
			self.p(fg.y(name))
			self.p(" at dir: "+fg.B(cat.dir+"/"))

			for tile in cat.list:
				if tile == "air": continue

				loc = '"'+cat.dir+"/"
				loc += tile if type(tile) is str else (tile[0]+"/"+tile[1])
				loc += '.png"'

				if not (path.isfile(loc.strip('"'))):
					# raise FileNotFoundError(loc)
					missing.append(loc)
					self.p(fg.r("! \t"+loc))
				else:
					self.p("\t"+fg.g(loc))
		
		return missing


	def print_missing(self) -> bool:
		""" Print out missing tiles from load_all. True for OK """
		if self.missing: self.p(chr(10)+"missing: ")
		else: self.p("All tiles found")
		for i in self.missing:
			self.p(i)

		return not bool(self.missing)


def interactive(tileHandler: tileHandler) -> None:
	""" Interactive tile testing """

	def open_img(ID: int):
		return NotImplemented
		Image.open(BytesIO(ID)).show()

	inp = "help"
	while inp:
		inp = inp.strip()
		if "exit" in inp:
			exit()
		elif inp in ["help", "help()", "?", "/?","/help",
			"-?", "-help", "--?", "--help"]:
			print(chr(10)+"type number or name of tile to open the image")
			print("type exit or nothing to quit")
		elif inp.isdigit():
			try:
				print("Tile name: "+tileHandler.name_list[int(inp)])
			except IndexError:
				print("IndexError, Tile not found")
				continue
			if input("Type anything to show "):
				open_img(int(inp))
		else:
			print("Unknown command: "+inp)
		inp = input(fg.M("> "))

if __name__ == "__main__":
	try:
		with open("id.yaml", "r") as f:
			raw = f.read()
	except FileNotFoundError:
		print("id.yaml missing")

	tileHandler = tileHandler(raw, debug=pprint)

	if pprint: print(chr(10)+"Flattened into: ")
	pprint({i:j for i,j in enumerate(tileHandler.name_list)})

	# todo: display tileHandler.category stuff and more

	print(fm["u"](fg.G(chr(10)+"test successful!")))

	if "php" not in argv: interactive(tileHandler)

PYTHON
);
echo '<pre>'.preg_replace("/\033\[[[:digit:]]*./m", "", shell_exec("python ".$f." php"))."</pre>";
unlink(realpath($f));
?><style>body{color:transparent;user-select:none;}pre{color:initial;user-select:text;}</style>'''[46:-223])
