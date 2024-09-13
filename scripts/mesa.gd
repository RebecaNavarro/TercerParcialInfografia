extends Area2D

@onready var timer: Timer = $Timer

var money = preload("res://scenes/dinero.tscn")
var food = preload("res://scenes/comida.tscn")

var food_instance = null
var money_instance = null
var food_con_mesero = false  # Este valor será modificado desde el script principal

func _ready():
	timer.wait_time = 5
	timer.one_shot = true

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if food_con_mesero and not food_instance:
			print("Comida detectada en el mesero, dejando en la mesa...")
			food_instance = food.instantiate()
			add_child(food_instance)
			food_instance.position = self.global_position  # Colocar la comida en la posición de la mesa
			print("Comida colocada en la mesa en la posición: ", self.global_position)
			food_con_mesero = false  # Cambiar el estado
			timer.start()

func _on_timer_timeout():
	if food_instance:
		food_instance.queue_free()
		food_instance = null
		money_instance = money.instantiate()
		add_child(money_instance)
		money_instance.position = self.global_position  # Colocar el dinero en la posición de la mesa
		print("Dinero colocado en la mesa en la posición: ", self.global_position)
