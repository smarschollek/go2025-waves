extends Node

@export var shootPosition: Marker2D
@export var projectileScene: PackedScene
@export var shootInterval: float = 1.0 
@export var rayCast: RayCast2D = null

var animated_sprite: AnimatedSprite2D

func _ready() -> void:
    TimeManager.onGameTick.connect(_on_game_tick)
    animated_sprite = get_parent().get_node("AnimatedSprite2D")
    pass

func _on_game_tick(totalTicks: int) -> void:
    if totalTicks % int(shootInterval * 4) == 0:
        if rayCast == null:
            shoot()
        elif rayCast.is_colliding():
            shoot()
            
func shoot() -> void:
    animated_sprite.play("shoot")
    
    var projectile = projectileScene.instantiate()
    projectile.position = shootPosition.global_position
    projectile.scale = get_parent().scale
    
    add_child(projectile)

    await animated_sprite.animation_finished
    animated_sprite.play("idle")
    
