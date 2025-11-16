@tool
extends Node2D

@export var info: DefenderInfo:
    set(value):
        info = value
        $PreviewSprite.texture = info.previewSprite
        $Label.text = str(info.cost)

var draggable: bool = false
var insideDropzone: bool = false
var current_dropzone = null
var drag_preview: Area2D

@onready var drag_scene = preload("res://game/ui/DragPreview.tscn")

var isDragging = false

func _ready() -> void:
    MoneyManager.moneyChanged.connect(toggleCardEnabled)
    $PreviewSprite.texture = info.previewSprite
    $Label.text = str(info.cost)
    pass

func _input(event: InputEvent):
    if MoneyManager.hasEnoughMoney(info.cost) == false:
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and $PreviewSprite.get_rect().has_point(to_local(event.position)) :

            start_drag(event.position)
        elif not event.pressed and isDragging:
            end_drag(event.position)

    if event is InputEventMouseMotion and isDragging:
        drag_preview.global_position = event.position

func start_drag(mouse_pos: Vector2):
    setDragging(true)
    
    drag_preview = drag_scene.instantiate()
    drag_preview.sprite = $PreviewSprite.texture
    drag_preview.scale = Vector2(1.5, 1.5)
    drag_preview.z_index = 1
    
    drag_preview.connect("dropzone_entered", Callable(self, "_on_dropzone_entered"))
    drag_preview.connect("dropzone_exited", Callable(self, "_on_dropzone_exited"))
    
    get_tree().current_scene.add_child(drag_preview)
    drag_preview.global_position = mouse_pos

func end_drag(_mouse_pos: Vector2):
    if current_dropzone != null:
        if MoneyManager.spendMoney(info.cost):
            startCooldown()
            GameManager.occupyDropzone(current_dropzone)
            var defender_instance = info.defenderScene.instantiate()
            defender_instance.position = current_dropzone.position
            get_tree().current_scene.add_child(defender_instance)
            
    
    setDragging(false)
    drag_preview.queue_free()

var cooldownCounter = 0

func startCooldown():
    cooldownCounter = 0
    $CooldownOverlay.visible = true
    $CooldownOverlay/Label.text = str(int(info.cooldownTime - cooldownCounter))
    $CooldownTimer.start()

func _on_cooldown_finished():
    if cooldownCounter == (info.cooldownTime - 1):
        $CooldownOverlay.visible = false
        cooldownCounter = 0
    else:
        cooldownCounter += 1.0
        $CooldownOverlay/Label.text = str(int(info.cooldownTime - cooldownCounter))
        $CooldownTimer.start()
        

func setDragging(value: bool):
    GameManager.isDragging = value
    isDragging = value
    current_dropzone= null

func _on_dropzone_entered(zone):
    current_dropzone = zone

func _on_dropzone_exited(zone):
    if current_dropzone == zone:
        current_dropzone = null

func toggleCardEnabled(newTotalMoney: int) -> void:
    if newTotalMoney >= info.cost:
        $PreviewSprite.modulate = Color(1, 1, 1, 1)
        $CardSprite.modulate = Color(1, 1, 1, 1)
        $Label.modulate = Color(1, 1, 1, 1)
        $Area2D/CollisionShape2D.disabled = false
    else:
        $PreviewSprite.modulate = Color(1, 1, 1, 0.5)
        $CardSprite.modulate = Color(1, 1, 1, 0.5)
        $Label.modulate = Color(1, 0, 0, 0.5)
        $Area2D/CollisionShape2D.disabled = true
    pass
