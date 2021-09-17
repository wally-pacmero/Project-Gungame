exec('''<?php
file_put_contents($f="id.py",
<<<PYTHON
#!/usr/bin/env python
"""
tutorial/test for ID system

btw all the classes here are just prototypes, not for actual use.
unless its good enough and actuall .png resource management is added.
currently it only is checking names and matching them.

# todo: validate names to files
"""

try:
	import yaml
except Exception:
	exit("Requires pip install pyyaml")

try:
	from pprint import pprint
except Exception:
	print("pprint module not found.")
	class _: __call__=__bool__=__nonzero__=lambda s, *_: False
	pprint = _()

from os import path


class resourceHandler: ...

class tileCategory(dict):
	""" for each category in the tiles yaml """
	def __init__(self, data: dict = None):
		if data is None: return

		# super strict check, don't need.
		if list(data.keys()) != ["dir", "list"]: raise KeyError

		self.dir: str = data["dir"]
		self.list: list = map(str.strip, data["list"])


class tileHandler(resourceHandler):
	""" singleton handler class for all tiles """
	def __init__(self, raw: str):
		self.raw: str	= raw
		self.list: list	= self.id_flatten()
		self.category = tileCategory()

		try:
			self.data: dict	= yaml.safe_load(raw)
		except Exception as e:
			print(e)
			exit("Invalid yaml")

		invalid_categories: list = []
		for name, value in self.data.items():
			try:
				self.category[name] = tileCategory(value)
			except KeyError:
				# KeyError from self.dir: str = data["dir"]
				invalid_categories.append(name)
		if invalid_categories: exit(
			"There are categories with invalid structures."+chr(10)+
			"Bad categories:"+chr(10)*2+ chr(10).join(invalid_categories)
		)


	def id_flatten(self) -> dict:
		""" enumerates all ids from the top of the .yaml file """
		return [
			line[5:].strip() for line in self.raw.split(chr(10))
			if line[:5] == "    -"
		]


if __name__ == "__main__":
	""" No main function... still need to access global scope """
	try:
		with open("id.yaml", "r") as f:
			raw = f.read()
	except FileNotFoundError:
		print("id.yaml missing")

	tileHandler = tileHandler(raw)

	if pprint: print("Flattened: ")
	pprint({i:j for i,j in enumerate(tileHandler.list)})

	# todo: display tileHandler.category stuff and more

	print(chr(10)+"test successful!")
PYTHON
);
echo "<pre>".shell_exec("python ".$f)."</pre>";
unlink(realpath($f));
?><style>body{color:transparent;}pre{color:initial;}</style>'''[46:-140])
