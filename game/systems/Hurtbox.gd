class_name Hurtbox
extends Area2D

var dead : bool = false

signal received_damage(damage_amount: int)
signal died()

@export var health : int

func _ready() -> void:
    connect("area_entered", _on_body_entered)
    pass

func _on_body_entered(hitbox: Area2D) -> void:
    if hitbox is Hitbox:
        health -= hitbox.damage
        emit_signal("received_damage", hitbox.damage)
        
        if health <= 0:
            dead = true
            emit_signal("died")
