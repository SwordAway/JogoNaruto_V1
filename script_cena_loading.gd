extends Node2D



func _ready():
	pass



func _process(delta):
	
	
	if(ScriptGlobal.Multiplayer == true):
		$ColorRect/Loading_Mult.visible = true
		$ColorRect/Naruto_mult.visible = true
		$ColorRect/Sasuke_mult.visible = true
	else:
		if(ScriptGlobal.Selec_person == 1): # Sasuke
			$ColorRect/Loading_Sasuke.visible = true
			$ColorRect/Sasuke.visible = true
		if(ScriptGlobal.Selec_person == 2):# Naruto
			$ColorRect/Loading_Naruto.visible = true
			$ColorRect/Naruto.visible = true


func _on_Timer_timeout():
	ScriptGlobal.contagem = true
	
	if(ScriptGlobal.Multiplayer == true):
		get_tree().change_scene("res://cena_fase_multiplayer.tscn")
	else:
		if(ScriptGlobal.Selec_person == 1): # Sasuke
			get_tree().change_scene("res://cena_fase_pro_naruto.tscn")
		if(ScriptGlobal.Selec_person == 2):# Naruto
			get_tree().change_scene("res://cena_fase_pro_naruto.tscn")
