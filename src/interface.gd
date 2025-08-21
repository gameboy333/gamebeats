extends Control

func _process(_delta):
	if gameVals.combo > 9999:
		$combo.text = "BIGx"
	else:
		$combo.text = str(gameVals.combo)+"x"
	$score.text = "%.0f" % gameVals.score
