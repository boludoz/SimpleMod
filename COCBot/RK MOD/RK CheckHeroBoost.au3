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
Local $sHeroTime[3] = ["", "", ""]

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
			SetLog("In Index " & $index, $COLOR_INFO)
			$sHeroTime[$index] = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 297, 675, 297 + 77, 675 + 18, True)
			If $sHeroTime[$index] = "none" Then
				SetLog("In Index ("&$index&") After First OCR Failed", $COLOR_ERROR)
				$sHeroTime[$index] = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 344, 675, 344 + 78, 675 + 18, True)
			EndIf
		EndIf
		If $index = 2 Then
			SetLog("In Index " & $index, $COLOR_INFO)
			$sHeroTime[$index] = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 250, 675, 250 + 77, 675 + 18, True)
			If $sHeroTime[$index] = "none" Then
				SetLog("In Index ("&$index&") After First OCR Failed", $COLOR_ERROR)
				$sHeroTime[$index] = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 297, 675, 297 + 78, 675 + 18, True)
			EndIf
		EndIf



		If $sHeroTime[$index] <> "none" Then
			setLog("inside ConvertOCRLongTime : "&$sHeroTime[$index], $COLOR_INFO)
			$CTime[$index] = _NowCalc()
			$CurrHeroBTime[$index] = ConvertOCRLongTime("Hero Time", $sHeroTime[$index], False)
			SetDebugLog("$sResult QuickMIS OCR: " & $sHeroTime[$index] & " (" & Round($CurrHeroBTime[$index], 2) & " minutes)")
		EndIf

		If $index = 0 Then SetLog("King Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)
		If $index = 1 Then SetLog("Queen Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)
		If $index = 2 Then SetLog("Warden Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)

		SetLog("$CTime["&$index&"] = " & $CTime[$index], $COLOR_INFO)
		SetLog("$CurrHeroBTime["&$index&"] = " & $CurrHeroBTime[$index], $COLOR_INFO)

		If ProfileSwitchAccountEnabled() Then
			$HeroTime[$g_iCurAccount][$index] = $CurrHeroBTime[$index]
			SetLog("$HeroTime["&$g_iCurAccount&"]["&$index&"] =  " & $HeroTime[$g_iCurAccount][$index], $COLOR_INFO)
		EndIf

		SetLog("-------------------------------------------", $COLOR_INFO)
		_Sleep($DELAYBOOSTHEROES1)
	Next
	ClickP($aAway, 2, 0, "#0000") ;Click Away
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


