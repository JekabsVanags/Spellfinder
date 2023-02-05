extends Particles2D

var lastingpow = 3
var fire = preload("res://Misc/Particles/fire.png")
var water = preload("res://Misc/Particles/water.png")
var wind = preload("res://Misc/Particles/wind.png")

func createAura( var bonus, var element):
	 
	if bonus == true:
		$Timer.start(lastingpow+2)
		$Light2D.energy = 1.5
		amount = 10

	if element == "WATER":
		texture = water
		$Light2D.color = Color(0.22,0.43,0.85)
		$Healtimer.start(1)
	elif element == "FIRE":
		texture = fire
		$Light2D.color = Color(0.62,0.12,0.09)
		get_parent().unharmable = true
	elif element == "WIND":
		texture = wind
		$Light2D.color = Color(0.5,0.82,0.82)
		get_parent().speed = 400

func _process(delta):
	print(get_parent().speed)
func _on_Timer_timeout():
	get_parent().unharmable = false
	get_parent().speed = 250
	self.queue_free()


func _on_Healtimer_timeout():
	get_parent().hp+=1
	$Healtimer.start()
