extends AnimatableBody3D
class_name Weapon

enum WeaponType { Sword, Dagger, Hammer }

enum Hand { Main, Side }
#region Publics
var model:MeshInstance3D

var weaponName:String
var type:WeaponType
var swingSpeed:float

var combos:Combo

#region Internal States
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isWeaponOut:bool
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var isAllowedToAttack:bool
@export_custom(PROPERTY_HINT_NONE, "readonly", PROPERTY_USAGE_READ_ONLY)
var currentCombo:Combo
#endregion
#endregion


func _init(type:WeaponType):
	self.type = type

func _ready():	
	self.resetCombo()

#region States Manipulations
func resetCombo():
	self.currentCombo = self.combos

func nextCombo(hand:Hand):
	if self.currentCombo == null:
		return null
	
	self.currentCombo = self.currentCombo.next(hand)
	if self.currentCombo == null:
		self.resetCombo()
		return null
	return self.currentCombo
	
func sheath():
	self.isAllowedToAttack = false
	self.isWeaponOut = false

func unsheath():
	self.isAllowedToAttack = true
	self.isWeaponOut = true

#endregion
