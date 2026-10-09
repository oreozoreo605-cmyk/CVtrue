extends Control

@export var distance = 10

@onready var nights = SaveLoad.save_file_data.Night
@onready var difficulty = nights - 0.7

@export var spotted = false

@onready var beginMove = 5 / difficulty
@onready var laterMove = 10 / difficulty

@onready var timer = $Timer

@onready var chance = 0
@onready var breakIn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randf_range(beginMove, laterMove)
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if spotted:
		var d: PackedScene = load("res://game_over.tscn")
		get_tree().change_scene_to_packed(d)

func _on_timer_timeout() -> void:
	
	if distance == 6:
		chance = 1
		
	if chance == 0:
		distance = randi_range(3, 5) * 2
	elif chance == 1:
		breakIn = randi_range(1, 2)
		if breakIn == 1:
			distance = 4
		else:
			distance = 10
		
		
	timer.wait_time = randf_range(beginMove, laterMove)
	timer.start()
	pass # Replace with function body.
