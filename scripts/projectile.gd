extends CharacterBody2D
class_name Projectile

@export var speed = 0
@export var direction = 0

func _physics_process(delta: float) -> void:
	if direction:
		velocity.x = direction * speed
		#if direction == -1: projectile.rotation_degrees = 180
		if velocity.x < 0: scale = Vector2(-1,1)
		elif velocity.x > 0: scale = Vector2(1,1)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self and not body is Player:
		collision_layer = 4 # 3 layer
		set_physics_process(false)
