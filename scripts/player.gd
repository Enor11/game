extends CharacterBody2D

@onready var scene = get_tree().root
const projectile = preload("res://nodes/Projectile.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("Interact"):
		var projectileInstance = projectile.instantiate()
		projectileInstance.global_position = position
		scene.get_tree().root.add_child.call_deferred(projectileInstance)
	
	move_and_slide()
