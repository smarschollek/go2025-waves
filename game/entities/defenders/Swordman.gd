extends Node2D

@export var data: Defender

var dead = false

func _ready() -> void:
    $Hurtbox.health = data.health
    $Lifebar.max_value = data.health

    $Hitbox.damage = data.attackDamage
    
    $StateMachine/Attack.attackInterval = data.attackInterval

func _physics_process(_delta: float) -> void:
    if(dead):
        return

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < data.health
    
    if $RayCast2D.is_colliding():
        $StateMachine.changeState("Attack")    
    else:
        $StateMachine.changeState("Idle")
    
func _on_hurtbox_died() -> void:
    dead = true
    $StateMachine.changeState("Dead")
