extends CharacterEntity

#region Publics
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var walkDirection:Vector2
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isFalling:bool

@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var weapon:Weapon
#endregion

#region Privates
var _animSM:AnimationNodeStateMachinePlayback
var _camera:TrackingCamera

var _walkDirection:Vector2
var _cameraRotation:Vector2
var _lastVelocity:Vector3

#endregion

func _ready():
	self._animSM = $"AnimationTree".get("parameters/StateMachine/playback")
	self.weapon = $RightFingersAttachment/sword
	
	self._setup_camera()
	
	self.add_collision_exception_with(self.weapon)
	self.sheath_weapon()

func _process(delta:float) -> void:
	self._refresh_anim_flags()

func _physics_process(delta: float) -> void:
	_process_controls(delta)
	_process_gravity(delta)	
	
	_lastVelocity = self.velocity
	self.move_and_slide()
	
	_process_collisions(delta)
	
	_process_cleanup(delta)

func _process_controls(delta: float):
	# Camera movements, prior to moving relative to the camera
	self._camera.rotate_relative(self._cameraRotation * ConfigurationManager.get_param("controls.mouse.sensitivity"))	

	if self._walkDirection != Vector2.ZERO:
		# Walk direction
		var angledWalk = Vector3(-_walkDirection.x, 0.0, _walkDirection.y).rotated(Vector3.UP, self._camera.rotation.y)
		
		# Body rotation to follow the direction		
		var targetAngle = self.basis.z.signed_angle_to(angledWalk, Vector3.UP)
		self.rotation.y += lerp(0.0, targetAngle, self.stats.ROTATION_SPEED * delta)
		
		# Walk action
		self.velocity = Vector3(
			angledWalk.x * self.stats.get_walk_speed(), 
			self.velocity.y, 
			angledWalk.z * self.stats.get_walk_speed())
	elif self.is_on_floor():
		# If no walk action, and player is on floor, stop character gradually
		# Otherwise, let him fly
		self.velocity = Vector3(
			lerp(self.velocity.x, 0.0, self.stats.ROTATION_SPEED * delta),
			self.velocity.y,
			lerp(self.velocity.z, 0.0, self.stats.ROTATION_SPEED * delta))
	
func _process_collisions(delta:float):
	var k = self.get_last_slide_collision()
	if k:
		var c = k.get_collider()
		if c is RigidBody3D:
			if c is Door:
				c.push_door(self, _lastVelocity)
			else:
				c.apply_impulse(_lastVelocity, self.global_position)
		else:
			pass#print("%s collided with %s" % [self.name, c.name])


func _process_cleanup(delta: float):
	self._walkDirection = Vector2.ZERO
	self._cameraRotation = Vector2.ZERO

func _setup_camera():
	self._camera = get_node(get_meta("Camera"))
	self._camera.set_target(self)

# Called each frame to expose internal variables to animation state machines
func _refresh_anim_flags():
	self.walkDirection = self._walkDirection
	self.isFalling = not self.is_on_floor()

#region Signal Handling
func move(direction:Vector2):
	self._walkDirection = direction

func jump():
	if self.is_on_floor():
		self.velocity += self.stats.get_jump_height()
	return

func look(relative:Vector2):
	self._cameraRotation = Vector2(-relative.x, relative.y)

func zoom_in() -> void:
	self._camera.remove_distance()

func zoom_out() -> void:
	self._camera.add_distance()

func toggle_weapon() -> void:
	if self.weapon.isWeaponOut:
		self.sheath_weapon()
	else:
		self.unsheath_weapon()

func attack() -> void:
	self.do_attack(Weapon.Hand.Main)

func block() -> void:
	self.do_attack(Weapon.Hand.Side)
#endregion

#region Animation Signals

func attack_ended():
	self.weapon.attack_ended()
	
func combo_ended():
	self.weapon.combo_ended()

func do_attack(hand:Weapon.Hand):
	if not self.weapon.isWeaponOut || not self.weapon.isAllowedToAttack || self.weapon.isSwinging:
		return
	
	var c:Combo = self.weapon.next_combo(hand)

	if not c == null:
		self.weapon.attack_started()
		self._animSM.travel(c.animation)

#endregion

#region Player Controls
func unsheath_weapon():
	self.weapon.unsheath()
	self.weapon.visible = true

func sheath_weapon():
	self.weapon.sheath()
	self.weapon.visible = false

#endregion
