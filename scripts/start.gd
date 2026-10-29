extends Button

@export var scene_to_launch : PackedScene

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(scene_to_launch)
