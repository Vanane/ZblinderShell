@tool
extends EditorScenePostImport
class_name ImportUtils

static func unwrap_collision(scene:Node, collision:Node3D, newParent:Node = null, keep:bool = true):
	var shape = collision.get_node("CollisionShape3D")
	if newParent == null:
		newParent = scene
	
	shape.owner = null
	collision.remove_child(shape)
	newParent.add_child(shape)
	shape.owner = newParent
		
	if not keep:
		collision.queue_free()
