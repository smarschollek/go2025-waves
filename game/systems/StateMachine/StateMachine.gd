extends Node
class_name StateMachine

@export var initialState: State

var states : Dictionary = {}

var stateStack : Array = []

var currentState : State

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            
    enterState(initialState)
    
func _process(delta: float) -> void:
    if currentState:
        currentState.update(delta)

func _physics_process(delta: float) -> void:
    if currentState:
        currentState.physics_update(delta)

func enterState(state: State) -> void:
    currentState = state
    currentState.enter()

func changeState(new_state_name: String) -> void:
    if currentState and currentState.name.to_lower() == new_state_name.to_lower():
        return

    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        return

    if currentState:
        stateStack.append(currentState)
        currentState.exit()

    enterState(new_state)