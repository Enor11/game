extends CharacterBody2D
class_name Player

@onready var scene = get_tree().current_scene
const projectile = preload("res://nodes/Projectile.tscn")
const projectile_texture = preload("res://nodes/projectile_texture.tscn")
var projectile_tex_instance = projectile_texture.instantiate()
@onready var _animation_player = $AnimationPlayer

@export var projectile_count = 10
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var JUMP_AVAILIBLE = true
var AIMING = false
var cooldown = 0.0
var facing_dir = 1

@export var health_bar : Control
@export var health = 100:
	set(value):
		health = value
		if health_bar:
			health_bar.health = value
			print(health)
		if health <= 0:
			get_tree().reload_current_scene()

func _ready() -> void:
	projectile_tex_instance.visible = false
	$".".add_child.call_deferred(projectile_tex_instance)

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
	
	if Input.is_action_just_pressed("M1") and AIMING: shoot_projectile()
	if Input.is_action_just_pressed("M2") and cooldown <= 0: AIMING = true
	if Input.is_action_just_released("M2"): AIMING = false
	
	if AIMING:
		projectile_tex_instance.visible = true
		projectile_tex_instance.look_at(get_global_mouse_position())
		var p_rotation = rad_to_deg(projectile_tex_instance.rotation)
		if abs(rad_to_deg(projectile_tex_instance.rotation)) > 90:
			projectile_tex_instance.scale = Vector2(1,-1)
		else: projectile_tex_instance.scale = Vector2(1,1)
		#projectile_tex_instance.scale = Vector2(direction,1)
	elif !AIMING and projectile_tex_instance.visible:
		projectile_tex_instance.visible = false
	
	move_and_slide()
	
func shoot_projectile():
	if projectile_count:
		var projectileInstance = projectile.instantiate()
		projectileInstance.global_position = position
		projectileInstance.speed = 200
		projectileInstance.direction = -1 if facing_dir < 0 else 1
		scene.add_child.call_deferred(projectileInstance)
		projectile_count -= 1 
