extends CharacterBody2D


var speed: float = 300.0
var jump_velocity: float = -400.0
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		sprite_2d.flip_h = true if direction > 0 else false
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
