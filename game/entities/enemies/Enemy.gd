extends AnimatableBody2D

@export var data : Attacker

func _ready() -> void:
    $Hurtbox.health = data.health
    $Lifebar.max_value = data.health

    $Hitbox.damage = data.attackDamage
    $StateMachine/Attack.attackInterval = data.attackInterval
    $StateMachine/Walk.speed = data.moveSpeed
        
func _physics_process(_delta: float) -> void:
    if($Hurtbox.dead):
        return

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < data.health

    if $RayCast2D.is_colliding():
        $StateMachine.changeState("Attack")
    else:
        $StateMachine.changeState("Walk")

func _on_hurtbox_died() -> void:
    ReportManager.killedUnits += 1
    LevelUpManager.addXP(1)
    $StateMachine.changeState("Dead")
