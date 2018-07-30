; #FUNCTION# ====================================================================================================================
; Name ..........: Wall/Building Upgrading Priority
; Description ...: Wall/Building Upgrading Priority Option
; Author ........: by RK MOD
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func chkUpgrPriority()
	If GUICtrlRead($g_hChkUpgrPriority) = $GUI_CHECKED Then
		$g_iChkUpgrPriority = 1
	Else
		$g_iChkUpgrPriority = 0
	EndIf
EndFunc   ;==>chkUpgrPriority


Func UpgrdPriority()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbUpgrdPriority)
		Case "Walls"
			$g_iCmbUpgrdPriority = 0 Then UpgradeWall()
		Case "Building"
			$g_iCmbUpgrdPriority = 1
	EndSwitch

EndFunc   ;==>UpgrdPriority