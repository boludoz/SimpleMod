; #FUNCTION# ====================================================================================================================
; Name ..........: RK Config
; Description ...: This file Read/Save/Apply RK MODs settings
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by RK MOD
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

Func ReadConfig_RKMod()

	; ================================================== CSV SPEED  - Added by RK MOD ================================ ;

	IniReadS($icmbCSVSpeed[$LB], $g_sProfileConfigPath, "RK CSV Speed", "cmbCSVSpeed[LB]", 2, "Int")
	IniReadS($icmbCSVSpeed[$DB], $g_sProfileConfigPath, "RK CSV Speed", "cmbCSVSpeed[DB]", 2, "Int")

; ================================================== Super XP - Added by RK MOD ==================================== ;

	IniReadS($ichkEnableSuperXP, $g_sProfileConfigPath, "RK GoblinXP", "EnableSuperXP", 0, "int")
	IniReadS($irbSXTraining, $g_sProfileConfigPath, "RK GoblinXP", "SXTraining", 1, "int")
	IniReadS($itxtMaxXPtoGain, $g_sProfileConfigPath, "RK GoblinXP", "MaxXptoGain", 500, "int")
	IniReadS($ichkSXBK, $g_sProfileConfigPath, "RK GoblinXP", "SXBK", $eHeroNone)
	IniReadS($ichkSXAQ, $g_sProfileConfigPath, "RK GoblinXP", "SXAQ", $eHeroNone)
    IniReadS($ichkSXGW, $g_sProfileConfigPath, "RK GoblinXP", "SXGW", $eHeroNone)

	;================================================== Forecast - by RK MOD ================================= ;

	IniReadS($iChkForecastBoost, $g_sProfileConfigPath, "RK Forecast", "chkForecastBoost", 0, "Int")
	IniReadS($iChkForecastPause, $g_sProfileConfigPath, "RK Forecast", "chkForecastPause", 0, "Int")
	IniReadS($iTxtForecastBoost, $g_sProfileConfigPath, "RK Forecast", "txtForecastBoost", 6, "Int")
	IniReadS($iTxtForecastPause, $g_sProfileConfigPath, "RK Forecast", "txtForecastPause", 2, "Int")
	IniReadS($ichkForecastHopingSwitchMax, $g_sProfileConfigPath, "RK Forecast", "chkForecastHopingSwitchMax", 0, "Int")
	IniReadS($icmbForecastHopingSwitchMax, $g_sProfileConfigPath, "RK Forecast", "cmbForecastHopingSwitchMax", 0, "Int")
	IniReadS($itxtForecastHopingSwitchMax, $g_sProfileConfigPath, "RK Forecast", "txtForecastHopingSwitchMax", 2, "Int")
	IniReadS($ichkForecastHopingSwitchMin, $g_sProfileConfigPath, "RK Forecast", "chkForecastHopingSwitchMin", 0, "Int")
	IniReadS($icmbForecastHopingSwitchMin, $g_sProfileConfigPath, "RK Forecast", "cmbForecastHopingSwitchMin", 0, "Int")
	IniReadS($itxtForecastHopingSwitchMin, $g_sProfileConfigPath, "RK Forecast", "txtForecastHopingSwitchMin", 2, "Int")
	IniReadS($icmbSwLang, $g_sProfileConfigPath, "RK Forecast", "cmbSwLang", 1, "int")

	;================================================== Move the Request CC Troops - Added by RK MOD =================== ;

	IniReadS($g_bReqCCFirst, $g_sProfileConfigPath, "planned", "ReqCCFirst", $g_bReqCCFirst, "Bool")

	;================================================== Stop For War - Added by RK MOD ==================== ;

	IniReadS($g_bStopForWar, $g_sProfileConfigPath, "war preparation", "Enable", False, "Bool")
	IniReadS($g_iStopTime, $g_sProfileConfigPath, "war preparation", "Stop Time", 0, "Int")
	IniReadS($g_bStopBeforeBattle, $g_sProfileConfigPath, "war preparation", "Stop Before", True, "Bool")
	IniReadS($g_iReturnTime, $g_sProfileConfigPath, "war preparation", "Return Time", 0, "Int")
	IniReadS($g_bTrainWarTroop, $g_sProfileConfigPath, "war preparation", "Train War Troop", False, "Bool")
	IniReadS($g_bUseQuickTrainWar, $g_sProfileConfigPath, "war preparation", "QuickTrain War Troop", False, "Bool")
	IniReadS($g_aChkArmyWar[0], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army1", False, "Bool")
	IniReadS($g_aChkArmyWar[1], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army2", False, "Bool")
	IniReadS($g_aChkArmyWar[2], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army3", False, "Bool")

	For $i = 0 To $eTroopCount - 1
		IniReadS($g_aiWarCompTroops[$i], $g_sProfileConfigPath, "war preparation", $g_asTroopShortNames[$i], 0, "Int")
	Next
	For $j = 0 To $eSpellCount - 1
		IniReadS($g_aiWarCompSpells[$j], $g_sProfileConfigPath, "war preparation", $g_asSpellShortNames[$j], 0, "Int")
	Next

	IniReadS($g_bRequestCCForWar, $g_sProfileConfigPath, "war preparation", "RequestCC War", False, "Bool")
	$g_sTxtRequestCCForWar = IniRead($g_sProfileConfigPath, "war preparation", "RequestCC War Text", "War troop please")

	;================================================== Bot Humanization - Added by RK MOD ==================== ;

	IniReadS($g_ichkUseBotHumanization, $g_sProfileConfigPath, "Bot Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization, "int")
	IniReadS($g_ichkUseAltRClick, $g_sProfileConfigPath, "Bot Humanization", "chkUseAltRClick", $g_ichkUseAltRClick, "int")
	IniReadS($g_ichkCollectAchievements, $g_sProfileConfigPath, "Bot Humanization", "chkCollectAchievements", $g_ichkCollectAchievements, "int")
	IniReadS($g_ichkLookAtRedNotifications, $g_sProfileConfigPath, "Bot Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications, "int")
	For $i = 0 To 12
		IniReadS($g_iacmbPriority[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPriority[" & $i & "]", $g_iacmbPriority[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbMaxSpeed[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbMaxSpeed[" & $i & "]", $g_iacmbMaxSpeed[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbPause[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPause[" & $i & "]", $g_iacmbPause[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iahumanMessage[$i], $g_sProfileConfigPath, "Bot Humanization", "humanMessage[" & $i & "]", $g_iahumanMessage[$i])
	Next
	IniReadS($g_icmbMaxActionsNumber, $g_sProfileConfigPath, "Bot Humanization", "cmbMaxActionsNumber", $g_icmbMaxActionsNumber, "int")
	IniReadS($g_ichallengeMessage, $g_sProfileConfigPath, "Bot Humanization", "challengeMessage", $g_ichallengeMessage)

	;================================================== ; Switch Profile - Added by RK MOD ==================== ;

	IniReadS($g_iChkGoldSwitchMax, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMax", 0, "int")
	IniReadS($g_iCmbGoldMaxProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMaxProfile", 0, "int")
	IniReadS($g_iTxtMaxGoldAmount, $g_sProfileConfigPath, "profiles", "txtMaxGoldAmount", 12000000, "int")
	IniReadS($g_iChkGoldSwitchMin, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMin", 0, "int")
	IniReadS($g_iCmbGoldMinProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMinProfile", 0, "int")
	IniReadS($g_iTxtMinGoldAmount, $g_sProfileConfigPath, "profiles", "txtMinGoldAmount", 10000000, "int")

	IniReadS($g_iChkElixirSwitchMax, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMax", 0, "int")
	IniReadS($g_iCmbElixirMaxProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMaxProfile", 0, "int")
	IniReadS($g_iTxtMaxElixirAmount, $g_sProfileConfigPath, "profiles", "txtMaxElixirAmount", 10000000, "int")
	IniReadS($g_iChkElixirSwitchMin, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMin", 0, "int")
	IniReadS($g_iCmbElixirMinProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMinProfile", 0, "int")
	IniReadS($g_iTxtMinElixirAmount, $g_sProfileConfigPath, "profiles", "txtMinElixirAmount", 10000000, "int")

	IniReadS($g_iChkDESwitchMax, $g_sProfileConfigPath, "profiles", "chkDESwitchMax", 0, "int")
	IniReadS($g_iCmbDEMaxProfile, $g_sProfileConfigPath, "profiles", "cmbDEMaxProfile", 0, "int")
	IniReadS($g_iTxtMaxDEAmount, $g_sProfileConfigPath, "profiles", "txtMaxDEAmount", 200000, "int")
	IniReadS($g_iChkDESwitchMin, $g_sProfileConfigPath, "profiles", "chkDESwitchMin", 0, "int")
	IniReadS($g_iCmbDEMinProfile, $g_sProfileConfigPath, "profiles", "cmbDEMinProfile", 0, "int")
	IniReadS($g_iTxtMinDEAmount, $g_sProfileConfigPath, "profiles", "txtMinDEAmount", 10000, "int")

	IniReadS($g_iChkTrophySwitchMax, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMax", 0, "int")
	IniReadS($g_iCmbTrophyMaxProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMaxProfile", 0, "int")
	IniReadS($g_iTxtMaxTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMaxTrophyAmount", 3000, "int")
	IniReadS($g_iChkTrophySwitchMin, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMin", 0, "int")
	IniReadS($g_iCmbTrophyMinProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMinProfile", 0, "int")
	IniReadS($g_iTxtMinTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMinTrophyAmount", 1000, "int")

	; ================================================== NEW ChatBot - by RK MOD ================================= ;

	IniReadS($g_iChkChatGlobal, $g_sProfileConfigPath, "Chatbot", "ChkChatGlobal", $g_iChkChatGlobal, "int")
	IniReadS($g_iChkScrambleGlobal, $g_sProfileConfigPath, "Chatbot", "ChkScrambleGlobal", $g_iChkScrambleGlobal, "int") 
	IniReadS($g_bChkDelayTime, $g_sProfileConfigPath, "Chatbot", "ChkDelayTime", $g_bChkDelayTime, "Bool")
    IniReadS($g_iTxtDelayTime, $g_sProfileConfigPath, "Chatbot", "TxtDelayTime", $g_iTxtDelayTime)
	IniReadS($g_iChkSwitchLang, $g_sProfileConfigPath, "Chatbot", "ChkSwitchLang", $g_iChkSwitchLang, "int")
	IniReadS($g_iCmbLang, $g_sProfileConfigPath, "Chatbot", "CmbLang", 9, "int")
	IniReadS($g_iChkRusLang, $g_sProfileConfigPath, "Chatbot", "ChkRusLang", $g_iChkRusLang, "int")
	IniReadS($g_iChkChatClan, $g_sProfileConfigPath, "Chatbot", "ChkChatClan", $g_iChkChatClan, "int")
	IniReadS($g_iChkClanUseResponses, $g_sProfileConfigPath, "Chatbot", "ChkUseResponses", $g_iChkClanUseResponses, "int")
	IniReadS($g_iChkClanAlwaysMsg, $g_sProfileConfigPath, "Chatbot", "ChkUseGeneric", $g_iChkClanAlwaysMsg, "int")
	IniReadS($g_iChkCleverbot, $g_sProfileConfigPath, "Chatbot", "ChkCleverbot", $g_iChkCleverbot, "int")
	IniReadS($g_iChkUseNotify, $g_sProfileConfigPath, "Chatbot", "ChkChatNotify", $g_iChkUseNotify, "int")
	IniReadS($g_iChkPbSendNew, $g_sProfileConfigPath, "Chatbot", "ChkPbSendNewChats", $g_iChkPbSendNew, "int")

	; ==================================================  Upgrade Management - Added by RK MOD ==================== ;

	IniReadS($g_ibUpdateNewUpgradesOnly, $g_sProfileConfigPath, "upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly, "int")
	
	; ================================================== BB_DropTrophies - by Chacal GYN (ID70) ================================= ;
	
	IniReadS($g_bChkBB_DropTrophies, $g_sProfileConfigPath, "other", "ChkBB_DropTrophies", $g_bChkBB_DropTrophies, "Int")
	IniReadS($g_iTxtBB_DropTrophies, $g_sProfileConfigPath, "other", "TxtBB_DropTrophies", $g_iTxtBB_DropTrophies, "Int")
EndFunc   ;==>ReadConfig_RKMod

Func SaveConfig_RKMod()  ; due to mini mode no guitCtrols Reads in this function
	ApplyConfig_RKMod(GetApplyConfigSaveAction())


	; ================================================== CSV SPEED - Added by RK MOD =============================== ;


	_Ini_Add("RK CSV Speed", "cmbCSVSpeed[LB]", $icmbCSVSpeed[$LB])
	_Ini_Add("RK CSV Speed", "cmbCSVSpeed[DB]", $icmbCSVSpeed[$DB])

	; ================================================== Super XP - Added by RK MOD ================================ ;

	_Ini_Add("RK GoblinXP", "EnableSuperXP", $ichkEnableSuperXP)
	_Ini_Add("RK GoblinXP", "SXTraining",  $irbSXTraining)
	_Ini_Add("RK GoblinXP", "SXBK", $ichkSXBK)
	_Ini_Add("RK GoblinXP", "SXAQ", $ichkSXAQ)
	_Ini_Add("RK GoblinXP", "SXGW", $ichkSXGW)
	_Ini_Add("RK GoblinXP", "MaxXptoGain", GUICtrlRead($txtMaxXPtoGain))


	 ; ================================================== Forecast - by RK MOD  ============================== ;

	_Ini_Add("RK Forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))
	_Ini_Add("RK Forecast", "txtForecastPause", GUICtrlRead($txtForecastPause))
	_Ini_Add("RK Forecast", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax))
	_Ini_Add("RK Forecast", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))
	_Ini_Add("RK Forecast", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin))
	_Ini_Add("RK Forecast", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))
	_Ini_Add("RK Forecast", "chkForecastBoost", $iChkForecastBoost ? 1 : 0)
	_Ini_Add("RK Forecast", "chkForecastPause", $iChkForecastPause ? 1 : 0)
	_Ini_Add("RK Forecast", "chkForecastHopingSwitchMax", $ichkForecastHopingSwitchMax ? 1 : 0)
	_Ini_Add("RK Forecast", "chkForecastHopingSwitchMin", $ichkForecastHopingSwitchMin ? 1 : 0)
	_Ini_Add("RK Forecast", "cmbSwLang", _GUICtrlComboBox_GetCurSel($cmbSwLang))

	;================================================== Move the Request CC Troops - Added by RK MOD ==================== ;

	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst)

	;================================================== Stop For War - Added by RK MOD ==================== ;

	_Ini_Add("war preparation", "Enable", $g_bStopForWar ? 1 : 0)
	_Ini_Add("war preparation", "Stop Time", $g_iStopTime)
	_Ini_Add("war preparation", "Stop Before", $g_bStopBeforeBattle ? 1 : 0)
	_Ini_Add("war preparation", "Return Time", $g_iReturnTime)
	_Ini_Add("war preparation", "Train War Troop", $g_bTrainWarTroop ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Troop", $g_bUseQuickTrainWar ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army1", $g_aChkArmyWar[0] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army2", $g_aChkArmyWar[1] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army3", $g_aChkArmyWar[2] ? 1 : 0)

	For $i = 0 To $eTroopCount - 1
		_Ini_Add("war preparation", $g_asTroopShortNames[$i], $g_aiWarCompTroops[$i])
	Next
	For $j = 0 To $eSpellCount - 1
		_Ini_Add("war preparation", $g_asSpellShortNames[$j], $g_aiWarCompSpells[$j])
	Next

	_Ini_Add("war preparation", "RequestCC War", $g_bRequestCCForWar ? 1 : 0)
	_Ini_Add("war preparation", "RequestCC War Text", $g_sTxtRequestCCForWar)

	;================================================== Bot Humanization - Added by RK MOD ==================== ;

	_Ini_Add("Bot Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization)
	_Ini_Add("Bot Humanization", "chkUseAltRClick", $g_ichkUseAltRClick)
	_Ini_Add("Bot Humanization", "chkCollectAchievements", $g_ichkCollectAchievements)
	_Ini_Add("Bot Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications)
	For $i = 0 To 12
		_Ini_Add("Bot Humanization", "cmbPriority[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbMaxSpeed[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbPause[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPause[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "humanMessage[" & $i & "]", GUICtrlRead($g_ahumanMessage[$i]))
	Next
	_Ini_Add("Bot Humanization", "cmbMaxActionsNumber", _GUICtrlComboBox_GetCurSel($g_cmbMaxActionsNumber))
	_Ini_Add("Bot Humanization", "challengeMessage", GUICtrlRead($g_challengeMessage))

	; ================================================ Switch Profile - Added by RK MOD ======================================== ;

	_Ini_Add("profiles", "chkGoldSwitchMax", $g_iChkGoldSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMaxProfile", $g_iCmbGoldMaxProfile)
	_Ini_Add("profiles", "txtMaxGoldAmount", $g_iTxtMaxGoldAmount)
	_Ini_Add("profiles", "chkGoldSwitchMin", $g_iChkGoldSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMinProfile", $g_iCmbGoldMinProfile)
	_Ini_Add("profiles", "txtMinGoldAmount", $g_iTxtMinGoldAmount)

	_Ini_Add("profiles", "chkElixirSwitchMax", $g_iChkElixirSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMaxProfile", $g_iCmbElixirMaxProfile)
	_Ini_Add("profiles", "txtMaxElixirAmount", $g_iTxtMaxElixirAmount)
	_Ini_Add("profiles", "chkElixirSwitchMin", $g_iChkElixirSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMinProfile", $g_iCmbElixirMinProfile)
	_Ini_Add("profiles", "txtMinElixirAmount", $g_iTxtMinElixirAmount)

	_Ini_Add("profiles", "chkDESwitchMax", $g_iChkDESwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMaxProfile", $g_iCmbDEMaxProfile)
	_Ini_Add("profiles", "txtMaxDEAmount", $g_iTxtMaxDEAmount)
	_Ini_Add("profiles", "chkDESwitchMin", $g_iChkDESwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMinProfile", $g_iCmbDEMinProfile)
	_Ini_Add("profiles", "txtMinDEAmount", $g_iTxtMinDEAmount)

	_Ini_Add("profiles", "chkTrophySwitchMax", $g_iChkTrophySwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMaxProfile", $g_iCmbTrophyMaxProfile)
	_Ini_Add("profiles", "txtMaxTrophyAmount", $g_iTxtMaxTrophyAmount)
	_Ini_Add("profiles", "chkTrophySwitchMin", $g_iChkTrophySwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMinProfile", $g_iCmbTrophyMinProfile)
	_Ini_Add("profiles", "txtMinTrophyAmount", $g_iTxtMinTrophyAmount)

	; ================================================== NEW ChatBot - by RK MOD ================================= ;

	_Ini_Add("Chatbot", "ChkChatGlobal", $g_iChkChatGlobal ? 1 : 0)
	_Ini_Add("Chatbot", "ChkScrambleGlobal", $g_iChkScrambleGlobal ? 1 : 0)  
    _Ini_Add("Chatbot", "ChkDelayTime", $g_bChkDelayTime ? 1 : 0)
    _Ini_Add("Chatbot", "TxtDelayTime", $g_iTxtDelayTime)
    _Ini_Add("Chatbot", "ChkSwitchLang", $g_iChkSwitchLang ? 1 : 0)
	_Ini_Add("Chatbot", "CmbLang", _GUICtrlComboBox_GetCurSel($g_hCmbLang))
	_Ini_Add("Chatbot", "ChkRusLang", $g_iChkRusLang ? 1 : 0)
	_Ini_Add("Chatbot", "ChkChatClan", $g_iChkChatClan ? 1 : 0)
	_Ini_Add("Chatbot", "ChkUseResponses", $g_iChkClanUseResponses ? 1 : 0)
	_Ini_Add("Chatbot", "ChkUseGeneric", $g_iChkClanAlwaysMsg ? 1 : 0)
	_Ini_Add("Chatbot", "ChkCleverbot", $g_iChkCleverbot ? 1 : 0)
	_Ini_Add("Chatbot", "ChkChatNotify", $g_iChkUseNotify ? 1 : 0)
	_Ini_Add("Chatbot", "ChkPbSendNewChats", $g_iChkPbSendNew ? 1 : 0)

    _Ini_Add("Chatbot", "globalMsg1", $glb1)
	_Ini_Add("Chatbot", "globalMsg2", $glb2)
	_Ini_Add("Chatbot", "genericMsgClan", $cGeneric)
	_Ini_Add("Chatbot", "responseMsgClan", $cResp)

	; ================================================== Upgrade Management - Added by RK MOD ================================== ;

	_Ini_Add("upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)

	; ================================================== BB_DropTrophies - by Chacal GYN (ID70) ================================= ;
	
	_Ini_Add("other", "ChkBB_DropTrophies", $g_bChkBB_DropTrophies)
	_Ini_Add("other", "TxtBB_DropTrophies", $g_iTxtBB_DropTrophies)
	
EndFunc   ;==>SaveConfig_RKMod

Func ApplyConfig_RKMod($TypeReadSave)

	Switch $TypeReadSave

		Case "Save"

			; ================================================== CSV SPEED - Added by RK MOD ========================= ;

		     $icmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB])
			 $icmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB])

			; ================================================== Super XP - Added by RK MOD ========================== ;

			$ichkEnableSuperXP = GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED ? 1 : 0
			$irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
			$ichkSXBK = (GUICtrlRead($chkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$ichkSXAQ = (GUICtrlRead($chkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$ichkSXGW = (GUICtrlRead($chkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
			$itxtMaxXPtoGain = Int(GUICtrlRead($txtMaxXPtoGain))

			; ================================================== Forecast - by RK MOD =========================== ;

			$iChkForecastBoost = GUICtrlRead($chkForecastBoost) = $GUI_CHECKED ? 1 : 0
			$iTxtForecastBoost = GUICtrlRead($txtForecastBoost)
			$iChkForecastPause = GUICtrlRead($chkForecastPause) = $GUI_CHECKED ? 1 : 0
			$iTxtForecastPause = GUICtrlRead($txtForecastPause)
			$ichkForecastHopingSwitchMax = (GUICtrlRead($chkForecastHopingSwitchMax) = $GUI_CHECKED)
			$icmbForecastHopingSwitchMax = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax)
			$itxtForecastHopingSwitchMax = GUICtrlRead($txtForecastHopingSwitchMax)
			$ichkForecastHopingSwitchMin = (GUICtrlRead($chkForecastHopingSwitchMin) = $GUI_CHECKED)
			$icmbForecastHopingSwitchMin = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin)
			$itxtForecastHopingSwitchMin = GUICtrlRead($txtForecastHopingSwitchMin)
			$icmbSwLang = _GUICtrlComboBox_GetCurSel($cmbSwLang)
			$iTxtForecastPause = GUICtrlRead($txtForecastPause)

			; =============================================== Move the Request CC Troops - Added by RK MOD =================== ;

			$g_bReqCCFirst = (GUICtrlRead($g_hChkReqCCFirst) = $GUI_CHECKED)

			;================================================== Stop For War - Added by RK MOD ==================== ;

			$g_bStopForWar = GUICtrlRead($g_hChkStopForWar)  = $GUI_CHECKED

			$g_iStopTime = _GUICtrlComboBox_GetCurSel($g_hCmbStopTime)
			$g_bStopBeforeBattle = _GUICtrlComboBox_GetCurSel($g_CmbStopBeforeBattle) = 0
			$g_iReturnTime = _GUICtrlComboBox_GetCurSel($g_hCmbReturnTime)

			$g_bTrainWarTroop = GUICtrlRead($g_hChkTrainWarTroop) = $GUI_CHECKED
			$g_bUseQuickTrainWar = GUICtrlRead($g_hChkUseQuickTrainWar) = $GUI_CHECKED
			$g_aChkArmyWar[0] = GUICtrlRead($g_ahChkArmyWar[0]) = $GUI_CHECKED
			$g_aChkArmyWar[1] = GUICtrlRead($g_ahChkArmyWar[1]) = $GUI_CHECKED
			$g_aChkArmyWar[2] = GUICtrlRead($g_ahChkArmyWar[2]) = $GUI_CHECKED
			For $i = 0 To $eTroopCount - 1
				$g_aiWarCompTroops[$i] = GUICtrlRead($g_ahTxtTrainWarTroopCount[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				$g_aiWarCompSpells[$j] = GUICtrlRead($g_ahTxtTrainWarSpellCount[$j])
			Next

			$g_bRequestCCForWar = GUICtrlRead($g_hChkRequestCCForWar) = $GUI_CHECKED
			$g_sTxtRequestCCForWar = GUICtrlRead($g_hTxtRequestCCForWar)

			;==================================================  Bot Humanization - Added by RK MOD ==================== ;

			$g_ichkUseBotHumanization = GUICtrlRead($g_chkUseBotHumanization) = $GUI_CHECKED ? 1 : 0
			$g_ichkUseAltRClick = GUICtrlRead($g_chkUseAltRClick) = $GUI_CHECKED ? 1 : 0
			$g_ichkCollectAchievements = GUICtrlRead($g_chkCollectAchievements) = $GUI_CHECKED ? 1 : 0
			$g_ichkLookAtRedNotifications = GUICtrlRead($g_chkLookAtRedNotifications) = $GUI_CHECKED ? 1 : 0
			For $i = 0 To 12
				$g_iacmbPriority[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i])
			Next
			For $i = 0 To 1
				$g_iacmbMaxSpeed[$i] = _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				$g_iacmbPause[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPause[$i])
			Next
			For $i = 0 To 1
				$g_iahumanMessage[$i] = GUICtrlRead($g_ahumanMessage[$i])
			Next
			$g_icmbMaxActionsNumber = _GUICtrlComboBox_GetCurSel($g_icmbMaxActionsNumber)
			$g_ichallengeMessage = GUICtrlRead($g_challengeMessage)

			; ================================================ Switch Profile - Added by RK MOD ======================================== ;

			$g_iChkGoldSwitchMax = GUICtrlRead($g_hChkGoldSwitchMax) = $GUI_CHECKED ? 1 : 0
			$g_iCmbGoldMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMaxProfile)
			$g_iTxtMaxGoldAmount = GUICtrlRead($g_hTxtMaxGoldAmount)
			$g_iChkGoldSwitchMin = GUICtrlRead($g_hChkGoldSwitchMin) = $GUI_CHECKED ? 1 : 0
			$g_iCmbGoldMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMinProfile)
			$g_iTxtMinGoldAmount = GUICtrlRead($g_hTxtMinGoldAmount)

			$g_iChkElixirSwitchMax = GUICtrlRead($g_hChkElixirSwitchMax) = $GUI_CHECKED ? 1 : 0
			$g_iCmbElixirMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMaxProfile)
			$g_iTxtMaxElixirAmount = GUICtrlRead($g_hTxtMaxElixirAmount)
			$g_iChkElixirSwitchMin = GUICtrlRead($g_hChkElixirSwitchMin) = $GUI_CHECKED ? 1 : 0
			$g_iCmbElixirMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMinProfile)
			$g_iTxtMinElixirAmount = GUICtrlRead($g_hTxtMinElixirAmount)

			$g_iChkDESwitchMax = GUICtrlRead($g_hChkDESwitchMax) = $GUI_CHECKED ? 1 : 0
			$g_iCmbDEMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMaxProfile)
			$g_iTxtMaxDEAmount = GUICtrlRead($g_hTxtMaxDEAmount)
			$g_iChkDESwitchMin = GUICtrlRead($g_hChkDESwitchMin) = $GUI_CHECKED ? 1 : 0
			$g_iCmbDEMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMinProfile)
			$g_iTxtMinDEAmount = GUICtrlRead($g_hTxtMinDEAmount)

			$g_iChkTrophySwitchMax = GUICtrlRead($g_hChkTrophySwitchMax) = $GUI_CHECKED ? 1 : 0
			$g_iCmbTrophyMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMaxProfile)
			$g_iTxtMaxTrophyAmount = GUICtrlRead($g_hTxtMaxTrophyAmount)
			$g_iChkTrophySwitchMin = GUICtrlRead($g_hChkTrophySwitchMin) = $GUI_CHECKED ? 1 : 0
			$g_iCmbTrophyMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMinProfile)
			$g_iTxtMinTrophyAmount = GUICtrlRead($g_hTxtMinTrophyAmount)

			; ================================================== NEW ChatBot - by RK MOD ================================= ;

			$g_iChkChatGlobal = GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED ? 1 : 0
			$g_iChkScrambleGlobal = GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED ? 1 : 0			
		    $g_bChkDelayTime = (GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED)
            $g_iTxtDelayTime = GUICtrlRead($g_hTxtDelayTime)
			$g_iChkSwitchLang = GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED ? 1 : 0
			$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)
			$g_iChkRusLang = GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED ? 1 : 0
			$g_iChkChatClan = GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED ? 1 : 0
			$g_iChkClanUseResponses = GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED ? 1 : 0
			$g_iChkClanAlwaysMsg = GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED ? 1 : 0
			$g_iChkCleverbot = GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED ? 1 : 0
			$g_iChkUseNotify = GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED ? 1 : 0
			$g_iChkPbSendNew = GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED ? 1 : 0

			; ================================================== Upgrade Management - Added by RK MOD ============================= ;

			$g_ibUpdateNewUpgradesOnly = GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED ? 1 : 0
			
			; ================================================== BB_DropTrophies - by Chacal GYN (ID70) ================================= ;
			
			$g_bChkBB_DropTrophies = (GUICtrlRead($g_hChkBB_DropTrophies) = $GUI_CHECKED) ? 1 : 0
			$g_iTxtBB_DropTrophies = GUICtrlRead($g_hTxtBB_DropTrophies)

		Case "Read"


			; ================================================== CSV SPEED - Added by RK MOD ============================  ;

			 _GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$LB], $icmbCSVSpeed[$LB])
			 _GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$DB], $icmbCSVSpeed[$DB])

			; ================================================== Super XP - Added by RK MOD ============================== ;

			GUICtrlSetState($chkEnableSuperXP, $ichkEnableSuperXP = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			chkEnableSuperXP()

			GUICtrlSetState($rbSXTraining, ($irbSXTraining = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXIAttacking, ($irbSXTraining = 2) ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetData($txtMaxXPtoGain, $itxtMaxXPtoGain)

			GUICtrlSetState($chkSXBK, $ichkSXBK = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXAQ, $ichkSXAQ = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXGW, $ichkSXGW = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)

			; ================================================== Forecast - by RK MOD ================================ ;

			GUICtrlSetState($chkForecastBoost, ($iChkForecastBoost = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($txtForecastBoost, $iTxtForecastBoost)
			chkForecastBoost()
			GUICtrlSetState($chkForecastPause, ($iChkForecastPause = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($txtForecastPause, $iTxtForecastPause)
			chkForecastPause()
			GUICtrlSetState($chkForecastHopingSwitchMax, ($ichkForecastHopingSwitchMax = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMax, $icmbForecastHopingSwitchMax)
			GUICtrlSetData($txtForecastHopingSwitchMax, $itxtForecastHopingSwitchMax)
			chkForecastHopingSwitchMax()
			GUICtrlSetState($chkForecastHopingSwitchMin, ($ichkForecastHopingSwitchMin = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMin, $icmbForecastHopingSwitchMin)
			GUICtrlSetData($txtForecastHopingSwitchMin, $itxtForecastHopingSwitchMin)
			chkForecastHopingSwitchMin()
			_GUICtrlComboBox_SetCurSel($cmbSwLang, $icmbSwLang)

			; ================================================== Move the Request CC Troops - Added by RK MOD ================== ;

			GUICtrlSetState($g_hChkReqCCFirst, $g_bReqCCFirst = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkReqCCFirst()

			;================================================== Stop For War - Added by RK MOD ==================== ;

			GUICtrlSetState($g_hChkStopForWar, $g_bStopForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbStopTime, $g_iStopTime)
			_GUICtrlComboBox_SetCurSel($g_CmbStopBeforeBattle, $g_bStopBeforeBattle ? 0 : 1)
			_GUICtrlComboBox_SetCurSel($g_hCmbReturnTime, $g_iReturnTime)

			GUICtrlSetState($g_hChkTrainWarTroop, $g_bTrainWarTroop ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseQuickTrainWar, $g_bUseQuickTrainWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[0], $g_aChkArmyWar[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[1], $g_aChkArmyWar[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[2], $g_aChkArmyWar[2] ? $GUI_CHECKED : $GUI_UNCHECKED)

			For $i = 0 To $eTroopCount - 1
				GUICtrlSetData($g_ahTxtTrainWarTroopCount[$i], $g_aiWarCompTroops[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				GUICtrlSetData($g_ahTxtTrainWarSpellCount[$j], $g_aiWarCompSpells[$j])
			Next
			GUICtrlSetState($g_hChkRequestCCForWar, $g_bRequestCCForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRequestCCForWar, $g_sTxtRequestCCForWar)
			ReadConfig_600_52_2()
			ChkStopForWar()

			;================================================== Bot Humanization - Added by RK MOD ==================== ;

			GUICtrlSetState($g_chkUseBotHumanization, $g_ichkUseBotHumanization = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkUseAltRClick, $g_ichkUseAltRClick = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkCollectAchievements, $g_ichkCollectAchievements = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkLookAtRedNotifications, $g_ichkLookAtRedNotifications = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUseBotHumanization()
			For $i = 0 To 12
				_GUICtrlComboBox_SetCurSel($g_acmbPriority[$i], $g_iacmbPriority[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbMaxSpeed[$i], $g_iacmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbPause[$i], $g_iacmbPause[$i])
			Next
			For $i = 0 To 1
				GUICtrlSetData($g_ahumanMessage[$i], $g_iahumanMessage[$i])
			Next
			_GUICtrlComboBox_SetCurSel($g_cmbMaxActionsNumber, $g_icmbMaxActionsNumber)
			GUICtrlSetData($g_challengeMessage, $g_ichallengeMessage)
			cmbStandardReplay()
			cmbWarReplay()

			; ================================================  Switch Profile - Added by RK MOD ======================================== ;

			GUICtrlSetState($g_hChkGoldSwitchMax, $g_iChkGoldSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMaxProfile, $g_iCmbGoldMaxProfile)
			GUICtrlSetData($g_hTxtMaxGoldAmount, $g_iTxtMaxGoldAmount)
			GUICtrlSetState($g_hChkGoldSwitchMin, $g_iChkGoldSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMinProfile, $g_iCmbGoldMinProfile)
			GUICtrlSetData($g_hTxtMinGoldAmount, $g_iTxtMinGoldAmount)

			GUICtrlSetState($g_hChkElixirSwitchMax, $g_iChkElixirSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMaxProfile, $g_iCmbElixirMaxProfile)
			GUICtrlSetData($g_hTxtMaxElixirAmount, $g_iTxtMaxElixirAmount)
			GUICtrlSetState($g_hChkElixirSwitchMin, $g_iChkElixirSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMinProfile, $g_iCmbElixirMinProfile)
			GUICtrlSetData($g_hTxtMinElixirAmount, $g_iTxtMinElixirAmount)

			GUICtrlSetState($g_hChkDESwitchMax, $g_iChkDESwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMaxProfile, $g_iCmbDEMaxProfile)
			GUICtrlSetData($g_hTxtMaxDEAmount, $g_iTxtMaxDEAmount)
			GUICtrlSetState($g_hChkDESwitchMin, $g_iChkDESwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMinProfile, $g_iCmbDEMinProfile)
			GUICtrlSetData($g_hTxtMinDEAmount, $g_iTxtMinDEAmount)

			GUICtrlSetState($g_hChkTrophySwitchMax, $g_iChkTrophySwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMaxProfile, $g_iCmbTrophyMaxProfile)
			GUICtrlSetData($g_hTxtMaxTrophyAmount, $g_iTxtMaxTrophyAmount)
			GUICtrlSetState($g_hChkTrophySwitchMin, $g_iChkTrophySwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMinProfile, $g_iCmbTrophyMinProfile)
			GUICtrlSetData($g_hTxtMinTrophyAmount, $g_iTxtMinTrophyAmount)

			; ================================================== NEW ChatBot - by RK MOD ======================================== ;

			GUICtrlSetState($g_hChkGlobalChat, $g_iChkChatGlobal = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkGlobalScramble, $g_iChkScrambleGlobal = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)			
			GUICtrlSetState($g_hChkDelayTime, $g_bChkDelayTime ? $GUI_CHECKED : $GUI_UNCHECKED)
            GUICtrlSetData($g_hTxtDelayTime, $g_iTxtDelayTime)			
			GUICtrlSetState($g_hChkSwitchLang, $g_iChkSwitchLang = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbLang, $g_iCmbLang)
			GUICtrlSetState($g_hChkRusLang, $g_iChkRusLang = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanChat, $g_iChkChatClan = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseResponses, $g_iChkClanUseResponses = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseGeneric, $g_iChkClanAlwaysMsg = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCleverbot, $g_iChkCleverbot = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkChatNotify, $g_iChkUseNotify = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkPbSendNewChats, $g_iChkPbSendNew = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
   		    chkRusLang()
			chkGlobalChat()
			chkGlobalScramble()
			chkCleverbot()
			chkSwitchLang()
			chkClanChat()
			chkUseResponses()
			chkUseGeneric()
			chkChatNotify()
			chkPbSendNewChats()
			ChatGuiEditUpdate()
            chkDelayTime()
			
			; ==================================================  Upgrade Management - Added by RK MOD ======================================== ;

			GUICtrlSetState($g_hChkUpdateNewUpgradesOnly, $g_ibUpdateNewUpgradesOnly = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
            chkUpdateNewUpgradesOnly()

			; ================================================== BB_DropTrophies - by Chacal GYN (ID70) ================================= ;
					
			GUICtrlSetState($g_hChkBB_DropTrophies, $g_bChkBB_DropTrophies = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtBB_DropTrophies, $g_iTxtBB_DropTrophies)
			ChkBB_DropTrophies()
			TxtBB_DropTrophies()
	EndSwitch

EndFunc   ;==>ApplyConfig_RKMod
