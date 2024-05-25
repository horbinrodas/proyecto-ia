extends CanvasLayer

var coins = 0  # La variable 'coins' es explícitamente de tipo String

func _ready():

	$Count.text = str(coins)

func handleCoinCollected():
	print("coin collected")
	coins+=1
	$Count.text = str(coins)
