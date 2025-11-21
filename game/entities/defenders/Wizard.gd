extends Node2D

@export var data: Defender

func _ready() -> void:
    $Hurtbox.health = data.health
    
    $Lifebar.max_value = data.health
    $Lifebar.visible = $Hurtbox.health < data.health
    $Lifebar.value = $Hurtbox.health

    $ShootBehavior.shootInterval = data.attackInterval
    $ShootBehavior.projectileScene = data.projectileScene
    $ShootBehavior.damage = data.attackDamage
    $ShootBehavior.projectileSpeed = data.projectileSpeed

    $RayCast1.target_position = Vector2(global_position.x / -2.5, 0)
    $RayCast2.target_position = Vector2(global_position.x / -2.5, 0)
    $RayCast3.target_position = Vector2(global_position.x / -2.5, 0)
    
func _on_hurtbox_died() -> void:
    $Hurtbox/CollisionShape2D.disabled = true
    
    $AnimatedSprite2D.play("dead")
    await $AnimatedSprite2D.animation_finished
    queue_free()


func _on_hurtbox_received_damage(_damage_amount: int) -> void:
    $Lifebar.visible = $Hurtbox.health < data.health
    $Lifebar.value = $Hurtbox.health
