extends Node2D

func _ready():
	var t = self.create_tween()
	t.tween_property(self, "position", Vector2(960, 1600), 7)
