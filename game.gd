extends Node2D

@onready var MouseLeft = $LeftMove
@onready var MouseRight = $RightMove

@onready var camera = $Camera2D

@onready var GameTimer = $GameTimer

@onready var left = false
@onready var right = false

@onready var chromebookUp = false
@onready var phoneOn = false
@onready var phoneShutdown = false

@onready var Chromebook = $layout1/Chromebook
@onready var chrmAnim = $layout1/Chromebook/AnimationPlayer

@onready var cameraControls = $CameraControls

@export var CurrentCam = 0

#ROOMS
@onready var outside = $outside
@onready var gym = $gym
@onready var pool = $pool

#AUDIO
@onready var shatter = $Shatter


#ENTITIES
@onready var Stev = get_tree().root.find_child("Steph", true, false)
@onready var StevDistance = Stev.distance
@onready var StevSpotted = Stev.spotted




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Simple beginning transition
	GameTimer.start()

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	##START UPDATERS##
	StevDistance = Stev.distance
	
	####THIS CONTAINS ALL THE CAMERA'S SCRIPTS####
	if left == true:
		if camera.position.x > 350:
			camera.position.x -= delta + 5
			
			MouseLeft.position.x -= delta + 5
			MouseRight.position.x -= delta + 5
		else:
			camera.position.x = 350
			
	if right == true:
		if camera.position.x < 750:
			camera.position.x += delta + 5
			
			MouseLeft.position.x += delta + 5
			MouseRight.position.x += delta + 5
		else:
			camera.position.x = 750
	pass
	
	##CHROMEBOOK SCRIPTS##
	if chromebookUp:
		MouseLeft.input_pickable = false
		MouseRight.input_pickable = false
	else:
		MouseLeft.input_pickable = true
		MouseRight.input_pickable = true
		
	##PHONE SCRIPTS##
	if CurrentCam == 1:
		outside.visible = true
		gym.visible = false
		pool.visible = false
		
	elif CurrentCam == 2:
		outside.visible = false
		gym.visible = true
		pool.visible = false
		
	elif CurrentCam == 3:
		outside.visible = false
		gym.visible = false
		pool.visible = true
		
	elif CurrentCam == 4:
		print("4")
		
	if phoneShutdown:
		outside.visible = false
		gym.visible = false
		pool.visible = false
		
	##STEV SCRIPTS##
	if StevDistance == 10:
			Stev.reparent(outside, true)
			Stev.position = $outside/Spawn1.position
		
	if StevDistance == 8:
			Stev.reparent(gym, true)
			Stev.position = $gym/Spawn1.position
	
	if StevDistance == 6:
			Stev.reparent(pool, true)
			Stev.position = $pool/Spawn1.position
	
	if StevDistance == 4:
			Stev.reparent($".", true)
			Stev.position = $"."/Spawn1.position
			shatter.play()
			
			if not StevSpotted:
				await get_tree().create_timer(2).timeout
				if not chromebookUp:
					Stev.spotted = true
			
			
			

func _on_left_move_mouse_entered() -> void:
	left = true
	right = false
	pass # Replace with function body.


func _on_right_move_mouse_entered() -> void:
	right = true
	left = false
	pass # Replace with function body.


func _on_left_move_mouse_exited() -> void:
	left = false
	pass # Replace with function body.


func _on_right_move_mouse_exited() -> void:
	right = false
	pass # Replace with function body.


func _on_chrome_button_pressed() -> void:
	if chromebookUp:
		chromebookUp = false
		chrmAnim.play("PullDown")
	else:
		chromebookUp = true
		chrmAnim.play("PullUp")
		
		
	pass # Replace with function body.


func _on_phone_button_pressed() -> void:
	if phoneOn:
		phoneOn = false
		cameraControls.visible = false
		phoneShutdown = true
		
	else:
		phoneOn = true
		cameraControls.visible = true
		phoneShutdown = false
	pass # Replace with function body.


func _on_game_timer_timeout() -> void:
	var c: PackedScene = load("res://survived.tscn")
	get_tree().change_scene_to_packed(c)
	pass # Replace with function body.
