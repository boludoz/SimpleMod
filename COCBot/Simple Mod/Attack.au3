#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Argentino(Boludoz)

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
	
;Ignore
;If IniRead($s, "", "", "False") = "True" Then $g_b = True
;$g_iGroup1 
;$g_iSliderLB
;$g_iSliderDB
;$g_iLabel1 
;$g_iLabel2 
;$g_iGroup2 
;$g_bRadioCVSspeed1 
;$g_bRadioCVSwait2 
;$g_bRadioCVSwait3 
;$g_iSliderWaitCVS
;$g_iLabel3 
; SliderWaitCVS
; SliderLB
; SliderDB
#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>

Func AttackRead()
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait1", "False") = "True" Then $g_bRadioCVSwait1 = True
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait2", "False") = "True" Then $g_bRadioCVSwait2 = True
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait3", "False") = "True" Then $g_bRadioCVSwait3 = True
$g_iSliderWaitCVS = IniRead($sChatIni, "AttackCVS", "SliderWaitCVS", "0")
$g_iSliderDB = IniRead($sChatIni, "AttackCVS", "SliderDB", "0")
$g_iSliderLB = IniRead($sChatIni, "AttackCVS", "SliderLB", "0")


EndFunc   ;==>AttackReadMessages

Func AttackGUICheckbox()


	$g_iSliderDB = GUICtrlRead($g_hSliderDB)
	$g_iSliderLB = GUICtrlRead($g_hSliderLB)
	$g_iSliderWaitCVS = GUICtrlRead($g_hSliderWaitCVS)

	$g_bRadioCVSwait1 = GUICtrlRead($g_hRadioCVSwait1) = $GUI_CHECKED
	$g_bRadioCVSwait2 = GUICtrlRead($g_hRadioCVSwait2) = $GUI_CHECKED
	$g_bRadioCVSwait3 = GUICtrlRead($g_hRadioCVSwait3) = $GUI_CHECKED
	
	IniWrite($sChatIni, "AttackCVS", "SliderLB", $g_iSliderLB)
	IniWrite($sChatIni, "AttackCVS", "SliderDB", $g_iSliderDB)
	IniWrite($sChatIni, "AttackCVS", "SliderWaitCVS", $g_iSliderWaitCVS)

	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait1", $g_bRadioCVSwait1)
	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait2", $g_bRadioCVSwait2)
	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait3", $g_bRadioCVSwait3)
	
	AttackGUICheckboxControl()

EndFunc   ;==>AttackGUICheckbox

Func AttackGUICheckboxControl()
		GUICtrlSetData($g_hSliderLB, $g_iSliderLB)
		$g_iSliderLB = GUICtrlRead($g_hSliderLB)
		$g_iSlider[1] = $g_iSliderLB

		GUICtrlSetData($g_hSliderDB, $g_iSliderDB)
		$g_iSliderDB = GUICtrlRead($g_hSliderDB)
		$g_iSlider[0] = $g_iSliderDB
	
	
	For $i = 0 To UBound($g_iSlider) - 1
			If $g_iSlider[$i] > 0 Then $g_iSlider[$i] += 1
			If $g_iSlider[$i] < 0 Then $g_iSlider[$i] -= 0.1
			If $g_iSlider[$i] = 0 Then $g_iSlider[$i] = .1
			$g_iSlider[$i] = Number(StringReplace($g_iSlider[$i], "-", "."))	
			If $g_iSlider[$i] <= 1 Then $g_iSlider[$i] -= 1
		Next
		SetDebugLog($g_iSlider[0] & ", " & $g_iSlider[1] & ", " & $g_iMultWaitCVS)

If GUICtrlRead($g_hRadioCVSwait1) = $GUI_CHECKED Then
		GUICtrlSetState($g_hRadioCVSwait2, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait3, $GUI_UNCHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_HIDE)
		$g_iMultWaitCVS = 0
	ElseIf GUICtrlRead($g_hRadioCVSwait2) = $GUI_CHECKED Then
		GUICtrlSetState($g_hRadioCVSwait1, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait3, $GUI_UNCHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_SHOW)
		
		GUICtrlSetData($g_hSliderWaitCVS, $g_iSliderWaitCVS)	
		$g_iSliderWaitCVS = GUICtrlRead($g_hSliderWaitCVS)
			$g_iMultWaitCVS = $g_iSliderWaitCVS
			If $g_iMultWaitCVS > 0 Then $g_iMultWaitCVS += 1
			If $g_iMultWaitCVS < 0 Then $g_iMultWaitCVS -= 0.1
			If $g_iMultWaitCVS = 0 Then $g_iMultWaitCVS = .1
			$g_iMultWaitCVS = Number(StringReplace($g_iMultWaitCVS, "-", "."))	
			If $g_iMultWaitCVS <= 1 Then $g_iMultWaitCVS -= 1

	ElseIf GUICtrlRead($g_hRadioCVSwait3) = $GUI_CHECKED Then
		GUICtrlSetState($g_hRadioCVSwait1, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait2, $GUI_UNCHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_HIDE)
		$g_iMultWaitCVS = 1
	Else
		GUICtrlSetState($g_hRadioCVSwait1, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait2, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait3, $GUI_CHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_HIDE)
		$g_iMultWaitCVS = 1
	EndIf
	
	For $i = 0 To UBound($g_iSlider) - 1
	GUICtrlSetState($g_iSlider[$i], $GUI_SHOW)
	Next

EndFunc   ;==>AttackGUICheckboxControl

;Func ChatbotGUICheckboxDisable()
;	For $i = $g_hChkGlobalChat To $g_hEditGeneric ; Save state of all controls on tabs
;		GUICtrlSetState($i, $GUI_DISABLE)
;	Next
;EndFunc   ;==>ChatbotGUICheckboxDisable
;Func ChatbotGUICheckboxEnable()
;	For $i = $g_hChkGlobalChat To $g_hEditGeneric ; Save state of all controls on tabs
;		GUICtrlSetState($i, $GUI_ENABLE)
;	Next
;	ChatbotGUICheckboxControl()
;EndFunc   ;==>ChatbotGUICheckboxEnable