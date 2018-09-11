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

#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>

Func AttackRead()
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait1", "False") = "True" Then $g_bRadioCVSwait1 = True
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait2", "False") = "True" Then $g_bRadioCVSwait2 = True
If IniRead($sChatIni, "AttackCVS", "RadioCVSwait3", "False") = "True" Then $g_bRadioCVSwait3 = True
$g_iSliderWaitCVS = IniRead($sChatIni, "AttackCVS", "SliderWaitCVS", "0")

$g_iSliderLB = IniRead($sChatIni, "SpeedAttackCVS", "SliderLB", "0")
$g_iSliderDB = IniRead($sChatIni, "SpeedAttackCVS", "SliderDB", "0")

EndFunc   ;==>AttackReadMessages

Func AttackGUICheckbox()


	$g_iSliderLB = GUICtrlRead($g_hSliderLB)
	$g_iSliderDB = GUICtrlRead($g_hSliderDB)

	$g_iSliderWaitCVS = GUICtrlRead($g_hSliderWaitCVS)
	$g_bRadioCVSwait1 = GUICtrlRead($g_hRadioCVSwait1) = $GUI_CHECKED
	$g_bRadioCVSwait2 = GUICtrlRead($g_hRadioCVSwait2) = $GUI_CHECKED
	$g_bRadioCVSwait3 = GUICtrlRead($g_hRadioCVSwait3) = $GUI_CHECKED
	
	IniWrite($sChatIni, "SpeedAttackCVS", "SliderLB", $g_iSliderWaitCVS)
	IniWrite($sChatIni, "SpeedAttackCVS", "SliderDB", $g_bRadioCVSwait1)

	IniWrite($sChatIni, "AttackCVS", "SliderWaitCVS", $g_iSliderWaitCVS)
	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait1", $g_bRadioCVSwait1)
	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait2", $g_bRadioCVSwait2)
	IniWrite($sChatIni, "AttackCVS", "RadioCVSwait3", $g_bRadioCVSwait3)
	
	AttackGUICheckboxControl()

EndFunc   ;==>AttackGUICheckbox

Func AttackGUICheckboxControl()
Local $iTmpVar = 0	
If GUICtrlRead($g_hRadioCVSwait1) = $GUI_CHECKED Then
		GUICtrlSetState($g_hRadioCVSwait2, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait3, $GUI_UNCHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_HIDE)
		$g_iMultWaitCVS = 0
	ElseIf GUICtrlRead($g_hRadioCVSwait2) = $GUI_CHECKED Then
		GUICtrlSetState($g_hRadioCVSwait1, $GUI_UNCHECKED)
		GUICtrlSetState($g_hRadioCVSwait3, $GUI_UNCHECKED)
		GUICtrlSetState($g_hSliderWaitCVS, $GUI_SHOW)
		$g_iSliderWaitCVS = GUICtrlRead($g_hSliderWaitCVS)
		$iTmpVar = StringReplace($g_iSliderWaitCVS, "-", ".")
		$g_iMultWaitCVS = $iTmpVar
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
	GUICtrlSetData($g_hSliderWaitCVS, $g_iSliderWaitCVS)
	$g_iSliderWaitCVS = GUICtrlRead($g_hSliderWaitCVS)
	
	GUICtrlSetData($g_hSliderLB, $g_iSliderLB)
	$g_iSliderLB = GUICtrlRead($g_hSliderLB)
	$iTmpVar = StringReplace($g_iSliderLB, "-", ".")
	$g_iSlider[$LB] = $iTmpVar

	GUICtrlSetData($g_hSliderDB, $g_iSliderDB)
	$g_iSliderDB = GUICtrlRead($g_hSliderDB)
	$iTmpVar = StringReplace($g_iSliderDB, "-", ".")
	$g_iSlider[$DB] = $iTmpVar

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