@tool
extends EditorScenePostImport

func _post_import(scene:Node):
	self.unwrap_collisions(scene)
	self.add_metadata(scene)
	
	return scene

func add_metadata(scene:Node):
	scene.set_meta("Camera", NodePath())
	
func unwrap_collisions(scene:Node):	
	ImportUtils.unwrap_collision(scene, scene.get_node("Entity/EntityCollision"), scene, false)

	scene.collision_layer = 1 | 2
	scene.collision_mask = 1 | 2
