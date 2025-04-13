extends Object
class_name Weapon

enum WeaponType { Sword, Dagger, Hammer }

enum Hand { Main, Side }

var model:MeshInstance3D

var name:String
var type:WeaponType
var swingSpeed:float

var combos:Combo
var currentCombo:Combo

func _init(type:WeaponType):
	self.type = type

func _ready():	
	self.resetCombo()


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
