extends Node2D
class_name BagManager

var bag : Array[BagScheduleItem] = []

@export var schedule : Array[BagScheduleItem] = []

var timer := 0.0

func _process(delta: float) -> void:
    timer += delta
    _checkBagSchedule()

func _checkBagSchedule() -> void:
    for item in schedule:
        if timer >= item.time:
            if item.action.to_upper() == "ADD":
                bag.append(item)
                schedule.erase(item)
                
            elif item.action.to_upper() == "REMOVE":

                var query = bag.filter(func(bagItem): 
                    return bagItem.type == item.type and bagItem.level == item.level
                )
                
                if query.size() > 0:
                    bag.erase(query[0])
                    schedule.erase(item)

func hasBagItems() -> bool:
    return bag.size() > 0

func getRandomBagItem() -> BagScheduleItem:
    if bag.size() == 0:
        return null
    var index = SeededRNG.getRandI() % bag.size()
    return bag[index]


func printBagContents() -> void:
    print("Current Bag Contents:")
    for item in bag:
        print(" - %s level %s" % [item.type, item.level])

