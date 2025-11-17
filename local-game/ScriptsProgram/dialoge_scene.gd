extends Control

@onready var label_dialogo = $Panel/LabelDialogo
@onready var btn_continue = $Panel/BtnContinuar

# Mensajes base se puede ajustar
var intro_template = "Hola %s viajero, bienvenido. Estas listo para estas aventura?"
var story_lines = [
	"Hace mucho tiempo la montañana estaba protegida por un talisman",
	"El sello ha sido roto por una construcción que estaban haciendo",
	"Es hora que tu seas el salvador de la ciudad, %s. Tu edad: %d. Ciudad:%s"
] 

var typing_delay = 0.04 # segundos por caracter

func _ready() -> void:
	btn_continue.visible = false
	var player_name = PlayerData.player_name if PlayerData.player_name != "" else "amigo"
	var intro = intro_template % player_name
	# Concatenar la historia final formateada con datos
	var story = "%s\n\n%s" % [intro, story_lines[2] % [player_name, PlayerData.age, PlayerData.city]]
	# Lanza la rutina de tipeo
	start_typewriter(story)

func start_typewriter(text: String) -> void:
	label_dialogo.text = ""
	# Llamamos a la co-rutina:
	call_deferred("_type_text_coroutine", text)

func _type_text_coroutine(text: String) -> void:
	# Reproducir cada carácter con pequeño delay
	var built := ""
	for ch in text:
		built += ch
		label_dialogo.text = built
		# Espera un frame corto usando create_timer para control preciso
		await get_tree().create_timer(typing_delay).timeout
	
	# Al terminar, permite continuar (esto debe estar FUERA del bucle for)
	btn_continue.visible = true
	btn_continue.pressed.connect(_on_continue_pressed)

func _on_continue_pressed() -> void:
	# Ir a la escena del perfil
	get_tree().change_scene_to_file("res://Escenas/profile_scene.tscn")
