extends Node
class_name ShootBehavior

@export var shoot_position: Marker2D
@export var projectile_scene: PackedScene
@export var shoot_interval: float = 1.0 

var time_since_last_shot: float = 0.0
var animated_sprite: AnimatedSprite2D

func _ready() -> void:
    animated_sprite = get_parent().get_node("AnimatedSprite2D")
    pass

func _process(delta: float) -> void:
    time_since_last_shot += delta
    if time_since_last_shot >= shoot_interval:
        shoot()
        time_since_last_shot = 0.0

func shoot() -> void:
    animated_sprite.play("shoot")
    
    var projectile = projectile_scene.instantiate()
    projectile.position = shoot_position.global_position
    projectile.scale = get_parent().scale
    
    add_child(projectile)

    await animated_sprite.animation_finished
    animated_sprite.play("idle")
    
