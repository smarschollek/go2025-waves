extends State
class_name AttackState

@export var animationPlayer: AnimationPlayer
@export var animation: String = "Attack"
@export var attackInterval: float = 1.0

var attackCooldown: float = 0.0

func enter() -> void:
    attack()

func update(delta: float) -> void:
    if attackCooldown <= 0:
        attack()
    
    attackCooldown -= delta
    
func attack() -> void:
    attackCooldown = attackInterval
    
    if animationPlayer:
        animationPlayer.play(animation)
        await animationPlayer.animation_finished
        animationPlayer.play("RESET")

