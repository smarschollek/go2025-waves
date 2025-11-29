extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $RayCast2D.target_position = Vector2(global_position.x / -2, 0)


func _physics_process(_delta: float) -> void:
    if $Hurtbox.dead:
        if killEverything():
            queue_free()

func killEverything() -> bool:
    if $RayCast2D.is_colliding():
        var collider = $RayCast2D.get_collider() 
        if collider is Hurtbox:
            collider.dead = true
            collider.died.emit()
            return false

    return true
        
