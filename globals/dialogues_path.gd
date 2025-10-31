extends Node
var dialogues_file_ch0lv1:FileAccess = FileAccess.open("res://json_files/dialogues_dict.json", FileAccess.READ)
var dialogues_ch0lv1:Dictionary = JSON.parse_string(dialogues_file_ch0lv1.get_as_text())
var dialogues_file_ch0lv2:FileAccess= FileAccess.open("res://json_files/dialogues_dict_ch0lv2.json", FileAccess.READ)
var dialogues_ch0lv2:Dictionary = JSON.parse_string(dialogues_file_ch0lv2.get_as_text())
