extends Resource

const SAVE_GAME_PATH := "user://save.tres"

@export var nights := 1


func write_savegame() -> void:
	ResourceSaver.save(SAVE_GAME_PATH, self)
