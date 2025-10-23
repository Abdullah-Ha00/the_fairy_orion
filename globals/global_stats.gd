extends Node
var score:int
var high_score:int
var dialogues:Dictionary ={
	"introduction":"intro",
	"monster":"second_phase",
	"parrot":"parrot_hurt",
	"fence":"fence_stopped"
}
var current_dialogue:String
var game_phases:Dictionary= {
	"begin":"normal",
	"monster_health_halved":"second_phase",
	"monster_health_zero": "win",
	"self_ally_defeated":"lose"
	
}
var current_game_phase:String
var dead_body: Node
var parrot_node:Node
var fairy_node:Node
var monster_node:Node
var arrow_node:Node
var is_game_started:bool
var is_game_finished:bool
var arrow_reset:bool
var levels:Dictionary= {
	"0-1":"ch0lv1",
	"0-2":"ch0lv2",
}
