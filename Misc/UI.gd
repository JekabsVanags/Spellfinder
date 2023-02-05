extends CanvasLayer


var overlayActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	overlayActive = true
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CenterContainer/Control/ProgressHP.value = Global.playerhp
	$CenterContainer/Control/ProgressSP.value = Global.playersp
	$TEXTBOXES/Sprite/Wordlist/RichTextLabel.text = Global.knownText
	
	if overlayActive == true and Input.is_action_just_pressed("ui_accept"):
		overlayActive = false
		$TEXTBOXES.visible = false
		$TEXTBOXES/Sprite/Newword.visible = false
		$TEXTBOXES/Sprite/Wordlist.visible = false
		if $Tutorial:
			$Tutorial.queue_free()
		Global.textinput = ''
		get_tree().paused = false


func _on_World1_newWordLearned(word, meaning):
	$TEXTBOXES.visible = true
	$TEXTBOXES/Sprite/Newword.visible = true
	$TEXTBOXES/Sprite/Newword/CenterContainer/HBoxContainer/LATVISH.text = word
	$TEXTBOXES/Sprite/Newword/CenterContainer/HBoxContainer/TRANSLATION.text = meaning
	Global.knownText = Global.knownText+'\r\n'+word+" MEANS "+meaning
	get_tree().paused = true
	overlayActive = true


func _on_World1_displayWordsLearned():
	$TEXTBOXES.visible = true
	$TEXTBOXES/Sprite/Wordlist.visible = true
	get_tree().paused = true
	overlayActive = true
