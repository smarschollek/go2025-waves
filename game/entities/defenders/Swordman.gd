extends Node2D

@export var data: Defender

var dead = false

func _ready() -> void:
    $Hurtbox.health = data.health
    $Hurtbox.receivedDamage.connect(_on_hurtbox_receivedDamage)

    $Lifebar.max_value = data.health

    $Hitbox.damage = data.attackDamage
    
    $StateMachine/Attack.attackInterval = data.attackInterval

func _physics_process(_delta: float) -> void:
    $Lifebar.visible = $Hurtbox.health != 0
    
    if($Hurtbox.dead):
        $StateMachine.changeState("Dead")
        return

    $Lifebar.value = $Hurtbox.health
    if $RayCast2D.is_colliding():
        $StateMachine.changeState("Attack")    
    else:
        $StateMachine.changeState("Idle")

func _on_hurtbox_receivedDamage(_damageAmount: int, _effectName: String, _duration: float) -> void:
    EffectManager.applyDamage($AnimatedSprite2D)