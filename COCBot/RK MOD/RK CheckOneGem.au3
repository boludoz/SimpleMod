; #FUNCTION# ====================================================================================================================
; Name ..........: check one gem boost
; Description ...: check one gem boost
; Author ........: Ahsan Iqbal
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Local $initBarracksSpellBoostTime
Local $initHeroesBoostTime
Local $bGemOcr
Local $bBoostimage = @ScriptDir & "\imgxml\boost\BoostC\BoostCCheck"
Local $bBoostocr = @ScriptDir & "\imgxml\Boost\BoostOcr"
Local $sHeroName[3] = ["King", "Queen", "Warden"]

Func OneGemBoost()
	Local $isLogShown = False ;For making sure log is print one time

	If $g_bChkOneGemBoostHeroes Then
		Local $checkIfHeroesNeedToBoost = Round((_DateDiff("s", $initHeroesBoostTime, _NowCalc()) / 60), 2) ;Difference in min with seconds float for precise result
		SetDebugLog("OneGemBoost $g_bFirstStart = " & $g_bFirstStart & " $initHeroesBoostTime = " & $initHeroesBoostTime & " $checkIfHeroesNeedToBoost = " & $checkIfHeroesNeedToBoost, $COLOR_DEBUG)
		For $index = 0 To 2
			Local $i_heroBoostTimeDiff = Round((_DateDiff("s", $CTime[$g_iCurAccount][$index], _NowCalc()) / 60), 2) ; Difference in min with seconds float for precise result
			Local $i_heroTime = $CurrHeroBTime[$index] - $i_heroBoostTimeDiff
			SetDebugLog("$CurrHeroBTime[" & $index & "] = " & $CurrHeroBTime[$index] & " | $CTime[" & $g_iCurAccount & "][" & $index & "] = " & $CTime[$g_iCurAccount][$index], $COLOR_DEBUG)
			SetDebugLog("$i_heroBoostTimeDiff = " & $i_heroBoostTimeDiff & " | $i_heroTime [" & $sHeroName[$index] & "] = " & $i_heroTime, $COLOR_DEBUG)
			If $i_heroTime > 0 Then ;If We have herotime which don't need boost no need to check
				SetDebugLog($sHeroName[$index] & " already Boosted no need to boost", $COLOR_DEBUG)
			ElseIf $g_bFirstStart Or $initHeroesBoostTime = "" Or $checkIfHeroesNeedToBoost > 60 Or $i_heroTime <= 0 Then
				If Not $isLogShown Then
					SetLog("Checking 1-Gem Army Event", $COLOR_INFO)
					$isLogShown = True
				EndIf
				CheckHeroOneGem($index)
			EndIf
		Next
		$initBarracksSpellBoostTime = _NowCalc() ;Take time when all three hereos boosted
	EndIf

	If $g_bChkOneGemBoostBarracks Or $g_bChkOneGemBoostSpells Then
		Local $checkIfBarracksNeedToBoost = Round((_DateDiff("s", $initBarracksSpellBoostTime, _NowCalc()) / 60), 2) ; Difference in min with seconds float for precise result
		SetDebugLog("OneGemBoost $g_bFirstStart = " & $g_bFirstStart & " $initBarracksSpellBoostTime = " & $initBarracksSpellBoostTime & " $checkIfBarracksNeedToBoost = " & $checkIfBarracksNeedToBoost, $COLOR_DEBUG)
		If $g_bFirstStart Or $initBarracksSpellBoostTime = "" Or $checkIfBarracksNeedToBoost > 60 Then ;Check if initBoostTime is empty or greater then 1 hour.
			If Not $isLogShown Then
				SetLog("Checking 1-Gem Army Event", $COLOR_INFO)
				$isLogShown = True
			EndIf
			OpenArmyOverview(True, "OneGemBoost()")
			If $g_bChkOneGemBoostBarracks Then CheckTroopsOneGem()
			If $g_bChkOneGemBoostSpells Then CheckSpellsOneGem()
			ClickP($aAway, 1, 0, "#0161")
		EndIf
		;$initBarracksSpellBoostTime = _NowCalc() ;Don't update time here this can cause 1 hour delay if barracks or spell factory already boosted before startup of bot Time updated where barracks and spell perfectly boosted.
	EndIf
EndFunc   ;==>OneGemBoost


Func CheckOneGem()
	$bGemOcr = QuickMis("OCR", $bBoostocr, 370, 420, 370 + 130, 420 + 50)
	$bGemOcr = StringReplace($bGemOcr, " ", "")
	If $bGemOcr <> "none" Then
		If $bGemOcr = 1 Then
			Return True
		Else
			SetLog("One Gem Boost Not Found", $COLOR_ERROR)
		EndIf
	Else
		SetLog("$bGemOcr Not Found", $COLOR_ERROR)
	EndIf
	Return False
EndFunc   ;==>CheckOneGem

Func CheckHeroOneGem($index)
	; For $index = 0 To 2
	If $index = 0 Then
		If $g_aiKingAltarPos[0] = "" Or $g_aiKingAltarPos[0] = -1 Then
			SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
		EndIf
	ElseIf $index = 1 Then
		If $g_aiQueenAltarPos[0] = "" Or $g_aiQueenAltarPos[0] = -1 Then
			SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
		EndIf
	ElseIf $index = 2 Then
		If $g_aiWardenAltarPos[0] = "" Or $g_aiWardenAltarPos[0] = -1 Then
			SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
		EndIf
	EndIf

	If $index = 0 Then BuildingClickP($g_aiKingAltarPos, "#0462")
	If $index = 1 Then BuildingClickP($g_aiQueenAltarPos, "#0462")
	If $index = 2 Then BuildingClickP($g_aiWardenAltarPos, "#0462")

	_Sleep($DELAYBOOSTHEROES1)

	Local $Boost = findButton("BoostOne")
	If IsArray($Boost) Then
		If $g_bDebugSetlog Then SetDebugLog("Boost Button X|Y = " & $Boost[0] & "|" & $Boost[1], $COLOR_DEBUG)
		Click($Boost[0], $Boost[1], 1, 0, "#0463")
		If _Sleep($DELAYBOOSTHEROES1) Then Return
		$Boost = findButton("GEM")
		If IsArray($Boost) Then
			If Not CheckOneGem() Then
				ClickP($aAway, 1, 0, "#0161")
				Return ; ContinueLoop
			EndIf
			Click($Boost[0], $Boost[1], 1, 0, "#0464")
			If _Sleep($DELAYBOOSTHEROES4) Then Return
			If IsArray(findButton("EnterShop")) Then
				SetLog("Not enough gems to boost " & $sHeroName[$index], $COLOR_ERROR)
			EndIf
		Else
			SetLog($sHeroName[$index] & " is already Boosted", $COLOR_SUCCESS)
		EndIf
	EndIf
	; Next
	ClickP($aAway, 1, 0, "#0161")
EndFunc   ;==>CheckHeroOneGem

Func CheckTroopsOneGem()
	OpenTroopsTab(True, "CheckTroopsOneGem()")

	If IsArray(findButton("BarrackBoosted")) Then
		SetLog("Barracks already boosted", $COLOR_SUCCESS)
		Return
	EndIf
	Local $aBoostBtn = findButton("BoostBarrack")
	If IsArray($aBoostBtn) Then
		ClickP($aBoostBtn)
		_Sleep($DELAYBOOSTBARRACKS1)
		Local $aGemWindowBtn = findButton("GEM")
		If IsArray($aGemWindowBtn) Then
			If Not CheckOneGem() Then
				ClickP($aAway, 1, 0, "#0161")
				Return
			EndIf
			ClickP($aGemWindowBtn)
			_Sleep($DELAYBOOSTBARRACKS2)
			If IsArray(findButton("EnterShop")) Then
				SetLog("Not enough gems to boost ", $COLOR_ERROR)
			EndIf
			$initBarracksSpellBoostTime = _NowCalc() ;Update time only when barrack was manually boosted
		EndIf
	EndIf

EndFunc   ;==>CheckTroopsOneGem

Func CheckSpellsOneGem()
	OpenSpellsTab(True, "CheckSpellsOneGem()")

	If IsArray(findButton("BarrackBoosted")) Then
		SetLog("Spells already boosted", $COLOR_SUCCESS)
		Return
	EndIf

	Local $aBoostBtn = findButton("BoostBarrack")
	If IsArray($aBoostBtn) Then
		ClickP($aBoostBtn)
		_Sleep($DELAYBOOSTBARRACKS1)
		If Not CheckOneGem() Then
			ClickP($aAway, 1, 0, "#0161")
			Return
		EndIf
		Local $aGemWindowBtn = findButton("GEM")
		If IsArray($aGemWindowBtn) Then
			ClickP($aGemWindowBtn)
			_Sleep($DELAYBOOSTBARRACKS2)
			If IsArray(findButton("EnterShop")) Then
				SetLog("Not enough gems to boost ", $COLOR_ERROR)
			EndIf
			$initBarracksSpellBoostTime = _NowCalc() ;Update time only when spells was manually boosted
		EndIf
	EndIf
	_Sleep(500)
EndFunc   ;==>CheckSpellsOneGem

