extends Object
class_name Combo

var animation:String
var then:Dictionary

func _init(animation:String, then:Dictionary = {}):
	self.animation = animation
	self.then = then

func next(action:Weapon.Hand) -> Combo:
	return self.then.get(action)
