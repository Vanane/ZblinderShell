extends CharacterBody3D

#region Publics
@export
var speed:float
@export
var jump_height:float
@export
var unsheathed:bool = false

@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var moving_direction:Vector3
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var is_falling:bool
#endregion

#region Privates
var _camera:TrackingCamera

var _walkDirection:Vector3
var _cameraRotation:Vector2
#endregion

func _ready():
	self._setup_camera()

func _process(delta:float) -> void:
	self._refresh_anim_flags()

func _physics_process(delta: float) -> void:
	_process_controls(delta)
	_process_cleanup(delta)

func _process_controls(delta: float):
	# Camera movements, prior to moving relative to the camera
	self._camera.rotate_relative(self._cameraRotation * ConfigurationManager.get_param("controls.mouse.sensitivity"))	

	# Body rotation to follow the direction
	if self._walkDirection != Vector3.ZERO:
		var angledWalk = self._walkDirection.rotated(Vector3.UP, self._camera.rotation.y)
		var targetAngle = self.basis.z.signed_angle_to(angledWalk, Vector3.UP)
		self.rotation.y += lerp(0.0, targetAngle, delta * 10)
		
		# Walk
		self.translate_object_local(Vector3.BACK * self.speed)
		
	# Gravity
	self.velocity += Vector3.DOWN*.5
	self.move_and_slide()

func _process_cleanup(delta: float):
	self._walkDirection = Vector3.ZERO
	self._cameraRotation = Vector2.ZERO

func _setup_camera():
	self._camera = get_node(get_meta("Camera"))
	self._camera.set_target(self)

# Called each frame to expose internal variables to animation state machines
func _refresh_anim_flags():
	self.moving_direction = self._walkDirection
	self.is_falling = not self.is_on_floor()

#region Signal Handling
func move(direction:Vector2):	
	self._walkDirection = Vector3(-direction.x, 0.0, direction.y)

func jump():
	if self.is_on_floor():
		self.velocity += Vector3.UP * jump_height
	return

func look(relative:Vector2):
	self._cameraRotation = Vector2(-relative.x, relative.y)

func zoom_in() -> void:
	self._camera.remove_distance()

func zoom_out() -> void:
	self._camera.add_distance()
#endregion


func toggle_weapon() -> void:
	self.can_attack = true
	self.unsheathed = not self.unsheathed
	pass # Replace with function body.


var attackCycle = ["SwordSwing1", "SwordSwing2"]
var attackState = 0

func attack() -> void:
	if not self.unsheathed || not self.can_attack:
		return
	var playback:AnimationNodeStateMachinePlayback = $"AnimationTree".get("parameters/StateMachine/playback")
	
	playback.travel(attackCycle[attackState])
	attackState = (attackState + 1) % attackCycle.size()
	self.can_attack = false


func block() -> void:
	pass # Replace with function body.

var can_attack:bool
func attack_ended():
	self.can_attack = true
