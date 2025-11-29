extends Node
class_name ShootBehavior

signal shooting

@export var shootPosition: Marker2D
@export var shootPositionMinOffsetX: float = 0.0
@export var shootPositionMaxOffsetX: float = 0.0
@export var shootPositionMinOffsetY: float = 0.0
@export var shootPositionMaxOffsetY: float = 0.0
@export var projectileScene: PackedScene
@export var shootInterval: float = 1.0 
@export var damage: int = 0

var timeSinceLastShot: float = 0.0
var animatedSprite: AnimatedSprite2D

func _ready() -> void:
    animatedSprite = get_parent().get_node("AnimatedSprite2D")
    pass

func _process(delta: float) -> void:
    timeSinceLastShot += delta
    if timeSinceLastShot >= shootInterval:
        shoot()
        timeSinceLastShot = 0.0

func shoot() -> void:
    

    shooting.emit()
    var projectile = projectileScene.instantiate()
    projectile.attackDamage = damage
    projectile.position = shootPosition.global_position + Vector2(
        SeededRNG.getRandomFloat(shootPositionMinOffsetX, shootPositionMaxOffsetX),
        SeededRNG.getRandomFloat(shootPositionMinOffsetY, shootPositionMaxOffsetY)
    )
    projectile.scale = get_parent().scale
    add_child(projectile)
