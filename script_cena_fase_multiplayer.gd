extends Node2D

func _process(delta):
	if(ScriptGlobal.Multiplayer == true):
		if($Naruto_Sasuke/Personagem.global_position.x <= 1009.6):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 0
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -490
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 1009.6
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = 600
	
		elif ($Naruto_Sasuke/Personagem.global_position.x >=1009.6 and $Naruto_Sasuke/Personagem.global_position.x  <= 4402.5):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 1013.4
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -788
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 4402.5
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -169.8

		elif ($Naruto_Sasuke/Personagem.global_position.x >= 4402.5 and $Naruto_Sasuke/Personagem.global_position.x <= 5425.8 ):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 4402.5
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1129.9
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 5425.8
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -113

		elif($Naruto_Sasuke/Personagem.global_position.x >= 5425.8 and $Naruto_Sasuke/Personagem.global_position.x <= 6449.3):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 5425.8
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1609.3
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 6449.3
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -927
		
		elif($Naruto_Sasuke/Personagem.global_position.x >= 6449.4 and $Naruto_Sasuke/Personagem.global_position.x <= 7477.7):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 6449.4
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1531.3
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 7477.7
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -945
		
		elif($Naruto_Sasuke/Personagem.global_position.x >= 7477.8 and $Naruto_Sasuke/Personagem.global_position.x <= 9216.7):
			$Naruto_Sasuke/Personagem/Camera2D.limit_left = 7477.8
			$Naruto_Sasuke/Personagem/Camera2D.limit_top = -1531.4
			$Naruto_Sasuke/Personagem/Camera2D.limit_right = 9216.7
			$Naruto_Sasuke/Personagem/Camera2D.limit_bottom = -978.9
		
		
		

