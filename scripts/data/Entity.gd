extends Object
class_name Entity


const WALK_SPEED = 2#m/s

const JUMP_HEIGHT = 1#m


#region Char Stats
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


func get_walk_speed():
	return WALK_SPEED * self.walkSpeed
	
func get_jump_height():
	return JUMP_HEIGHT * self.jumpHeight
