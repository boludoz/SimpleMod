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

Func TruePixel($ix1 = 0, $iy1 = 0, $ix2 = 0, $iy2 = 0, $iHexColor = 0, $iCTolerance = 20) ; returns true if the last chat was not by you, false otherwise
   Local $sReturn[3] = [0, 0, 0]

   _CaptureRegion()
	For $y = $iy1 To $iy2
		For $x = $ix1 To $ix2
			If _ColorCheck(_GetPixelColor($x, $y), Hex($iHexColor, $iCTolerance), $iCTolerance) Then
				$sReturn[0] = True
				$sReturn[1] = $x
				$sReturn[2]	= $y
			Return $sReturn
			Endif
		Next
	Next  
	$sReturn[0] = False
	$sReturn[1] = 0
	$sReturn[2]	= 0
   Return $sReturn
EndFunc

Func BB_DropTrophies()
	Local $iBoy = 0
	Local $i = 0
	Local $j = 0

	Local $cPixColor  = ''
	Local $Nside      = 1
	Local $SIDESNAMES = "TR|TL"

	Local $bDegug     = False
	Local $bContinue  = True

	Local $OkButtom[4]     = [ 400, 495 + $g_iBottomOffsetY, 0xE2F98B, 20 ]
	Local $OkBatleEnd[4]   = [ 630, 400 + $g_iBottomOffsetY, 0xE2FA8C, 20 ]
	Local $OkWaitBattle[4] = [ 400, 500 + $g_iBottomOffsetY, 0xF0F0F0, 20 ]
	Local $TroopSlot[4]    = [  40, 638 + $g_iBottomOffsetY, 0x404040, 20 ]
	Local $NextSlotActive[6] = [0x5094D8, 0x5094D8, 0x5094D8, 0x5094D8, 0x5094D8, 0x5094D8]
	Local $NextSlotOff[6]  = [0x464646, 0x454545, 0x454545, 0x464646, 0x454545, 0x5198E0]
	Local $NextSlotAdd     = 72
	Local $TroopsToDrop    = 0
	Local $iKing = 0x251CC6
	If _Sleep($DELAYRESPOND) Then Return
	If $g_iTxtBB_DropTrophies > 0 Then $g_aiCurrentLootBB[$eLootTrophyBB] = getTrophyMainScreen(67, 84)
	If _Sleep($DELAYRESPOND) Then Return

	If $g_bChkBB_DropTrophies Then
		; Click attack button and find a match
		If $g_iTxtBB_DropTrophies > 0 Then
			$i = $g_aiCurrentLootBB[$eLootTrophyBB] - $g_iTxtBB_DropTrophies
		Endif
		If $i > 0 Then 

			If _Sleep($DELAYCHECKOBSTACLES1) Then Return

			If BB_PrepareAttack() Then

				If _Sleep($DELAYCHECKOBSTACLES3 * 2) Then Return

				; Deploy All Troops From Slot's
				Setlog(" ====== BB Attack ====== ", $COLOR_INFO)
				For $i = 0 to 5
					If ($i > 0) Then 
						$TroopSlot[0] += $NextSlotAdd
						$TroopSlot[2] = $NextSlotOff[$i]
					EndIf
					$j = 0
					$cPixColor = _GetPixelColor($TroopSlot[0], $TroopSlot[1], True)
					
					$TroopsToDrop = getTroopCountBig( $TroopSlot[0]+24, $TroopSlot[1]-7 )
					If ($i > 0) Then 
						If _Sleep(120) Then Return 
						If Not _ColorCheck( $cPixColor, Hex($NextSlotOff[$i], 20), $TroopSlot[3]) Then
							ClickP($TroopSlot, 1, 0, "#0000")
							Local $x = $TroopSlot[0]
							Local $y = $TroopSlot[1]
							$bContinue = False
							For $b = 0 to 5
							$x += $NextSlotAdd
								If _ColorCheck(_GetPixelColor($x, $y), Hex($NextSlotActive[$b], 20), 20) Then 
								$bContinue = True
								EndIf
							Next
						EndIf					
					EndIf
					If $bContinue Then
						While Not _ColorCheck( $cPixColor, Hex($TroopSlot[2], 20), $TroopSlot[3])
							If $iBoy = 0 Then
							If _Sleep($DELAYRESPOND*3) Then Return
						If QuickMIS("BC1", $g_sImgMachine, 0, 652, 835, 724, True, False) Then
								KeepClicks()
								Local $aBoyDropPoint[2] = [0, 0]
										$aBoyDropPoint[0] = $g_iQuickMISX
										$aBoyDropPoint[1] = (652 + $g_iQuickMISY)
									Setlog("Drop boy on map", $COLOR_GREEN)
									ClickP($aBoyDropPoint, 1, 0, "#0000") ; Drop Troop
									If _Sleep($DELAYDROPTROOP1 / 5) Then Return
									AttackClick(557, 251, 1, SetSleep(0), 0, "#0000")
									If _Sleep($DELAYDROPTROOP2 / 5) Then Return
								$iBoy = 1
								EndIf
									ReleaseClicks()

							EndIf
							BB_Attack($Nside, $SIDESNAMES, 8)
							
							If $bDegug Then SetLog("BB: Drop Troops - Slot[ " & String( $i + 1 ) & " ], code: 0x" & $cPixColor & " [ " & String( $j ) & " ] Num:[ " & $TroopsToDrop & " ]", $COLOR_DEBUG)
							If _Sleep(12) Then Return 
							$j += 1
							If $j > 5 Then ExitLoop
							$cPixColor = _GetPixelColor($TroopSlot[0], $TroopSlot[1], True)
						WEnd
						If $bDegug Then SetLog("BB: Last Slot Color [ " & String( $i + 1 ) & " ], code: 0x" & $cPixColor & " [ " & String( $i + 1 ) & " ]", $COLOR_DEBUG)
					EndIf
				Next
					
				Setlog("Will Wait End Battle for " & String( $DELAYCHECKOBSTACLES4 / 60000 / 2 ) & " minutes then continue", $COLOR_INFO)
				If _Sleep($DELAYCHECKOBSTACLES4 / 2 ) Then Return

				; If $OkWaitBattle Exists
				$cPixColor = _GetPixelColor($OkWaitBattle[0], $OkWaitBattle[1], True)
				If _ColorCheck( $cPixColor, Hex($OkWaitBattle[2], 20), $OkWaitBattle[3]) Then
					If $bDegug Then SetLog("BB: Click Okay Buttom for no wait battle end, code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
					ClickP($OkWaitBattle, 1, 0, "#0000")
				EndIf

				If _Sleep(12) Then Return 

				; wait $OkButtom to appear
				$j = 0
				$cPixColor = _GetPixelColor($OkButtom[0], $OkButtom[1], True)
				While Not _ColorCheck( $cPixColor, Hex($OkButtom[2], 20), $OkButtom[3])
					If $bDegug Then SetLog("BB: Click Okay Buttom. [Ok]. code: 0x" & $cPixColor & " [ " & String( $j ) & " ]", $COLOR_DEBUG)
					If _Sleep(12) Then Return 
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

				If _Sleep(12) Then Return 

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

					If _Sleep(12) Then Return
					ClickP($aAway, 1, 0, "#0000")

				EndIf

			EndIf

			If _Sleep(12) Then Return
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
