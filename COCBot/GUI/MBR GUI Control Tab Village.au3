; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Sardo (2016)
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Func chkTrap()
	; If GUICtrlRead($g_hChkTrap) = $GUI_CHECKED Then
		; $g_bChkTrap = True
		; ;GUICtrlSetState($btnLocateTownHall, $GUI_SHOW)
	; Else
		; $g_bChkTrap = False
		; ;GUICtrlSetState($btnLocateTownHall, $GUI_HIDE)
	; EndIf
; EndFunc   ;==>chkTrap

; Func ChkCollect()
	; $g_bChkCollect = (GUICtrlRead($g_hChkCollect) = $GUI_CHECKED)
; EndFunc   ;==>ChkCollect

Func chkRequestCCHours()
	Local $bWasRedraw = SetRedrawBotWindow(False, Default, Default, Default, "chkRequestCCHours")

	If GUICtrlRead($g_hChkRequestTroopsEnable) = $GUI_CHECKED Then
		GUICtrlSetState($g_hTxtRequestCC, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkRusLang2, $GUI_SHOW + $GUI_ENABLE) ; Russian Request- by RK MOD
		For $i = $g_hChkSkipRequestCC To $g_hLblRequestCCHoursPM  ; Skip request CC - Add RK MOD
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		For $i = $g_hChkReqCCFirst To $g_hLblRequestCCHoursPM 
 			GUICtrlSetState($i, $GUI_ENABLE)
 		Next
		chkSkipRequestCC() ; Skip request CC - Add RK MOD
	Else
		GUICtrlSetState($g_hTxtRequestCC, $GUI_SHOW + $GUI_DISABLE)
		GUICtrlSetState($g_hChkRusLang2, $GUI_SHOW + $GUI_DISABLE) ; Russian Request- by RK MOD
		For $i = $g_hChkSkipRequestCC To $g_hLblRequestCCHoursPM ; Skip request CC - Add RK MOD
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		For $i = $g_hChkReqCCFirst To $g_hLblRequestCCHoursPM
 			GUICtrlSetState($i, $GUI_DISABLE)
 		Next
	EndIf

	SetRedrawBotWindowControls($bWasRedraw, $g_hGrpRequestCC, "chkRequestCCHours")
EndFunc   ;==>chkRequestCCHours

; Skip request CC - Add RK MOD
Func chkSkipRequestCC()
	If GUICtrlRead($g_hChkSkipRequestCC) = $GUI_CHECKED Then
		For $i = $g_hTxtSkipRequestCCTroop To $g_hTxtSkipRequestCCSpell
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		If GUICtrlRead($g_hTxtSkipRequestCCTroop) <= 0 Then
			GUICtrlSetState($g_hLblSkipRequestCCTroop, $GUI_DISABLE)
		Else
			GUICtrlSetState($g_hLblSkipRequestCCTroop, $GUI_ENABLE)
		EndIf
		If GUICtrlRead($g_hTxtSkipRequestCCSpell) <= 0 Then
			GUICtrlSetState($g_hLblSkipRequestCCSpell, $GUI_DISABLE)
		Else
			GUICtrlSetState($g_hLblSkipRequestCCSpell, $GUI_ENABLE)
		EndIf
	Else
		For $i = $g_hTxtSkipRequestCCTroop To $g_hTxtSkipRequestCCSpell
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>chkSkipRequestCC

Func chkRequestCCHoursE1()
	If GUICtrlRead($g_hChkRequestCCHoursE1) = $GUI_CHECKED And GUICtrlRead($g_ahChkRequestCCHours[0]) = $GUI_CHECKED Then
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkRequestCCHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkRequestCCHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkRequestCCHoursE1, $GUI_UNCHECKED)
EndFunc   ;==>chkRequestCCHoursE1

Func chkRequestCCHoursE2()
	If GUICtrlRead($g_hChkRequestCCHoursE2) = $GUI_CHECKED And GUICtrlRead($g_ahChkRequestCCHours[12]) = $GUI_CHECKED Then
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkRequestCCHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkRequestCCHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkRequestCCHoursE2, $GUI_UNCHECKED)
EndFunc   ;==>chkRequestCCHoursE2

Func chkDonateHours()
	Local $bWasRedraw = SetRedrawBotWindow(False, Default, Default, Default, "chkDonateHours")

    If GUICtrlRead($g_hChkDonateHoursEnable) = $GUI_CHECKED Then
		For $i = $g_hLblDonateCChour To $g_hLblDonateHoursPM
			GUICtrlSetState($i, $GUI_ENABLE)
			GUICtrlSetState($g_hchkReqCCFirst, $GUI_SHOW + $GUI_ENABLE)
		Next
	Else
		For $i = $g_hLblDonateCChour To $g_hLblDonateHoursPM
			GUICtrlSetState($i, $GUI_DISABLE)
			GUICtrlSetState($g_hchkReqCCFirst, $GUI_SHOW + $GUI_DISABLE)
		Next
	EndIf

	SetRedrawBotWindowControls($bWasRedraw, $g_hGrpDonateCC, "chkDonateHours")
EndFunc   ;==>chkDonateHours

Func chkDonateHoursE1()
	If GUICtrlRead($g_ahChkDonateHoursE1) = $GUI_CHECKED And GUICtrlRead($g_ahChkDonateHours[0]) = $GUI_CHECKED Then
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkDonateHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkDonateHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_ahChkDonateHoursE1, $GUI_UNCHECKED)
EndFunc   ;==>chkDonateHoursE1

Func chkDonateHoursE2()
	If GUICtrlRead($g_ahChkDonateHoursE2) = $GUI_CHECKED And GUICtrlRead($g_ahChkDonateHours[12]) = $GUI_CHECKED Then
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkDonateHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkDonateHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_ahChkDonateHoursE2, $GUI_UNCHECKED)
EndFunc   ;==>chkDonateHoursE2

; move the Request CC Troops function to the beginning of the run loop
Func chkReqCCFirst()
	$g_bReqCCFirst = (GUICtrlRead($g_hChkReqCCFirst) = $GUI_CHECKED)
EndFunc   ;==>chkReqCCFirst