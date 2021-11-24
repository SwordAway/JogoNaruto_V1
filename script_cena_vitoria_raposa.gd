extends Node2D

func _ready():
	if(ScriptGlobal.Status_music == true):
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

func selec():
	if(ScriptGlobal.Status_som == true):
		$Selec.play()
	else:
		$Selec.stop()
	
func press():
	if(ScriptGlobal.Status_som == true):
		$Press.play()
	else:
		$Press.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	press()
	get_tree().change_scene("res://cena_inicio.tscn")
	ScriptGlobal.reset()
	

func _on_AudioStreamPlayer_finished():
	if(ScriptGlobal.Status_music == true and not $AudioStreamPlayer.playing):
		$AudioStreamPlayer2.play()
	else: 
		$AudioStreamPlayer2.stop()


func _on_Button_mouse_entered():
	selec()
