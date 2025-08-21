extends Node2D

func anim():
	var upPos = global_position-Vector2(0,50)
	var downPos = upPos+Vector2(0,150)
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self,"global_position",upPos,0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"global_position",downPos,0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_delay(0.2)
	tween.tween_property(self,"rotation_degrees",randi_range(-20,20),0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_delay(0.2)
	tween.tween_property(self,"modulate",modulate-Color(0,0,0,1),0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_delay(0.2)
	await get_tree().create_timer(.6).timeout
	queue_free()
