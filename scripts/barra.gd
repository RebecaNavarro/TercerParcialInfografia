extends StaticBody2D

@onready var restaurante: Node2D = $".."

func _input(event):
	if event is InputEvent and event.is_action_pressed("ClickDerecho"):
		var target_position = get_global_mouse_position()
		#restaurante.
