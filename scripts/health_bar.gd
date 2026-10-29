extends Control

@onready var Progress_bar : ProgressBar = %ProgressBar

@export var accuracy : float = 0.1
@export var speed : float = 0.01
var time : float = 0
@export var health : float = 100:
	set(value):
		health = value

@export var max_health : float = 100:
	set(value):
		max_health = value

func _process(delta: float) -> void:
	time += delta * speed
	if abs(Progress_bar.value - health) > accuracy:
		Progress_bar.value = lerp(Progress_bar.value, health, time)
	Progress_bar.get_theme_stylebox("fill").bg_color = Color(1.0, 0.5, 0.0, 1)
	Progress_bar.get_theme_stylebox("background").bg_color = Color(0.0, 0.0, 1.0, 0.5)
