extends Node3D

signal playerJumped
signal playerMoved(direction:Vector2)

signal zoomedIn
signal zoomedOut
signal mouseMoved(relative:Vector2)

func _process(_delta: float) -> void:
	scanInputs()
	scanZooms()
	
func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
	mouseMoved.emit(event.relative)


func scanInputs():
		var direction = Input.get_vector("PlayerMoveLeft", "PlayerMoveRight", "PlayerMoveBackward", "PlayerMoveForward")
		var jump = Input.is_action_just_pressed("PlayerJump")
		if direction != Vector2.ZERO:
			playerMoved.emit(direction)
		
		if jump:
			playerJumped.emit()

func scanZooms():
	if Input.is_action_just_pressed("ZoomIn"):
		zoomedIn.emit()
	if Input.is_action_just_pressed("ZoomOut"):
		zoomedOut.emit()
