extends Object
class_name Combo

var animation:String
var rawDamage:float
var then:Dictionary

func _init(_animation:String, _rawDamage:float, _then:Dictionary = {}):
	self.animation = _animation
	self.then = _then
	self.rawDamage = _rawDamage

func next(action:Weapon.Hand) -> Combo:
	return self.then.get(action)
