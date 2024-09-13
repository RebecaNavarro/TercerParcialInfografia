extends CharacterBody2D

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

@export var max_speed = 50

var input_vector
var target_position: Vector2

func set_target(new_target_position: Vector2) -> void:
	target_position = new_target_position
	navigation.target_position = target_position

func _physics_process(delta: float) -> void:
	if target_position:
		if navigation.is_navigation_finished():
			state_machine.travel("Iddle")
			return
		var next_path_position = navigation.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * max_speed
		move_and_slide()
		
		var direction_vector = velocity.normalized()
		set_blend_position(direction_vector)
		state_machine.travel("Walk")
	

func _ready() -> void:
	print(navigation.get_current_navigation_path())

func set_blend_position(vector):
	anim_tree.set("parameters/Idle/blend_position", vector)
	anim_tree.set("parameters/Walk/blend_position", vector)

func _on_player_control_do_move(incoming_input_vector: Vector2) -> void:
	input_vector = incoming_input_vector
	set_blend_position(input_vector)
	state_machine.travel("Walk")
	
