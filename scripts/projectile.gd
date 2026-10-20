extends RigidBody2D

@onready var projectile: RigidBody2D = $"."

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	projectile.freeze = true
