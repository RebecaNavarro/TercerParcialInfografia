extends CharacterBody2D

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var timer_feiz: Timer = $Timers/Timer_feiz
@onready var timer_enojado: Timer = $Timers/Timer_enojado
@onready var timer_borrar_enojado: Timer = $Timers/Timer_borrar_enojado
@onready var timer_borrar_feliz: Timer = $Timers/Timer_borrar_feliz

@export var max_speed = 80

var input_vector
var target_position: Vector2

var sentado = false

func set_target(new_target_position: Vector2) -> void:
	target_position = new_target_position
	navigation.target_position = target_position

func _ready() -> void:
	print(navigation.get_current_navigation_path())
	timer_enojado.wait_time = 3
	timer_enojado.one_shot = true  
	timer_enojado.start()
	timer_feiz.wait_time = 3
	timer_feiz.one_shot = true  
	timer_feiz.start()
	timer_borrar_enojado.wait_time = 4
	timer_borrar_enojado.one_shot = true  
	timer_borrar_feliz.wait_time = 4
	timer_borrar_feliz.one_shot = true  

func _physics_process(delta: float) -> void:
	if target_position:
		if navigation.is_navigation_finished():
			state_machine.travel("Sit")
			sentado = true
			return
		var next_path_position = navigation.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * max_speed
		move_and_slide()
		
		var direction_vector = velocity.normalized()
		set_blend_position(direction_vector)
		state_machine.travel("Walk")

func set_blend_position(vector):
	anim_tree.set("parameters/Idle/blend_position", vector)
	anim_tree.set("parameters/Walk/blend_position", vector)
	anim_tree.set("parameters/Sit/blend_position", vector)
	anim_tree.set("parameters/Angry/blend_position", vector)
	anim_tree.set("parameters/Happy/blend_position", vector)

func _on_player_control_do_move(incoming_input_vector: Vector2) -> void:
	input_vector = incoming_input_vector
	set_blend_position(input_vector)
	state_machine.travel("Walk")
	
func _on_timer_enojado_timeout() -> void :
	if not sentado:
		state_machine.travel("Angry")
		timer_borrar_enojado.start()

func _on_timer_borrar_enojado_timeout() -> void:
	if not sentado:
		queue_free()

func _on_timer_borrar_feliz_timeout() -> void:
	if sentado:
		queue_free()


func _on_timer_feiz_timeout() -> void:
	if sentado:
		state_machine.travel("Happy")
		timer_borrar_feliz.start()
