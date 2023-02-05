extends Area2D

var power = 0
var lastingpow = 0
var fire = preload("res://Misc/Particles/fire.png")
var water = preload("res://Misc/Particles/water.png")
var wind = preload("res://Misc/Particles/wind.png")

func createHand( var bonus, var element):
	 
	if bonus == true:
		$Sprite.scale = Vector2(1,1)
		power += 1

	if element == "WATER":
		$Sprite.texture = water
		power += 1
		lastingpow = 2
	elif element == "FIRE":
		$Sprite.texture = fire
		power += 2
		lastingpow = 1.5
	elif element == "WIND":
		$Sprite.texture = wind
		power += 1
		lastingpow = 2
	
	$Timer.wait_time = lastingpow
	$Timer.autostart = true
	
func _on_Timer_timeout():
	self.queue_free()

func _on_FRONTATTACK_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(power)
		queue_free()
