extends CharacterBody3D

var speed:float

var _pov:TrackingCamera

var _direction:Vector3

func _ready():
	self._setup_camera()
	
	self.speed = .2

func _setup_camera():
	self._pov = get_node(get_meta("Camera"))
	self._pov.set_target(self, Vector3(-1, 0, -2.5))



func move(direction:Vector2):
	self.rotation = self._pov.rotation
	self._direction = (Vector3(-direction.x, 0.0, direction.y) * self.speed).rotated(Vector3.UP, self.rotation.y)

func jump():
	if self.is_on_floor():
		self.velocity += Vector3.UP*5
	return

func look(relative:Vector2):
	self._pov.rotate_relative(relative * ConfigurationManager.get_param("controls.mouse.sensitivity"))

func _physics_process(_delta: float) -> void:
	self.velocity += Vector3.DOWN*.5	
	self.position += self._direction
	
	var morgie:Morgie = $"Untitled"
	if _direction != Vector3.ZERO:
		morgie.walk()
	else:
		morgie.stop()
	
	_direction = Vector3.ZERO
	self.move_and_slide()

func zoom_in() -> void:
	self._pov.remove_distance()


func zoom_out() -> void:
	self._pov.add_distance()
