; #FUNCTION# ====================================================================================================================
; Name ..........: Check Hero Time Boost
; Description ...: Check Hero Time Boost
; Author ........: Ahsan Iqbal
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Local $HeroTime[8][3] = [["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""]]
Local $CurrHeroBTime[3] = ["", "", ""]
Local $CTime[3] = ["", "", ""]

Func CheckHeroBoost()
	SetLog("Checking Hero Boost Time", $COLOR_INFO)

	checkMainScreen()
	For $index = 0 To 2
		If ProfileSwitchAccountEnabled() Then
			$CurrHeroBTime[$index] = $HeroTime[$g_iCurAccount][$index]
		EndIf

		If $index = 0 Then
			If $g_aiKingAltarPos[0] = "" Or $g_aiKingAltarPos[0] = -1 Then
				LocateKingAltar()
				SaveConfig()
				If _Sleep($DELAYBOOSTHEROES4) Then Return
			EndIf
		ElseIf $index = 1 Then
			If $g_aiQueenAltarPos[0] = "" Or $g_aiQueenAltarPos[0] = -1 Then
				LocateQueenAltar()
				SaveConfig()
				If _Sleep($DELAYBOOSTHEROES4) Then Return
			EndIf
		ElseIf $index = 2 Then
			If $g_aiWardenAltarPos[0] = "" Or $g_aiWardenAltarPos[0] = -1 Then
				LocateWardenAltar()
				SaveConfig()
				If _Sleep($DELAYBOOSTHEROES4) Then Return
			EndIf
		EndIf

		If _DateIsValid($CurrHeroBTime[$index]) Then

		EndIf
		
		If $index = 0 Then BuildingClickP($g_aiKingAltarPos, "#0462")
		If $index = 1 Then BuildingClickP($g_aiQueenAltarPos, "#0462")
		If $index = 2 Then BuildingClickP($g_aiWardenAltarPos, "#0462")

		If $index = 0 Or $index = 1 Then
			SetLog("In Index == 0 and 1", $COLOR_INFO)
			Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 297, 675, 297 + 77, 675 + 18, True)
			If $sHeroTime = "none" Then
				Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 344, 674, 344 + 78, 674 + 20, True)
			EndIf
		EndIf
		If $index = 2 Then
			Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 250, 675, 250 + 77, 675 + 18, True)
			If $sHeroTime = "none" Then
				Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 297, 674, 297 + 78, 674 + 20, True)
			EndIf
		EndIf


		SetLog("sHeroTime = " & $sHeroTime, $COLOR_INFO)

		If $sHeroTime <> "none" Then
			$CTime[$index] = _NowCalc()
			$CurrHeroBTime[$index] = ConvertOCRLongTime("Hero Time", $sHeroTime, False)
			SetDebugLog("$sResult QuickMIS OCR: " & $sHeroTime & " (" & Round($CurrHeroBTime[$index], 2) & " minutes)")
		Else
			Sleep(1000)
		EndIf

		If ProfileSwitchAccountEnabled() Then
			$HeroTime[$g_iCurAccount][$index] = $CurrHeroBTime[$index]
		EndIf
	Next

EndFunc   ;==>CheckHeroBoost

Func HeroBoostTime($aResultHeroes, $i)
	SetLog("$CurrHeroBTime = " & $CurrHeroBTime[$i], $COLOR_INFO)
	SetLog("Time Diff HeroTime = " & (_DateDiff("n", $CTime[$i], _NowCalc())), $COLOR_INFO)
	If $CurrHeroBTime[$i] <> "" Or $CurrHeroBTime[$i] <> 0 Then
		If $CurrHeroBTime[$i] - (_DateDiff("n", $CTime[$i], _NowCalc())) > 0 Then
			$aResultHeroes /= 4
		EndIf
		Return $aResultHeroes
	Else
		Return $aResultHeroes
	EndIf
EndFunc   ;==>HeroBoostTime

