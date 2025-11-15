extends AnimatableBody2D

func _on_detection_box_collision_detected(_target: Area2D) -> void:
    $StateMachine.currentState.changeState.emit($StateMachine.currentState, "Attack")
