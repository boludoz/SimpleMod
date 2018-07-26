; #FUNCTION# ====================================================================================================================
; Name ..........: getArmySpellTime
; Description ...: Obtains time reamining in mimutes for spells Training - Army Overview window
; Syntax ........: getArmySpellTime($bOpenArmyWindow = False, $bCloseArmyWindow = False)
; Parameters ....:
; Return values .:
; Author ........: Promac(04-2016)
; Modified ......: MonkeyHunter (04-2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getArmySpellTime($bOpenArmyWindow = False, $bCloseArmyWindow = False, $bCheckWindow = True, $bSetLog = True, $bNeedCapture = True)

	If $g_bDebugSetlogTrain Then SetLog("getArmySpellTime():", $COLOR_DEBUG1)

	$g_aiTimeTrain[1] = 0 ; reset time

	If $bCheckWindow Then
		If Not $bOpenArmyWindow And Not IsTrainPage() Then ; check for train page
			SetError(1)
			Return ; not open, not requested to be open - error.
		ElseIf $bOpenArmyWindow Then
			If Not openArmyOverview(True, "getArmySpellTime()") Then
				SetError(2)
				Return ; not open, requested to be open - error.
			EndIf
			If _Sleep($DELAYCHECKARMYCAMP5) Then Return
		EndIf
	EndIf

	; Verify is the Spells Factory is Boosted
	Local $bBoosted = False
	If QuickMIS("BC1", @ScriptDir & "\imgxml\Resources\Boosted", 435, 300, 500, 337) Then ; search for treasury button
		$bBoosted = True
	Endif

	Local $sResultSpells = getRemainTrainTimer(495, 315, $bNeedCapture) ;Get time via OCR.
	$g_aiTimeTrain[1] = ConvertOCRTime("Spells", $sResultSpells, $bSetLog) ; update global array

	If $bBoosted then
		$g_aiTimeTrain[1] = $g_aiTimeTrain[1] / 4
		Setlog("Boosted Spells Factory detected!", $COLOR_INFO)
	EndIf

	If $bCloseArmyWindow Then
		ClickP($aAway, 1, 0, "#0000") ;Click Away
		If _Sleep($DELAYCHECKARMYCAMP4) Then Return
	EndIf
EndFunc   ;==>getArmySpellTime
