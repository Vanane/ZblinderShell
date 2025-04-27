extends AnimatableBody3D
class_name Weapon

enum WeaponType { Sword, Dagger, Hammer }

enum Hand { Main, Side }
#region Publics
@export
var weaponOwner:Node3D

var model:MeshInstance3D

var weaponName:String
var type:WeaponType
var swingSpeed:float

var combos:Combo
#endregion
#region Internals
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isWeaponOut:bool
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isAllowedToAttack:bool
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isSwinging:bool
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var currentCombo:Combo

@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var collisionTracker:Array
#endregion

func _init(type:WeaponType):
	self.type = type

func _ready():	
	self.reset_combo()

#region States Manipulations
func reset_combo():
	self.currentCombo = self.combos
	self.reset_collisions()

func next_combo(hand:Hand):
	if self.currentCombo == null:
		return null
	
	self.currentCombo = self.currentCombo.next(hand)
	if self.currentCombo == null:
		self.reset_combo()
		return null
	return self.currentCombo
	
func sheath():
	self.isAllowedToAttack = false
	self.isWeaponOut = false
	self.isSwinging = false

func unsheath():
	self.isAllowedToAttack = true
	self.isWeaponOut = true
	self.isSwinging = false
	self.reset_collisions()

func attack_started():
	self.isSwinging = true
	self.isAllowedToAttack = false
	
func attack_ended():
	self.isAllowedToAttack = true
	self.isSwinging = false
	self.reset_collisions()

func combo_ended():
	self.isAllowedToAttack = true
	self.isSwinging = false
	self.reset_combo()

func reset_collisions():
	self.collisionTracker = []

#endregion
