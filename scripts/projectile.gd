extends CharacterBody2D
class_name Projectile

@onready var ProjectileTexture = %ProjectileTexture.animation_player
@export var speed = 0
@export var direction = 0:
	set(value):
		direction = value
		_update_facing()

func _ready() -> void:
	_update_facing()

func _update_facing() -> void:
	if not is_node_ready():
		return
	if direction != 0:
		scale = Vector2(direction,1)

func _physics_process(delta: float) -> void:
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self and not body is Player:
		ProjectileTexture.queue("hit")
		ProjectileTexture.queue("break")
		
		collision_layer = 4 # 3 layer
		set_physics_process(false)
