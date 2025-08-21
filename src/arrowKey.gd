extends Sprite2D

@export var arrowType = "left"
var baseScale = self.scale
var pressedScale = self.scale * .85
var baseModulate = modulate
var pressModulate = modulate + Color(-.25,-.25,-.25)

@onready var hitbox:Area2D = self.find_child("Area2D")
@onready var ratingInst = preload("res://note_rating.tscn")

func _ready():
	arrowType = arrowType

func  _unhandled_key_input(_event):
	if Input.is_action_just_pressed(arrowType):
		gameVals.emit_signal("keyPress",arrowType)
		self.scale = pressedScale
		modulate = pressModulate
		
		var overlapping = hitbox.get_overlapping_areas()
		if overlapping:
			var overlappingNote = overlapping[0].get_parent()
			if overlappingNote and overlappingNote.is_in_group(arrowType):
				#print("hit")
				var rating = ratingInst.instantiate()
				var ratingLabel : RichTextLabel = rating.find_child("label")
				get_tree().current_scene.call_deferred("add_child",rating)
				rating.global_position = global_position
				var noteDifference = global_position.y - overlappingNote.global_position.y
				if noteDifference > 135 or noteDifference <= -135:
					gameVals.score += 25
					rating.modulate = Color.BROWN
					ratingLabel.text = "CRAP."
				elif (noteDifference > 90 and noteDifference <= 135) or (noteDifference > -135 and noteDifference <= -90):
					gameVals.score += 75
					rating.modulate = Color.DARK_ORANGE
					ratingLabel.text = "bad.."
				elif (noteDifference > 45 and noteDifference <= 90) or (noteDifference > -90 and noteDifference <= -45):
					gameVals.score += 150
					rating.modulate = Color.WEB_GREEN
					ratingLabel.text = "good!"
				elif noteDifference > -45 and noteDifference <= 45:
					gameVals.score += 300
					rating.modulate = Color.DEEP_SKY_BLUE
					ratingLabel.text = "cool!!"
				#print(arrowType)
				
				rating.call_deferred("anim")
				
				modulate = overlappingNote.find_child("Arrow").modulate + Color(.15,.15,.15)
				if overlappingNote.holdNote:
					overlappingNote.find_child("Arrow").visible = false
					overlappingNote.global_position = global_position
					overlappingNote.holdStart = Time.get_ticks_msec()
					overlappingNote.holding = true
					#print("HOLD.")
				else:
					overlappingNote.queue_free()
					
				gameVals.combo += 1
				
	if Input.is_action_just_released(arrowType):
		self.scale = baseScale
		modulate = baseModulate
