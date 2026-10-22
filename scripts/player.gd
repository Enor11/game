extends CharacterBody2D
class_name Player

@onready var scene = get_tree().current_scene
const projectile = preload("res://nodes/Projectile.tscn")

@export var projectile_count = 10

@onready var _animation_player = $AnimationPlayer

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var JUMP_AVAILIBLE = true
var facing_dir = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		JUMP_AVAILIBLE = true
		velocity.y = JUMP_VELOCITY
	if not is_on_floor() and JUMP_AVAILIBLE and Input.is_action_just_pressed("Jump"):
		JUMP_AVAILIBLE = false
		velocity.y = JUMP_VELOCITY

	# movement
	var direction := Input.get_axis("Left", "Right")
	if direction:
		facing_dir = direction
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0
		_animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animation_player.stop()

	# projectiles
	if Input.is_action_just_pressed("Interact") and projectile_count:
		var projectileInstance = projectile.instantiate()
		projectileInstance.global_position = position
		projectileInstance.speed = 200
		projectileInstance.direction = -1 if facing_dir < 0 else 1
		scene.add_child.call_deferred(projectileInstance)
		projectile_count -= 1 
	
	move_and_slide()
