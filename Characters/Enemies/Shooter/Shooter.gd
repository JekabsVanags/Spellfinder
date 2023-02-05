extends StaticBody2D

var shootdir = Vector2(0,0)
var shotsinrow = 1
var hp = 2
var power = 1

var bullet = preload("res://Characters/Enemies/Shooter/Bullet.tscn")

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shootdir = global_position - Global.playerpos
	if hp <=0:
		self.queue_free()

func _on_Shoot_timer_timeout():
	if shotsinrow == 0:
		$"Shoot timer".wait_time = 3
		shotsinrow = 3
	else:
		$"Shoot timer".wait_time = 1.5
		shotsinrow-=1
		var newbullet = bullet.instance()
		newbullet.createBall(-Vector2(cos(shootdir.angle()), sin(shootdir.angle())),power)
		get_parent().add_child(newbullet)
		newbullet.global_position = self.global_position
		

func take_damage(var damage):
	hp -= damage
	$AnimationPlayer.play("damaged")

func _on_FindPLayer_timeout():
	self.rotation = shootdir.angle()-1.57 


func _on_VisibilityNotifier2D_screen_entered():
	$"Shoot timer".start()


func _on_VisibilityNotifier2D_screen_exited():
	$"Shoot timer".stop()
