extends Node2D




func _ready():
	$ChekMusic.pressed = ScriptGlobal.Status_music
	$ChekSom.pressed = ScriptGlobal.Status_som
	$Controle.visible = false
	$".".visible = false


func _process(delta):
	
	var largura = get_viewport_rect().size.x
	var x_atual = global_position.x

	
	global_position.x = clamp(x_atual,0,largura)
	
	if(Input.is_action_just_pressed("esq")):
		$Controle.visible = false
	
# Controla o pause ( A parte pause, o nó tem que estar no modo Process)
	if(Input.is_action_just_pressed("Pause")):
		if (get_tree().paused == false):
			get_tree().paused = true
			$".".visible = true
		else:
			get_tree().paused = false
			$".".visible = false
			
		if(ScriptGlobal.Status_som == true):
		 $Pause_Som.play()
		else:
		 $Pause_Som.stop()

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

func _on_ChekSom_pressed():
	if($ChekSom.pressed):
		ScriptGlobal.Status_som = true
	else:
		ScriptGlobal.Status_som = false


func _on_Tela_inicio_pressed():
	get_tree().change_scene("res://cena_inicio.tscn")
	ScriptGlobal.reset()
	get_tree().paused = false
	


func _on_ChekMusic_pressed():
	if($ChekMusic.pressed):
		ScriptGlobal.Status_music = true
	else:
		ScriptGlobal.Status_music = false





func _on_Controles_pressed():
	$Controle.visible = true
	if($Controle.visible == true):
		if(ScriptGlobal.Status_som == true):
			$poupup.play()
		else:
			$poupup.stop()
	press()

func _on_Tela_inicio_mouse_entered():
	selec()
