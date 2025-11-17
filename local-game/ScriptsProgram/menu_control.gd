extends Control

@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

# Cuando la escena se carga, se ejecuta la música
func _ready() -> void:
	if not music_player.playing:
		music_player.play()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/form_scenaDatosJugador.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
