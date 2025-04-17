extends CharacterBody3D
class_name CharacterEntity

@onready var stats:EntityStats = $EntityStats


func _physics_process(delta: float) -> void:
	_process_gravity(delta)
	self.move_and_slide()

func _process_gravity(delta:float):
	self.velocity += self.stats.get_gravity_force() * delta
