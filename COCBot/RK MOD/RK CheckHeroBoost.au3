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
Local $CurrHeroTime[3] = ["", "", ""]
Local $Position[3] = [$g_aiKingAltarPos, $g_aiQueenAltarPos, $g_aiWardenAltarPos]
Local $CTime[3] = ["", "", ""]

Func CheckHeroBoost()
	SetLog("Checking Hero Boost Time", $COLOR_INFO)

	If IsMainPage() Then
		For $index = 0 To 2
			If ProfileSwitchAccountEnabled() Then
				$CurrHeroTime[$index] = $HeroTime[$g_iCurAccount][$index]
			EndIf

			SetLog("Position[0] = " & ($Position[$index])[0], $COLOR_INFO)
			SetLog("g_aiKingAltarPos[0] = " & $g_aiKingAltarPos[0], $COLOR_INFO)
			SetLog("g_aiQueenAltarPos[0] = " & $g_aiQueenAltarPos[0], $COLOR_INFO)
			SetLog("g_aiWardenAltarPos[0] = " & $g_aiWardenAltarPos[0], $COLOR_INFO)

			If ($Position[$index])[0] = "" Or ($Position[$index])[0] = -1 Then
				If $index == 0 Then LocateKingAltar()
				If $index == 1 Then LocateQueenAltar()
				If $index == 2 Then LocateWardenAltar()
				SaveConfig()
				If _Sleep($DELAYBOOSTHEROES4) Then Return
			EndIf

			If _DateIsValid($CurrHeroTime[$index]) Then

			EndIf
			
			;_ArrayDisplay(($Position[$index]))
			BuildingClickP(($Position[$index]), "#0462")

			If $index = 0 Or $index = 1 Then
				SetLog("In Index == 0 and 1", $COLOR_INFO)
				Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 297, 675, 297 + 77, 675 + 18, True)
			EndIf
			If $index = 2 Then Local $sHeroTime = QuickMIS("OCR", @ScriptDir & "\imgxml\HeroTime", 250, 675, 250 + 77, 675 + 18, True)

			SetLog("sHeroTime = " & $sHeroTime, $COLOR_INFO)

			If $sHeroTime <> "none" Then
				$CTime[$index] = _NowCalc()
				$CurrHeroTime[$index] = ConvertOCRLongTime("Hero Time", $sHeroTime, False)
				SetDebugLog("$sResult QuickMIS OCR: " & $sHeroTime & " (" & Round($CurrHeroTime[$index], 2) & " minutes)")
			EndIf

			If ProfileSwitchAccountEnabled() Then
				$HeroTime[$g_iCurAccount][$index] = $CurrHeroTime[$index]
			EndIf
			Sleep(1000)
		Next
	EndIf

EndFunc   ;==>CheckHeroBoost

Func HeroBoostTime($aResultHeroes, $i)
	Local $Time
	SetLog("$CurrHeroTime = " & $CurrHeroTime[$i], $COLOR_INFO)
	If $CurrHeroTime[$i] <> "" Or $CurrHeroTime[$i] <> 0 Then
		If $CurrHeroTime[$i]-(_DateDiff("n", $CTime[$i], _NowCalc())) > 0 Then
			$Time /= 4
		EndIf
		Return $Time
	Else
		Return $Time
	EndIf
EndFunc   ;==>HeroBoostTime
