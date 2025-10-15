extends Bug
func decrease_fairy_stats():
	GlobalStats.fairy_node.beam_damage -= 3
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node, Color.SEA_GREEN)
