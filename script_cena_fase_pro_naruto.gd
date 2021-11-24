extends Node2D

func _ready():
	if (ScriptGlobal.Selec_person == 1):
		$fase_naruto.visible = false
		$fase_sasuke.visible = true
	elif(ScriptGlobal.Selec_person == 2):
		$fase_naruto.visible = true
		$fase_sasuke.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	
	if(ScriptGlobal.Multiplayer == false):

		if($Naruto_Sasuke/Personagem.global_position.x <= 1740):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 0
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = 0
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 1740
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = 600
	
		elif ($Naruto_Sasuke/Personagem.global_position.x >=1740 and $Naruto_Sasuke/Personagem.global_position.x  <= 2770):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 1742
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -16
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 2770
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = 586

		elif ($Naruto_Sasuke/Personagem.global_position.x >= 2770 and $Naruto_Sasuke/Personagem.global_position.x <= 3794 ):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 2771
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -96
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 3794
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = 602

		elif($Naruto_Sasuke/Personagem.global_position.x >= 3794 and $Naruto_Sasuke/Personagem.global_position.x <= 4818):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 3795
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -352
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 4818
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = 664
		
		elif($Naruto_Sasuke/Personagem.global_position.x >= 4818 and $Naruto_Sasuke/Personagem.global_position.x <= 5841.6):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 4819
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1277
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 5841.6
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -185.3
		
		elif($Naruto_Sasuke/Personagem.global_position.x >= 5841.6 and $Naruto_Sasuke/Personagem.global_position.x <= 9237.3):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 5841.7
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1572.5
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 9237.3
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -952.8
		
		
		elif($Naruto_Sasuke/Personagem.global_position.x >=9237.9 and $Naruto_Sasuke/Personagem.global_position.x <= 10268):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 9237.9
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1543.8
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 10268
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -943


		


