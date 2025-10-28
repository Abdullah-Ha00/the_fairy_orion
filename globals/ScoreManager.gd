extends Node
var save_file = "user://savefile.cfg"

func save_score(score:int,level:String) -> void:
	var score_config = ConfigFile.new()
	score_config.load(save_file)
	var high_score = score_config.get_value(level, "HighScore", 0)
	if score >high_score:
		score_config.set_value(level, "HighScore", score)
		score_config.save(save_file)
		
	else:
		pass

func load_score(level:String):
	var score = ConfigFile.new()
	var err = score.load(save_file)
	if err == OK:
		return score.get_value(level, "HighScore", 0)
	else:
		return 0

func save_battle_unlock():
	var battle_unlock = ConfigFile.new()
	battle_unlock.set_value("Battle", "ch0lv2", 1)
	battle_unlock.save(save_file)
	
func load_battle_unlock():
	var load_battle_flag = ConfigFile.new()
	var err = load_battle_flag.load(save_file)
	if err == OK:
		return load_battle_flag.get_value("Battle", "ch0lv2",0)
	else:
		return 0
	


	
