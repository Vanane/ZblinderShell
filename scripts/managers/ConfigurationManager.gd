extends Node3D

class_name ConfigurationManager


static var params:Dictionary  = {
		"controls": {
			"mouse": {
					"sensitivity":0.005
				}
		}
	}


static func get_param(name:String):
	var t = ConfigurationManager.params
	for sub in name.split('.'):
		t = t[sub]
	return t
