extends Node2D

@export var holdNote : bool = false
@export var noteDirection : String = "left"
@export var noteSpeed : float = 5.0
@export var holdLen : float = 1.0
@export var holding:bool = false
@export var holdStart : float = 0

func _init():
	set_process(false)

func _physics_process(delta):
	if holding:
		var elapsed = (Time.get_ticks_msec() - holdStart) / 1000.0
		var remaining = max(0, holdLen - elapsed)
		$Tail.scale.y = (remaining * (noteSpeed*60))/40
		$Arrow.visible = false
		gameVals.score += 0.25
		
		if remaining <= 0 or not Input.is_action_pressed(noteDirection):
			if remaining > .1:
				gameVals.combo = 0
				gameVals.score -= 75
			queue_free()
	else:
		position.y += noteSpeed
	if global_position.y > 1300:
		queue_free()
		gameVals.combo = 0
		gameVals.score -= 150

func setup(x):
	global_position = Vector2(x,-150.0)
	if holdNote:
		$Tail.scale = Vector2(.7,((noteSpeed*60) * holdLen)/40)
		#$Tail.position = Vector2(-20,0)
	set_process(true)
