extends Node
var settings_file: String =  "user://settings.cfg"
func save_audio_volume(music, sfx):
	var audio_config = ConfigFile.new()
	audio_config.set_value("audio","music",music)
	audio_config.set_value("audio", "sfx", sfx)
	audio_config.save(settings_file)
	
func load_music_volume():
	var load_music = ConfigFile.new()
	var err = load_music.load(settings_file)
	if err == OK:
		return load_music.get_value("audio","music",0)
	else:
		return 1

func load_sfx_volume():
	var load_sfx = ConfigFile.new()
	var err = load_sfx.load(settings_file)
	if err == OK:
		return load_sfx.get_value("audio","sfx",0)
	else:
		return 1
