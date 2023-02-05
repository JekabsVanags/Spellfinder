extends TileMap

var eventactive = 0
var checkactive = false

signal newWordLearned(word,meaning)
signal displayWordsLearned()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	match eventactive:
		1:
			if Global.textinput == "JUNGLAS ATVERT":
				print("YOU WIN")
				get_tree().quit()
	
	if checkactive==true:
		if Global.textinput == "TOUCH" or Global.textinput == "READ":
			emit_signal("displayWordsLearned")


func _on_DOOROPEN_body_entered(body):
	if(body.name == "Player"):
		eventactive = 1
		get_parent().get_child(2).get_child(1).visible = true
		get_parent().get_child(2).get_child(1).get_child(0).play("rotate")
		emit_signal("displayWordsLearned")


func _on_DOOROPEN_body_exited(body):
	if(body.name == "Player"):
		eventactive = 0
		get_parent().get_child(2).get_child(1).visible = false


func _on_NEWWORD_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","UGNIS","FIRE")
		$NEWWORD.queue_free()


func _on_CHECKSPELLS_body_entered(body):
	if(body.name == "Player"):
		checkactive = true
		get_parent().get_child(2).get_child(1).visible = true
		get_parent().get_child(2).get_child(1).get_child(0).play("rotate")


func _on_SPELLUGNIS_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","UGNIS","FIRE")
		$SPELLUGNIS.queue_free()


func _on_SPELLVEEJIS_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","VEEJIS","WIND")
		$SPELLVEEJIS.queue_free()

func _on_SPELLMAST_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","MAST","TO THROW")
		$SPELLMAST.queue_free()


func _on_SPELLAS_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","AS","I AM")
		$SPELLAS.queue_free()


func _on_SPELLVARPT_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","VARPT","TO SPIN")
		$SPELLVARPT.queue_free()


func _on_SPELLAPUS_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","APUS","FROM BOTH SIDES")
		$SPELLAPUS.queue_free()


func _on_SPELLDAGTI_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","DAGTI","TO BURN FIERCLY")
		$SPELLDAGTI.queue_free()


func _on_SPELLTREIS_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","TREIS","FROM THREE SIDES")
		$SPELLTREIS.queue_free()


func _on_SPELLTAICI_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","TAICI","TO FLOW SWIFTLY")
		$SPELLTAICI.queue_free()


func _on_SPELLPIUSTI_body_entered(body):
	if(body.name == "Player"):
		emit_signal("newWordLearned","PIUSTI","TO BLOW QUICKLY")
		$SPELLPIUSTI.queue_free()


func _on_UZVARA_body_entered(body):
	if(body.name == "Player"):
		eventactive = 1
		get_parent().get_child(2).get_child(1).get_child(0).play("rotate")


func _on_UZVARA_body_exited(body):
	if(body.name == "Player"):
		eventactive = 0
