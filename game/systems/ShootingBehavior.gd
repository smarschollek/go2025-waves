extends Node

@export var shootPosition: Marker2D
@export var projectileScene: PackedScene
@export var shootInterval: float = 1.0 
@export var rayCasts: Array[RayCast2D]

var timeElapsed: float = 0.0
var rayCastChildren: Array[RayCast2D] = []

var damage: int = 10
var projectileSpeed: float = 250.0

func _ready() -> void:
    for child in get_children():
        if child is RayCast2D:
            rayCastChildren.append(child)

    pass

func _process(delta: float) -> void:
    timeElapsed += delta

    if timeElapsed >= shootInterval:
        timeElapsed = 0.0
        if rayCasts.size() == 0:
            shoot()
        elif anyRaycastColliding():
            shoot()

func anyRaycastColliding() -> bool:
    for rayCast in rayCasts:
        if rayCast.is_colliding():
            return true
    return false

func shoot() -> void:
    var projectile = projectileScene.instantiate() as Projectile
    projectile.position = shootPosition.global_position 
    
    projectile.attackDamage = damage
    projectile.projectileSpeed = projectileSpeed    
    
    projectile.scale = get_parent().scale
    
    add_child(projectile)
    
