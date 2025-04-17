@tool
extends EditorScenePostImport

func _post_import(scene:Node):
	self.unwrap_collisions(scene)
	
	return scene


func unwrap_collisions(scene:Node):	
	ImportUtils.unwrap_collision(scene, scene.get_node("Model/_Collision"), scene, false)
	
	scene.collision_layer = 2
	scene.collision_mask = 2
