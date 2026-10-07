extends CanvasLayer

@onready var LeftCam = $leftCamera
@onready var RightCam = $RightCamera

@onready var game = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_camera_pressed() -> void:
	if game.CurrentCam > 1:
		game.CurrentCam -= 1
		
	elif game.CurrentCam == 1:
		game.CurrentCam = 3
		
	else:
		game.CurrentCam = 1
	
	pass # Replace with function body.


func _on_right_camera_pressed() -> void:
	if game.CurrentCam < 3:
		game.CurrentCam += 1
		
	elif game.CurrentCam == 3:
		game.CurrentCam = 1
		
	else:
		game.CurrentCam = 3
	pass # Replace with function body.
