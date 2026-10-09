extends Resource
class_name SaveDataResource

@export var Night: int = 1

var difficulty: int:
	get:
		return Night - 0.7
