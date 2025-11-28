extends Node2D

@export var data: Defender

func _ready() -> void:
    $Hurtbox.health = data.health
    $Hurtbox.receivedDamage.connect(_on_hurtbox_received_damage)

    $Lifebar.max_value = data.health
    $Lifebar.value = $Hurtbox.health

func _process(_delta: float) -> void:
    if($Hurtbox.dead):
        $Lifebar.visible = false
        $Hurtbox/CollisionShape2D.disabled = true
        $AnimatedSprite2D.play("Dead")
        await $AnimatedSprite2D.animation_finished
        queue_free()

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < data.health

    if $RayCast2D.is_colliding():
        $AnimatedSprite2D.play("Block")
        
func _on_hurtbox_received_damage(_damageAmount: int, _effectName: String, _duration: float) -> void:
    EffectManager.applyDamage($AnimatedSprite2D)
