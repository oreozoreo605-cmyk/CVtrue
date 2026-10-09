extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.save_file_data.Night += 1
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_load_pressed() -> void:
	var e: PackedScene = load("res://main_menu.tscn")
	get_tree().change_scene_to_packed(e)
	pass # Replace with function body.
