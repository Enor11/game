extends StaticBody2D
class_name Enemy

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("dead!!!")
		get_tree().reload_current_scene()
	if body is Projectile:
		print("hit!!!")
		$".".queue_free()
