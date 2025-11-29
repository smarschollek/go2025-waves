extends Node2D

@export var data: Defender

var health: int = 0

func _ready() -> void:
    health = data.health
    
    $Hurtbox.health = health
    $Hurtbox.receivedDamage.connect(_on_hurtbox_received_damage)
    
    $Lifebar.max_value = health

    $ShootBehavior.shootInterval = UpgradeManager.applyUpgrades(data.attackInterval, data.defenderType, UpgradeManager.UPGRADETYPES.attackSpeed)
    $ShootBehavior.projectileScene = data.projectileScene
    $ShootBehavior.projectileSpeed = data.projectileSpeed
    $ShootBehavior.damage = UpgradeManager.applyUpgrades(data.attackDamage, data.defenderType, UpgradeManager.UPGRADETYPES.attackDamage)
    

    $RayCast1.target_position = Vector2(global_position.x / -2.5, 0)
    $RayCast2.target_position = Vector2(global_position.x / -2.5, 0)
    $RayCast3.target_position = Vector2(global_position.x / -2.5, 0)

func _physics_process(_delta: float) -> void:
    if($Hurtbox.dead):
        $Lifebar.visible = false
        $Hurtbox/CollisionShape2D.disabled = true
        $AnimatedSprite2D.play("Dead")
        await $AnimatedSprite2D.animation_finished
        queue_free()

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < health

func _on_hurtbox_received_damage(_damage_amount: int, _effectName: String, _duration: float) -> void:
    EffectManager.applyDamage($AnimatedSprite2D)
    
