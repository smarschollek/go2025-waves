extends AnimatableBody2D

var currentTarget: Area2D = null

func _process(_delta: float) -> void:
    if $StateMachine.currentState.name == "Attack" and not is_instance_valid(currentTarget):
        # $StateMachine.currentState.changeState.emit($StateMachine.currentState, "Walking")
        pass
func _on_detection_box_collision_detected(target: Area2D) -> void:
    currentTarget = target
    $StateMachine.currentState.changeState.emit($StateMachine.currentState, "Attack")

func _on_hurtbox_died() -> void:
    ReportManager.killedUnits += 1
    $StateMachine.currentState.changeState.emit($StateMachine.currentState, "Dead")
