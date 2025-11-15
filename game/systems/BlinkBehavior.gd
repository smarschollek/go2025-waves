extends Node
class_name BlinkBehavior

@export var sprite: Node
@export var shader: ShaderMaterial

func _ready() -> void:
    if sprite == null:
        push_error("BlinkBehavior: sprite is null")
    
    if sprite is not Sprite2D and sprite is not AnimatedSprite2D:
        push_error("BlinkBehavior: sprite is not a Sprite2D or a AnimatedSprite2D")
        
func TriggerBlink(_damage) -> void:
    var tween = get_tree().create_tween()
    tween.tween_method(SetShaderBlinkIntensity, 1.0, 0, 0.2)

func SetShaderBlinkIntensity(intensity: float) -> void:
    if sprite == null:
        return
        
    sprite.material = shader
    sprite.material.set_shader_parameter("blinkIntensity", intensity)
    sprite.material.set_shader_parameter("blinkColor", Color(1, 1, 1, 1))

    
