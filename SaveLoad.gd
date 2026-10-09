extends Node

const SAVE_PATH := "user://SaveFile.tres"

var save_file_data: SaveDataResource = SaveDataResource.new()

func _ready() -> void:
	load_save()

func save_game() -> void:
	var error := ResourceSaver.save(save_file_data, SAVE_PATH)
	if error != OK:
		push_error("Save failed: %s" % error_string(error))

func load_save() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return # Keep the new resource's default values.

	var loaded := ResourceLoader.load(SAVE_PATH)

	if loaded is SaveDataResource:
		save_file_data = loaded
	else:
		push_error("Could not load SaveDataResource from %s" % SAVE_PATH)
