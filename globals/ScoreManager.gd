extends Node
var save_file = "user://savefile.cfg"

func save_score(score:int) -> void:
	var score_config = ConfigFile.new()
	score_config.load(save_file)
	var high_score = score_config.get_value("Score", "HighScore", 0)
	if score >high_score:
		score_config.set_value("Score", "HighScore", score)
		score_config.save(save_file)
		
	else:
		pass

func load_score():
	var score = ConfigFile.new()
	var err = score.load(save_file)
	if err == OK:
		return score.get_value("Score", "HighScore", 0)
	else:
		return 0
	


	
