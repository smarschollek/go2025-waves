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
            child.changeState.connect(_on_child_changeState)
            child.previousState.connect(_on_child_previousState)

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

func _on_child_previousState():
    if stateStack.size() == 0:
        return

    var previous_state = stateStack.pop_back()
    if !previous_state:
        return

    if currentState:
        currentState.exit()
        
    enterState(previous_state)

func _on_child_changeState(state: State, new_state_name: String) -> void:
    if state != currentState:
        return

    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        return

    if currentState:
        stateStack.append(currentState)
        currentState.exit()
        
    enterState(new_state)
