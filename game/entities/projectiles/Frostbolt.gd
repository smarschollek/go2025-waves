extends Projectile


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $Hitbox.damage = attackDamage
    $ProjectileBehavior.force = projectileSpeed
