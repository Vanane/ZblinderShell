extends Weapon
class_name Sword

@onready
var collider:CollisionShape3D = $CollisionShape3D

func _init() -> void:
	super._init(WeaponType.Sword)
	
	self.combos = Combo.new("", 0, {
		Hand.Main:Combo.new("SwordSwing1", 1, {
			Hand.Main:Combo.new("SwordSwing2", 2, {
				Hand.Side:Combo.new("SwordStab", 3)
			})
		})
	})


func _physics_process(delta: float) -> void:
	if not self.isSwinging:
		return
	var k = self.move_and_collide(Vector3.ZERO, true)
	if k:
		var c = k.get_collider()
		if c is CharacterEntity:
			if self.collisionTracker.find(c) < 0:
				c.take_damage(self.currentCombo.rawDamage, self.weaponOwner)
				self.collisionTracker.append(c)
			
	
