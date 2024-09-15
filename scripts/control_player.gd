extends Node2D

signal do_move(input_vector)

@onready var mesero: CharacterBody2D = $".."
@onready var cliente: CharacterBody2D = $".."

const ACCELERATION = 500
const FRICTION = 500
const MAX_SPEED = 100

var input_vector
var last_direction

func _physics_process(delta: float) -> void:
	move_state(delta)

func move_state(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		do_move.emit(input_vector)
		mesero.velocity = mesero.velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		cliente.velocity = mesero.velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		last_direction = input_vector
	else:
		mesero.velocity = mesero.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		cliente.velocity = cliente.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	mesero.move_and_slide()
	cliente.move_and_slide()
