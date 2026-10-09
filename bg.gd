extends Node

@onready var BG = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BG.play("default")
	

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var a: PackedScene = load("res://interval.tscn")
	get_tree().change_scene_to_packed(a)
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	SaveLoad.save_file_data.Night = 1
	pass # Replace with function body.


func _on_save_pressed() -> void:
	SaveLoad.save_game()
	pass # Replace with function body.


func _on_load_pressed() -> void:
	SaveLoad.load_save()
	pass # Replace with function body.
