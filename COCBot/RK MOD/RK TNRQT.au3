; #FUNCTION# ====================================================================================================================
; Name ..........: TNRQT
; Description ...: Train and Remove Queue Troops
; Author ........: Ahsan Iqbal
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Local $Troopsdetect
Local $Spelldetect

Func TNRQT()
	OpenTroopsTab(True, "TNRQT()")
	Local $TroopCamp = GetCurrentArmy(48, 160)
	$Troopsdetect = CheckQueueTroops()
	OpenSpellsTab(True, "TNRQT()")
	$Spelldetect = CheckQueueSpells()
	Local $TroopsToTrain = WhatToTrainQueue(False, False)
	Local $TroopsToRemove = WhatToTrainQueue(True, False)

	If $Troopsdetect = "" Then SetDebugLog("Troops are empty", $COLOR_DEBUG)
	
	If $g_bDebugSetlog Then

		If $TroopsToTrain[0][0] = "Arch" And $TroopsToTrain[0][1] = 0 Then
			SetDebugLog("None Troops Left To Train", $COLOR_DEBUG)
		Else
			SetDebugLog("Troops Left To Train : ", $COLOR_INFO)
			For $i = 0 To UBound($Troopsdetect) - 1
				SetDebugLog("  - " & $TroopsToTrain[$i][0] & ": " & $TroopsToTrain[$i][1] & "x", $COLOR_SUCCESS)
			Next
		EndIf

		If $TroopsToRemove[0][0] = "Arch" And $TroopsToRemove[0][1] = 0 Then
			SetDebugLog("None Troops Left To Remove", $COLOR_DEBUG)
		Else
			SetDebugLog("Troops Left To Remove : ", $COLOR_INFO)
			For $i = 0 To UBound($Troopsdetect) - 1
				SetDebugLog("  - " & $TroopsToRemove[$i][0] & ": " & $TroopsToRemove[$i][1] & "x", $COLOR_SUCCESS)
			Next
		EndIf

	EndIf
	
EndFunc   ;==>TNRQT

Func WhatToTrainQueue($ReturnExtraTroopsOnly = False, $bSetLog = True)
	;OpenArmyTab(True, "WhatToTrain()"); was False EDITED By RK MOD
	Local $ToReturn[1][2] = [["Arch", 0]]

	If $g_bIsFullArmywithHeroesAndSpells And Not $ReturnExtraTroopsOnly Then
		If $g_iCommandStop = 3 Or $g_iCommandStop = 0 Then
			If $g_bFirstStart Then $g_bFirstStart = False
			Return $ToReturn
		EndIf
		SetLog(" - Your Army is Full, let's Make Troops", $COLOR_INFO)
		; Elixir Troops
		For $i = 0 To $eTroopCount - 1
			Local $troopIndex = $g_aiTrainOrder[$i]
			If $g_aiArmyCompTroops[$troopIndex] > 0 Then
				$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
				$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompTroops[$troopIndex]
				ReDim $ToReturn[UBound($ToReturn) + 1][2]
			EndIf
		Next

		; Spells
		For $i = 0 To $eSpellCount - 1
			Local $BrewIndex = $g_aiBrewOrder[$i]
			If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
			If $g_aiArmyCompSpells[$BrewIndex] > 0 Then
				If HowManyTimesWillBeUsed($g_asSpellShortNames[$BrewIndex]) > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				Else
					getArmySpells(False, False, False, False)
					If $g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex] > 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex]
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					Else
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = 9999
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			EndIf
		Next
		Return $ToReturn
	EndIf

	; Get Current available troops
	;getArmyTroops(False, False, False, False)
	;getArmySpells(False, False, False, False)

	Switch $ReturnExtraTroopsOnly
		Case False
			; Check Elixir Troops Extra Quantity To Train
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				If $Troopsdetect[$troopIndex] > 0 Then
					If $g_aiArmyCompTroops[$troopIndex] - $Troopsdetect[$troopIndex] > 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompTroops[$troopIndex] - $Troopsdetect[$troopIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next

			; Check Spells Extra Quantity To Train
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $Spelldetect[$BrewIndex] > 0 Then
					If $g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex] > 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next
		Case Else
			; Check Elixir Troops Extra Quantity To Remove
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				If $Troopsdetect[$troopIndex] > 0 Then
					If $g_aiArmyCompTroops[$troopIndex] - $Troopsdetect[$troopIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompTroops[$troopIndex] - $Troopsdetect[$troopIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next

			; Check Spells Extra Quantity To Remove
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $Spelldetect[$BrewIndex] > 0 Then
					If $g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompSpells[$BrewIndex] - $Spelldetect[$BrewIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next
	EndSwitch
	;DeleteInvalidTroopInArray($ToReturn)
	Return $ToReturn
EndFunc   ;==>WhatToTrainQueue
