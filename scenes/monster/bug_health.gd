extends Bug

func decrease_fairy_stats():
	GlobalStats.fairy_node.health -= 3
	GlobalStats.fairy_node.update_health_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node)
