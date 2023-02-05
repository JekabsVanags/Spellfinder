extends StaticBody2D

var hp = 4
var power = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp <= 0:
		self.queue_free()

func take_damage(var damage):
	hp -= damage
	$AnimationPlayer.play("damaged")

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		body.takingDamage(power)
