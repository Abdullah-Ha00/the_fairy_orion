extends Bug
var damage_debuff_sound:String = "res://audio/sfx/retro-spell-sfx-85574.mp3"

func decrease_fairy_stats():
	GlobalStats.fairy_node.beam_damage -= 3
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node, Color.SEA_GREEN)
	GlobalFunctions.play_sound(damage_debuff_sound,10)
