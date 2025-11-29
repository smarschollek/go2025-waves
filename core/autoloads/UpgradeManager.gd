extends Node

var rows := 14

var showSwordman := false
var showPriest := false
var showFrostwizard := false
var showKnight := false

var pointsToSpend := 0

const UPGRADETYPES = {
    "attackSpeed": "attackSpeed",
    "attackDamage": "attackDamage",
    "health": "health",
}

var level = 0
func _physics_process(_delta: float) -> void:
    if level != GameManager.level:
        level = GameManager.level
        showSwordman = GameManager.level >= 2
        showPriest = GameManager.level >= 3
        showFrostwizard = GameManager.level >= 4
        showKnight = GameManager.level >= 5

var defenderUpgradesInitialValues = {
    "wizard" : {
        "attackSpeed" : 0,
        "attackDamage": 0,
    },
    "swordman": {
        "health" : 0,
        "attackSpeed": 0,
        "attackDamage": 0,
    },
    "priest": {
        "attackSpeed": 0,
    },
    "frostwizard": {
        "attackSpeed": 0,
        "attackDamage": 0,
    },
    "knight": {
        "health" : 0,
    },
}

var defenderUpgrades = {
    "wizard" : {
        "attackSpeed" : 0,
        "attackDamage": 0,
    },
    "swordman": {
        "health" : 0,
        "attackSpeed": 0,
        "attackDamage": 0,
    },
    "priest": {
        "attackSpeed": 0,
    },
    "frostwizard": {
        "attackSpeed": 0,
        "attackDamage": 0,
    },
    "knight": {
        "health" : 0,
    },
}

func reset() -> void:
    pointsToSpend = 0
    defenderUpgrades = defenderUpgradesInitialValues.duplicate(true)

func downgradeADefenders(defenderType: String, upgradeType: String) -> int:
    if defenderUpgrades.has(defenderType):
        if defenderUpgrades[defenderType].has(upgradeType):
            if defenderUpgrades[defenderType][upgradeType] > 0:
                defenderUpgrades[defenderType][upgradeType] -= 1
                pointsToSpend += 1
                
    print(defenderUpgrades)
    return defenderUpgrades[defenderType][upgradeType]
    

func upgradeDefender(defenderType: String, upgradeType: String) -> int:
    if pointsToSpend == 0:
        return defenderUpgrades[defenderType][upgradeType]

    if defenderUpgrades.has(defenderType):
        if defenderUpgrades[defenderType].has(upgradeType):
            if defenderUpgrades[defenderType][upgradeType] < 10:
                defenderUpgrades[defenderType][upgradeType] += 1
                pointsToSpend -= 1

    print(defenderUpgrades)
    return defenderUpgrades[defenderType][upgradeType]
    
func getDefenderValue(defenderType: String, upgradeType: String) -> int:
    if defenderUpgrades.has(defenderType):
        if defenderUpgrades[defenderType].has(upgradeType):
            return defenderUpgrades[defenderType][upgradeType]

    return 0

func applyUpgrades(value: float, defenderType: String, upgradeType: String) -> float:
    var upgradeLevel = 0
    if defenderUpgrades.has(defenderType):
        if defenderUpgrades[defenderType].has(upgradeType):
            upgradeLevel = defenderUpgrades[defenderType][upgradeType]

    for i in upgradeLevel:
        if upgradeType == UPGRADETYPES.attackSpeed:
            value = value - (value / 100 * 10)
        else: 
            value = value + (value / 100 * 10)

    return value

    
