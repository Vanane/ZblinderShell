extends Weapon
class_name Sword

func _init():
	super._init(WeaponType.Sword)
	
	self.combos = Combo.new("", {
		Hand.Main:Combo.new("SwordSwing1", {
			Hand.Main:Combo.new("SwordSwing2", {
				Hand.Side:Combo.new("SwordStab")
			})
		})
	})
	
	self._ready()
