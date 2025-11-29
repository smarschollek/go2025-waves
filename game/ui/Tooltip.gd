@tool
extends TextureRect

@export var tooltipPosition: String = "top":
    set(value): 
        tooltipPosition = value
        if tooltipPosition == "top":
            self.texture = preload("res://assets/sprites/Tooltip_top.png")
        elif tooltipPosition == "left":
            self.texture = preload("res://assets/sprites/Tooltip_left.png")   
        else :
            self.texture = preload("res://assets/sprites/Tooltip.png")   


@export var title: String:
    set(value):
        title = value
        $TitleLabel.text = title

@export var description: String:
    set(value):
        description = value
        $DescriptionLabel.text = description

@export var show:= false:
    set(value):
        show = value
        visible = show

func _ready() -> void:
    self.z_index = GameManager.ZINDEX.UI
    visible = false
