@tool
extends EditorScenePostImport

func _post_import(scene):
	self.unwrap_collision(scene)
	return scene

func unwrap_collision(scene):
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
