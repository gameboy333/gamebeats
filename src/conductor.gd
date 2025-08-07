extends AudioStreamPlayer

@export var bpm = 115
@export var beats = 4

var song_pos = 0.0
var song_pos_beats = 0
var sec_per_beat = 60.0 / bpm
var last_beat = 0
var beats_before_start = 0
var beat = 0
var measure = 1

var closest = 0
var time_off_beat = 0.0

signal onBeat(pos)
signal onMeasure(pos)
signal onPos(pos)

func _ready():
	sec_per_beat = 60.0 / bpm

func _physics_process(_delta):
	if playing:
		song_pos = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_pos -= AudioServer.get_output_latency()
		emit_signal("onPos",song_pos)
		song_pos_beats = int(floor(song_pos / sec_per_beat)) + beats_before_start
		#print(song_pos_beats)
		_emit_beat()
		
func _emit_beat():
	if last_beat < song_pos_beats:
		beat += 1
		if beat > beats:
			beat = 1
			measure += 1
			#print("NEW MEASURE!!!!!!!!!!!!!!")
		last_beat = song_pos_beats
		emit_signal("onMeasure",measure)
		emit_signal("onBeat",beat)

func _on_timer_timeout():
	song_pos_beats += 1
	if song_pos_beats < beats_before_start - 1:
		$Timer.start()
	elif song_pos_beats == beats_before_start - 1:
		$Timer.wait_time = $Timer.wait_time - (AudioServer.get_time_to_next_mix()+AudioServer.get_output_latency())
		$Timer.start()
	else:
		play()
		$Timer.stop()
	_emit_beat()
