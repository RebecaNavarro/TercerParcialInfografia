extends Node2D

@onready var mesero: CharacterBody2D = $"Mesero"
@onready var navigation: NavigationAgent2D = $"Mesero/NavigationAgent2D"
@onready var barra: Area2D = $Barra
#Timers
@onready var timer_barra: Timer = $Timers/Timer_barra
@onready var timer_mesa_a: Timer = $Timers/Timer_mesa_a
@onready var timer_mesa_b: Timer = $Timers/Timer_mesa_b
@onready var timer_mesa_c: Timer = $Timers/Timer_mesa_c
@onready var timer_mesa_d: Timer = $Timers/Timer_mesa_d
@onready var timer_mesa_e: Timer = $Timers/Timer_mesa_e
#Mesas:
@onready var mesa_a: Area2D = $Mesas/MesaA
@onready var mesa_b: Area2D = $Mesas/MesaB
@onready var mesa_c: Area2D = $Mesas/MesaC
@onready var mesa_d: Area2D = $Mesas/MesaD
@onready var mesa_e: Area2D = $Mesas/MesaE

var food = preload("res://scenes/comida.tscn")
var money = preload("res://scenes/dinero.tscn")

var food_instance_barra = null
var food_instance_mesa_a = null
var food_instance_mesa_b = null
var food_instance_mesa_c = null
var food_instance_mesa_d = null
var food_instance_mesa_e = null
var food_con_mesero = false
var money_instance = null

var dinero = 0

func _ready() -> void:
	timer_barra.wait_time = 5 
	timer_barra.one_shot = true  
	timer_barra.start()
	timer_mesa_a.wait_time = 5
	timer_mesa_a.one_shot = true  
	timer_mesa_b.wait_time = 5
	timer_mesa_b.one_shot = true 
	timer_mesa_b.wait_time = 5
	timer_mesa_b.one_shot = true 
	timer_mesa_c.wait_time = 5
	timer_mesa_c.one_shot = true 
	timer_mesa_d.wait_time = 5
	timer_mesa_d.one_shot = true 
	timer_mesa_e.wait_time = 5
	timer_mesa_e.one_shot = true 

func _input(event):
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		var target_position = get_global_mouse_position()
		mesero.set_target(target_position)

func _on_timer_barra_timeout() -> void:
	if not food_instance_barra:
		food_instance_barra = food.instantiate()
		barra.add_child(food_instance_barra)
		food_instance_barra.position = Vector2(300, 125)
		print("Se ha creado la comida en la barra")

func _on_barra_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if food_instance_barra:
			food_instance_barra.queue_free()  
			food_instance_barra = null
			print("La comida ha sido recogida de la barra")
			timer_barra.start()
			food_con_mesero = true

func _on_mesa_a_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if not food_instance_mesa_a and food_con_mesero:
			food_instance_mesa_a = food.instantiate()
			mesa_a.add_child(food_instance_mesa_a)
			food_instance_mesa_a.position = Vector2(125, -300)
			print("Se ha creado la comida en la mesa a")
			food_con_mesero = false
			timer_mesa_a.start()

func _on_mesa_b_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if not food_instance_mesa_b and food_con_mesero:
			food_instance_mesa_b = food.instantiate()
			mesa_b.add_child(food_instance_mesa_b)
			food_instance_mesa_b.position = Vector2(600, -300)
			print("Se ha creado la comida en la mesa b")
			food_con_mesero = false
			timer_mesa_b.start()

func _on_mesa_c_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if not food_instance_mesa_c and food_con_mesero:
			food_instance_mesa_c = food.instantiate()
			mesa_c.add_child(food_instance_mesa_c)
			food_instance_mesa_c.position = Vector2(350, -160)
			print("Se ha creado la comida en la mesa c")
			food_con_mesero = false
			timer_mesa_c.start()

func _on_mesa_d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if not food_instance_mesa_d and food_con_mesero:
			food_instance_mesa_d = food.instantiate()
			mesa_d.add_child(food_instance_mesa_d)
			food_instance_mesa_d.position = Vector2(125, 0)
			print("Se ha creado la comida en la mesa d")
			food_con_mesero = false
			timer_mesa_d.start()

func _on_mesa_e_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEvent and event.is_action_pressed("ClickIzq"):
		if not food_instance_mesa_e and food_con_mesero:
			food_instance_mesa_e = food.instantiate()
			mesa_e.add_child(food_instance_mesa_e)
			food_instance_mesa_e.position = Vector2(600, 0)
			print("Se ha creado la comida en la mesa e")
			food_con_mesero = false
			timer_mesa_e.start()

func _on_timer_mesa_a_timeout() -> void:
	if food_instance_mesa_a:
		food_instance_mesa_a.queue_free()  
		food_instance_mesa_a = null
		print("La comida ha sido eliminada de la mesa a")
		money_instance = money.instantiate()
		mesa_a.add_child(money_instance)
		money_instance.position = Vector2(125, -300)

func _on_timer_mesa_b_timeout() -> void:
	if food_instance_mesa_b:
		food_instance_mesa_b.queue_free()  
		food_instance_mesa_b = null
		print("La comida ha sido eliminada de la mesa b")
		money_instance = money.instantiate()
		mesa_b.add_child(money_instance)
		money_instance.position = Vector2(600, -300)

func _on_timer_mesa_c_timeout() -> void:
	if food_instance_mesa_c:
		food_instance_mesa_c.queue_free()  
		food_instance_mesa_c = null
		print("La comida ha sido eliminada de la mesa c")
		money_instance = money.instantiate()
		mesa_c.add_child(money_instance)
		money_instance.position = Vector2(350, -160)

func _on_timer_mesa_d_timeout() -> void:
	if food_instance_mesa_d:
		food_instance_mesa_d.queue_free()  
		food_instance_mesa_d = null
		print("La comida ha sido eliminada de la mesa d")
		money_instance = money.instantiate()
		mesa_d.add_child(money_instance)
		money_instance.position = Vector2(125, 0)

func _on_timer_mesa_e_timeout() -> void:
	if food_instance_mesa_e:
		food_instance_mesa_e.queue_free()  
		food_instance_mesa_e = null
		print("La comida ha sido eliminada de la mesa e")
		money_instance = money.instantiate()
		mesa_e.add_child(money_instance)
		money_instance.position = Vector2(600, 0)
