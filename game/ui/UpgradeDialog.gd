extends PanelContainer

@onready var swordmanContainer = $VBoxContainer/PanelContainer2/SwordmanContainer
@onready var priestContainer = $VBoxContainer/PanelContainer3/PriestContainer
@onready var frostwizardContainer = $VBoxContainer/PanelContainer4/FrostwizardContainer
@onready var knightContainer = $VBoxContainer/PanelContainer5/KnightContainer


@onready var pointsToSpendLabel = $VBoxContainer/CenterContainer/PointsLabel

func _ready() -> void:
    swordmanContainer.visible = UpgradeManager.showSwordman
    priestContainer.visible = UpgradeManager.showPriest
    frostwizardContainer.visible = UpgradeManager.showFrostwizard
    knightContainer.visible = UpgradeManager.showKnight


@onready var pointsToSpend := 0

func _physics_process(_delta: float) -> void:
    if pointsToSpend != UpgradeManager.pointsToSpend:
        pointsToSpend = UpgradeManager.pointsToSpend
        pointsToSpendLabel.text = "Points to spend: %d" % UpgradeManager.pointsToSpend    

