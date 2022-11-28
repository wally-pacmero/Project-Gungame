#!/usr/bin/env python

from os import path, rename, walk
from re import sub
import json5
import yaml

print("You have to manually put the comments back in :(")

# Checking input
conv = input("type 0 to convert all json to yaml, type 1 to convert all yaml to json: ")
if conv in ["0", "1"]:
	conv = conv == "0"
else:
	print("Invalid option")

# Check if in pgg folder
if path.isdir("../resources"):
	print("found resources folder")
else:
	print("resources not found! Is this file in the Project-Gungame/utils directory?\nAborting")
	exit()

keep = input("keep comments? (Y/n): ") != "n"

for directory in walk("../resources"):
	for file_name in directory[2]:
		if conv:
			if file_name.endswith(".json"):
				fp = directory[0] + "\\" + file_name
				print("converting", fp)
				with open(fp, "r") as f:
					comments = "".join([i.replace("//", "#", 1) for i in f.readlines() if i.lstrip().startswith("//")])
					f.seek(0)
					data = json5.loads("".join([i for i in f.readlines() if not i.lstrip().startswith("//")]))
				with open(fp, "w") as f:
					if keep:
						f.write(comments + ("\n" if comments else "") + yaml.dump(data, sort_keys=False))
					else:
						f.write(yaml.dump(data, sort_keys=False))
				rename(fp, sub(r"\.json$", ".yaml", fp))

		else:
			if file_name.endswith(".yaml"): # or file_name.endswith(".yml"):
				fp = directory[0] + "\\" + file_name
				print("converting", fp)
				with open(fp, "r") as f:
					comments = "".join([i.replace("#", "//", 1) for i in f.readlines() if i.lstrip().startswith("#")])
					f.seek(0)
					data = yaml.safe_load(f)
				with open(fp, "w") as f:
					if keep:
						f.write(comments + ("\n" if comments else "") + json5.dumps(data, indent=4, sort_keys=False))
					else:
						json5.dump(data, f, indent=4, sort_keys=False)
				rename(fp, sub(r"\.yaml$", ".json", fp))
