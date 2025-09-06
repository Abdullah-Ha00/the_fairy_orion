extends Node
var score:int
var high_score:int
var dialogues:Dictionary ={
	"introduction":"intro",
	"monster":"second_phase",
	"parrot":"parrot_hurt"
}
var current_dialogue:String
var game_phases:Dictionary= {
	"begin":"normal",
	"monster_health_halved":"second_phase",
	
}
var current_game_phase:String
var dead_body: Node
var parrot_node:Node
var fairy_node:Node
var monster_node:Node
var can_press_pause:bool
var is_game_started:bool
var is_game_finished:bool
