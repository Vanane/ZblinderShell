@tool
extends EditorScenePostImport

func _post_import(scene):
	var player = scene.get_node("Player")
	var collision = player.get_node("Collision")
	var shape = collision.get_node("CollisionShape3D")
	
	shape.owner = null
	shape.reparent(scene)
	shape.owner = scene
	player.remove_child(collision)
	collision.queue_free()
	
	return scene
