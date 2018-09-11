; #FUNCTION# ====================================================================================================================
; Name ..........: BB_DropTrophies
; Description ...: 
; Author ........: Chackall++
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Global $g_iLoopCount = 0

Func BB_DropTrophies()
	Local $iCheck = 0
	Local $iClickMachineX = 0
	Local $iClickMachineY = 0
	Local $i = 0
	Local $j = 0
	$g_iLoopCount = 0

	Local $cPixColor  = ''
	Local $Nside      = 1
	Local $SIDESNAMES = "TR|TL"

	Local $bDegug     = False
	Local $bContinue  = True

	Local $OkButtom[4]     = [ 400, 495 + $g_iBottomOffsetY, 0xE2F98B, 20 ]
	Local $OkBatleEnd[4]   = [ 630, 400 + $g_iBottomOffsetY, 0xE2FA8C, 20 ]
	Local $TroopSlot[4]    = [  40, 638 + $g_iBottomOffsetY, 0x404040, 20 ]
	Local $NextSlotActive[7] = [0x4C92D3, 0x5298E0, 0x4C92D3, 0x5598E0, 0x5498E0, 0x5198E0, 0x5094D8]
	Local $NextSlotOff[7]  = [0x464646, 0x454545, 0x454545, 0x464646, 0x454545, 0x5198E0, 0x5198E0]
	Local $NextSlotAdd     = 72
	Local $TroopsToDrop    = 0
	
	If _Sleep($DELAYRESPOND) Then Return
	If $g_iTxtBB_DropTrophies > 0 Then $g_aiCurrentLootBB[$eLootTrophyBB] = getTrophyMainScreen(67, 84)
	If _Sleep($DELAYRESPOND) Then Return

	If $g_bChkBB_DropTrophies Then
		; Click attack button and find a match
		If $g_iTxtBB_DropTrophies > 0 Then
			$i = $g_aiCurrentLootBB[$eLootTrophyBB] - $g_iTxtBB_DropTrophies
		Endif
		If $i > 0 Then 

			If BB_PrepareAttack() Then

				If _Sleep($DELAYCHECKOBSTACLES3 * 2) Then Return

				; Deploy All Troops From Slot's
				Setlog(" ====== BB Attack ====== ", $COLOR_INFO)
				For $i = 0 to 6
					If ($i > 0) Then 
						$TroopSlot[0] += $NextSlotAdd
						$TroopSlot[2] = $NextSlotOff[$i]
					EndIf
					$j = 0
					$cPixColor = _GetPixelColor($TroopSlot[0], $TroopSlot[1], True)
					
					$TroopsToDrop = getTroopCountBig( $TroopSlot[0]+24, $TroopSlot[1]-7 )
					If ($i > 0) Then 
						If _Sleep(120) Then Return 
						If Not _ColorCheck( $cPixColor, Hex($NextSlotOff[$i], 25), $TroopSlot[3]) Then
							ClickP($TroopSlot, 1, 0, "#0000")
							Local $x = $TroopSlot[0]
							Local $y = $TroopSlot[1]
							$bContinue = False
							For $b = 0 to 6
							$x += $NextSlotAdd
								If _ColorCheck(_GetPixelColor($x, $y), Hex($NextSlotActive[$b], 25), 25) Then 
								$bContinue = True
								EndIf
							Next
						EndIf					
					EndIf
					If $bContinue Then
						While Not _ColorCheck( $cPixColor, Hex($TroopSlot[2], 25), $TroopSlot[3])
							BB_Attack($Nside, $SIDESNAMES, 8)
							If $g_iLoopCount >= 8 Then ExitLoop
							If $bDegug Then SetLog("BB: Drop Troops - Slot[ " & String( $i + 1 ) & " ], code: 0x" & $cPixColor & " [ " & String( $j ) & " ] Num:[ " & $TroopsToDrop & " ]", $COLOR_DEBUG)
							If _Sleep(12) Then Return 
							$j += 1
							If $j > 6 Then ExitLoop
							$cPixColor = _GetPixelColor($TroopSlot[0], $TroopSlot[1], True)
						WEnd
						If $bDegug Then SetLog("BB: Last Slot Color [ " & String( $i + 1 ) & " ], code: 0x" & $cPixColor & " [ " & String( $i + 1 ) & " ]", $COLOR_DEBUG)
					EndIf
				Next
				While $bContinue = True
				If _Sleep(500) Then Return
				; Okay pixel
					If _Sleep(500) Then Return
					Local $iOkayColor[3][3] = [[0xBEE758, 0, 1], [0xA8DD49, 0, 1], [0x7BC726, 0, 1]]
					Local $iOkayPixel = _MultiPixelSearch(279, 378, 646, 685, 1, 1, Hex(0xBFE85A, 6), $iOkayColor, 35)
					
					If IsArray($iOkayPixel) Then
						Local $ClickOkX = $iOkayPixel[0], $ClickOkY = $iOkayPixel[1]
						Setlog("Exit battle", $COLOR_INFO)
						Click($ClickOkX, $ClickOkY)
						$bContinue = False
				; ---
						Else
						If _Sleep(500) Then Return
						Local $iOffColor[3][3] = [[0x4C49D5, 0, 1], [0x4C49D5, 0, 1], [0x4C49D5, 0, 1]]
						Local $iButtonPixel = _MultiPixelSearch(22, 658, 472, 726, 1, 1, Hex(0x4C49D5, 6), $iOffColor, 35)
						
						If IsArray($iButtonPixel) Then
							If $iCheck = 0 Then 
							Setlog("Boy on map", $COLOR_GREEN)
							$iClickMachineX = $iButtonPixel[0]
							$iClickMachineY = $iButtonPixel[1]
	
							ClickP($iButtonPixel, 100, 0, "#0000") ; Drop Troop
	
							If _Sleep($DELAYDROPTROOP1 / 5) Then Return
							AttackClick(557, 251, 1, SetSleep(0), 0, "#0000")
							$iCheck = 0
							ElseIf $iCheck = 1 Then
							AttackClick($iClickMachineX + 20, $iClickMachineY + 20, 1, SetSleep(0), 0, "#0000")
							EndIf
						EndIf
					EndIf
					
				WEnd

				If _Sleep($DELAYCHECKOBSTACLES4) Then Return 

				; wait $OkButtom to appear
				$j = 0
				$cPixColor = _GetPixelColor($OkButtom[0], $OkButtom[1], True)
				While Not _ColorCheck( $cPixColor, Hex($OkButtom[2], 20), $OkButtom[3])
					If $bDegug Then SetLog("BB: Click Okay Buttom. [Ok]. code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
					If _Sleep($DELAYCHECKOBSTACLES4) Then Return 
					$j += 1
					If $j > 10 Then ExitLoop
					$cPixColor = _GetPixelColor($OkButtom[0], $OkButtom[1], True)
				WEnd
				If $j < 10 Then
					SetLog("BB: Click Okay Buttom. [Ok]. code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
					ClickP($OkButtom, 1, 0, "#0000")
				Else
					SetLog("BB: Can't Find Okay Buttom [Ok]. code: 0x" & $cPixColor, $COLOR_ERROR)
				EndIf

				If _Sleep($DELAYCHECKOBSTACLES4) Then Return 

				; wait $OkBatleEnd to appear
				If $j < 10 Then
					$j = 0
					$cPixColor = _GetPixelColor($OkBatleEnd[0], $OkBatleEnd[1], True)
					While Not _ColorCheck( $cPixColor, Hex($OkBatleEnd[2], 20), $OkBatleEnd[3])
						If $bDegug Then SetLog("BB: Try Click Okay Buttom [end], code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
						If _Sleep($DELAYCHECKOBSTACLES3) Then Return
						$j += 1
						If $j > 30 Then ExitLoop
						$cPixColor = _GetPixelColor($OkBatleEnd[0], $OkBatleEnd[1], True)
					WEnd
					If $j < 30 Then
						SetLog("BB: Click Okay Buttom [end], code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
						ClickP($OkBatleEnd, 1, 0, "#0000")
					Else
						SetLog("BB: Can't Find Okay Buttom [End]. code: 0x" & $cPixColor, $COLOR_ERROR)
					EndIf
				Else

					If _Sleep($DELAYCHECKOBSTACLES4) Then Return
					ClickP($aAway, 1, 0, "#0000")

				EndIf

			EndIf

			If _Sleep($DELAYCHECKOBSTACLES4) Then Return
			ClickP($aAway, 1, 0, "#0000")

		Else
			Setlog("Ignore BB Drop Trophies: [Not Needed] [ " & String( $g_iTxtBB_DropTrophies ) & " ]", $COLOR_INFO)
		EndIf
	Else
		Setlog("Ignore BB Drop Trophies [ Disabled ]", $COLOR_INFO)
	Endif

EndFunc	;==> BB_DropTrophies

Func ChkBB_DropTrophies()
	$g_bChkBB_DropTrophies = (GUICtrlRead($g_hChkBB_DropTrophies) = $GUI_CHECKED) ? 1 : 0
EndFunc   ;==>ChkBB_DropTrophies

Func TxtBB_DropTrophies()
	$g_iTxtBB_DropTrophies = GUICtrlRead($g_hTxtBB_DropTrophies)
EndFunc   ;==>TxtBB_DropTrophies
