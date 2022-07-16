extends RigidBody

export var rolling_force = 40
export var jump_impulse = 1000
export var can_jump = true
export var launch_impulse_mag = 1000
func _ready():
	$CameraRig.set_as_toplevel(true)
	$FloorCheck.set_as_toplevel(true)
	
#func _physics_process(delta):
#	var old_camera_pos = $CameraRig.global_transform.origin
#	var ball_pos = global_transform.origin
#	var new_camera_pos = lerp(old_camera_pos, ball_pos, 0.1)
#	$CameraRig.global_transform.origin = new_camera_pos
#	$FloorCheck.global_transform.origin = global_transform.origin
#
#
#	if Input.is_action_pressed("forward"):
#		angular_velocity.x -= rolling_force*delta
#	elif Input.is_action_pressed("backward"):
#		angular_velocity.x += rolling_force*delta
#	if Input.is_action_pressed("left"):
#		angular_velocity.z += rolling_force*delta
#	elif Input.is_action_pressed("right"):
#		angular_velocity.z -= rolling_force*delta
#
#	var is_grounded = $FloorCheck.is_colliding()
#	if Input.is_action_just_pressed("jump"):
#		if is_grounded:
#			apply_central_impulse(Vector3.UP * jump_impulse)
func _physics_process(delta):
	var old_camera_pos = $CameraRig.global_transform.origin
	var ball_pos = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, ball_pos, 0.1)
	var mouse_position = get_viewport().get_mouse_position()
	#print(mouse_position)
	var launch_angle = ((mouse_position.x / OS.get_window_size().x) * 180) - 90
	#print(launch_angle)


	
	$CameraRig.global_transform.origin = new_camera_pos
	$FloorCheck.global_transform.origin = global_transform.origin
	
	#inital jump
	var is_grounded = $FloorCheck.is_colliding()
	
	if can_jump:
		if is_grounded:
			if Input.is_action_just_pressed("jump"):
				print("Just jumped")
				apply_central_impulse(Vector3.UP * jump_impulse)
				apply_central_impulse(Vector3.FORWARD * launch_impulse_mag)
				can_jump = false
	if Input.is_action_pressed("left"):
		angular_velocity.z += rolling_force*delta
	elif Input.is_action_pressed("right"):
		angular_velocity.z -= rolling_force*delta
	

var play_audio_factor = 3

func _on_RigidBody_body_entered(body):
	if abs(self.linear_velocity.x) > play_audio_factor || abs(self.linear_velocity.y) > play_audio_factor || abs(self.linear_velocity.z) > play_audio_factor:
		$"AudioStreamPlayer".play()


