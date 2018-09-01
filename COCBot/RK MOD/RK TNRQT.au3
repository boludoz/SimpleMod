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

Func TNRQT()
	Local $TroopCamp = GetCurrentArmy(48, 160)
	OpenTroopsTab(True, "TNRQT()")
	Local $Troopsdetect = CheckQueueTroops()
	OpenSpellsTab(True, "TNRQT()")
	Local $Spelldetect = CheckQueueSpells()
	Local $iWhatToTrain = WhatToTrainQueue(True, False)
	_ArrayDisplay($iWhatToTrain)
	SetDebugLog("$eTroopCount = " & $eTroopCount, $COLOR_INFO)
	;SetDebugLog("$g_asTroopShortNames = " & $g_asTroopShortNames[$troopIndex], $COLOR_INFO)
	;SetDebugLog("$g_aiArmyCompTroops = " & $g_aiArmyCompTroops[$troopIndex], $COLOR_INFO)

	If $Troopsdetect = "" Then SetDebugLog("Troops are empty", $COLOR_INFO)
	If $iWhatToTrain[0][0] = "Arch" And $iWhatToTrain[0][1] = 0 Then SetDebugLog("None left troops", $COLOR_INFO)
EndFunc   ;==>TNRQT

Func WhatToTrainQueue($ReturnExtraTroopsOnly = False, $bSetLog = True)
	;OpenArmyTab(True, "WhatToTrain()"); was False EDITED By RK MOD
	Local $ToReturn[1][2] = [["Arch", 0]]

	If $g_bIsFullArmywithHeroesAndSpells And Not $ReturnExtraTroopsOnly Then
		If $g_iCommandStop = 3 Or $g_iCommandStop = 0 Then
			If $g_bFirstStart Then $g_bFirstStart = False
			Return $ToReturn
		EndIf
		SetLog(" - Your Army is Full, let's add or remove troops", $COLOR_INFO)
		; Elixir Troops
		For $i = 0 To $eTroopCount - 1
			Local $troopIndex = $g_aiTrainOrder[$i]
			SetDebugLog("$g_aiArmyCompTroops[$troopIndex] = " & $g_aiArmyCompTroops[$troopIndex], $COLOR_INFO)
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
					If $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex] > 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex]
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
			; Check Elixir Troops needed quantity to Train
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				SetDebugLog("$g_aiArmyCompTroops[$troopIndex] = " & $g_aiArmyCompTroops[$troopIndex], $COLOR_INFO)
				If $g_aiArmyCompTroops[$troopIndex] > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				EndIf
			Next

			; Check Spells needed quantity to Brew
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiArmyCompSpells[$BrewIndex] > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				EndIf
			Next
		Case Else
			; Check Elixir Troops Extra Quantity
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				SetDebugLog("$g_aiCurrentTroops[$troopIndex] = " & $g_aiCurrentTroops[$troopIndex], $COLOR_INFO)
				If $g_aiCurrentTroops[$troopIndex] > 0 Then
					If $g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next

			; Check Spells Extra Quantity
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiCurrentSpells[$BrewIndex] > 0 Then
					If $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next
	EndSwitch
	;DeleteInvalidTroopInArray($ToReturn)
	Return $ToReturn
EndFunc   ;==>WhatToTrainQueue
