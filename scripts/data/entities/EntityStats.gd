extends Node3D
class_name EntityStats

const WALK_SPEED = 2#m/s
const ROTATION_SPEED = 10#

const JUMP_HEIGHT = 1#m

#region Signals
signal healthModified
signal staminaModified
signal manaModified

signal healthDepleted(oldV:float, newV:float)
signal staminaDepleted(oldV:float, newV:float)
signal manaDepleted(oldV:float, newV:float)
#endregion
#region Publics
@export
var maxHealth:float

@export
var health:float:
	set(v):
		healthModified.emit(health, v)
		health = v

@export
var maxStamina:float
@export
var stamina:float:
	set(v):
		staminaModified.emit(stamina, v)
		stamina = v

@export
var maxMana:float
@export
var mana:float:
	set(v):
		manaModified.emit(mana, v)
		mana = v

@export
var walkSpeed:float
@export
var jumpHeight:float
#endregion

static func default():
	'''Initializes a functional stats sheet'''
	var r = new()
	r.maxHealth = 100
	r.health = 100
	r.maxStamina = 100
	r.stamina = 100
	r.maxMana = 100
	r.mana = 100
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

func append_health(amount:float):
	self.health = clamp(self.health + amount, 0, self.maxHealth)
	if self.health == 0:
		self.healthDepleted.emit()

func append_stamina(amount:float):
	self.stamina = clamp(self.stamina + amount, 0, self.maxStamina)
	if self.stamina == 0:
		self.staminaDepleted.emit()

func append_mana(amount:float):
	self.mana = clamp(self.mana + amount, 0, self.maxMana)
	if self.mana == 0:
		self.manaDepleted.emit()
