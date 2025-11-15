class_name DetectionBox
extends Area2D

signal collisionDetected(target: Area2D)

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if area is Hurtbox:
        collisionDetected.emit(area)