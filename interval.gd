extends Node2D

@export var NightValue = 1

@onready var nights = $UIstuff/Nights
@onready var Trans = $UIstuff/TransitionBox/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	Trans.play("OUT")
	Trans.animation_finished.connect(on_anim_finished)
	
	

	pass # Replace with function body.

func on_anim_finished(name):
	if name == "OUT":
		var b: PackedScene = load("res://game.tscn")
		get_tree().change_scene_to_packed(b)
		
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nights.text = "Night " + str(NightValue)
	pass
