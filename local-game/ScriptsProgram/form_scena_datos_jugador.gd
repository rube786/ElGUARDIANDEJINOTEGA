extends Control

@onready var le_name := $VBoxContainer/LineEdit_Nombre
@onready var le_age := $VBoxContainer/LineEdit_Edad
@onready var le_city := $VBoxContainer/LineEdit_ciudad
@onready var btn_submit := $VBoxContainer/Continuar

func _ready() -> void:
	btn_submit.pressed.connect(_on_submit_pressed)
	
func _on_submit_pressed() -> void:
	var nombre_text = le_name.text.strip_edges()
	var edad_text = le_age.text.strip_edges()
	var ciudad_text = le_city.text.strip_edges()
	
	if nombre_text == "" or edad_text == "" or ciudad_text == "":
		print("Por favor completa todos los campos")
		return
	
	# CORRECCIÓN: Cambiar is_valid_integer() por is_valid_int()
	var edad_val = int(edad_text) if edad_text.is_valid_int() else -1
	if edad_val <= 0:
		print("Edad inválida")
		return

	# Guardar datos
	PlayerData.player_name = nombre_text
	PlayerData.age = edad_val
	PlayerData.city = ciudad_text

	print("Datos guardados: ", PlayerData.player_name, ", ", PlayerData.age, ", ", PlayerData.city)
	# Cambiar escena para seguir con dialogo
	get_tree().change_scene_to_file("res://Escenas/DialogeScene.tscn")
