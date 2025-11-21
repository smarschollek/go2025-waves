@tool
extends Node2D

@export var scene: PackedScene

@export var info: Defender:
    set(value):
        info = value
        $PreviewSprite.texture = info.sprite
        $Label.text = str(info.cost)

var draggable: bool = false
var insideDropzone: bool = false
var current_dropzone = null
var drag_preview: Area2D

@onready var drag_scene = preload("res://game/ui/DragPreview.tscn")

var isDragging = false

func _ready() -> void:
    MoneyManager.moneyChanged.connect(toggleCardEnabled)

    DragAndDropManager.cardDropped.connect(_onCardDropped)
    
func _input(event: InputEvent):
    if MoneyManager.hasEnoughMoney(info.cost) == false:
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and $PreviewSprite.get_rect().has_point(to_local(event.position)) :
            if DragAndDropManager.isDragging():
                clearPreviewSprite()
                DragAndDropManager.clear()                
            else:
                DragAndDropManager.startDrag(self, scene, $PreviewSprite.texture)
                


    if event is InputEventMouseMotion and DragAndDropManager.isDragging():
        DragAndDropManager.onDrag(event.position)


func _onCardDropped(_dropZone: Node, card: Node):
    clearPreviewSprite()
    if card == self:
        MoneyManager.spendMoney(info.cost)
        startCooldown() 

func clearPreviewSprite():
    if drag_preview:
        drag_preview.queue_free()
        drag_preview = null

var cooldownCounter = 0

func startCooldown():
    cooldownCounter = 0
    $CooldownOverlay.visible = true
    $CooldownOverlay/Label.text = str(int(info.buildCooldown - cooldownCounter))
    $CooldownTimer.start()

func _on_cooldown_finished():
    if cooldownCounter == (info.buildCooldown - 1):
        $CooldownOverlay.visible = false
        cooldownCounter = 0
    else:
        cooldownCounter += 1.0
        $CooldownOverlay/Label.text = str(int(info.buildCooldown - cooldownCounter))
        $CooldownTimer.start()
        
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
