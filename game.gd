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
@onready var ChromeWork = true

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

@onready var Ost = get_tree().root.find_child("Ostr", true, false)
@onready var OstDistance = Ost.distance
@onready var OstSpotted = Ost.spotted

@onready var faunTag = $layout1/goGuardian
@onready var faunTimer = $layout1/TimeLeft
@onready var faunTime

@onready var tidicksGuard = $Tidik.tidicksDefend

#AESTETICS

@onready var CamStatic = $layout1/cameraStatic





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Simple beginning transition
	GameTimer.start()
	faunTimer.start()
	
	CamStatic.play()

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	##START UPDATERS##
	StevDistance = Stev.distance
	OstDistance = Ost.distance
	
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
	if chromebookUp and ChromeWork:
		MouseLeft.input_pickable = false
		MouseRight.input_pickable = false
	elif not chromebookUp:
		MouseLeft.input_pickable = true
		MouseRight.input_pickable = true
		
	##PHONE SCRIPTS##
	if CurrentCam == 1:
		outside.visible = true
		gym.visible = false
		pool.visible = false
		
		CamStatic.visible = true
		
	elif CurrentCam == 2:
		outside.visible = false
		gym.visible = true
		pool.visible = false
		
		CamStatic.visible = true
		
	elif CurrentCam == 3:
		outside.visible = false
		gym.visible = false
		pool.visible = true
		
		CamStatic.visible = true
		
	elif CurrentCam == 4:
		print("4")
		
	if phoneShutdown:
		outside.visible = false
		gym.visible = false
		pool.visible = false
		
		CamStatic.visible = false
	
	var StevCD = false
	var OstrCD = false
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
			StevCD = false
			Stev.reparent($".", true)
			Stev.position = $"."/Spawn1.position
			shatter.play()
	
			
			if not StevSpotted:
				if StevCD == false:
					await get_tree().create_timer(2).timeout
					StevCD = true
					
				if not chromebookUp:
					Stev.spotted = true
				else:
					Stev.spotted = false
	
	##OST SCRIPTS##
	if OstDistance == 10:
			Ost.reparent(outside, true)
			Ost.position = $outside/Spawn2.position
		
	if OstDistance == 8:
			Ost.reparent(gym, true)
			Ost.position = $gym/Spawn2.position
	
	if OstDistance == 6:
			Ost.reparent(pool, true)
			Ost.position = $pool/Spawn2.position
	
	if OstDistance == 4:
			
		
			Ost.reparent($".", true)
			Ost.position = $"."/Spawn2.position
			shatter.play()
			
			if not OstSpotted:
				await get_tree().create_timer(2).timeout
				if not chromebookUp:
					Ost.spotted = true
					
	##FAUN SCRIPTS##
	faunTime = faunTimer.time_left
	
	faunTag.text = "[shake]A  \"GUARDIAN\" IS WATCHING YOU:
The Faun's oblivion: " + str(round(faunTime))
	
	if chromebookUp:
		faunTimer.paused = false
	else:
		faunTimer.paused = true
		
	if not ChromeWork and chromebookUp:
		chromebookUp = false
		chrmAnim.play("PullDown")




func _on_time_left_timeout() -> void:
	ChromeWork = false
	pass # Replace with function body.			
			
			

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
	elif not chromebookUp and ChromeWork:
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
