extends RigidBody2D

@onready var projectile: RigidBody2D = $"."


func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("test")
	projectile.sleeping = true
