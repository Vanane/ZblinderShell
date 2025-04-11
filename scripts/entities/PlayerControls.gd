extends CharacterBody3D

#region Exported variables
@export
var speed:float
@export
var jump_height:float

@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var moving_direction:Vector3
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var is_falling:bool
#endregion

#region Internal variables
var _pov:TrackingCamera

var _direction:Vector3
#endregion

func _ready():
	self._setup_camera()

func _physics_process(_delta: float) -> void:
	self.position += self._direction
	
	self.velocity += Vector3.DOWN*.5
	self.move_and_slide()
	
	self._direction = Vector3.ZERO

func _process(_delta:float) -> void:
	self._refresh_anim_flags()


func _setup_camera():
	self._pov = get_node(get_meta("Camera"))
	self._pov.set_target(self)

# Called each frame to expose internal variables to animation state machines
func _refresh_anim_flags():
	self.moving_direction = self._direction
	self.is_falling = not self.is_on_floor()

#region Signals
func move(direction:Vector2):
	self.rotation = self._pov.rotation
	self._direction = (Vector3(-direction.x, 0.0, direction.y) * self.speed).rotated(Vector3.UP, self.rotation.y)

func jump():
	if self.is_on_floor():
		self.velocity += Vector3.UP * jump_height
	return

func look(relative:Vector2):
	self._pov.rotate_relative(relative * ConfigurationManager.get_param("controls.mouse.sensitivity"))

func zoom_in() -> void:
	self._pov.remove_distance()

func zoom_out() -> void:
	self._pov.add_distance()
#endregion


@export
var unsheathed:bool = false
func toggle_weapon() -> void:
	self.unsheathed = not self.unsheathed
	pass # Replace with function body.
