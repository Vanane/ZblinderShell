extends CharacterBody3D
class_name CharacterEntity

@onready var stats:EntityStats = $EntityStats


func _ready() -> void:
	self.stats.healthDepleted.connect(self.health_depleted)
	self.stats.staminaDepleted.connect(self.stamina_depleted)
	self.stats.manaDepleted.connect(self.mana_depleted)

func _physics_process(delta: float) -> void:
	_process_gravity(delta)
	self.move_and_slide()

func _process_gravity(delta:float):
	self.velocity += self.stats.get_gravity_force() * delta


func take_damage(dmg:float, who:Node3D):
	self.stats.append_health(-dmg)
	print("Ouch ! %s dealt %s to %s. Has %s HP left." % [who.name, dmg, self.name, self.stats.health])

func health_depleted():
	self.collision_layer -= CollisionLayers.WEAPONS

func stamina_depleted():
	pass
	
func mana_depleted():
	pass
