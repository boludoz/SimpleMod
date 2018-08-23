; #FUNCTION# ====================================================================================================================
; Name ..........: Check Hero Time Boost
; Description ...: Check Hero Time Boost
; Author ........: Ahsan Iqbal
; Modified ......: mmajid
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

	Local $bIsBoostedImg = @ScriptDir & "\imgxml\boost\BoostC\BoostCCheck"
	Local $bHeroTimeOCRImgs = @ScriptDir & "\imgxml\HeroTime"

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

		_Sleep($DELAYBOOSTHEROES5) ; Delay for 1300ms Atleast So OCR can take picture of the screen correctly otherwise it will fail

		If $index = 0 Or $index = 1 Then
			If $g_bDebugSetlog Then SetLog("In Index " & $index, $COLOR_INFO)

			If QuickMis("BC1", $bIsBoostedImg, 365, 640, 365 + 40, 640 + 38) Then ;When King OR Queen Has 4 Buttons Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 350, 675, 350 + 65, 675 + 18, True)
			ElseIf QuickMis("BC1", $bIsBoostedImg, 320, 640, 320 + 40, 640 + 38) Then ;When King OR Queen Has 5 Buttons(When Has Boost Spell) Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 300, 675, 300 + 70, 675 + 18, True)
			ElseIf QuickMis("BC1", $bIsBoostedImg, 415, 640, 415 + 40, 640 + 38) Then ;When King OR Queen Has 3 Buttons(When Hero Are Maxed) Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 395, 675, 395 + 70, 675 + 18, True)
			Else
				$sHeroTime[$index] = "none" ;Means King OR Queen is not boosted
			EndIf


		EndIf
		If $index = 2 Then
			If $g_bDebugSetlog Then SetLog("In Index " & $index, $COLOR_INFO)

			If QuickMis("BC1", $bIsBoostedImg, 320, 640, 320 + 40, 640 + 38) Then ;When Warden Has 5 Buttons Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 300, 675, 300 + 70, 675 + 18, True)
			ElseIf QuickMis("BC1", $bIsBoostedImg, 270, 640, 270 + 40, 640 + 38) Then ;When Warden Has 6 Buttons(When Has Boost Spell) Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 250, 675, 250 + 70, 675 + 18, True)
			ElseIf QuickMis("BC1", $bIsBoostedImg, 365, 640, 365 + 40, 640 + 38) Then ;When Warden Has 4 Buttons(Warden Is Maxed) Check if boosted then Do OCR
				$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 350, 675, 350 + 65, 675 + 18, True)
			Else
				$sHeroTime[$index] = "none" ;Means Warden is not boosted
			EndIf

		EndIf



		If $sHeroTime[$index] <> "none" Then
			If $g_bDebugSetlog Then setLog("inside ConvertOCRLongTime : " & $sHeroTime[$index], $COLOR_INFO)
			$CTime[$index] = _NowCalc()
			$CurrHeroBTime[$index] = ConvertOCRLongTime("Hero Time", $sHeroTime[$index], False)
			SetDebugLog("$sResult QuickMIS OCR: " & $sHeroTime[$index] & " (" & Round($CurrHeroBTime[$index], 2) & " minutes)")
		EndIf

		If $g_bDebugSetlog Then
			If $index = 0 Then SetLog("King Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)
			If $index = 1 Then SetLog("Queen Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)
			If $index = 2 Then SetLog("Warden Boost Time OCR = " & $sHeroTime[$index], $COLOR_INFO)
			SetLog("$CTime[" & $index & "] = " & $CTime[$index], $COLOR_INFO)
			SetLog("$CurrHeroBTime[" & $index & "] = " & $CurrHeroBTime[$index], $COLOR_INFO)
		EndIf

		If ProfileSwitchAccountEnabled() Then
			$HeroTime[$g_iCurAccount][$index] = $CurrHeroBTime[$index]
			SetLog("$HeroTime[" & $g_iCurAccount & "][" & $index & "] =  " & $HeroTime[$g_iCurAccount][$index], $COLOR_INFO)
		EndIf

		If $g_bDebugSetlog Then SetLog("-------------------------------------------", $COLOR_INFO)

	Next
	ClickP($aAway, 2, 0, "#0000") ;Click Away
EndFunc   ;==>CheckHeroBoost

Func HeroBoostTimeDiv($aResultHeroes, $i)
	Local $iheroTime = ($CurrHeroBTime[$i] - (_DateDiff("n", $CTime[$i], _NowCalc())))

	If $CurrHeroBTime[$i] <> "" Or $CurrHeroBTime[$i] <> 0 Then
		
		If $g_bDebugSetlog Then
			SetLog("$CurrHeroBTime = " & $CurrHeroBTime[$i], $COLOR_INFO)
			SetLog("$CTime[$i] = " & $CTime[$i], $COLOR_INFO)
			SetLog("Time Diff HeroTime = " & $iheroTime, $COLOR_INFO)
		EndIf

		If $iheroTime > 0 Then
			If ($aResultHeroes - ($iheroTime * 4)) < 0 Then
				If $g_bDebugSetlog Then SetLog("$aResultHeroes /= 4", $COLOR_INFO)
				$aResultHeroes /= 4
			ElseIf ($aResultHeroes - ($iheroTime * 4)) > 0 Then
				If $g_bDebugSetlog Then SetLog("$aResultHeroes = $aResultHeroes - ($iheroTime * 4)", $COLOR_INFO)
				$aResultHeroes = ($aResultHeroes - ($iheroTime * 4))+ ($aResultHeroes / 4)
			EndIf
		EndIf
		Return $aResultHeroes
	Else
		Return $aResultHeroes
	EndIf
EndFunc   ;==>HeroBoostTimeDiv


