extends Unit
class_name Defender

@export var cost: int = 100
@export var attackDamage: float = 10.0
@export var attackInterval: float = 1.0

@export var isMelee: bool = false

@export var projectileScene: PackedScene
@export var projectileSpeed: float = 250.0

@export var sprite: Texture2D

@export var buildCooldown: float = 10.0