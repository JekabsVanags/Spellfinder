extends KinematicBody2D

var hp = 10
var sp = 10

var casting = false
var direction = 0
var disabled = false
var unharmable = false
var directioninvector = Vector2(0,1)
var speed = 250
var movement = Vector2(0,0)
var spelltext = ''

var ball = preload("res://Characters/Player/Magic/Magic.tscn")
var hand = preload("res://Characters/Player/Magic/FRONTATTACK.tscn")
var spin = preload("res://Characters/Player/Magic/ARROUNDATTACK.tscn")
var aura = preload("res://Characters/Player/Magic/AURA.tscn")

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.start("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disabled == false:
		if Input.is_action_pressed("ui_focus_next"):
			casting = true
			movement = Vector2(0,0)
		elif Input.is_action_just_released("ui_focus_next"):
			magicParser()
		else:
			casting = false
			movement()
	movement = move_and_slide(movement)
	
	if hp <= 0:
		get_tree().quit()
	
	Global.playerpos = self.global_position
	Global.playerhp = hp
	Global.playersp = sp

func movement():
	if Input.is_action_pressed("ui_up"):
		state_machine.travel("MoveU")
		movement = Vector2(0,-speed)
		directioninvector = Vector2(0,-1)
	elif Input.is_action_pressed("ui_down"):
		state_machine.travel("MoveD")
		movement = Vector2(0,speed)
		directioninvector = Vector2(0,1)
	elif Input.is_action_pressed("ui_left"):
		state_machine.travel("MoveL")
		movement = Vector2(-speed,0)
		directioninvector = Vector2(-1,0)
	elif Input.is_action_pressed("ui_right"):
		state_machine.travel("MoveR")
		movement = Vector2(speed,0)
		directioninvector = Vector2(1,0)
	else:
		state_machine.travel("Idle")
		movement = Vector2(0,0)

func _input(event):
	if event is InputEventKey and event.is_pressed() and casting == true:
		var key_text = OS.get_scancode_string(event.scancode)
		if key_text == 'Space':
			Global.textinput+=' '
		elif key_text == 'Shift' or key_text == 'BackSpace':
			pass
		else:
			Global.textinput+=key_text

func takingDamage(damage):
	if unharmable == false:
		Global.textinput = ''
		hp -= damage
		disabled = true
		$Timer.start()
		match directioninvector:
			Vector2(1,0):
				state_machine.travel("HurtR")
			Vector2(-1,0):
				state_machine.travel("HurtL")
			Vector2(0,-1):
				state_machine.travel("HurtU")
			Vector2(0,1):
				state_machine.travel("HurtD")
		$AudioStreamPlayer2D.play()
		movement = -directioninvector*Vector2(10,10)
	

func magicParser():
	
	var wordlist = Global.textinput.split(' ')
	var word1
	var word2
	var word3
	var word4
	
	for i in wordlist:
		if word1 == null:
			match i:
				'AS':
					word1 = 'I'
				'APUS':
					word1 = 'BOTH'
				'TREIS':
					word1 = 'THREE'
				'JAAS':
					word1 = 'YALL'
		if word2 == null:
			match i:
				'UGNIS':
					word2 = 'FIRE'
				'UUDNAS':
					word2 = 'WATER'
				'VEEJIS':
					word2 = 'WIND'
				'DZIVAS':
					word2 = 'LIFE'
		if word2 == null:
			match i:
				'UGNIS':
					word2 = 'FIRE'
				'UUDNAS':
					word2 = 'WATER'
				'VEEJIS':
					word2 = 'WIND'
				'DZIVAS':
					word2 = 'LIFE'
		if word3 == null:
			match i:
				'TVART':
					word3 = 'GET'
				'MAST':
					word3 = 'THROW'
				'VARPT':
					word3 = 'SPIN'
		if word4 == null:
			match i:
				'DAGTI':
					word4 = 'BURN'
				'PIUSTI':
					word4 = 'BLOW'
				'TAICI':
					word4 = 'FLOW'
				'MUZHI':
					word4 = 'FOREVER'
	Global.textinput = ''
	magicMaker(word1,word2,word3,word4)


func magicMaker(var word1, var word2, var word3, var word4):
	var bonus = false
	match word2:
		"WATER":
			var stream = preload("res://Characters/Player/Magic/water_sfx.ogg")
			$Magic.stream = stream
			$Magic.play()
		"FIRE":
			var stream = preload("res://Characters/Player/Magic/flame_sfx.ogg")
			$Magic.stream = stream
			$Magic.play()
		"WIND":
			var stream = preload("res://Characters/Player/Magic/wind_sfx.ogg")
			$Magic.stream = stream
			$Magic.play()
	
	if word2=='WATER' && word4 =='FLOW' or word2=='FIRE' && word4=='BURN'  or word2=='WIND' && word4=='BLOW':
		bonus = true
		sp-=1
	if word3 == 'THROW' && word2 != null:
		if word1 == 'BOTH':
			var newball1 = ball.instance()
			newball1.createBall(-directioninvector,bonus,word2)
			get_parent().add_child(newball1)
			newball1.global_position = self.global_position
			var newball = ball.instance()
			newball.createBall(directioninvector,bonus,word2)
			get_parent().add_child(newball)
			newball.global_position = self.global_position
			sp-=2
		elif word1 == 'THREE':
			var newball1 = ball.instance()
			newball1.createBall(Vector2(-0.8,-1),bonus,word2)
			get_parent().add_child(newball1)
			newball1.global_position = self.global_position
			var newball = ball.instance()
			newball.createBall(Vector2(0,1),bonus,word2)
			get_parent().add_child(newball)
			newball.global_position = self.global_position
			var newball2 = ball.instance()
			newball2.createBall(Vector2(0.8,-1),bonus,word2)
			get_parent().add_child(newball2)
			newball2.global_position = self.global_position
			sp-=2
		else:
			var newball = ball.instance()
			newball.createBall(directioninvector,bonus,word2)
			get_parent().add_child(newball)
			newball.global_position = self.global_position
			sp-=1
		
	if word3 == null && word2 != null && word1 == null:
		var newhand = hand.instance()
		newhand.createHand(bonus,word2)
		$Sprite.add_child(newhand)
		newhand.global_position = self.global_position
		sp -= 1
	if word3 == "SPIN" && word2 != null:
		var newspin = spin.instance()
		newspin.createSpin(bonus,word2)
		add_child(newspin)
		$Shield.disabled = false
		unharmable = true
		newspin.global_position = self.global_position
		sp-= 2
	if word1 == "I" && word2!= null:
		var newaura = aura.instance()
		add_child(newaura)
		newaura.createAura(bonus,word2)
		newaura.global_position = self.global_position
		sp -=1

func _on_Timer_timeout():
	disabled = false

func _on_SPGAIN_timeout():
	if (sp<10):
		sp+=1
