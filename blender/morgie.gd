extends Node3D; class_name Morgie;

var animator:AnimationPlayer


func _ready() -> void:
	$"Player/Collision/CollisionShape3D".reparent(self)

	self.animator = $"AnimationPlayer"
	self.animator.play("Idle")

func run():
	self.animator.play("Run")

func stop():
	self.animator.play("Idle")
