class_name BasicEnemy extends CharacterBody2D


const SPEED: float = 100.0
const JUMP_VELOCITY: float = -400.0
const DETECTION_RANGE: float = 400

var rand_direction: int = 0
var direction_duration: float = 2.0
const MIN_DUR: float = 0.2
const MAX_DUR: float = 3

var player: CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(direction_duration)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player:
		timer.stop()
		velocity.x = 1 * SPEED
	else:
		if timer.is_stopped():
			timer.start(direction_duration)

		velocity.x = rand_direction * SPEED
	
	var physics_body: PhysicsBody2D = ray_cast_2d.get_collider()
	
	if physics_body is CharacterBody2D:
		player = ray_cast_2d.get_collider()
	
	else:
		player = null
	
	move_and_slide()


func _on_timer_timeout() -> void:
	rand_direction = randi_range(-1, 1)
	
	if rand_direction == 1:
		sprite_2d.flip_h = true
		ray_cast_2d.target_position.x = DETECTION_RANGE
		
	elif rand_direction == -1:
		sprite_2d.flip_h = false
		ray_cast_2d.target_position.x = -1 * DETECTION_RANGE
	
	
	direction_duration = randf_range(MIN_DUR, MAX_DUR)
	timer.start(direction_duration)
