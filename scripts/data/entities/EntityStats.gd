extends Node3D
class_name EntityStats

const WALK_SPEED = 2#m/s
const ROTATION_SPEED = 10#

const JUMP_HEIGHT = 1#m

#region Signals
signal healthDepleted
signal staminaDepleted
signal manaDepleted

#region Publics
@export
var maxHealth:float
@export
var health:float

@export
var maxStamina:float
@export
var stamina:float

@export
var maxMana:float
@export
var mana:float

@export
var walkSpeed:float
@export
var jumpHeight:float
#endregion

static func default():
	'''Initializes a functional stats sheet'''
	var r = new()
	r.maxHealth = 1
	r.health = 1
	r.maxStamina = 1
	r.stamina = 1
	r.maxMana = 1
	r.mana = 1
	r.walkSpeed = 1
	r.jumpHeight = 1
	
	return r


func get_walk_speed():
	return (self.walkSpeed if self.walkSpeed > -1 else WALK_SPEED)
	
func get_jump_height() -> Vector3:
	return Vector3.UP * (self.jumpHeight if self.jumpHeight > -1 else JUMP_HEIGHT) * 2 * sqrt(get_gravity()/2)

func get_gravity() -> float:
	return float(ProjectSettings.get_setting("physics/3d/default_gravity"))
	
func get_gravity_force() -> Vector3:
	return Vector3(ProjectSettings.get_setting("physics/3d/default_gravity_vector")) * get_gravity()
