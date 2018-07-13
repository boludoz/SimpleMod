; #FUNCTION# ====================================================================================================================
; Name ..........: BoostAllWithMagicSpell
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .: None
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BoostAllWithMagicSpell()
	Local $bBoosted = False
	Local $asHero[3] = ["king", "queen", "warden"]
	Local $aHeroPos[3][2] = [[$g_aiKingAltarPos[0], $g_aiKingAltarPos[1]], [$g_aiQueenAltarPos[0], $g_aiQueenAltarPos[1]], [$g_aiWardenAltarPos[0], $g_aiWardenAltarPos[1]]]

	; Verifying existent Variables to run this routine
	If Not $g_iChkBoostBMagic Then Return
	If AllowBoosting("All using magic spell", $g_iCmbBoostBrMagic) = False Then Return

	SetLog("Boost all with magic spell...")

	Static $iAvailableHero = -1 ; -1 = No hero available, 0|1|2 = King|Queen|Warden
	Static $iHeroWithBadLocation = -1

	If OpenArmyOverview(True, "BoostWithMagicSpell()") Then
		; check hero status
		If $iAvailableHero >= 0 And $aHeroPos[$iAvailableHero][0] <> "" And $aHeroPos[$iAvailableHero][0] <> -1 Then
			; Already have data
		Else
			$iAvailableHero = -1
			For $i = $eKing To $eWarden
				If $i = $iHeroWithBadLocation Then ContinueLoop
				If $aHeroPos[$i][0] = "" Or $aHeroPos[$i][0] = -1 Then ContinueLoop ; hero not yet located, skip to check another hero.
				Local $sResult = ArmyHeroStatus($i)
				If StringInStr($sResult, $asHero[$i], $STR_NOCASESENSEBASIC) Or StringInStr($sResult, "heal", $STR_NOCASESENSEBASIC) Then
					$iAvailableHero = $i
					ExitLoop ; found 1 hero available, quit checking the rest.
				EndIf
			Next
		EndIf

		; check boost status
		If OpenTroopsTab(True, "BoostWithMagicSpell()") Then
			If _ColorCheck(_GetPixelColor(825, 320, True), Hex(0xA0A09B, 6), 30) Then
				SetLog("Already boosted!")
				$bBoosted = True
			EndIf
		EndIf
		ClickP($aAway, 1, 0, "#0000") ;Click Away
		If _Sleep($DELAYCHECKARMYCAMP4) Then Return
		If $bBoosted Then Return
	EndIf

	; boosting with Hero Location
	If $iAvailableHero >= 0 Then
		; click hero
		Local $aPos[2] = [$aHeroPos[$iAvailableHero][0], $aHeroPos[$iAvailableHero][1]]
		BuildingClickP($aPos)
		If _Sleep($DELAYBOOSTHEROES2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], $g_asHeroShortNames[$iAvailableHero], $STR_NOCASESENSEBASIC) > 0 Then
				SetDebugLog("Boost all using " & $g_asHeroShortNames[$iAvailableHero] & " located at " & $aPos[0] & ", " & $aPos[1])
				If $iHeroWithBadLocation = $iAvailableHero Then $iHeroWithBadLocation = -1
			Else
				SetDebugLog("This location (" & $aPos[0] & ", " & $aPos[1] & ") is " & $aResult[1] & ", not " & $g_asHeroShortNames[$iAvailableHero] & " as expected")
				$iHeroWithBadLocation = $iAvailableHero
				$iAvailableHero = -1 ; reset due to bad location
			EndIf
		EndIf

		; boost
		If $iAvailableHero >= 0 Then ; check again, just in case $iAvailableHero is reset due to bad location
			Local $offColor[2][3] = [[0x34D17A, 10, 0], [0xF6DD7E, 45, 0]]
			Local $SpellPos = _MultiPixelSearch(403, 655, 460, 655, 1, 1, 0x38C1FF, $offColor, 30)
			If IsArray($SpellPos) And UBound($SpellPos) = 2 Then ; click BoostAll
				ClickP($SpellPos)
				If _Sleep($DELAYBOOSTHEROES2) Then Return
				If _ColorCheck(_GetPixelColor(400, 440, True), Hex(0x7D8BFF, 6), 30) Then ; click violet OK button
					Click(400, 440)
					$bBoosted = True ; done!
				Else
					SetLog("Cannot find 'Training Potion' button")
				EndIf
			Else
				SetLog("Cannot find 'BoostAll'")
			EndIf
		EndIf

		If Not $bBoosted Then ClickP($aAway, 1, 0, "#0000")
	Else
		SetLog("No hero available or located")
		ClickP($aAway, 1, 0, "#0000")
	EndIf

	; boosting with Clan Castle Location
	If Not $bBoosted And $g_aiClanCastlePos[0] <> "" And $g_aiClanCastlePos[0] <> -1 Then
		; click CC
		BuildingClickP($g_aiClanCastlePos)
		If _Sleep($DELAYBOOSTHEROES2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], "Castle", $STR_NOCASESENSEBASIC) > 0 Then
				SetDebugLog("Boost all using Clan Castle located at " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
			Else
				SetDebugLog("This location (" & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1] & ") is " & $aResult[1] & ", not the Clan Castle as expected")
			EndIf
		EndIf

		; boost
		Local $offColor[2][3] = [[0xFDD298, 10, 0], [0x4B92F2, 30, 0]]
		Local $MagicPos = _MultiPixelSearch(525, 665, 583, 665, 1, 1, 0x602C28, $offColor, 30)
		If IsArray($MagicPos) And UBound($MagicPos) = 2 Then
			ClickP($MagicPos)
			If _Sleep($DELAYBOOSTHEROES2) Then Return
			If _ColorCheck(_GetPixelColor(315, 395, True), Hex(0x1DC059, 6), 30) Then ; click Training Potion
				Click(315, 395)
				If _Sleep($DELAYBOOSTHEROES2) Then Return
				If _ColorCheck(_GetPixelColor(200, 565, True), Hex(0x8CD136, 6), 30) Then
					Click(200, 565)
					If _Sleep($DELAYBOOSTHEROES2) Then Return
					$bBoosted = True
				Else
					SetLog("Cannot find 'Use' button to boost")
				EndIf
			Else
				SetLog("Cannot find Training Potion available")
			EndIf
			If Not $bBoosted Then ClickP($aAway, 1, 0, "#0000")
		Else
			SetLog("Cannot find 'Magic Items' Button")
			ClickP($aAway, 1, 0, "#0000")
		EndIf

	ElseIf Not $bBoosted Then
		SetLog("Clan Castle is not located")
		ClickP($aAway, 1, 0, "#0000")
		Return
	EndIf

	If $bBoosted Then
		If $g_iCmbBoostBrMagic >= 1 And $g_iCmbBoostBrMagic <= 5 Then
			$g_iCmbBoostBrMagic -= 1
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: " & $g_iCmbBoostBrMagic, $COLOR_SUCCESS)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostBrMagic, $g_iCmbBoostBrMagic)
		ElseIf $g_iCmbBoostBrMagic = 6 Then
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: Unlimited", $COLOR_SUCCESS)
		EndIf
	Else
		SetLog("Cannot 'BoostAll' with Magic Spell")
	EndIf

	If _Sleep($DELAYBOOSTBARRACKS3) Then Return
	Return $bBoosted

EndFunc   ;==>BoostAllWithMagicSpell
