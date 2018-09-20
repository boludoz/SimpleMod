; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Profiles" tab under the "Bot" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hCmbProfile = 0, $g_hTxtVillageName = 0, $g_hBtnAddProfile = 0, $g_hBtnConfirmAddProfile = 0, $g_hBtnConfirmRenameProfile = 0, $g_hChkOnlySCIDAccounts = 0, $g_hCmbWhatSCIDAccount2Use = 0 , _
	   $g_hBtnDeleteProfile = 0, $g_hBtnCancelProfileChange = 0, $g_hBtnRenameProfile = 0, $g_hBtnPullSharedPrefs = 0, $g_hBtnPushSharedPrefs = 0 , $g_hBtnSaveprofile = 0, $g_hBtnRecycle = 0
	   
;------------------REMOVED By Simple Mod - START------------------
;Global $g_hChkSwitchAcc = 0, $g_hCmbSwitchAcc = 0, $g_hChkSharedPrefs = 0, $g_hCmbTotalAccount = 0, $g_hChkSmartSwitch = 0, $g_hCmbTrainTimeToSkip = 0, $g_hChkDonateLikeCrazy = 0, _
	   ;$g_ahChkAccount[8], $g_ahCmbProfile[8], $g_ahChkDonate[8], _
	   ;$g_hRadSwitchGooglePlay = 0, $g_hRadSwitchSuperCellID = 0, $g_hRadSwitchSharedPrefs = 0
;------------------REMOVED By Simple Mod - END------------------
Func CreateBotProfiles()

	Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "Group_01", "Switch Profiles"), $x - 20, $y - 20, $g_iSizeWGrpTab2, 55)
    $x -= 5
        $g_hCmbProfile = GUICtrlCreateCombo("", $x - 3, $y + 1, 115, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "CmbProfile_Info_01", "Use this to switch to a different profile")& @CRLF & _
							   GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "CmbProfile_Info_02", "Your profiles can be found in") & ": " & @CRLF & $g_sProfilePath)
			setupProfileComboBox()
			PopulatePresetComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbProfile")
        $g_hTxtVillageName = GUICtrlCreateInput(GetTranslatedFileIni("MBR Popups", "MyVillage", "MyVillage"), $x - 3, $y, 130, 22, $ES_AUTOHSCROLL)
			GUICtrlSetLimit (-1, 100, 0)
			GUICtrlSetFont(-1, 9, 400, 1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "TxtVillageName_Info_01", "Your village/profile's name"))
			GUICtrlSetState(-1, $GUI_HIDE)
			; GUICtrlSetOnEvent(-1, "txtVillageName") - No longer needed

		; Local static to avoid GDI Handle leak
		Static $bIconAdd = 0
		If $bIconAdd = 0 Then
			$bIconAdd = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
		EndIf
		Static $bIconConfirm = 0
		If $bIconConfirm = 0 Then
			$bIconConfirm = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
		EndIf
		Static $bIconDelete = 0
		If $bIconDelete = 0 Then
			$bIconDelete = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
		EndIf
		Static $bIconCancel = 0
		If $bIconCancel = 0 Then
			$bIconCancel = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
		EndIf
		Static $bIconEdit = 0
		If $bIconEdit = 0 Then
			$bIconEdit = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
		EndIf
		Static $bIconPush = 0
		If $bIconPush = 0 Then
			$bIconPush = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconPush, @ScriptDir & "\images\Button\iconPush.bmp")
		EndIf
		Static $bIconPull = 0
		If $bIconPull = 0 Then
			$bIconPull = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconPull, @ScriptDir & "\images\Button\iconPull.bmp")
		EndIf
		Static $bIconSave = _GUIImageList_Create(24, 24, 4)
		_GUIImageList_AddBitmap($bIconSave, @ScriptDir & "\images\Button\iconConfirm.bmp")
		
		Local $bIconRecycle = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_4.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")

		$x -= 15
		$g_hBtnAddProfile = _GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnAddProfile, $bIconAdd, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnAddProfile_Info_01", "Add New Profile"))
		$g_hBtnConfirmAddProfile = _GUICtrlCreateButton("", $x + 148, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmAddProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnConfirmAddProfile_Info_01", "Confirm"))
		$g_hBtnConfirmRenameProfile = _GUICtrlCreateButton("", $x + 145, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmRenameProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnConfirmAddProfile_Info_01", -1))
		$g_hBtnDeleteProfile = _GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnDeleteProfile, $bIconDelete, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnDeleteProfile_Info_01", "Delete Profile"))
		$g_hBtnCancelProfileChange = _GUICtrlCreateButton("", $x + 175, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnCancelProfileChange, $bIconCancel, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnCancelProfileChange_Info_01", "Cancel"))
		$g_hBtnRenameProfile = _GUICtrlCreateButton("", $x + 194, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnRenameProfile, $bIconEdit, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnRenameProfile_Info_01", "Rename Profile"))
		$g_hBtnPullSharedPrefs = _GUICtrlCreateButton("", $x + 224, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnPullSharedPrefs, $bIconPull, 4)
			GUICtrlSetOnEvent(-1, "btnPullSharedPrefs")
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnPullSharedPrefs_Info_01", "Pull CoC shared_prefs folder"))
		$g_hBtnPushSharedPrefs = _GUICtrlCreateButton("", $x + 254, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnPushSharedPrefs, $bIconPush, 4)
			GUICtrlSetOnEvent(-1, "btnPushSharedPrefs")
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnPushSharedPrefs_Info_01", "Push CoC shared_prefs folder"))
		$g_hBtnSaveprofile = _GUICtrlCreateButton("", $x + 284, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnSaveprofile, $bIconSave, 4)
			GUICtrlSetOnEvent(-1, "BtnSaveprofile")
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnSaveprofile_Info_01", "Save your current setting."))
		$g_hBtnRecycle = _GUICtrlCreateButton("", $x + 313, $y + 2, 22, 22)
			_GUICtrlButton_SetImageList($g_hBtnRecycle, $bIconRecycle, 4)
			GUICtrlSetOnEvent(-1, "btnRecycle")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1,  GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnRecycle_Info_01", "Recycle Profile by removing all settings no longer suported that could lead to bad behaviour"))
			If GUICtrlRead($g_hCmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf

		;$x += 17
		;$g_hChkOnlySCIDAccounts = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "ChkOnlySCIDAccounts", "SC_ID"), $x + 285, $y, -1, -1)
		;	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "ChkOnlySCIDAccounts_Info_01", "Are you using SC_ID?"))
		;	GUICtrlSetOnEvent(-1, "OnlySCIDAccounts")
		;$g_hCmbWhatSCIDAccount2Use = GUICtrlCreateCombo("", $x + 290 + 47, $y , 83, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		;	GUICtrlSetData(-1, "Account nº1|Account nº2|Account nº3|Account nº4|Account nº5", "Account nº1")
		;	GUICtrlSetData(-1, "Account 1|Account 2|Account 3|Account 4|Account 5", "Account 1")
		;	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "WhatSCIDAccount2Use_Info_01", "Select the correct account from Login Window!"))
		;	GUICtrlSetOnEvent(-1, "WhatSCIDAccount2Use")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>CreateBotProfiles
