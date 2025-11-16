extends Node

@export var shootPosition: Marker2D
@export var projectileScene: PackedScene
@export var shootInterval: float = 1.0 
@export var rayCast: RayCast2D = null

var animated_sprite: AnimatedSprite2D
var timeElapsed: float = 0.0

func _ready() -> void:
    
    animated_sprite = get_parent().get_node("AnimatedSprite2D")
    pass

func _process(delta: float) -> void:
    timeElapsed += delta

    if timeElapsed >= shootInterval:
        timeElapsed = 0.0
        if rayCast == null:
            shoot()
        elif rayCast.is_colliding():
            shoot()

func shoot() -> void:
    var projectile = projectileScene.instantiate()
    projectile.position = shootPosition.global_position
    projectile.scale = get_parent().scale
    
    add_child(projectile)
    
