extends KinematicBody2D

var velocity = Vector2(0,0)
var power

func createBall(var direction, var powe):
	velocity = direction*Vector2(100,100)
	power = powe
	
func _process(delta):
	move_and_slide(velocity) 
	if get_slide_count():
		var collision = get_slide_collision(0)
		if collision.collider.name == 'Player':
			pass
		else:
			queue_free()

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		body.takingDamage(power)
		queue_free()
		
func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
