
; #FUNCTION# ====================================================================================================================
; Name ..........: ProfileSwitch RK MOD
; Description ...: This file contains all functions of ProfileSwitch feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: ---
; Modified ......: 03/09/2016
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================

Func ProfileSwitch()
	If $g_iChkGoldSwitchMax = 1 Or $g_iChkGoldSwitchMin = 1 Or $g_iChkElixirSwitchMax = 1 Or $g_iChkElixirSwitchMin = 1 Or _
			$g_iChkDESwitchMax = 1 Or $g_iChkDESwitchMin = 1 Or $g_iChkTrophySwitchMax = 1 Or $g_iChkTrophySwitchMin = 1 Then
		Local $SwitchtoProfile = ""
		While True
			If $g_iChkGoldSwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootGold]) >= Number($g_iTxtMaxGoldAmount) Then
					$SwitchtoProfile = $g_iCmbGoldMaxProfile
					SetLog("Village Gold detected Above Gold Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkGoldSwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootGold]) < Number($g_iTxtMinGoldAmount) And Number($g_aiCurrentLoot[$eLootGold]) > 1 Then
					$SwitchtoProfile = $g_iCmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkElixirSwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootElixir]) >= Number($g_iTxtMaxElixirAmount) Then
					$SwitchtoProfile = $g_iCmbElixirMaxProfile
					SetLog("Village Gold detected Above Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkElixirSwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootElixir]) < Number($g_iTxtMinElixirAmount) And Number($g_aiCurrentLoot[$eLootElixir]) > 1 Then
					$SwitchtoProfile = $g_iCmbElixirMinProfile
					SetLog("Village Gold detected Below Elixir Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkDESwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) >= Number($g_iTxtMaxDEAmount) Then
					$SwitchtoProfile = $g_iCmbDEMaxProfile
					SetLog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkDESwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) < Number($g_iTxtMinDEAmount) And Number($g_aiCurrentLoot[$eLootDarkElixir]) > 1 Then
					$SwitchtoProfile = $g_iCmbDEMinProfile
					SetLog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkTrophySwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) >= Number($g_iTxtMaxTrophyAmount) Then
					$SwitchtoProfile = $g_iCmbTrophyMaxProfile
					SetLog("Village Trophies detected Above Throphy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_iChkTrophySwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) < Number($g_iTxtMinTrophyAmount) And Number($g_aiCurrentLoot[$eLootTrophy]) > 1 Then
					$SwitchtoProfile = $g_iCmbTrophyMinProfile
					SetLog("Village Trophies detected Below Trophy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> "" Then
			TrayTip(" Profile Switch Village Report!", "Gold: " & _NumberFormat($g_aiCurrentLoot[$eLootGold]) & "; Elixir: " & _NumberFormat($g_aiCurrentLoot[$eLootElixir]) & "; Dark: " & _NumberFormat($g_aiCurrentLoot[$eLootDarkElixir]) & "; Trophy: " & _NumberFormat($g_aiCurrentLoot[$eLootTrophy]), "", 0)
			If FileExists(@ScriptDir & "\Audio\SwitchingProfiles.wav") Then
				SoundPlay(@ScriptDir & "\Audio\SwitchingProfiles.wav", 1)
			ElseIf FileExists(@WindowsDir & "\media\tada.wav") Then
				SoundPlay(@WindowsDir & "\media\tada.wav", 1)
			EndIf

			_GUICtrlComboBox_SetCurSel($g_hCmbProfile, $SwitchtoProfile)
			cmbProfile()
			If _Sleep(2000) Then Return
			runBot()
		EndIf
	EndIf

EndFunc   ;==>ProfileSwitch



; Switch Profiles 
Func btnRecycle()
	FileDelete($g_sProfileConfigPath)
    saveConfig()
	SetLog("Profile " & $g_sProfileCurrentName & " was recycled with success", $COLOR_GREEN)
	SetLog("All unused settings were removed", $COLOR_GREEN)
EndFunc   ;==>btnRecycle

Func setupProfileComboBoxswitch()
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBoxswitch