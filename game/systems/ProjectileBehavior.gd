extends Node

@export var animated_body: AnimatableBody2D
@export var force: float = 500.0
@export var flight_time: float = 5.0

var velocity: Vector2 = Vector2.ZERO
var elapsed_time: float = 0.0

func shoot(direction: Vector2) -> void:
    velocity = direction.normalized() * force

func _ready() -> void:
    shoot(Vector2.LEFT)
    pass # Replace with function body.

func _process(delta: float) -> void:
    if elapsed_time < flight_time:
        animated_body.position += velocity * delta
        elapsed_time += delta
    else:
        get_parent().queue_free()