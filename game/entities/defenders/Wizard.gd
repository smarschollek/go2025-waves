extends Node2D

@export var data: Defender

func _ready() -> void:
    $Hurtbox.health = data.health
    $Hurtbox.receivedDamage.connect(_on_hurtbox_received_damage)
    
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

func _physics_process(_delta: float) -> void:
    $Lifebar.visible = $Hurtbox.health != 0
    
    if($Hurtbox.dead):
        $Hurtbox/CollisionShape2D.disabled = true
        $AnimatedSprite2D.play("Dead")
        await $AnimatedSprite2D.animation_finished
        queue_free()

    $Lifebar.value = $Hurtbox.health

func _on_hurtbox_received_damage(_damage_amount: int, _effectName: String, _duration: float) -> void:
    EffectManager.applyDamage($AnimatedSprite2D)
    
