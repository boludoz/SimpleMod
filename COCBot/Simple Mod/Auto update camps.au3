; #FUNCTION# ====================================================================================================================
; Name ..........: OCRbypass / RK Auto Update camps v.0.7 (#ID135-)
; Description ...: ByPass camps. capacity auto update
; Author ........: Boludoz (25/6/2018) Rulesss (1/7/2018)
; Modified ......: Boludoz (1/7/2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: getArmyCapacityOnTrainTroops(48, 160), _getArmyCapacityOnTrainTroops(48, 160)
; ===============================================================================================================================

Func _getArmyCapacityOnTrainTroops($x_start, $y_start) ;  -> Gets quantity of troops in army Window
    Local $aTempResult[3] = [0, 0, 0]
	Local $aResult[3] = [0, 0, 0]
	$aResult[0] = getOcrAndCapture("coc-NewCapacity", $x_start, $y_start, 70, 16, True)

	Local $dbg = 0
	
	If StringInStr($aResult[0], "#") Then
		Local $aTempResult = StringSplit($aResult[0], "#", $STR_NOCOUNT)
		$aResult[1] = Number($aTempResult[0])
		$aResult[2] = Number($aTempResult[1])
		; SG Machine
		;If $aResult[2] <= 2 Then
		;GUICtrlSetData($g_hTxtTotalMachine, $aResult[2])
		;$g_iTotalMachine = $aResult[2]
		; Spell
			If $aResult[2] <= 22 Then
				$g_iTotalSpellValue = $aResult[2] / 2
				GUICtrlSetData($g_hTxtTotalCountSpell, $g_iTotalSpellValue)
				; Army
			  ElseIf $aResult[2] >= 40 Then
				$g_iTotalCampForcedValue = $aResult[2] / 2 
				GUICtrlSetData($g_hTxtTotalCampForced, $g_iTotalCampForcedValue)
				
				If $dbg = 1 Then Setlog($aResult[0])
				If $dbg = 1 Then Setlog($g_iTotalSpellValue)
				If $dbg = 1 Then Setlog($g_iTotalCampForcedValue)
				
				lblTotalCountTroop1()
			EndIf	
	Else
		SetLog("DEBUG | ERROR on GetCurrentArmy", $COLOR_ERROR)
	EndIf

	Return $aResult[0]
EndFunc   ;==>_getArmyCapacityOnTrainTroops

Func CheckAutoCamp() ; Only first Run and th5 + (Then every time he does the troops he will do it alone.)
	Local $dbg = 0
	If $dbg = 1 Then Setlog("Auto camp called")
	Sleep(50)

	;	Local $iCmpSpell = StringCompare($g_iTotalSpellValue, "0")
    ;   If $iCmpSpell = 0 Then ;And $g_iTownHallLevel >= 5 Then ; Spell camp
			WaitMainscreen()
            Click(30, 584)
            If _Sleep(250) Then Return
			OpenTrainTab("Brew Spells Tab", True)
            If _Sleep(250) Then return
			Local $NewSpellOCR = _getArmyCapacityOnTrainTroops(43, 160) ; Check spell camps
			OpenTrainTab("Train Troops Tab", True)
            If _Sleep(250) Then Return
			Local $NewCampOCR = _getArmyCapacityOnTrainTroops(43, 160) ; Check army camps
				Click(825, 122)
			If _Sleep(250) Then Return
	;	Endif
EndFunc   ;==>CheckAutoCamp

; INFO ! ======================
	;		; full & forced Total Camp values
	;		$g_iTrainArmyFullTroopPct = Int(GUICtrlRead($g_hTxtFullTroop))
	;		$g_bTotalCampForced = (GUICtrlRead($g_hChkTotalCampForced) = $GUI_CHECKED)
	;		$g_iTotalCampForcedValue = Int(GUICtrlRead($g_hTxtTotalCampForced))
	;		; spell capacity and forced flag
	;		$g_iTotalSpellValue = GUICtrlRead($g_hTxtTotalCountSpell)
	;		$g_bForceBrewSpells = (GUICtrlRead($g_hChkForceBrewBeforeAttack) = $GUI_CHECKED)
; ============

Func chkAutoCamp()
    If GUICtrlRead($g_hChkAutoCamp) = $GUI_CHECKED Then
        $g_bChkAutoCamp = True
    Else
        $g_bChkAutoCamp = False
    EndIf
EndFunc ;==>chkAutoCamp