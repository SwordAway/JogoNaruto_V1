extends KinematicBody2D

#Controlar Movimento em Geral
var atacando = false
var direcao = 1
var transOn = false


# Ataques
var qtd_socos: int = 0;
var socos_limite_sasuke: int = 13;
var socos_limite_demon: int = 13;
var socos: bool = false;

#Morte
var veldaMorte = 100
var mortepersonagem = Vector2(veldaMorte,0) 

# Personagem Normal
var forca_pulo = 600
var velocidade = 300
var mov = Vector2(0,0) 

#Personagem Transformado
var forca_pulo_raposa = 750
var velocidade_raposa = 450
var mov_raposa = Vector2(0,0) 

func _ready():
	$VitoriaSasuke.visible = false
	$Demon.visible = false
	$Sasuke.visible = true
	$VitoriaDemon.visible = false
	$TransformacaoDemon.visible = false
	$MorteSasuke.visible = false
	$MorteDemon.visible = false



func mortes():
#	Gravidade
	if($MorteSasuke.animation == "mortesasuke"):
		mortepersonagem.y = 300
	if($MorteDemon.animation == "mortedemon"):
		mortepersonagem.y = 300 
	
#	Pulo
	if($MorteDemon.visible == true):
		if($MorteDemon.animation == "mortedemon"):
			move_and_slide(mortepersonagem)
	
	if($MorteSasuke.visible == true):
		if($MorteSasuke.animation == "mortesasuke"):
			move_and_slide(mortepersonagem)

func _process(delta):
	
	
	if($Sasuke.visible == true):
		get_parent().get_node("Vidas/Jogador2/Sasuke").visible = true
	elif($Demon.visible == true):
		get_parent().get_node("Vidas/Jogador2/Sasuke").visible = false
	
	
#	var largura = get_parent().get_node("Personagem/Camera2D").get_viewport_rect().size.x
#	var altura = get_parent().get_node("Personagem/Camera2D").get_viewport_rect().size.y
#
#	var x_atual = global_position.x
#	var y_atual = global_position.y
#
#	global_position.x = clamp(x_atual,0,largura)
#	global_position.y = clamp(y_atual,0,altura)
	
	
	#Dropar de plataforma
	if(Input.is_action_just_pressed("dropPlataform 6")):
		get_parent().get_node("PersoSasuke").set_collision_layer_bit(0, false)
		get_parent().get_node("PersoSasuke").set_collision_mask_bit(0, false)
		
	elif(Input.is_action_just_released("dropPlataform 6")):
		get_parent().get_node("PersoSasuke").set_collision_layer_bit(0, true)
		get_parent().get_node("PersoSasuke").set_collision_mask_bit(0, true)
	
	
	sasuke(delta)
	demon(delta)
	vitoriaSasuke()

#  Sistema de Combos
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

#Movimentos Sasuke
func sasuke(delta):
#	controlar animacoes
	#	Movimentação
	if($Sasuke.visible == true):
		
		if($Sasuke.animation == "jutsuBolaFogo" or $Sasuke.animation == "jutsurept"):
			mov.y = 0
			mov.x = 0
			velocidade = 0
		else:
			velocidade = 300
			mov.y += 15 
		if(qtd_socos > socos_limite_sasuke):
			qtd_socos = 0
			$Area_socos/Colis_socos.disabled = true
		if(not atacando):
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("ui_left")):
				if($RayCast2D.is_colliding() and direcao == 1 and not is_on_floor()):
					$Sasuke.play("puloparede")
					mov.y = -forca_pulo 

#					Muda tudo pro lado esquerdo
				if(direcao == 1):
					scale.x = -0.519
					direcao = -1
				mov.x = -velocidade  

#					Animacao de correr
				if (is_on_floor()):
					$Sasuke.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Sasuke.play("naparede")
					mov.y = 0

#					Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("ui_left") and is_on_wall() and $RayCast2D.is_colliding() and not $Sasuke.animation == "puloparede"):
					$Sasuke.play("caindo")

#			Tudo pro lado Direito
			elif(Input.is_action_pressed("ui_right")):

				if($RayCast2D.is_colliding() and direcao == -1 and not is_on_floor()):
					$Sasuke.play("puloparede")
					mov.y = -forca_pulo

#				muda tudo pro lado direito
				if(direcao == -1):
					scale.x = -0.519
					direcao = 1
				mov.x = velocidade 

#					Animacao de correr
				if (is_on_floor()):
					$Sasuke.play("correndo")

#					Animacao de ficar na parede e Ficar na parede
				if(is_on_wall()):
					$Sasuke.play("naparede")
					mov.y = 0
#				Animacao de caindo se estiver perto da parede
			elif(Input.is_action_just_released("ui_right") and is_on_wall() and $RayCast2D.is_colliding() and not $Sasuke.animation == "puloparede" ):
					$Sasuke.play("caindo")


			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("ui_down") and is_on_floor()):
				$Sasuke.play("agaixando")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov.x = 0
#			 	Reativa os collisions
			elif(Input.is_action_just_released("ui_down")):
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
			if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
				$Sasuke.play("pulando")
				mov.y = -forca_pulo 
			
			
			
#			-_-_-_-_-Parte de Skills_-_-_-_-

#			Jogando Shuriken "7"
		if(Input.is_action_just_pressed("shuriken 7") and not is_on_wall()):
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
				
			
#			Quando soltar o Botao da Shuriken "7"
		elif(Input.is_action_just_released("shuriken 7")):
			if(is_on_floor()):
				$Sasuke.play("parado")
			if(not is_on_floor()):
				$Sasuke.play("caindo")
			atacando = false

#			Jutsu bola de fogo (8)
		if(Input.is_action_just_pressed("jutsuBLFogo  8") and not is_on_wall()):
			$Sasuke.play("jutsuBolaFogo")
			mov.x = 0
			atacando = true
			if(ScriptGlobal.Status_som == true):
				$Jutsu.play()
			else:
				$Jutsu.stop()
		
		
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos 0")):
			mov.x = 0
			mov.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_sasuke()

#			Soco pra baixo
		if(Input.is_action_just_pressed("ui_down") and not is_on_floor() and not is_on_wall()):
			mov.y = 300 
			mov.x = 0
			$Sasuke.play("socoPbaixo")
			atacando = true
			
	#			Apertar 9 para Transformar
		if(ScriptGlobal.furia_demon == 10):
			if(ScriptGlobal.Multiplayer == true):
				get_parent().get_node("Vidas/Jogador2/Barra_Furia2/Label2").visible = true
			if(ScriptGlobal.furia_demon == 10 and Input.is_action_just_pressed("Transformacao 9")):
				$TempoTransformado.start()
				transOn = true
				$TransformacaoDemon.set_frame(0) 
				ScriptGlobal.furia_demon = 0
				ScriptGlobal.vidas_sasuke +=4 
				get_parent().get_node("Vidas/Jogador2/Barra_Furia2/Label2").visible = false
				
	
	
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
			mov_raposa.x = 0 
			mov_raposa.y = 0 
			velocidade_raposa = 0 
		else:
			velocidade_raposa = 450 * delta
			mov_raposa.y += 15 * delta
#		Animacao de socos
		if(qtd_socos > socos_limite_demon):
			qtd_socos = 0 * delta
			$Area_socos/Colis_socos.disabled = true
			
#			Movimentação
		if(not atacando):
#			Tudo pro lado Esquerdo
			if(Input.is_action_pressed("ui_left")):
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
			elif(Input.is_action_just_released("ui_left") and is_on_wall() and $RayCast2D.is_colliding() and not $Demon.animation == "puloparededemon"):
					$Demon.play("caindodemon")
#
#			Tudo pro lado Direito
			elif(Input.is_action_pressed("ui_right")):
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
			elif(Input.is_action_just_released("ui_right") and is_on_wall() and $RayCast2D.is_colliding() and not $Demon.animation == "puloparededemon" ):
					$Demon.play("caindodemon")
#
#
			#	Agaixar e desviar dos ataques
			elif(Input.is_action_pressed("ui_down") and is_on_floor()):
				$Demon.play("agaixademon")
				$HitD/CollisionShape2D.disabled = true
				$HitE/CollisionShape2D.disabled = true
				mov_raposa.x = 0

			elif(Input.is_action_just_released("ui_down")):
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
			if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
				$Demon.play("pulodemon")
				mov_raposa.y = -forca_pulo_raposa * delta
#
#			Jogando Shuriken "7"
		if(Input.is_action_just_pressed("shuriken 7") and not is_on_wall()):
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
		elif(Input.is_action_just_released("shuriken 7")):
			if(is_on_floor()):
				$Demon.play("idledemon")
			if(not is_on_floor()):
				$Demon.play("caindodemon")
			atacando = false
			
#			Jutsu bola de fogo (J)
		if(Input.is_action_just_pressed("jutsuBLFogo  8") and not is_on_wall()):
			$Demon.play("jutsuBolaFogodemon")
			mov_raposa.x = 0
			atacando = true
			if(ScriptGlobal.Status_som == true):
				$Jutsu.play()
			else:
				$Jutsu.stop()
			
#			Ataques (combos)
		if(Input.is_action_just_pressed("Socos 0")):
			mov_raposa.x = 0
			mov_raposa.y = 0
			qtd_socos += 1 
			socos = true
			atacando = true
			$Area_socos/Colis_socos.disabled = false
			ataque_demon()
			
#			Soco pra baixo
		if(Input.is_action_just_pressed("ui_down") and not is_on_floor() and not is_on_wall()):
			mov_raposa.y = 350 
			mov_raposa.x = 0
			$Demon.play("socobaixodemon")
			atacando = true
			
		mov_raposa = move_and_slide(mov_raposa,Vector2(0,-1))



func vitoriaSasuke():
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

func _on_Sasuke_animation_finished():
	if($Sasuke.animation == "jutsurept"):
		atacando = false
		
	if($Sasuke.animation == "jutsuBolaFogo"):
			$Sasuke.play("jutsurept")
			
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


func _on_MorteSasuke_animation_finished():
	if($MorteSasuke.animation == "mortesasuke"):
		veldaMorte = 0
		$MorteSasuke.play("chaosasuke")
	elif($MorteSasuke.animation == "chaosasuke"):
		get_tree().change_scene("res://cena_game_over.tscn")


func _on_Demon_animation_finished():
	if($Demon.animation == "jutsureptdemon"):
		atacando = false
		
	if($Demon.animation == "jutsuBolaFogodemon"):
			$Demon.play("jutsureptdemon")
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


func _on_MorteDemon_animation_finished():
	if($MorteDemon.animation == "mortedemon"):
		veldaMorte = 0
		
		$MorteDemon.play("chaodemon")
	elif($MorteDemon.animation == "chaodemon"):
		get_tree().change_scene("res://cena_game_over.tscn")


func _on_VitoriaSasuke_animation_finished():
	if($VitoriaSasuke.animation == "VitoriaSasuke"):
		get_tree().change_scene("res://cena_vitoria_multiplayer.tscn") 

func _on_VitoriaDemon_animation_finished():
	if($VitoriaDemon.animation == "vitoriademon"):
		get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")

func _on_TransformacaoDemon_animation_finished():
	if($TransformacaoDemon.animation == "transformacaodemon" and transOn == true):
		$TransformacaoDemon.visible = false
		$Demon.visible = true
		transOn = false


func _on_HitE_area_entered(area):
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


func _on_HitD_area_entered(area):
	if($Demon.visible == true):
		if(area.name == "FoiceE"):
			if(ScriptGlobal.vidas_sasuke > 0):
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
			if(ScriptGlobal.vidas_sasuke > 0):
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


func _on_TempoTransformado_timeout():
	if($Demon.visible == true):
		$Demon.visible = false
		$TransformacaoDemon.visible = false
		$Sasuke.visible = true
