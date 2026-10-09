extends Control

@export var distance = 10

@onready var nights = SaveLoad.save_file_data.Night
@onready var difficulty = nights - 0.7


@export var spotted = false

@onready var beginMove = 5 / difficulty
@onready var laterMove = 10 / difficulty

@onready var timer = $Timer

@onready var stevSuperScare = $StevSuperScare
@onready var stevScare = $StevScare

@onready var Tidick = get_tree().root.find_child("Tidik", true, false)


@onready var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randf_range(beginMove, laterMove)
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if spotted:
		stevScare.play()
		stevSuperScare.play()
		var d: PackedScene = load("res://game_over.tscn")
		get_tree().change_scene_to_packed(d)

func _on_timer_timeout() -> void:
	if Tidick.tidicksDefend == false:
		direction = randi_range(0, 1)
		
		if direction == 0:
			distance -= 2
			if distance == 2 or distance == 0:
				distance = 10
		
		
		elif direction == 1:
			distance += 2
			if distance == 10 or distance == 12:
				distance -= 4
	else:
		distance = 10
		
		
	timer.wait_time = randf_range(beginMove, laterMove)
	timer.start()
	pass # Replace with function body.
