@tool
extends EditorScenePostImport

func _post_import(scene:Node):
	self.unwrap_collision(scene)
	self.add_metadata(scene)
	
	return scene

func add_metadata(scene:Node):
	scene.set_meta("Camera", NodePath())
	
func unwrap_collision(scene:Node):
	var player = scene.get_node("Player")
	var collision = player.get_node("_Collision")
	var shape = collision.get_node("CollisionShape3D")

	shape.owner = null
	collision.remove_child(shape)
	scene.add_child(shape)
	shape.owner = scene
	
	player.remove_child(collision)
	collision.queue_free()
	return scene
