@tool
extends Node3D
class_name DoorRoot

#region Publics
@export var doorDimensions: Vector3:
	set(new):
		doorDimensions = new
		if self.is_node_ready():
			self.resize_elements()
#endregion

#region Privates
var doorBody:Door
var doorCol:CollisionShape3D
var doorMesh:MeshInstance3D

#endregion


func _ready():
	self.doorBody = $"DoorBody"
	self.doorCol = $"DoorBody/Collision"
	self.doorMesh = $"DoorBody/Collision/Mesh"
	
	self.resize_elements()


func resize_elements():
	self.resize_door()
	self.resize_bumpers()

func resize_door():
	self.doorCol.shape.size = self.doorDimensions
	self.doorMesh.mesh.size = self.doorDimensions
	doorBody.center_of_mass = Vector3(self.doorDimensions.x/2, 0, 0)
	
func resize_bumpers():
	var i = 1
	for b in ["DoorBumperBack", "DoorBumperFront"]:
		var bumperBody = self.get_node(b)
		var bumperCol = bumperBody.get_node("Collision")
		
		bumperCol.shape.size = Vector3(1, 1, 1)
		bumperBody.position = Vector3(
			self.doorDimensions.x / 2 + bumperCol.shape.size.x / 2 + self.doorDimensions.z / 2,
			0,
			i * (self.doorDimensions.z / 2 + bumperCol.shape.size.z / 2))
		
		i *= -1
		
