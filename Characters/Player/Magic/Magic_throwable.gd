extends KinematicBody2D

var velocity = Vector2(0,0)
var power = 0
var speed = 0
var elemtype
var fire = preload("res://Misc/Particles/fire.png")
var water = preload("res://Misc/Particles/water.png")
var wind = preload("res://Misc/Particles/wind.png")

func createBall(var direction, var bonus, var element):
	elemtype = element
	if bonus == true:
		$Magic.scale = Vector2(1.5,1.5)
		$Particles2D.scale = Vector2(1.5,1.5)
		power += 2
		
	if element == "WATER":
		$Particles2D.texture = water
		speed = Vector2(100,100)
		power = 2
	elif element == "FIRE":
		$Particles2D.texture = fire
		power = 2
		speed = Vector2(120,120)
	elif element == "WIND":
		$Particles2D.texture = wind
		power = 1
		speed = Vector2(200,200)
	velocity = direction*speed 
	
func _process(delta):
	move_and_slide(velocity) 
	if get_slide_count():
		var collision = get_slide_collision(0)
		if collision.collider.name == 'Magic' or '@Magic@' in collision.collider.name:
			$CollisionShape2D.disabled = true
			$Timer.start()
		else:
			queue_free()
		

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(power)
		queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false


