extends KinematicBody2D

#Ataque Inimigo (loop)
var Atkloopin: bool = false;
var direcaoAtk: int = 0

#Naruto Morte
var veldaMorte = 10
var mortepersonagem = Vector2(veldaMorte,0)

#Morte Inimigo
var velInimigo = 40
var movInimigo = Vector2(velInimigo,0)
var velMorteini = 400

func _ready():
	$InimigoChao.visible = false
	
func _process(delta):
#	if(Atkloopin == true):
#		$TempoAtk.start()
	
#	Controla o movimento da morte (pulinho)
	if($Inimigoani.animation == "morteinimigo"):
		move_and_slide(movInimigo)

# Tiro inimigo do Lado Esquerdo
func _on_ZonaDetc_body_entered(body):
	if(body.is_in_group("Personagem")):
		$Inimigoani.play("ataqueinimigo")
		$Inimigoani.flip_h = false
		var cena_disparo = preload("res://cena_disparo_inimigo.tscn")
		var objeto_disparo = cena_disparo.instance()
		objeto_disparo.global_position = $Position2D.global_position
		objeto_disparo.z_index = 0
		get_tree().root.add_child(objeto_disparo)
		Atkloopin = true
		direcaoAtk = 1
		$TempoAtk.start()


# Tiro inimigo do Lado Direito
func _on_ZonaDetc2_body_entered(body):
	if(body.is_in_group("Personagem")):
		$Inimigoani.play("ataqueinimigo")
		$Inimigoani.flip_h = true
		var cena_disparo = preload("res://cena_disparo_inimigoD.tscn")
		var objeto_disparo = cena_disparo.instance()
		objeto_disparo.global_position = $Position2D.global_position
		objeto_disparo.z_index = 0
		get_tree().root.add_child(objeto_disparo)
		Atkloopin = true
		direcaoAtk = 2

# Quando o Personagem sai do range, o inimigo reseta (lado Esquerdo)
func _on_ZonaDetc_body_exited(body):
	if(body.is_in_group("Personagem")):
		if(not $Inimigoani.animation == "morteinimigo"):
			$Inimigoani.play("inimigoparado")
		Atkloopin = false
		direcaoAtk = 0
	
# Quando o Personagem sai do range, o inimigo reseta (Lado Direito)
func _on_ZonaDetc2_body_exited(body):
	if(body.is_in_group("Personagem")):
		if(not $Inimigoani.animation == "morteinimigo"):
			$Inimigoani.play("inimigoparado")
		Atkloopin = false
		direcaoAtk = 0
	
# Quando acabar a animacao morte ele ficar parado
func _on_Inimigoani_animation_finished():
	
	if($Inimigoani.animation == "ataqueinimigo"):
		$Inimigoani.play("inimigoparado")
		
	if($Inimigoani.animation == "morteinimigo"):
		ScriptGlobal.kil_inimigo -= 1 
		ScriptGlobal.furia_raposa += 1 
		ScriptGlobal.furia_demon += 1
		$CollisionShape2D.queue_free()
		$InimigoChao.visible = true
		if($Inimigoani.flip_h == true):
			$InimigoChao.play("inimigochao")
			$InimigoChao.flip_h = true
			
		elif($Inimigoani.flip_h == false):
			$InimigoChao.play("inimigochao")
			$InimigoChao.flip_h = false
		

# Recebe tiro do lado Direito e morte do inimigo
func _on_LdE_area_entered(area):
	if(area.name == "Disparo" or area.name == "Bola_de_Fogo"):
		$Inimigoani.play("morteinimigo")
		$Inimigoani.flip_h = false
		movInimigo.x = velInimigo 
		movInimigo.y = velMorteini
		$ZonaDetc/CollisionShape2D.queue_free()
		$CollisionShape2D.disabled = true
		$ZonaDetc2/CollisionShape2D.queue_free()
		$LdE/CollisionShape2D.queue_free()
		$LdD/CollisionShape2D.queue_free()
		$Cabeca/CollisionShape2D.queue_free()
		$colis_cabeca.queue_free()
		$ECorpo_inimigo/CollisionShape2D.queue_free()
		$DCorpo_inimigo/CollisionShape2D.queue_free()

# Recebe tiro do lado Esquerdo e morte do inimigo
func _on_LdD_area_entered(area):
	if(area.name == "Disparo" or area.name == "Bola_de_Fogo"):
		$Inimigoani.play("morteinimigo")
		$Inimigoani.flip_h = true
		movInimigo.x = -velInimigo 
		movInimigo.y = velMorteini
		$ZonaDetc/CollisionShape2D.queue_free()
		$CollisionShape2D.disabled = true
		$ZonaDetc2/CollisionShape2D.queue_free()
		$LdE/CollisionShape2D.queue_free()
		$LdD/CollisionShape2D.queue_free()
		$Cabeca/CollisionShape2D.queue_free()
		$colis_cabeca.queue_free()
		$ECorpo_inimigo/CollisionShape2D.queue_free()
		$DCorpo_inimigo/CollisionShape2D.queue_free()

# ao final da animacao do inimigo morrer
func _on_InimigoChao_animation_finished():
	if($InimigoChao.animation == "inimigochao"):
#		$CollisionShape2D.queue_free()
		movInimigo.y = 0
		movInimigo.x = 0
	elif($InimigoChao.animation == "nacabeca"):
		ScriptGlobal.kil_inimigo -= 1 
		ScriptGlobal.furia_raposa += 1 
		ScriptGlobal.furia_demon += 1

# Inimigo morre pisando na cabeca
func _on_Cabeca_body_entered(body):
	if (body.name == "Personagem" or body.name == "PersoSasuke"):
		$ZonaDetc/CollisionShape2D.queue_free()
		$CollisionShape2D.queue_free()
		$colis_cabeca.queue_free()
		$ZonaDetc2/CollisionShape2D.queue_free()
		$LdE/CollisionShape2D.queue_free()
		$LdD/CollisionShape2D.queue_free()
		$Cabeca/CollisionShape2D.queue_free()
		$ECorpo_inimigo/CollisionShape2D.queue_free()
		$DCorpo_inimigo/CollisionShape2D.queue_free()
		$Inimigoani.visible = false
		$InimigoChao.visible = true
		if($Inimigoani.flip_h == true):
			$InimigoChao.play("nacabeca")
			$InimigoChao.flip_h = true
		elif($Inimigoani.flip_h == false):
			$InimigoChao.play("nacabeca")
			$InimigoChao.flip_h = false

#Personagem entra colide com o corpo do inimigo (Lado Direito)
func _on_DCorpo_inimigo_body_entered(body):
	if(body.name == "Personagem"):
		if(body.get_node("Naruto").visible == true):
			body.get_node("Naruto").visible = false
			body.get_node("MorteNaruto").visible = true
			body.get_node("MorteNaruto").play("mortenaruto")
			
		if(body.get_node("Sasuke").visible == true):
			body.get_node("Sasuke").visible = false
			body.get_node("MorteSasuke").visible = true
			body.get_node("MorteSasuke").play("mortesasuke")
			
		if(body.get_node("Raposa").visible == true):
			body.get_node("Raposa").visible = false
			body.get_node("MorteRaposa").visible = true
			body.get_node("MorteRaposa").play("morteraposa")
			
		if(body.get_node("Demon").visible == true):
			body.get_node("Demon").visible = false
			body.get_node("MorteDemon").visible = true
			body.get_node("MorteDemon").play("mortedemon")
		ScriptGlobal.vidas_naruto = 0
		ScriptGlobal.vidas_sasuke = 0
		
	if(body.name == "PersoSasuke"):
		if(body.get_node("Demon").visible == true):
			body.get_node("Demon").visible = false
			body.get_node("MorteDemon").visible = true
			body.get_node("MorteDemon").play("mortedemon")
		if(body.get_node("Sasuke").visible == true):
			body.get_node("Sasuke").visible = false
			body.get_node("MorteSasuke").visible = true
			body.get_node("MorteSasuke").play("mortesasuke")
		ScriptGlobal.vidas_sasuke = 0

#Personagem entra colide com o corpo do inimigo (Lado Esquerdo)
func _on_ECorpo_inimigo_body_entered(body):
	if(body.name == "Personagem"):
		if(body.get_node("Naruto").visible == true):
			body.get_node("Naruto").visible = false
			body.get_node("MorteNaruto").visible = true
			body.get_node("MorteNaruto").play("mortenaruto")
			
		if(body.get_node("Sasuke").visible == true):
			body.get_node("Sasuke").visible = false
			body.get_node("MorteSasuke").visible = true
			body.get_node("MorteSasuke").play("mortesasuke")
			
		if(body.get_node("Raposa").visible == true):
			body.get_node("Raposa").visible = false
			body.get_node("MorteRaposa").visible = true
			body.get_node("MorteRaposa").play("morteraposa")
			
		if(body.get_node("Demon").visible == true):
			body.get_node("Demon").visible = false
			body.get_node("MorteDemon").visible = true
			body.get_node("MorteDemon").play("mortedemon")
		ScriptGlobal.vidas_naruto = 0
		ScriptGlobal.vidas_sasuke = 0
		body.mortepersonagem.x = -veldaMorte 

	if(body.name == "PersoSasuke"):
		if(body.get_node("Demon").visible == true):
			body.get_node("Demon").visible = false
			body.get_node("MorteDemon").visible = true
			body.get_node("MorteDemon").play("mortedemon")
			
		if(body.get_node("Sasuke").visible == true):
			body.get_node("Sasuke").visible = false
			body.get_node("MorteSasuke").visible = true
			body.get_node("MorteSasuke").play("mortesasuke")
		ScriptGlobal.vidas_sasuke = 0
		body.mortepersonagem.x = -veldaMorte 
		
#Socos dos Personagens (lado Direito)
func _on_DCorpo_inimigo_area_entered(area):
	if(area.name == "Area_socos"):
		$Inimigoani.play("morteinimigo")
		$Inimigoani.flip_h = true
		movInimigo.x = -velInimigo 
		movInimigo.y = velMorteini 
		$ZonaDetc/CollisionShape2D.queue_free()
		$CollisionShape2D.disabled = true
		$ZonaDetc2/CollisionShape2D.queue_free()
		$LdE/CollisionShape2D.queue_free()
		$LdD/CollisionShape2D.queue_free()
		$Cabeca/CollisionShape2D.queue_free()
		$colis_cabeca.queue_free()
		$ECorpo_inimigo/CollisionShape2D.queue_free()
		$DCorpo_inimigo/CollisionShape2D.queue_free()

#Socos dos Personagens (lado Esquerdo)
func _on_ECorpo_inimigo_area_entered(area):
	if(area.name == "Area_socos"):
		$Inimigoani.play("morteinimigo")
		$Inimigoani.flip_h = false
		movInimigo.x = velInimigo 
		movInimigo.y = velMorteini
		$ZonaDetc/CollisionShape2D.queue_free()
		$CollisionShape2D.disabled = true
		$ZonaDetc2/CollisionShape2D.queue_free()
		$LdE/CollisionShape2D.queue_free()
		$LdD/CollisionShape2D.queue_free()
		$Cabeca/CollisionShape2D.queue_free()
		$colis_cabeca.queue_free()
		$ECorpo_inimigo/CollisionShape2D.queue_free()
		$DCorpo_inimigo/CollisionShape2D.queue_free()



#	if($Inimigoani.animation == "ataqueinimigo"):
#		contagem_ataque_inimigo +=1
#	pass

# Controla o tempo de Ataque (Lopping)
func _on_TempoAtk_timeout():
	
	if(direcaoAtk == 1):
		$Inimigoani.set_frame(0)
		$Inimigoani.play("ataqueinimigo")
		$Inimigoani.flip_h = false
		var cena_disparo = preload("res://cena_disparo_inimigo.tscn")
		var objeto_disparo = cena_disparo.instance()
		objeto_disparo.global_position = $Position2D.global_position
		objeto_disparo.z_index = 0
		get_tree().root.add_child(objeto_disparo)
		
	if(direcaoAtk == 2):
		$Inimigoani.set_frame(0)
		$Inimigoani.play("ataqueinimigo")
		$Inimigoani.flip_h = true
		var cena_disparo = preload("res://cena_disparo_inimigoD.tscn")
		var objeto_disparo = cena_disparo.instance()
		objeto_disparo.global_position = $Position2D.global_position
		objeto_disparo.z_index = 0
		get_tree().root.add_child(objeto_disparo)
