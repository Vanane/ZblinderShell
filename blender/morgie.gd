extends Node3D; class_name Morgie;

var animator:AnimationPlayer


func _ready() -> void:
	self.animator = $"AnimationPlayer"
	self.animator.get_animation("PlayerActions").loop_mode = Animation.LOOP_LINEAR	

func walk():
	self.animator.play("PlayerActions")

func stop():
	self.animator.stop()
