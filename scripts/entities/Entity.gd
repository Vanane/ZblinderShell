extends RigidBody3D
class_name Entity


func _physics_process(delta: float) -> void:
	_process_gravity()


func _process_gravity():
	self.apply_force(get_gravity())
