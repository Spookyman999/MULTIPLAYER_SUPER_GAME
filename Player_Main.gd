extends CharacterBody3D


var SPEED = 10.0
var JUMP_VELOCITY = 10
var ACC = 2
var DCC = 2
var GRAV_MOD = 5
var JUMP_CAN = 0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * GRAV_MOD


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		JUMP_CAN = 2
		print(JUMP_CAN)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and JUMP_CAN >= 1:
		velocity.y = JUMP_VELOCITY
		JUMP_CAN -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x,direction.x * SPEED,ACC)
		velocity.z = move_toward(velocity.z,direction.z * SPEED,ACC)
	else:
		velocity.x = move_toward(velocity.x, 0, DCC)
		velocity.z = move_toward(velocity.z, 0, DCC)
		

	move_and_slide()
