extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var speed:float = 100.00

var is_moving:bool = false 
var current_dir:String = "down"  # Dirección actual (siempre mantiene la última)

func ready():
	$DeteccioArea.add_to_group("PersonajeInicial")

func _physics_process(_delta):
	handle_movement()
	handle_animation()
	move_and_slide()

func handle_movement():
	velocity = Vector2.ZERO
	is_moving = false
	
	# DETECCIÓN DE MOVIMIENTO MANTENIDO
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2.LEFT * speed
		is_moving = true
		current_dir = "left"
		
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2.RIGHT * speed
		is_moving = true
		current_dir = "right"
		
	elif Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP * speed
		is_moving = true
		current_dir = "up"
		
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN * speed
		is_moving = true
		current_dir = "down"
	
	# DETECCIÓN DE CAMBIO DE DIRECCIÓN SIN MOVIMIENTO (solo pulsación)
	elif Input.is_action_just_pressed("ui_left"):
		current_dir = "left"
		_update_animation_immediately()
		
	elif Input.is_action_just_pressed("ui_right"):
		current_dir = "right"
		_update_animation_immediately()
		
	elif Input.is_action_just_pressed("ui_up"):
		current_dir = "up"
		_update_animation_immediately()
		
	elif Input.is_action_just_pressed("ui_down"):
		current_dir = "down"
		_update_animation_immediately()

func handle_animation():
	if is_moving:
		# Animaciones de movimiento (solo cuando se mantiene presionado)
		match current_dir:
			"left":
				anim.play("CaminarIzquierda")
			"right":
				anim.play("CaminarDerecha")
			"up":
				anim.play("CaminarArriba")
			"down":
				anim.play("Caminar")
	else:
		# Animaciones de IDLE (descanso) - usa la dirección actual
		match current_dir:
			"left":
				anim.play("DescansoIzquierda")  # Mantiene mirando a la izquierda
			"right":
				anim.play("DescansoDerecha")    # Mantiene mirando a la derecha
			"up":
				anim.play("Descansoespalda")     # Mantiene mirando arriba/espalda
			"down":
				anim.play("Descanso")           # Mantiene mirando abajo/frente

func _update_animation_immediately():
	# Actualizar la animación inmediatamente cuando cambia dirección
	if not is_moving:
		handle_animation()
