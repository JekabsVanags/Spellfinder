extends KinematicBody2D

var dir = Vector2(0,0)
var hp = 3
var power = 1

var active = false
var chasing = false

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = global_position - Global.playerpos
	self.rotation = dir.angle()-1.57 
	if active == true && chasing == true:
		move_and_slide(-dir.normalized()*Vector2(100,100))
	elif active == true && chasing == false:
		move_and_slide(dir.normalized()*Vector2(50,50))
	if hp < 0 or hp == 0:
		self.queue_free()

func take_damage(var damage):
	hp -= damage
	$AnimationPlayer.play("damaged")

func _on_Detection_body_entered(body):
	if body.name == 'Player':
		active = true
		chasing = true
		$"Chasing timer".start()

func _on_Hurt_body_entered(body):
	if body.name == "Player":
		body.takingDamage(power)
		chasing = false
		$"Retreat timer".start()


func _on_Retreat_timer_timeout():
	chasing = true
	$"Chasing timer".start()


func _on_Chasing_timer_timeout():
	chasing = false
	$"Retreat timer".start()

func _on_Detection_body_exited(body):
	if body.name == "Player":
		chasing = false
		active = false
