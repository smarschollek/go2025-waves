class_name Hitbox
extends Area2D

@export var damage: int = 1
@export var persist_on_hit: bool = false

signal hit_registered(target: Area2D)

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    
func _on_area_entered(area: Area2D) -> void:
    if area is Hurtbox:
        hit_registered.emit(area)
        if not persist_on_hit:
            get_parent().queue_free()

