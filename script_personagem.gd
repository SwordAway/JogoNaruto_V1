extends KinematicBody2D


#Controlar HUD
var barraSasuke
var barraNaruto

#Controlar Movimento em Geral
var atacando = false
var direcao = 1
var transOn = false


#Ataques
var qtd_socos: int = 0;
var socos_limite_naruto: int = 13;
var socos_limite_raposa: int = 20;
var socos_limite_sasuke: int = 13;
var socos_limite_demon: int = 13;
var socos: bool = false;


#Morte
var veldaMorte = 100
var mortepersonagem = Vector2(veldaMorte,0) 


# Personagem Normal
var forca_pulo = 20000
var velocidade = 1000
var mov = Vector2(0,0) 

#Personagem Transformado
var forca_pulo_raposa = 1150
var velocidade_raposa = 450
var mov_raposa = Vector2(0,0) 


# Muda a interface
func HUD():
#	var barra = $ProgressBar.get("custom_styles/fg")
#	Mudar a cor da barra Naruto

	if(ScriptGlobal.Multiplayer == true):
		barraNaruto = get_parent().get_node("Vidas/Jogador2/Barra_Vida1").get("custom_styles/fg")
	if(ScriptGlobal.Multiplayer == false):
		barraNaruto = get_parent().get_node("Vidas/Jogador1/Barra_Vida").get("custom_styles/fg")

	if(ScriptGlobal.vidas_naruto >=6):
		barraNaruto.bg_color = Color(0.015686, 0.490196, 0)
	if(ScriptGlobal.vidas_naruto <=5):
		barraNaruto.bg_color = Color (0.898039, 0.6, 0.035294)
	if(ScriptGlobal.vidas_naruto <=2):
		barraNaruto.bg_color = Color(1,0,0)

#	Mudar a cor da barra Sasuke
	if(ScriptGlobal.Multiplayer == true):
		barraSasuke = get_parent().get_node("Vidas/Jogador2/Barra_Vida2").get("custom_styles/fg")
	if(ScriptGlobal.Multiplayer == false):
		barraSasuke = get_parent().get_node("Vidas/Jogador 1_1/Barra_Vida").get("custom_styles/fg")
	
	if(ScriptGlobal.vidas_sasuke >=6):
		barraSasuke.bg_color = Color(0.015686, 0.490196, 0)
	if(ScriptGlobal.vidas_sasuke <=5):
		barraSasuke.bg_color = Color (0.898039, 0.6, 0.035294)
	if(ScriptGlobal.vidas_sasuke <=2):
		barraSasuke.bg_color = Color(1,0,0)
		
#	barrinha de vida e furia
	if(ScriptGlobal.Multiplayer == true):
		get_parent().get_node("Vidas/Jogador2/Barra_Vida1").value = ScriptGlobal.vidas_naruto #Mult On
		get_parent().get_node("Vidas/Jogador2/Barra_Vida2").value = ScriptGlobal.vidas_sasuke #Mult On
		get_parent().get_node("Vidas/Jogador2/Barra_Furia1").value = ScriptGlobal.furia_raposa #Mult On
		get_parent().get_node("Vidas/Jogador2/Barra_Furia2").value = ScriptGlobal.furia_demon #Mult On
		
	else:
		get_parent().get_node("Vidas/Jogador 1_1/Barra_Vida").value = ScriptGlobal.vidas_sasuke #Mult Off
		get_parent().get_node("Vidas/Jogador1/Barra_Vida").value = ScriptGlobal.vidas_naruto #Mult Off
		get_parent().get_node("Vidas/Jogador1/Barra_Furia").value = ScriptGlobal.furia_raposa #Mult Off
		get_parent().get_node("Vidas/Jogador 1_1/Barra_Furia").value = ScriptGlobal.furia_demon #Mult Off
	

#	Icones
	if(ScriptGlobal.Multiplayer == true):
		get_parent().get_node("Vidas/Jogador1").visible = false
		get_parent().get_node("Vidas/Jogador 1_1").visible = false
		get_parent().get_node("Vidas/Jogador2").visible = true
		
		if($Naruto.visible == true):
			get_parent().get_node("Vidas/Jogador2/Naruto1").visible = true
		elif($Raposa.visible == true):
			get_parent().get_node("Vidas/Jogador2/Naruto1").visible = false #Mult On
		
		if($Sasuke.visible == true):
			get_parent().get_node("Vidas/Jogador2/Sasuke").visible = true
		elif($Demon.visible == true):
			get_parent().get_node("Vidas/Jogador2/Sasuke").visible = false #Mult On
	else:
		if($Naruto.visible == true):
			get_parent().get_node("Vidas/Jogador1").visible = true
			get_parent().get_node("Vidas/Jogador 1_1").visible = false
			get_parent().get_node("Vidas/Jogador1/Naruto").visible = true
		if($Sasuke.visible == true):
			get_parent().get_node("Vidas/Jogador1").visible = false
			get_parent().get_node("Vidas/Jogador 1_1").visible = true
			get_parent().get_node("Vidas/Jogador 1_1/Sasuke").visible = true
		if($Demon.visible == true):
			get_parent().get_node("Vidas/Jogador 1_1/Sasuke").visible = false #Mult Off
		if($Raposa.visible == true):
			get_parent().get_node("Vidas/Jogador1/Naruto").visible = false #Mult Off
			
	
# Coisas que vao acontecer no inicio
func _ready():
#	area dos socos
	$Area_socos/Colis_socos.disabled = true
	
#	musica
	if(ScriptGlobal.Multiplayer == true):
		if(ScriptGlobal.Status_music == true):
			$MusicaMultOn.play()
		else: 
			$MusicaMultOn.stream_paused = true
	else:
		if(ScriptGlobal.Status_music == true):
			$AudioStreamPlayer.play()
		else: 
			$AudioStreamPlayer.stream_paused = true
	
	get_parent().get_node("Vidas/Jogador1/Barra_Furia/Label").visible = false #Mult Off
	get_parent().get_node("Vidas/Jogador2/Barra_Furia1/Label1").visible = false #Mult On
	get_parent().get_node("Vidas/Jogador 1_1/Barra_Furia/Label").visible = false #Mult Off
	get_parent().get_node("Vidas/Jogador2/Barra_Furia2/Label2").visible = false #Mult On

	if(ScriptGlobal.Multiplayer == true):
		
#		Naruto
		$Vitoria.visible = false
		$Raposa.visible = false
		$Naruto.visible = true
		$VitoriaRapo.visible = false
		$Transformacao.visible = false
		$MorteNaruto.visible = false
		$MorteRaposa.visible = false
		
#		Sasuke
		$VitoriaSasuke.visible = false
		$Demon.visible = false
		$Sasuke.visible = false
		$VitoriaDemon.visible = false
		$TransformacaoDemon.visible = false
		$MorteSasuke.visible = false
		$MorteDemon.visible = false
		
		
		
		get_parent().get_node("PersoSasuke").visible = true
	else:
		
		get_parent().get_node("PersoSasuke").queue_free()
		
#		Naruto
	if(ScriptGlobal.Selec_person == 2 and ScriptGlobal.Multiplayer == false):
#		Naruto On
		$Vitoria.visible = false
		$Raposa.visible = false
		$Naruto.visible = true
		$VitoriaRapo.visible = false
		$Transformacao.visible = false
		$MorteNaruto.visible = false
		$MorteRaposa.visible = false
		
##		Sasuke off
		$VitoriaSasuke.visible = false
		$Demon.visible = false
		$Sasuke.visible = false
		$VitoriaDemon.visible = false
		$TransformacaoDemon.visible = false
		$MorteSasuke.visible = false
		$MorteDemon.visible = false
		
#		Sasuke
	elif(ScriptGlobal.Selec_person == 1 and ScriptGlobal.Multiplayer == false):
#		Naruto off
		$Vitoria.visible = false
		$Raposa.visible = false
		$Naruto.visible = false
		$VitoriaRapo.visible = false
		$Transformacao.visible = false
		$MorteNaruto.visible = false
		$MorteRaposa.visible = false

#		Sasuke On
		$VitoriaSasuke.visible = false
		$Demon.visible = false
		$Sasuke.visible = true
		$VitoriaDemon.visible = false
		$TransformacaoDemon.visible = false
		$MorteSasuke.visible = false
		$MorteDemon.visible = false
		

#Sistema de Combos
func ataque_naruto():
	match qtd_socos:
		1:
			$Naruto.play("atk2")
		2:
			$Naruto.play("atk3")
			$Area_socos/Colis_socos.disabled = true
		3:
			$Naruto.play("atk4")
		4:
			$Naruto.play("atk1")
			$Area_socos/Colis_socos.disabled = true
		5:
			$Naruto.play("atk5")
		6:
			$Naruto.play("atk6")
			$Area_socos/Colis_socos.disabled = true
		7:
			$Naruto.play("atk7")
		8:
			$Naruto.play("atk8")
			$Area_socos/Colis_socos.disabled = true
		9:
			$Naruto.play("atk9")
			$Area_socos/Colis_socos.disabled = true
		10:
			$Naruto.play("atk10")
			$Area_socos/Colis_socos.disabled = true
		11:
			$Naruto.play("atk11")
			$Area_socos/Colis_socos.disabled = true
		12:
			$Naruto.play("atk12")

		13:
			$Naruto.play("atk13")
			$Area_socos/Colis_socos.disabled = true
	socos = false

func ataque_sasuke():
	match qtd_socos:
		1:
			$Sasuke.play("atk1")
			$Area_socos/Colis_socos.disabled = true
		2:
			$Sasuke.play("atk2")
			$Area_socos/Colis_socos.disabled = true
		3:
			$Sasuke.play("atk3")
		4:
			$Sasuke.play("atk4")
			$Area_socos/Colis_socos.disabled = true
		5:
			$Sasuke.play("atk5")
			$Area_socos/Colis_socos.disabled = true
		6:
			$Sasuke.play("atk6")
			$Area_socos/Colis_socos.disabled = true
		7:
			$Sasuke.play("atk7")
		8:
			$Sasuke.play("atk8")
			$Area_socos/Colis_socos.disabled = true
		9:
			$Sasuke.play("atk9")
			$Area_socos/Colis_socos.disabled = true
		10:
			$Sasuke.play("atk10")
			$Area_socos/Colis_socos.disabled = true
		11:
			$Sasuke.play("atk11")
			$Area_socos/Colis_socos.disabled = true
		12:
			$Sasuke.play("atk12")

		13:
			$Sasuke.play("atk13")
			$Area_socos/Colis_socos.disabled = true
	socos = false

func ataque_demon():
	match qtd_socos:
		1:
			$Demon.play("atk1")
			$Area_socos/Colis_socos.disabled = true
		2:
			$Demon.play("atk2")
			$Area_socos/Colis_socos.disabled = true
		3:
			$Demon.play("atk3")
		4:
			$Demon.play("atk4")
			$Area_socos/Colis_socos.disabled = true
		5:
			$Demon.play("atk5")
			$Area_socos/Colis_socos.disabled = true
		6:
			$Demon.play("atk6")
			$Area_socos/Colis_socos.disabled = true
		7:
			$Demon.play("atk7")
			$Area_socos/Colis_socos.disabled = true
		8:
			$Demon.play("atk8")
		9:
			$Demon.play("atk9")
			$Area_socos/Colis_socos.disabled = true
		10:
			$Demon.play("atk10")
			$Area_socos/Colis_socos.disabled = true
		11:
			$Demon.play("atk11")
		12:
			$Demon.play("atk12")
			$Area_socos/Colis_socos.disabled = true
		13:
			$Demon.play("atk13")
			$Area_socos/Colis_socos.disabled = true
	socos = false

func ataque_raposa():
	match qtd_socos:
		1:
			$Raposa.play("atk1")
		2:
			$Raposa.play("atk2")
			$Area_socos/Colis_socos.disabled = true
		3:
			$Raposa.play("atk3")
		4:
			$Raposa.play("atk4")
			$Area_socos/Colis_socos.disabled = true
		5:
			$Raposa.play("atk5")
			$Area_socos/Colis_socos.disabled = true
		6:
			$Raposa.play("atk6")
		7:
			$Raposa.play("atk7")
			$Area_socos/Colis_socos.disabled = true
		8:
			$Raposa.play("atk8")
			$Area_socos/Colis_socos.disabled = true
		9:
			$Raposa.play("atk9")
			$Area_socos/Colis_socos.disabled = true
		10:
			$Raposa.play("atk10")
		11:
			$Raposa.play("atk11")
			$Area_socos/Colis_socos.disabled = true
		12:
			$Raposa.play("atk12")
			$Area_socos/Colis_socos.disabled = true
		13:
			$Raposa.play("atk13")
			$Area_socos/Colis_socos.disabled = true
		14:
			$Raposa.play("atk14")
			$Area_socos/Colis_socos.disabled = true
		15:
			$Raposa.play("atk15")
			$Area_socos/Colis_socos.disabled = true
		16:
			$Raposa.play("atk16")
			$Area_socos/Colis_socos.disabled = true
		17:
			$Raposa.play("atk17")
		18:
			$Raposa.play("atk18")
			$Area_socos/Colis_socos.disabled = true
		19:
			$Raposa.play("atk19")
			$Area_socos/Colis_socos.disabled = true
	socos = false

#	Fica atualizando toda hora
func _physics_process(delta):
	
	var largura = 10268

	var x_atual = global_position.x

	global_position.x = clamp(x_atual,0,largura)
	
	
#Dropar de plataforma
	if(Input.is_action_just_pressed("dropPlataform")):
		get_parent().get_node("Personagem").set_collision_layer_bit(0, false)
		get_parent().get_node("Personagem").set_collision_mask_bit(0, false)
		
	elif(Input.is_action_just_released("dropPlataform")):
		get_parent().get_node("Personagem").set_collision_layer_bit(0, true)
		get_parent().get_node("Personagem").set_collision_mask_bit(0, true)

#	print(qtd_socos)
#	controlar musica
	
	if(ScriptGlobal.Multiplayer == true):
		if(ScriptGlobal.Status_music == true and not $MusicaMultOn.playing):
			$MusicaMultOn.play()
		elif(ScriptGlobal.Status_music == false and $MusicaMultOn.playing):
			$MusicaMultOn.stream_paused = true
			
	else:
		if(ScriptGlobal.Status_music == true and not $AudioStreamPlayer.playing):
			$AudioStreamPlayer.play()
		elif(ScriptGlobal.Status_music == false and $AudioStreamPlayer.playing):
			$AudioStreamPlayer.stream_paused = true
			
#	if(global_position.y>$Camera2D.limit_bottom):
#		get_tree().change_scene("res://cena_game_over.tscn")

	
	
	ScriptGlobal.controlVida() 
	vitoria(delta) 
	mortes(delta) 
	raposa(delta) 
	sasuke(delta)
	demon(delta)
	naruto(delta) 
	HUD() 


#   Movimentos Naruto
func naruto(delta):
#	controlar animacoes
	#	Movimentação
	if($Naruto.visible == true):
		mov.y += 1200 * delta 
		if(qtd_socos > socos_limite_naruto):
			qtd_socos = 0
			$Area_socos/Colis_socos.disabled = true
		if(not atacando):
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("A")):
				if($RayCast2D.is_colliding() and direcao == 1 and not is_on_floor()):
					$Naruto.play("pulo parede")
					mov.y = -forca_pulo * delta

#					Muda tudo pro lado esquerdo
				if(direcao == 1):
					scale.x = -0.519
					direcao = -1
				mov.x = -velocidade * delta

#					Animacao de correr
				if (is_on_floor()):
					$Naruto.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Naruto.play("naparede")
					mov.y = 0

#					Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("A") and is_on_wall() and $RayCast2D.is_colliding() and not $Naruto.animation == "pulo parede"):
					$Naruto.play("caindo")

#			Tudo pro lado Direito
			elif(Input.is_action_pressed("D")):

				if($RayCast2D.is_colliding() and direcao == -1 and not is_on_floor()):
					$Naruto.play("pulo parede")
					mov.y = -forca_pulo * delta

#				muda tudo pro lado direito
				if(direcao == -1):
					scale.x = -0.519
					direcao = 1
				mov.x = velocidade * delta

#					Animacao de correr
				if (is_on_floor()):
					$Naruto.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Naruto.play("naparede")
					mov.y = 0
#				Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("D") and is_on_wall() and $RayCast2D.is_colliding() and not $Naruto.animation == "pulo parede" ):
					$Naruto.play("caindo")


			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("S") and is_on_floor()):
				$Naruto.play("agaixando")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov.x = 0
#			 	Reativa os collisions
			elif(Input.is_action_just_released("S")):
				$HitD/CollisionShape2D.disabled = false
				$HitE/CollisionShape2D.disabled = false
			
#				Parado  
			else: 
				if (is_on_floor() and not $Naruto.animation == "hit"):
					$Naruto.play("parado")
				mov.x = 0
				
#				Caindo
				if (not is_on_floor() and not is_on_wall() and not $Naruto.animation == "jogarwapon" and not $Naruto.animation == "pulo parede" and not $Naruto.animation == "pulando" and not $RayCast2D.is_colliding()):
					$Naruto.play("caindo")
				
				
#				Pulo pelo chao
			if(Input.is_action_just_pressed("W") and is_on_floor()):
				$Naruto.play("pulando")
				mov.y = -forca_pulo * delta
			
			
			
#			-_-_-_-_-Parte de Skills_-_-_-_-

#			Jogando Shuriken "S"
		if(Input.is_action_just_pressed("shuriken H") and not is_on_wall()):
			$Naruto.play("jogarwapon")
			mov.x = 0
			atacando = true
			
			var cena_disparo = preload("res://cena_disparoD.tscn")
			
			var objeto_disparo = cena_disparo.instance()
			objeto_disparo.global_position = $Shuriken.global_position
			objeto_disparo.z_index = 0
			
			if(direcao == -1):
				objeto_disparo.scale.x = -1
			
			get_tree().root.add_child(objeto_disparo)
			if(ScriptGlobal.Status_som == true):
				$ShurikenSom.play()
			else:
				$ShurikenSom.stop()
				
			
#			Quando soltar o Botao da Shuriken "S"
		elif(Input.is_action_just_released("shuriken H")):
			if(is_on_floor()):
				$Naruto.play("parado")
			if(not is_on_floor()):
				$Naruto.play("caindo")
			atacando = false
			
			
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos K")):
			mov.x = 0
			mov.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_naruto()

			
#			Soco pra baixo
		if(Input.is_action_just_pressed("S") and not is_on_floor() and not is_on_wall()):
			mov.y = 700 * delta
			mov.x = 0
			$Naruto.play("socoPbaixo")
			atacando = true
			
	#			Apertar L para Transformar
		if(ScriptGlobal.furia_raposa == 10):
			if(ScriptGlobal.Multiplayer == false):
				get_parent().get_node("Vidas/Jogador1/Barra_Furia/Label").visible = true
			elif(ScriptGlobal.Multiplayer == true):
				get_parent().get_node("Vidas/Jogador2/Barra_Furia1/Label1").visible = true
			if(ScriptGlobal.furia_raposa == 10 and Input.is_action_just_pressed("Transformacao L")):
				$TempoTransformado.start() 
				transOn = true
				$Transformacao.set_frame(0) 
				ScriptGlobal.furia_raposa = 0
				ScriptGlobal.vidas_naruto +=4 
				get_parent().get_node("Vidas/Jogador1/Barra_Furia/Label").visible = false
				get_parent().get_node("Vidas/Jogador2/Barra_Furia1/Label1").visible = false
	
	
				if(direcao == 1):
					$Naruto.visible = false
					$Transformacao.visible = true
					$Transformacao.play("transformacao")
	
				elif(direcao == -1):
					$Naruto.visible = false
					$Transformacao.visible = true
					$Transformacao.play("transformacao")

		 mov = move_and_slide(mov,Vector2(0,-1))

# Movimentos Sasuke
func sasuke(delta):
#	controlar animacoes
	#	Movimentação
	if($Sasuke.visible == true):
		
		if($Sasuke.animation == "jutsuBolaFogo" or $Sasuke.animation == "jutsurept"):
			mov.y = 0
			mov.x = 0
			velocidade = 0
		else:
			velocidade = 800 * delta
			mov.y += 800 * delta
		if(qtd_socos > socos_limite_sasuke):
			qtd_socos = 0
			$Area_socos/Colis_socos.disabled = true
		if(not atacando):
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("A")):
				if($RayCast2D.is_colliding() and direcao == 1 and not is_on_floor()):
					$Sasuke.play("puloparede")
					mov.y = -forca_pulo * delta

#					Muda tudo pro lado esquerdo
				if(direcao == 1):
					scale.x = -0.519
					direcao = -1
				mov.x = -velocidade * delta

#					Animacao de correr
				if (is_on_floor()):
					$Sasuke.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Sasuke.play("naparede")
					mov.y = 0

#					Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("A") and is_on_wall() and $RayCast2D.is_colliding() and not $Sasuke.animation == "puloparede"):
					$Sasuke.play("caindo")

#			Tudo pro lado Direito
			elif(Input.is_action_pressed("D")):

				if($RayCast2D.is_colliding() and direcao == -1 and not is_on_floor()):
					$Sasuke.play("puloparede")
					mov.y = -forca_pulo * delta

#				muda tudo pro lado direito
				if(direcao == -1):
					scale.x = -0.519
					direcao = 1
				mov.x = velocidade * delta

#					Animacao de correr
				if (is_on_floor()):
					$Sasuke.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Sasuke.play("naparede")
					mov.y = 0
#				Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("D") and is_on_wall() and $RayCast2D.is_colliding() and not $Sasuke.animation == "puloparede" ):
					$Sasuke.play("caindo")


			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("S") and is_on_floor()):
				$Sasuke.play("agaixando")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov.x = 0
#			 	Reativa os collisions
			elif(Input.is_action_just_released("S")):
				$HitD/CollisionShape2D.disabled = false
				$HitE/CollisionShape2D.disabled = false
			
#				Parado  
			else: 
				if (is_on_floor() and not $Sasuke.animation == "hit"):
					$Sasuke.play("parado")
				mov.x = 0
				
#				Caindo
				if (not is_on_floor() and not is_on_wall() and not $Sasuke.animation == "jogarwapon" and not $Sasuke.animation == "puloparede" and not $Sasuke.animation == "pulando" and not $RayCast2D.is_colliding()):
					$Sasuke.play("caindo")
				
				
#				Pulo pelo chao
			if(Input.is_action_just_pressed("W") and is_on_floor()):
				$Sasuke.play("pulando")
				mov.y = -forca_pulo * delta
			
			
			
#			-_-_-_-_-Parte de Skills_-_-_-_-

#			Jogando Shuriken "H"
		if(Input.is_action_just_pressed("shuriken H") and not is_on_wall()):
			$Sasuke.play("jogarwapon")
			mov.x = 0
			atacando = true
			
			var cena_disparo = preload("res://cena_disparoD.tscn")
			
			var objeto_disparo = cena_disparo.instance()
			objeto_disparo.global_position = $Shuriken.global_position
			objeto_disparo.z_index = 0
			
			if(direcao == -1):
				objeto_disparo.scale.x = -1
			
			get_tree().root.add_child(objeto_disparo)
			if(ScriptGlobal.Status_som == true):
				$ShurikenSom.play()
			else:
				$ShurikenSom.stop()
				
			
#			Quando soltar o Botao da Shuriken "S"
		elif(Input.is_action_just_released("shuriken H")):
			if(is_on_floor()):
				$Sasuke.play("parado")
			if(not is_on_floor()):
				$Sasuke.play("caindo")
			atacando = false

#			Jutsu bola de fogo (J)
		if(Input.is_action_just_pressed("jutsuBLFogo  J") and not is_on_wall()):
			$Sasuke.play("jutsuBolaFogo")
			mov.x = 0
			atacando = true
			
			if(ScriptGlobal.Status_som == true):
				$Jutsu.play()
			else:
				$Jutsu.stop()
		
		
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos K")):
			mov.x = 0
			mov.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_sasuke()

#			
			
#			Soco pra baixo
		if(Input.is_action_just_pressed("S") and not is_on_floor() and not is_on_wall()):
			mov.y = 800 * delta
			mov.x = 0
			$Sasuke.play("socoPbaixo")
			atacando = true
			
	#			Apertar L para Transformar
		if(ScriptGlobal.furia_demon == 10):
			if(ScriptGlobal.Multiplayer == false):
				get_parent().get_node("Vidas/Jogador 1_1/Barra_Furia/Label").visible = true
			elif(ScriptGlobal.Multiplayer == true):
				get_parent().get_node("Vidas/Jogador2/Barra_Furia2/Label2").visible = true
			if(ScriptGlobal.furia_demon == 10 and Input.is_action_just_pressed("Transformacao L")):
				$TempoTransformado.start()
				transOn = true
				$TransformacaoDemon.set_frame(0) 
				ScriptGlobal.furia_demon = 0
				ScriptGlobal.vidas_sasuke +=4 
				get_parent().get_node("Vidas/Jogador2/Barra_Furia2/Label2").visible = false
				get_parent().get_node("Vidas/Jogador 1_1/Barra_Furia/Label").visible = false
	
	
				if(direcao == 1):
					$Sasuke.visible = false
					$TransformacaoDemon.visible = true
					$TransformacaoDemon.play("transformacaodemon")
	
				elif(direcao == -1):
					$Sasuke.visible = false
					$TransformacaoDemon.visible = true
					$TransformacaoDemon.play("transformacaodemon")

		mov = move_and_slide(mov,Vector2(0,-1))
	
# Movimentos Demon
func demon(delta):
	if($Demon.visible == true):
		
		if($Demon.animation == "jutsuBolaFogodemon" or $Demon.animation == "jutsureptdemon"):
			mov_raposa.y = 0
			mov_raposa.x = 0
			velocidade_raposa = 0
		else:
			velocidade_raposa = 950 * delta
			mov_raposa.y += 1200 * delta
#		Animacao de socos
		if(qtd_socos > socos_limite_demon):
			qtd_socos = 0
			$Area_socos/Colis_socos.disabled = true
			
#			Movimentação
		if(not atacando):
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("A")):
				if($RayCast2D.is_colliding() and direcao == 1 and not is_on_floor()):
					$Demon.play("puloparededemon")
					mov_raposa.y = -forca_pulo_raposa * delta

#					Muda tudo pro lado esquerdo
				if(direcao == 1):
					scale.x = -0.519
					direcao = -1
				mov_raposa.x = -velocidade_raposa * delta

#					Animacao de correr
				if (is_on_floor()):
					$Demon.play("corredemon")
#
#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Demon.play("parededemon")
					mov_raposa.y = 0
#
#					Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("A") and is_on_wall() and $RayCast2D.is_colliding() and not $Demon.animation == "puloparededemon"):
					$Demon.play("caindorapo")
#
#			Tudo pro lado Direito
			elif(Input.is_action_pressed("D")):
				if($RayCast2D.is_colliding() and direcao == -1 and not is_on_floor()):
					$Demon.play("puloparededemon")
					mov_raposa.y = -forca_pulo_raposa * delta

#				muda tudo pro lado direito
				if(direcao == -1):
					scale.x = -0.519
					direcao = 1

				mov_raposa.x = velocidade_raposa * delta
#
#					Animacao de correr
				if (is_on_floor()):
					$Demon.play("corredemon")
#
#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Demon.play("parededemon")
					mov_raposa.y = 0
#				Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("D") and is_on_wall() and $RayCast2D.is_colliding() and not $Demon.animation == "puloparededemon" ):
					$Demon.play("caindodemon")
#
#
			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("S") and is_on_floor()):
				$Demon.play("agaixademon")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov_raposa.x = 0

			elif(Input.is_action_just_released("S")):
				$HitD/CollisionShape2D.disabled = false
				$HitE/CollisionShape2D.disabled = false

#				Parado
			else: 
				if (is_on_floor() and not $Demon.animation == "hitdemon"):
					$Demon.play("idledemon")
				mov_raposa.x = 0
#
#				Caindo
				if(not is_on_floor() and not is_on_wall() and not $Demon.animation == "ataquedemon" and not $Demon.animation == "puloparededemon" and not $Demon.animation == "pulodemon" and not $RayCast2D.is_colliding()):
					$Demon.play("caindodemon")
#
#				Pulo pelo chao
			if (Input.is_action_just_pressed("W") and is_on_floor()):
				$Demon.play("pulodemon")
				mov_raposa.y = -forca_pulo_raposa * delta
#
#			Jogando Shuriken "H"
		if(Input.is_action_just_pressed("shuriken H") and not is_on_wall()):
			$Demon.play("ataquedemon")
			mov_raposa.x = 0
			atacando = true

			var cena_disparo = preload("res://cena_disparoD.tscn")

			var objeto_disparo = cena_disparo.instance()
			objeto_disparo.global_position = $Shuriken.global_position
			objeto_disparo.z_index = 0
			
			if(direcao == -1):
				objeto_disparo.scale.x = -1

			get_tree().root.add_child(objeto_disparo)
			if(ScriptGlobal.Status_som == true):
				$ShurikenSom.play()
			else:
				$ShurikenSom.stop()
			
#			Quando soltar o Botao da Shuriken "H"
		elif(Input.is_action_just_released("shuriken H")):
			if(is_on_floor()):
				$Demon.play("idledemon")
			if(not is_on_floor()):
				$Demon.play("caindodemon")
			atacando = false
			
#			Jutsu bola de fogo (J)
		if(Input.is_action_just_pressed("jutsuBLFogo  J") and not is_on_wall()):
			$Demon.play("jutsuBolaFogodemon")
			mov_raposa.x = 0
			atacando = true
			
			if(ScriptGlobal.Status_som == true):
				$Jutsu.play()
			else:
				$Jutsu.stop()
			
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos K")):
			mov_raposa.x = 0
			mov_raposa.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_demon()
			
#			Soco pra baixo
		if(Input.is_action_just_pressed("S") and not is_on_floor() and not is_on_wall()):
			mov_raposa.y = 350 
			mov_raposa.x = 0
			$Demon.play("socobaixodemon")
			atacando = true
			
		mov_raposa = move_and_slide(mov_raposa,Vector2(0,-1))

#  Movimentos Raposa
func raposa(delta):

	if($Raposa.visible == true):
		mov_raposa.y +=1200 * delta
		if(qtd_socos > socos_limite_raposa):
			qtd_socos = 0
			$Area_socos/Colis_socos.disabled = true
#			Movimentação
		if(not atacando):
#
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("A")):
				if($RayCast2D.is_colliding() and direcao == 1 and not is_on_floor()):
					$Raposa.play("puloparederapo")
					mov_raposa.y = -forca_pulo_raposa * delta
#
#					Muda tudo pro lado esquerdo
				if(direcao == 1):
					scale.x = -0.519
					direcao = -1
				mov_raposa.x = -velocidade_raposa * delta

#					Animacao de correr
				if (is_on_floor()):
					$Raposa.play("correrapo")
#
#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Raposa.play("parederapo")
					mov_raposa.y = 0
#
#					Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("A") and is_on_wall() and $RayCast2D.is_colliding() and not $Raposa.animation == "puloparederapo"):
					$Raposa.play("caindorapo")
#
#			Tudo pro lado Direito
			elif(Input.is_action_pressed("D")):
				if($RayCast2D.is_colliding() and direcao == -1 and not is_on_floor()):
					$Raposa.play("puloparederapo")
					mov_raposa.y = -forca_pulo_raposa * delta

#				muda tudo pro lado direito
				if(direcao == -1):
					scale.x = -0.519
					direcao = 1

				mov_raposa.x = velocidade_raposa * delta
#
#					Animacao de correr
				if (is_on_floor()):
					$Raposa.play("correrapo")
#
#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Raposa.play("parederapo")
					mov_raposa.y = 0
#				Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("D") and is_on_wall() and $RayCast2D.is_colliding() and not $Raposa.animation == "puloparederapo" ):
					$Raposa.play("caindorapo")
#
#
			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("S") and is_on_floor()):
				$Raposa.play("agaixarapo")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov_raposa.x = 0

			elif(Input.is_action_just_released("S")):
				$HitD/CollisionShape2D.disabled = false
				$HitE/CollisionShape2D.disabled = false

#				Parado
			else: 
				if (is_on_floor() and not $Raposa.animation == "hitrapo"):
					$Raposa.play("idlerapo")
				mov_raposa.x = 0
#
#				Caindo
				if(not is_on_floor() and not is_on_wall() and not $Raposa.animation == "ataquerapo" and not $Raposa.animation == "puloparederapo" and not $Raposa.animation == "pulorapo" and not $RayCast2D.is_colliding()):
					$Raposa.play("caindorapo")
#
#				Pulo pelo chao
			if (Input.is_action_just_pressed("W") and is_on_floor()):
				$Raposa.play("pulorapo")
				mov_raposa.y = -forca_pulo_raposa * delta
#
#			Jogando Shuriken "H"
		if(Input.is_action_just_pressed("shuriken H") and not is_on_wall()):
			$Raposa.play("ataquerapo")
			mov_raposa.x = 0
			atacando = true

			var cena_disparo = preload("res://cena_disparoD.tscn")

			var objeto_disparo = cena_disparo.instance()
			objeto_disparo.global_position = $Shuriken.global_position
			objeto_disparo.z_index = 0
			
			if(direcao == -1):
				objeto_disparo.scale.x = -1

			get_tree().root.add_child(objeto_disparo)
			if(ScriptGlobal.Status_som == true):
				$ShurikenSom.play()
			else:
				$ShurikenSom.stop()
			
#			Quando soltar o Botao da Shuriken "H"
		elif(Input.is_action_just_released("shuriken H")):
			if(is_on_floor()):
				$Raposa.play("idlerapo")
			if(not is_on_floor()):
				$Raposa.play("caindorapo")
			atacando = false
			
			
			
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos K")):
			mov_raposa.x = 0
			mov_raposa.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_raposa()
			
#			Soco pra baixo
		if(Input.is_action_just_pressed("S") and not is_on_floor() and not is_on_wall()):
			mov_raposa.y = 350 
			mov_raposa.x = 0
			$Raposa.play("socobaixorapo")
			atacando = true
			
		mov_raposa = move_and_slide(mov_raposa,Vector2(0,-1))

#  Mortes dos Personagens (gravidade e Pulo)
func mortes(delta):
#	Gravidade
	if($MorteNaruto.animation == "mortenaruto"):
		mortepersonagem.y = 800 * delta
	if($MorteRaposa.animation == "morteraposa"):
		mortepersonagem.y = 800 * delta
	
	if($MorteSasuke.animation == "mortesasuke"):
		mortepersonagem.y = 800 * delta
	if($MorteDemon.animation == "mortedemon"):
		mortepersonagem.y = 800 * delta
#	Pulo
	if($MorteRaposa.visible == true):
		if($MorteRaposa.animation == "morteraposa"):
			move_and_slide(mortepersonagem)
	if($MorteDemon.visible == true):
		if($MorteDemon.animation == "mortedemon"):
			move_and_slide(mortepersonagem)
			
	if($MorteNaruto.visible == true):
		if($MorteNaruto.animation == "mortenaruto"):
			move_and_slide(mortepersonagem)
	if($MorteSasuke.visible == true):
		if($MorteSasuke.animation == "mortesasuke"):
			move_and_slide(mortepersonagem)

#  Comemoracao de vitoria dos personagens
func vitoria(delta):
#		Naruto Normal
	if(ScriptGlobal.kil_inimigo == 1):
		if($Naruto.visible == true):
			$Naruto.visible = false
			$Vitoria.visible = true
			$Raposa.visible = false
			$Vitoria.play("Vitoria")
			forca_pulo = 0
			velocidade = 0
		
#		Naruto Raposa
		elif($Raposa.visible == true):
			$Raposa.visible = false
			$VitoriaRapo.visible = true
			$VitoriaRapo.play("vitoriarapo")
			forca_pulo = 0
			velocidade = 0
		
	#		Sasuke Normal
	if(ScriptGlobal.kil_inimigo == 1):
		if($Sasuke.visible == true):
			$Sasuke.visible = false
			$VitoriaSasuke.visible = true
			$Demon.visible = false
			$VitoriaSasuke.play("VitoriaSasuke")
			forca_pulo = 0
			velocidade = 0
		
#		Sasuke Demon
		elif($Demon.visible == true):
			$Demon.visible = false
			$VitoriaDemon.visible = true
			$VitoriaDemon.play("vitoriademon")
			forca_pulo = 0
			velocidade = 0

#  Animacao Raposa
func _on_Raposa_animation_finished():
	if($Raposa.animation == "puloparederapo"):
		$Raposa.play("caindorapo")
#	levar dano
	elif ($Raposa.animation == "hitrapo"):
		$Raposa.play("idlerapo")
		atacando = false
		
#	soco pra baixo
	elif($Raposa.animation == "socobaixorapo"):
		atacando = false
	
	elif($Raposa.animation == "atk1" or $Raposa.animation == "atk2" or $Raposa.animation == "atk3"
	or $Raposa.animation == "atk4" or $Raposa.animation == "atk5" or $Raposa.animation == "atk6"
	or $Raposa.animation == "atk7" or $Raposa.animation == "atk8" or $Raposa.animation == "atk9"
	or $Raposa.animation == "atk10" or $Raposa.animation == "atk11" or $Raposa.animation == "atk12"
	or $Raposa.animation == "atk13" or $Raposa.animation == "atk14" or $Raposa.animation == "atk15"
	or $Raposa.animation == "atk16" or $Raposa.animation == "atk17" or $Raposa.animation == "atk18"
	or $Raposa.animation == "atk19"):
		qtd_socos = 0
		socos = false
		atacando = false 
		$Area_socos/Colis_socos.disabled = true

# Animacao Demon
func _on_Demon_animation_finished():

	if($Demon.animation == "jutsureptdemon"):
		atacando = false
		
	if($Demon.animation == "jutsuBolaFogodemon"):
			$Demon.play("jutsureptdemon")
			mov_raposa.x = 0
			mov_raposa.y = 0
			var cena_Blfogo = preload("res://cena_boladfogo.tscn")
			
			var objeto_disparoFogo = cena_Blfogo.instance()
			objeto_disparoFogo.global_position = $Boladefogo.global_position
			objeto_disparoFogo.z_index = 0
			
			if(direcao == -1):
				objeto_disparoFogo.scale.x = -1
				
			get_tree().root.add_child(objeto_disparoFogo)
	
	
	if($Demon.animation == "puloparededemon"):
		$Demon.play("caindodemon")
#	levar dano
	elif ($Demon.animation == "hitdemon"):
		$Demon.play("idledemon")
		atacando = false
#	soco pra baixo
	elif($Demon.animation == "socobaixodemon"):
		atacando = false
		
	elif($Demon.animation == "atk1" or $Demon.animation == "atk2" or $Demon.animation == "atk3"
	or $Demon.animation == "atk4" or $Demon.animation == "atk5" or $Demon.animation == "atk6"
	or $Demon.animation == "atk7" or $Demon.animation == "atk8" or $Demon.animation == "atk9"
	or $Demon.animation == "atk10" or $Demon.animation == "atk11" or $Demon.animation == "atk12"
	or $Demon.animation == "atk13"):
		qtd_socos = 0
		socos = false
		atacando = false 
		$Area_socos/Colis_socos.disabled = true

#  Tela de Vitoria Raposa
func _on_VitoriaRapo_animation_finished():
	if($VitoriaRapo.animation == "vitoriarapo"):
		ScriptGlobal.contagem = false
		if(ScriptGlobal.Multiplayer == true):
			get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")
		else:
			get_tree().change_scene("res://cena_vitoria_raposa.tscn")
		

#  Tela de Vitoria Demon
func _on_VitoriaDemon_animation_finished():
	if($VitoriaDemon.animation == "vitoriademon"):
		ScriptGlobal.contagem = false
		if(ScriptGlobal.Multiplayer == true):
			get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")
		else:
			get_tree().change_scene("res://cena_vitoria_demon.tscn") 

#  Tela de Vitoria Naruto 
func _on_Vitoria_animation_finished():
	if($Vitoria.animation == "Vitoria"):
		ScriptGlobal.contagem = false
		if(ScriptGlobal.Multiplayer == true):
			get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")
		else:
			get_tree().change_scene("res://cena_vitoria_naruto.tscn")

#  Tela de Vitoria Sasuke
func _on_VitoriaSasuke_animation_finished():
	if($VitoriaSasuke.animation == "VitoriaSasuke"):
		ScriptGlobal.contagem = false
		if(ScriptGlobal.Multiplayer == true):
			get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")
			
		else:
			get_tree().change_scene("res://cena_vitoria_sasuke.tscn") 

#  Conversao de Normal para Raposa
func _on_Transformacao_animation_finished():
	if($Transformacao.animation == "transformacao" and transOn == true):
		$Transformacao.visible = false
		$Raposa.visible = true
		transOn = false

#  Conversao de Normal para Demon
func _on_TransformacaoDemon_animation_finished():
	if($TransformacaoDemon.animation == "transformacaodemon" and transOn == true):
		$TransformacaoDemon.visible = false
		$Demon.visible = true
		transOn = false

#  Atingido pela Direita
func _on_HitD_area_entered(area):
	if($Raposa.visible == true):
		if(area.name == "FoiceE"):
			if(ScriptGlobal.vidas_naruto>0):
				$Raposa.play("hitrapo")
				ScriptGlobal.vidas_naruto -= 1
				mov_raposa.x = 0
			if(ScriptGlobal.vidas_naruto == 0):
				$Raposa.visible = false
				$MorteRaposa.visible = true
				mortepersonagem.x = -veldaMorte
				$MorteRaposa.play("morteraposa")
				if(direcao == 1):
					$MorteRaposa.flip_h = false
				elif(direcao == -1):
					$MorteRaposa.flip_h = true
					
	if($Naruto.visible == true):
		if(area.name == "FoiceE"):
			if(ScriptGlobal.vidas_naruto>0):
				$Naruto.play("hit")
				ScriptGlobal.vidas_naruto -= 1
				mov.x = 0
			if(ScriptGlobal.vidas_naruto == 0):
				$Naruto.visible = false
				$MorteNaruto.visible = true
				mortepersonagem.x = -veldaMorte 
				$MorteNaruto.play("mortenaruto")
				if(direcao == 1):
					$MorteNaruto.flip_h = false
				elif(direcao == -1):
					$MorteNaruto.flip_h = true
					
	if($Demon.visible == true):
		if(area.name == "FoiceE"):
			if(ScriptGlobal.vidas_sasuke>0):
				$Demon.play("hitdemon")
				ScriptGlobal.vidas_sasuke -= 1
				mov_raposa.x = 0
			if(ScriptGlobal.vidas_sasuke == 0):
				$Demon.visible = false
				$MorteDemon.visible = true
				mortepersonagem.x = -veldaMorte 
				$MorteDemon.play("mortedemon")
				if(direcao == 1):
					$MorteDemon.flip_h = false
				elif(direcao == -1):
					$MorteDemon.flip_h = true
					
	if($Sasuke.visible == true):
		if(area.name == "FoiceE"):
			if(ScriptGlobal.vidas_sasuke>0):
				$Sasuke.play("hit")
				ScriptGlobal.vidas_sasuke -= 1
				mov.x = 0
			if(ScriptGlobal.vidas_sasuke == 0):
				$Sasuke.visible = false
				$MorteSasuke.visible = true
				mortepersonagem.x = -veldaMorte 
				$MorteSasuke.play("mortesasuke")
				if(direcao == 1):
					$MorteSasuke.flip_h = false
				elif(direcao == -1):
					$MorteSasuke.flip_h = true

#  Atingido pela Esquerda 
func _on_HitE_area_entered(area):
	if($Raposa.visible == true):
		if(area.name == "FoiceD"):
			if(ScriptGlobal.vidas_naruto > 0):
				$Raposa.play("hitrapo")
				ScriptGlobal.vidas_naruto -= 1
				mov_raposa.x = 0
			if(ScriptGlobal.vidas_naruto == 0):
				$Raposa.visible = false
				$MorteRaposa.visible = true
				mortepersonagem.x = veldaMorte 
				$MorteRaposa.play("morteraposa")
				if(direcao == 1):
					$MorteRaposa.flip_h = true
				elif(direcao == -1):
					$MorteRaposa.flip_h = false
				
	if($Naruto.visible == true):
		if(area.name == "FoiceD"):
			if(ScriptGlobal.vidas_naruto > 0):
				$Naruto.play("hit")
				ScriptGlobal.vidas_naruto -= 1
				mov.x = 0
			if(ScriptGlobal.vidas_naruto == 0):
				$Naruto.visible = false
				$MorteNaruto.visible = true
				mortepersonagem.x = veldaMorte
				$MorteNaruto.play("mortenaruto")
				if(direcao == 1):
					$MorteNaruto.flip_h = true
				elif(direcao == -1):
					$MorteNaruto.flip_h = false
					
	if($Demon.visible == true):
		if(area.name == "FoiceD"):
			if(ScriptGlobal.vidas_sasuke > 0):
				$Demon.play("hitdemon")
				ScriptGlobal.vidas_sasuke -= 1
				mov_raposa.x = 0
			if(ScriptGlobal.vidas_sasuke == 0):
				$Demon.visible = false
				$MorteDemon.visible = true
				mortepersonagem.x = veldaMorte
				$MorteDemon.play("mortedemon")
				if(direcao == 1):
					$MorteDemon.flip_h = true
				elif(direcao == -1):
					$MorteDemon.flip_h = false
				
	if($Sasuke.visible == true):
		if(area.name == "FoiceD"):
			if(ScriptGlobal.vidas_sasuke > 0):
				$Sasuke.play("hit")
				ScriptGlobal.vidas_sasuke -= 1
				mov.x = 0
			if(ScriptGlobal.vidas_sasuke == 0):
				$Sasuke.visible = false
				$MorteSasuke.visible = true
				mortepersonagem.x = veldaMorte
				$MorteSasuke.play("mortesasuke")
				if(direcao == 1):
					$MorteSasuke.flip_h = true
				elif(direcao == -1):
					$MorteSasuke.flip_h = false

#  Morte do Naruto Raposa
func _on_MorteRaposa_animation_finished():
	if($MorteRaposa.animation == "morteraposa"):
		veldaMorte = 0
		
		$MorteRaposa.play("chaoraposa")
	elif($MorteRaposa.animation == "chaoraposa"):
		get_tree().change_scene("res://cena_game_over.tscn")

# Morte do Sasuke Demon
func _on_MorteDemon_animation_finished():
	if($MorteDemon.animation == "mortedemon"):
		veldaMorte = 0
		
		$MorteDemon.play("chaodemon")
	elif($MorteDemon.animation == "chaodemon"):
		get_tree().change_scene("res://cena_game_over.tscn")

#  Morte do Naruto
func _on_MorteNaruto_animation_finished():
	if($MorteNaruto.animation == "mortenaruto"):
		veldaMorte = 0
		$MorteNaruto.play("chaonaruto")
	elif($MorteNaruto.animation == "chaonaruto"):
		get_tree().change_scene("res://cena_game_over.tscn")

# Morte do Sasuke
func _on_MorteSasuke_animation_finished():
	if($MorteSasuke.animation == "mortesasuke"):
		veldaMorte = 0
		$MorteSasuke.play("chaosasuke")
	elif($MorteSasuke.animation == "chaosasuke"):
		get_tree().change_scene("res://cena_game_over.tscn")

# Animacao Naruto
func _on_Naruto_animation_finished():
	
#	Final da Animaçao de ataque
	if ($Naruto.animation == "atk1" or $Naruto.animation == "atk2" or $Naruto.animation == "atk3"
	or $Naruto.animation == "atk4" or $Naruto.animation == "atk5" or $Naruto.animation == "atk6"
	or $Naruto.animation == "atk7" or $Naruto.animation == "atk8" or $Naruto.animation == "atk9"
	or $Naruto.animation == "atk10" or $Naruto.animation == "atk11" or $Naruto.animation == "atk12"
	or $Naruto.animation == "atk13"):
		qtd_socos = 0
		socos = false
		atacando = false 
		$Area_socos/Colis_socos.disabled = true
	
	if($Naruto.animation == "pulo parede"):
		$Naruto.play("caindo")
	
	if ($Naruto.animation == "hit"):
		$Naruto.play("parado")
		atacando = false
		
	elif($Naruto.animation == "socoPbaixo"):
		atacando = false

# Animacao Sasuke
func _on_Sasuke_animation_finished():
	
	if($Sasuke.animation == "jutsurept"):
		atacando = false
		
	if($Sasuke.animation == "jutsuBolaFogo"):
			$Sasuke.play("jutsurept")
			mov.x = 0
			mov.y = 0
			var cena_Blfogo = preload("res://cena_boladfogo.tscn")
			
			var objeto_disparoFogo = cena_Blfogo.instance()
			objeto_disparoFogo.global_position = $Boladefogo.global_position
			objeto_disparoFogo.z_index = 0
			
			if(direcao == -1):
				objeto_disparoFogo.scale.x = -1
				
			get_tree().root.add_child(objeto_disparoFogo)
			
#	Final da Animaçao de ataque
	if ($Sasuke.animation == "atk1" or $Sasuke.animation == "atk2" or $Sasuke.animation == "atk3"
	or $Sasuke.animation == "atk4" or $Sasuke.animation == "atk5" or $Sasuke.animation == "atk6"
	or $Sasuke.animation == "atk7" or $Sasuke.animation == "atk8" or $Sasuke.animation == "atk9"
	or $Sasuke.animation == "atk10" or $Sasuke.animation == "atk11" or $Sasuke.animation == "atk12"
	or $Sasuke.animation == "atk13"):
		qtd_socos = 0
		socos = false
		atacando = false 
		$Area_socos/Colis_socos.disabled = true
	
	if($Sasuke.animation == "puloparede"):
		$Sasuke.play("caindo")
	
	if ($Sasuke.animation == "hit"):
		$Sasuke.play("parado")
		atacando = false
		
	elif($Sasuke.animation == "socoPbaixo"):
		atacando = false

# Controlar Musica
func _on_AudioStreamPlayer_finished():
	if(ScriptGlobal.Status_music == true):
		$AudioStreamPlayer.stream_paused = false
		$AudioStreamPlayer.play()
	else: 
		$AudioStreamPlayer.stream_paused = true
	

func _on_MusicaMultOn_finished():
	if(ScriptGlobal.Status_music == true):
		$MusicaMultOn.stream_paused = false
		$MusicaMultOn.play()
	else: 
		$MusicaMultOn.stream_paused = true

# Controlar Animação de tempo de Transformado
func _on_TempoTransformado_timeout():
	if($Raposa.visible == true):
		$Raposa.visible = false
		$Transformacao.visible = false
		$Naruto.visible = true
		
	if($Demon.visible == true):
		$Demon.visible = false
		$TransformacaoDemon.visible = false
		$Sasuke.visible = true
		
#		
