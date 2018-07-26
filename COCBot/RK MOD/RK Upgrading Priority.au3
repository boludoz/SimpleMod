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
	If GUICtrlRead($g_hChkUpgrPriority) = $GUI_CHECKED Then
	    GUICtrlSetState($g_hCmbUpgrPriority, $GUI_ENABLE)
	Else
   	    GUICtrlSetState($g_hCmbUpgrPriority, $GUI_DISABLE)
	EndIf	
EndFunc   ;==>chkUpgrPriority


Func UpgrPriority()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbUpgrPriority)
		Case 0
			$g_iCmbUpgrPriority = "Wall"
		Case 1
			$g_iCmbUpgrPriority = "Building"
	EndSwitch

EndFunc   ;==>BoostBrMagic