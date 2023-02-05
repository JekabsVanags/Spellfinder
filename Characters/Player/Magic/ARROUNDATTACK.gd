extends Area2D

var power = 1
var lastingpow = 3
var fire = preload("res://Misc/Particles/fire.png")
var water = preload("res://Misc/Particles/water.png")
var wind = preload("res://Misc/Particles/wind.png")

func createSpin( var bonus, var element):
	 
	if bonus == true:
		$CollisionShape2D.scale = Vector2(1.3,1.3)
		$Particles2D.process_material.emission_ring_radius = 90
		$Particles2D.amount = 300
		lastingpow += 2

	if element == "WATER":
		$Particles2D.texture = water
	elif element == "FIRE":
		$Particles2D.texture = fire
	elif element == "WIND":
		$Particles2D.texture = wind
	
	$Timer.wait_time = lastingpow
	$Timer.autostart = true 
	
func _on_Timer_timeout():
	get_parent().unharmable = false
	get_parent().get_child(1).disabled = true
	self.queue_free()

func _on_ARROUNDATTACK_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(power)
