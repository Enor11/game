extends CharacterBody2D

var hit_wall : bool = false
@onready var projectile = $"."

@export var speed = 0
@export var direction = 0


func _physics_process(delta: float) -> void:
	if not hit_wall:
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_wall = true
