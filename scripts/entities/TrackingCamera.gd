extends Node3D;class_name TrackingCamera;

signal pov_entered
signal pov_exited

var target:Node3D

var offset:Vector3

#region Internal fields

var _pivot:Node3D
var _camera:Node3D

var _distanceStep:float
var _maxDistance:float
var _cameraOrigin:Vector3
var _xLimit:Vector2

#region Animations & Easing



#endregion

#endregion

func _ready() -> void:
	self._camera = $Pivot/Camera
	self._pivot = $Pivot
	self._cameraOrigin = self._camera.position
	self._distanceStep = 1
	self._maxDistance = 20
	self._xLimit = Vector2(-75, 75)


func _process(_delta: float) -> void:
	self.position = self.target.position
	self._camera.position = self.offset

func set_target(target:Node3D, offset:Vector3 = Vector3.ZERO):
	self.target = target
	self.offset = offset
	self._camera.position = self._cameraOrigin + self.offset

func rotate_relative(relative:Vector2) -> void:
	self.rotate_y(-relative.x)
	self._pivot.rotate_x(relative.y)
	self._pivot.rotation.x = deg_to_rad(clamp(self._pivot.rotation_degrees.x, self._xLimit.x, self._xLimit.y))

func set_distance(distance:float):
	var d = clamp(distance, -self._maxDistance, 0)
	self.offset.z = d
	
	if not is_pov() and self.offset.z == 0:
		pov_entered.emit()
	else:
		if is_pov() and self.offset.z != 0:
			pov_exited.emit()

func add_distance():
	self.set_distance(self.offset.z - self._distanceStep)

func remove_distance():
	self.set_distance(self.offset.z + self._distanceStep)

func is_pov():
	return self._camera.position.z == 0
