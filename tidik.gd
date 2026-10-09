extends Control

@onready var timer = $Timer
@export var tidicksDefend = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randf_range(100, 200)
	timer.start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	tidicksDefend = true
	$".".visible = true
	await get_tree().create_timer(15).timeout
	tidicksDefend = false
	$".".visible = false
	timer.start()
pass # Replace with function body.
