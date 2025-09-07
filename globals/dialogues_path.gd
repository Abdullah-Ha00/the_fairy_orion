extends Node
var file:FileAccess = FileAccess.open("res://json_files/dialogues_dict.json", FileAccess.READ)
var dialogues:Dictionary = JSON.parse_string(file.get_as_text())
