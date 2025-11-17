extends Control

func _ready() -> void:
	$mapa.pressed.connect(_on_mapa_pressed)
	
	# Conectar todos los botones "próximamente"
	for boton in [$Avatar, $Armas, $Guardar]:
		boton.pressed.connect(_mostrar_proximamente.bind(boton))

func _on_mapa_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/nivel1.tscn")

func _mostrar_proximamente(boton: Button) -> void:
	# Crear el mensaje flotante
	var mensaje = Label.new()
	mensaje.text = "¡Próximamente!"
	mensaje.add_theme_color_override("font_color", Color.YELLOW)
	mensaje.add_theme_font_size_override("font_size", 14)
	mensaje.add_theme_constant_override("outline_size", 2)
	mensaje.add_theme_color_override("font_outline_color", Color.BLACK)
	
	# Posicionar el mensaje centrado arriba del botón
	var boton_rect = boton.get_global_rect()
	mensaje.position = Vector2(
		boton_rect.position.x + (boton_rect.size.x - mensaje.size.x) / 2,
		boton_rect.position.y - 35
	)
	
	add_child(mensaje)
	
	# Animación de fade out y movimiento
	var tween = create_tween()
	tween.parallel().tween_property(mensaje, "position:y", mensaje.position.y - 20, 1.5)
	tween.parallel().tween_property(mensaje, "modulate:a", 0.0, 1.5)
	
	# Eliminar después de la animación
	await tween.finished
	mensaje.queue_free()
