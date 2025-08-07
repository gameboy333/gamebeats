extends Sprite2D

@export var arrowType = "left"
var baseScale = self.scale
var pressedScale = self.scale * .85
var baseModulate = modulate
var pressModulate = modulate + Color(-.25,-.25,-.25)

@onready var hitbox:Area2D = self.find_child("Area2D")

func  _unhandled_key_input(_event):
	if Input.is_action_just_pressed(arrowType):
		self.scale = pressedScale
		modulate = pressModulate
		
		var overlapping = hitbox.get_overlapping_areas()
		if overlapping:
			var overlappingNote = overlapping[0].get_parent()
			if overlappingNote and overlappingNote.is_in_group(arrowType):
				var noteDifference = global_position.y - overlappingNote.global_position.y
				if noteDifference > 100:
					print("CRAP")
				elif noteDifference > 50 and noteDifference <= 100:
					print("bad")
				elif noteDifference > 20 and noteDifference <= 50:
					print("good")
				elif noteDifference > -20 and noteDifference <= 20:
					print("cool")
				
				modulate = overlappingNote.modulate + Color(.15,.15,.15)
				overlappingNote.queue_free()
				
	if Input.is_action_just_released(arrowType):
		self.scale = baseScale
		modulate = baseModulate
