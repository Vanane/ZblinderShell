extends Entity
class_name Door


#region Publics
@export
var closingSpeed:float
@export
var timeBeforeClose:float
#endregion

#region Privates
var _doorClosing:bool
var _initialRotation:Vector3

var _tweenCloseDoor:Tween
var _timerCloseDoor:SceneTreeTimer
#endregion


func _ready() -> void:
	self._initialRotation = self.rotation
	self.enable_contacts()

func enable_contacts():
	self.contact_monitor = true
	self.max_contacts_reported = 1

func _physics_process(delta: float) -> void:
	lerp_close_door()

func lerp_close_door():
	if self._doorClosing:	
		if snapped(self.rotation, Vector3.ONE * 0.01) == snapped(self._initialRotation, Vector3.ONE * 0.01):
			self._doorClosing = false
			self.angular_velocity = Vector3.ZERO
			self.linear_velocity = Vector3.ZERO
			self.rotation = self._initialRotation
		else:
			self.apply_impulse(Vector3.LEFT.rotated(Vector3.UP, self.get_parent().rotation.y) * self.closingSpeed)


func bumper_collided(a:PhysicsBody3D):
	self.angular_velocity *= -1

func push_door(who:PhysicsBody3D, impulse:Vector3):
	self.apply_impulse(impulse, who.global_position - self.global_position)
	
	if self._timerCloseDoor != null:
		self._timerCloseDoor.disconnect("timeout", self.close_door)
	self._timerCloseDoor = get_tree().create_timer(timeBeforeClose / 1000, true, true)
	self._timerCloseDoor.timeout.connect(self.close_door)


func close_door():
	self._doorClosing = true
