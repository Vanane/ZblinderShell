extends Node3D
# Publics
@export
var joystickLeftSensitivity:float = 2.5


# Privates
var _joystickMotion:Vector2

# Signals
signal playerJumped
signal playerMoved(direction:Vector2)
signal playerAttacked
signal playerBlocked
signal playerUnsheathed

signal zoomedIn
signal zoomedOut
signal mouseMoved(relative:Vector2)

func _process(_delta: float) -> void:
	scanInputs()
	scanZooms()
	
	manageJoystickRightMotion()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.mouseMoved.emit(event.relative)
	elif event is InputEventJoypadMotion:
		self._joystickMotion = snapped(Vector2(		
			event.axis_value if event.axis == JOY_AXIS_RIGHT_X else self._joystickMotion.x,
			event.axis_value if event.axis == JOY_AXIS_RIGHT_Y else self._joystickMotion.y),
			Vector2(.2,.2))
			

func scanInputs():
		var direction = Input.get_vector("Left", "Right", "Down", "Up")
		var jump = Input.is_action_just_pressed("Smash")
		var attack = Input.is_action_just_pressed("FirstAction")
		var block = Input.is_action_just_pressed("SecondAction")
		var sheathUnsheath = Input.is_action_just_pressed("ThirdAction")
		if direction != Vector2.ZERO:
			playerMoved.emit(direction)
		
		if jump:
			playerJumped.emit()
			
		if attack:
			playerAttacked.emit()
			
		if block:
			playerBlocked.emit()
			
		if sheathUnsheath:
			playerUnsheathed.emit()

func scanZooms():
	if Input.is_action_just_pressed("ScrollUp"):
		zoomedIn.emit()
	if Input.is_action_just_pressed("ScrollDown"):
		zoomedOut.emit()


func manageJoystickRightMotion():
	if self._joystickMotion != Vector2.ZERO:
		self.mouseMoved.emit(self._joystickMotion * joystickLeftSensitivity)
