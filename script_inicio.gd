extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inicio/Folha1.play("Fcaindo")
	$Selc_Multplayer/Folha2.play("Fcaindo")
	$Selec_personagem/SasukeDistaque.visible = true
	$AudioStreamPlayer.play()
	$Inicio/Certeza.visible = false
	$Config/Controles.visible = false
	$Config/ChekMusic.pressed = ScriptGlobal.Status_music
	$Config/ChekSom.pressed = ScriptGlobal.Status_som
	$Ranking_cena.visible = false
	musica()
	
#	Paginas
	$Inicio.visible = true
	$Config.visible = false
	$Creditos.visible = false
	$Selc_Multplayer.visible = false
	
	
	
func musica():
	if(ScriptGlobal.Status_music == true):
		$AudioStreamPlayer.stream_paused = false
		$AudioStreamPlayer2.stream_paused = false
	else:
		$AudioStreamPlayer.stream_paused = true
		$AudioStreamPlayer2.stream_paused = true

# Som de Click
func click():
	if(ScriptGlobal.Status_som == true):
		 $Click.play()
	else:
		 $Click.stop()

func sobre_botao():
	if(ScriptGlobal.Status_som == true):
		 $Sobre_botao.play()
	else:
		 $Sobre_botao.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	ScriptGlobal.speed += 0.001
#	print(ScriptGlobal.speed)



	if(Input.is_action_just_pressed("esq")):
		$Config/Controles.visible = false
		$Ranking_cena.visible = false
	
	
	musica()
	$Selec_personagem/NarutinDistaque.visible = false
	$Selec_personagem/SasukeDistaque.visible = false
	
	
	if(Input.is_action_just_pressed("ui_right")):
		if(ScriptGlobal.Selec_person < 2 ):
			ScriptGlobal.Selec_person += 1
			sobre_botao()
		else:
			ScriptGlobal.Selec_person = 1
			sobre_botao()
	elif(Input.is_action_just_pressed("ui_left")):
		if(ScriptGlobal.Selec_person > 1):
			ScriptGlobal.Selec_person -=1
			sobre_botao()
		else:
			ScriptGlobal.Selec_person = 2
			sobre_botao()
		
	elif(Input.is_action_just_pressed("enter")):
		get_tree().change_scene("res://cena_loading.tscn")

	if(ScriptGlobal.Selec_person == 1):
		$Selec_personagem/SasukeDistaque.visible = true
	elif(ScriptGlobal.Selec_person == 2):
		$Selec_personagem/NarutinDistaque.visible = true
		
#	Ir para o Modo de Jogo
func _on_Button_pressed():
	$Inicio.visible = false
	$Config.visible = false
	$Creditos.visible = false
	$Selc_Multplayer.visible = true
	click()

#	Ir para o jogo direto
func _on_Mult_On_pressed():
	get_tree().change_scene("res://cena_loading.tscn") #provisoria
	ScriptGlobal.Multiplayer = true
	click()

# Ir para a seleção de personagem
func _on_Mult_Off_pressed():
#	get_tree().change_scene("res://cena_fase1.tscn")
	$Camera2D.limit_left = 2048 
	$Camera2D.limit_right = 3071.5
	ScriptGlobal.Multiplayer = false
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()
	click()
	
	

# Voltar ao modo de jogo
func _on_Voltar_modo_game_pressed():
	$Camera2D.limit_left = 0 
	$Camera2D.limit_right = 1024
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.play()
	click()

# Musica de Inicio
func _on_AudioStreamPlayer_finished():
	if(ScriptGlobal.Status_music == true and not $AudioStreamPlayer2.playing):
		$AudioStreamPlayer.play()
	else: 
		$AudioStreamPlayer.stop()

# Musica de Seleção de Personagem
func _on_AudioStreamPlayer2_finished():
	if(ScriptGlobal.Status_music == true and not $AudioStreamPlayer.playing):
		$AudioStreamPlayer2.play()
	else: 
		$AudioStreamPlayer2.stop()

# Todos Abaixo é o efeito de ao passar o mouse em cima
func _on_Mult_On_mouse_entered():
	sobre_botao()
func _on_Voltar_modo_game_mouse_entered():
	sobre_botao()
func _on_Mult_Off_mouse_entered():
	sobre_botao()
func _on_Voltar_Inicio_mouse_entered():
	sobre_botao()
func _on_Fechar_Jogo_mouse_entered():
	sobre_botao()
func _on_Button_mouse_entered():
	sobre_botao()
func _on_Sim_mouse_entered():
	sobre_botao()
func _on_Nao_mouse_entered():
	sobre_botao()
func _on_Config_mouse_entered():
	sobre_botao()
func _on_Control_mouse_entered():
	sobre_botao()
func _on_Creditos_mouse_entered():
	sobre_botao()
func _on_Voltar_tela_inicial_mouse_entered():
	sobre_botao()
func _on_Ranking_mouse_entered():
	sobre_botao()


# Ir para a tela de Configuração
func _on_Config_pressed():
	$Inicio.visible = false
	$Config.visible = true
	$Creditos.visible = false
	$Selc_Multplayer.visible = false
	click()
	
	
# Botoes pra voltar pra Tela inicial
func _on_Voltar_tela_inicial_pressed():
	$Inicio.visible = true
	$Config.visible = false
	$Creditos.visible = false
	$Selc_Multplayer.visible = false
	click()
func _on_Voltar_Inicio_pressed():
	$Inicio.visible = true
	$Config.visible = false
	$Creditos.visible = false
	$Selc_Multplayer.visible = false
	click()




func _on_Fechar_Jogo_pressed():
	$Inicio/Config.disabled = true
	$Inicio/Fechar_Jogo.disabled = true
	$Inicio/Button.disabled = true
	$Inicio/Certeza.visible = true
	
	if($Inicio/Certeza.visible == true):
		if(ScriptGlobal.Status_som == true):
			$Som_popup.play()
		else:
			$Som_popup.stop()
	click()
func _on_Sim_pressed():
	
	$Inicio/Config.disabled = false
	$Inicio/Fechar_Jogo.disabled = false
	$Inicio/Button.disabled = false
#	get_tree().change_scene("res://cena_login.tscn")
	get_tree().change_scene("res://cena_vitoria_naruto.tscn")
	click()
	
func _on_Nao_pressed():
	$Inicio/Certeza.visible = false
	$Inicio/Config.disabled = false
	$Inicio/Fechar_Jogo.disabled = false
	$Inicio/Button.disabled = false
	click()

func _on_Control_pressed():
	$Config/Controles.visible = true
	if($Config/Controles.visible == true):
		if(ScriptGlobal.Status_som == true):
			$Som_popup.play()
		else:
			$Som_popup.stop()
	click()


# Ir para Tela de Creditos
func _on_Creditos_pressed():
	$Inicio.visible = false
	$Config.visible = false
	$Creditos.visible = true
	$Selc_Multplayer.visible = false
	click()


func _on_ChekSom_pressed():
	if($Config/ChekSom.pressed):
		ScriptGlobal.Status_som = true
	else:
		ScriptGlobal.Status_som = false

func _on_ChekMusic_pressed():
	if($Config/ChekMusic.pressed):
		ScriptGlobal.Status_music = true
	else:
		ScriptGlobal.Status_music = false




# Aparecer o Ranking
func _on_Ranking_pressed():
	$Ranking_cena.visible = true
	click()
	if($Ranking_cena.visible == true and Input.is_action_just_pressed("esq")):
		$Ranking_cena.visible = false
