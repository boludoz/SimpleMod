; #FUNCTION# ====================================================================================================================
; Name ..........: Alternative SendText
; Description ...: A function to send unicode characters through ADB while typing text
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: DocOc RK Team
; Modified ......: ---
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......: ---
;================================================================================================================================

Func cmbStandardDropSidesAB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesAB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaAB()
EndFunc   ;==>g_hCmbStandardDropSidesAB

Func cmbStandardDropSidesDB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaDB()
EndFunc   ;==>g_hCmbStandardDropSidesDB

Func Bridge()
    If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
            GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		    GUICtrlSetState($g_hChkRandomSpeedAtkDB, $GUI_UNCHECKED)
		    chkRandomSpeedAtkDB()
		For $i = $g_hChkRandomSpeedAtkDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_DISABLE + $GUI_HIDE)
		Next
	Else
		For $i = $g_hChkRandomSpeedAtkDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_ENABLE + $GUI_SHOW)
		Next
        chkSmartAttackRedAreaDB()
	EndIf

EndFunc   ;==>Bridge