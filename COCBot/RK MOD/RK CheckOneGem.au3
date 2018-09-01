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
Local $initBoostTime
Local $bGemOcr
Local $bBoostimage = @ScriptDir & "\imgxml\boost\BoostC\BoostCCheck"
Local $bBoostocr = @ScriptDir & "\imgxml\Boost\BoostOcr"

Func OneGemBoost()
	Local $checkIfBoostNeededToBeChecked = _DateDiff("n", $initBoostTime, _NowCalc()) ;n = Difference in minutes between the given dates
	SetDebugLog("OneGemBoost $g_bFirstStart = " & $g_bFirstStart & " $initBoostTime = " & $initBoostTime & " $checkIfBoostNeededToBeChecked = " & $checkIfBoostNeededToBeChecked, $COLOR_DEBUG)
	Local $FoundRes = 0

	For $index = 0 To 2
		Local $i_heroTime = ($CurrHeroBTime[$index] - (_DateDiff("n", $CTime[$g_iCurAccount][$index], _NowCalc())))
		If $g_bFirstStart Or $initBoostTime = "" Or $checkIfBoostNeededToBeChecked > 60 Or $i_heroTime < 0 Then ;Check if initBoostTime is empty or greater then 1 hour.
			If $g_bChkOneGemBoostHeroes Or $g_bChkOneGemBoostBarracks Or $g_bChkOneGemBoostSpells Then
				If $index = 0 Then SetLog("Checking 1-Gem Army Event", $COLOR_INFO)
				If $g_bChkOneGemBoostHeroes Then CheckHeroOneGem($index)
				If $index = 2 And $FoundRes = 0 And ($g_bChkOneGemBoostBarracks Or $g_bChkOneGemBoostSpells) Then
					OpenArmyOverview(True, "OneGemBoost()")
					If $g_bChkOneGemBoostBarracks Then CheckTroopsOneGem()
					If $g_bChkOneGemBoostSpells Then CheckSpellsOneGem()
					ClickP($aAway, 1, 0, "#0161")
					$FoundRes += 1
				EndIf
			EndIf
			$initBoostTime = _NowCalc()
		EndIf
	Next
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
	Local $sHeroName[3] = ["King", "Queen", "Warden"]
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
				Return; ContinueLoop
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
		EndIf
	EndIf

EndFunc   ;==>CheckTroopsOneGem

Func CheckSpellsOneGem()
	OpenSpellsTab(True, "CheckSpellsOneGem()")
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
		EndIf
	EndIf
	_Sleep(500)
EndFunc   ;==>CheckSpellsOneGem
