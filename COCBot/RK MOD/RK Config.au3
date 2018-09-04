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

	IniReadS($g_bChkGoldSwitchMax, $g_sProfileConfigPath, "profiles", "GoldSwitchMax", $g_bChkGoldSwitchMax, "Bool")
	IniReadS($g_iCmbGoldMaxProfile, $g_sProfileConfigPath, "profiles", "GoldMaxProfile", $g_iCmbGoldMaxProfile, "int")
	IniReadS($g_iTxtMaxGoldAmount, $g_sProfileConfigPath, "profiles", "MaxGoldAmount", $g_iTxtMaxGoldAmount, "int")
	IniReadS($g_bChkGoldSwitchMin, $g_sProfileConfigPath, "profiles", "GoldSwitchMin", $g_bChkGoldSwitchMin, "Bool")
	IniReadS($g_iCmbGoldMinProfile, $g_sProfileConfigPath, "profiles", "GoldMinProfile", $g_iCmbGoldMinProfile, "int")
	IniReadS($g_iTxtMinGoldAmount, $g_sProfileConfigPath, "profiles", "MinGoldAmount", $g_iTxtMinGoldAmount, "int")

	IniReadS($g_bChkElixirSwitchMax, $g_sProfileConfigPath, "profiles", "ElixirSwitchMax", $g_bChkElixirSwitchMax, "Bool")
	IniReadS($g_iCmbElixirMaxProfile, $g_sProfileConfigPath, "profiles", "ElixirMaxProfile", $g_iCmbElixirMaxProfile, "int")
	IniReadS($g_iTxtMaxElixirAmount, $g_sProfileConfigPath, "profiles", "MaxElixirAmount", $g_iTxtMaxElixirAmount, "int")
	IniReadS($g_bChkElixirSwitchMin, $g_sProfileConfigPath, "profiles", "ElixirSwitchMin", $g_bChkElixirSwitchMin, "Bool")
	IniReadS($g_iCmbElixirMinProfile, $g_sProfileConfigPath, "profiles", "ElixirMinProfile", $g_iCmbElixirMinProfile, "int")
	IniReadS($g_iTxtMinElixirAmount, $g_sProfileConfigPath, "profiles", "MinElixirAmount", $g_iTxtMinElixirAmount, "int")

	IniReadS($g_bChkDESwitchMax, $g_sProfileConfigPath, "profiles", "DESwitchMax", $g_bChkDESwitchMax, "Bool")
	IniReadS($g_iCmbDEMaxProfile, $g_sProfileConfigPath, "profiles", "DEMaxProfile", $g_iCmbDEMaxProfile, "Bool")
	IniReadS($g_iTxtMaxDEAmount, $g_sProfileConfigPath, "profiles", "MaxDEAmount", $g_iTxtMaxDEAmount, "int")
	IniReadS($g_bChkDESwitchMin, $g_sProfileConfigPath, "profiles", "DESwitchMin", $g_bChkDESwitchMin, "Bool")
	IniReadS($g_iCmbDEMinProfile, $g_sProfileConfigPath, "profiles", "DEMinProfile", $g_iCmbDEMinProfile, "int")
	IniReadS($g_iTxtMinDEAmount, $g_sProfileConfigPath, "profiles", "MinDEAmount", $g_iTxtMinDEAmount, "int")

	IniReadS($g_bChkTrophySwitchMax, $g_sProfileConfigPath, "profiles", "TrophySwitchMax", $g_bChkTrophySwitchMax, "Bool")
	IniReadS($g_iCmbTrophyMaxProfile, $g_sProfileConfigPath, "profiles", "TrophyMaxProfile", $g_iCmbTrophyMaxProfile, "int")
	IniReadS($g_iTxtMaxTrophyAmount, $g_sProfileConfigPath, "profiles", "MaxTrophyAmount", $g_iTxtMaxTrophyAmount, "int")
	IniReadS($g_bChkTrophySwitchMin, $g_sProfileConfigPath, "profiles", "TrophySwitchMin", $g_bChkTrophySwitchMin, "Bool")
	IniReadS($g_iCmbTrophyMinProfile, $g_sProfileConfigPath, "profiles", "TrophyMinProfile", $g_iCmbTrophyMinProfile, "int")
	IniReadS($g_iTxtMinTrophyAmount, $g_sProfileConfigPath, "profiles", "MinTrophyAmount", $g_iTxtMinTrophyAmount, "int")

	; ================================================== NEW ChatBot - by RK MOD ================================= ;

	;IniReadS($g_bChkChatGlobal, $g_sProfileConfigPath, "Chatbot", "ChkChatGlobal", False, "Bool")
	;IniReadS($g_bChkScrambleGlobal, $g_sProfileConfigPath, "Chatbot", "ChkScrambleGlobal", False, "Bool") 	
	;IniReadS($g_bChkDelayTime, $g_sProfileConfigPath, "Chatbot", "ChkDelayTime", False, "Bool")
    ;IniReadS($g_iTxtDelayTime, $g_sProfileConfigPath, "Chatbot", "TxtDelayTime", $g_iTxtDelayTime)
	;IniReadS($g_bChkSwitchLang, $g_sProfileConfigPath, "Chatbot", "ChkSwitchLang", False, "Bool")
	;IniReadS($g_iCmbLang, $g_sProfileConfigPath, "Chatbot", "CmbLang", $g_iCmbLang, "int")	
	;IniReadS($g_bChkRusLang, $g_sProfileConfigPath, "Chatbot", "ChkRusLang", False, "Bool")	
	;IniReadS($g_bChkChatClan, $g_sProfileConfigPath, "Chatbot", "ChkChatClan", False, "Bool")	
	;IniReadS($g_bChkClanUseResponses, $g_sProfileConfigPath, "Chatbot", "ChkUseResponses", False, "Bool")
	;IniReadS($g_bChkClanAlwaysMsg, $g_sProfileConfigPath, "Chatbot", "ChkUseGeneric", False, "Bool")
	;IniReadS($g_bChkCleverbot, $g_sProfileConfigPath, "Chatbot", "ChkCleverbot", False, "Bool")
	;IniReadS($g_bChkUseNotify, $g_sProfileConfigPath, "Chatbot", "ChkChatNotify", False, "Bool")
	;IniReadS($g_bChkPbSendNew, $g_sProfileConfigPath, "Chatbot", "ChkPbSendNewChats", False, "Bool")

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

	_Ini_Add("profiles", "GoldSwitchMax", $g_bChkGoldSwitchMax ? True : False)
	_Ini_Add("profiles", "GoldMaxProfile", $g_iCmbGoldMaxProfile)
	_Ini_Add("profiles", "MaxGoldAmount", $g_iTxtMaxGoldAmount)
	_Ini_Add("profiles", "GoldSwitchMin", $g_bChkGoldSwitchMin ? True : False)
	_Ini_Add("profiles", "GoldMinProfile", $g_iCmbGoldMinProfile)
	_Ini_Add("profiles", "MinGoldAmount", $g_iTxtMinGoldAmount)

	_Ini_Add("profiles", "ElixirSwitchMax", $g_bChkElixirSwitchMax ? True : False)
	_Ini_Add("profiles", "ElixirMaxProfile", $g_iCmbElixirMaxProfile)
	_Ini_Add("profiles", "MaxElixirAmount", $g_iTxtMaxElixirAmount)
	_Ini_Add("profiles", "ElixirSwitchMin", $g_bChkElixirSwitchMin ? True : False)
	_Ini_Add("profiles", "ElixirMinProfile", $g_iCmbElixirMinProfile)
	_Ini_Add("profiles", "MinElixirAmount", $g_iTxtMinElixirAmount)

	_Ini_Add("profiles", "DESwitchMax", $g_bChkDESwitchMax ? True : False)
	_Ini_Add("profiles", "DEMaxProfile", $g_iCmbDEMaxProfile)
	_Ini_Add("profiles", "MaxDEAmount", $g_iTxtMaxDEAmount)
	_Ini_Add("profiles", "DESwitchMin", $g_bChkDESwitchMin ? True : False)
	_Ini_Add("profiles", "DEMinProfile", $g_iCmbDEMinProfile)
	_Ini_Add("profiles", "MinDEAmount", $g_iTxtMinDEAmount)

	_Ini_Add("profiles", "TrophySwitchMax", $g_bChkTrophySwitchMax ? True : False)
	_Ini_Add("profiles", "TrophyMaxProfile", $g_iCmbTrophyMaxProfile)
	_Ini_Add("profiles", "MaxTrophyAmount", $g_iTxtMaxTrophyAmount)
	_Ini_Add("profiles", "TrophySwitchMin", $g_bChkTrophySwitchMin ? True : False)
	_Ini_Add("profiles", "TrophyMinProfile", $g_iCmbTrophyMinProfile)
	_Ini_Add("profiles", "MinTrophyAmount", $g_iTxtMinTrophyAmount)

	; ================================================== NEW ChatBot - by RK MOD ================================= ;

	;_Ini_Add("Chatbot", "ChkChatGlobal", $g_bChkChatGlobal ? True : False)	
	;_Ini_Add("Chatbot", "ChkScrambleGlobal", $g_bChkScrambleGlobal ? True : False)  
    ;_Ini_Add("Chatbot", "ChkDelayTime", $g_bChkDelayTime ? True : False)	
    ;_Ini_Add("Chatbot", "TxtDelayTime", $g_iTxtDelayTime)	
    ;_Ini_Add("Chatbot", "ChkSwitchLang", $g_bChkSwitchLang ? True : False)
	;_Ini_Add("Chatbot", "CmbLang", _GUICtrlComboBox_GetCurSel($g_hCmbLang))	
	;_Ini_Add("Chatbot", "ChkRusLang", $g_bChkRusLang ? True : False)	
	;_Ini_Add("Chatbot", "ChkChatClan", $g_bChkChatClan ? True : False)
	;
	;_Ini_Add("Chatbot", "ChkUseResponses", $g_bChkClanUseResponses ? True : False)
	;_Ini_Add("Chatbot", "ChkUseGeneric", $g_bChkClanAlwaysMsg ? True : False)
	;_Ini_Add("Chatbot", "ChkCleverbot", $g_bChkCleverbot ? True : False)
	;_Ini_Add("Chatbot", "ChkChatNotify", $g_bChkUseNotify ? True : False)
	;_Ini_Add("Chatbot", "ChkPbSendNewChats", $g_bChkPbSendNew ? True : False)
    ;
    ;_Ini_Add("Chatbot", "globalMsg1", $glb1)
	;_Ini_Add("Chatbot", "globalMsg2", $glb2)
	;_Ini_Add("Chatbot", "genericMsgClan", $cGeneric)
	;_Ini_Add("Chatbot", "responseMsgClan", $cResp)

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

			$g_bChkGoldSwitchMax = (GUICtrlRead($g_hChkGoldSwitchMax) = $GUI_CHECKED)
			$g_iCmbGoldMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMaxProfile)
			$g_iTxtMaxGoldAmount = GUICtrlRead($g_hTxtMaxGoldAmount)
			$g_bChkGoldSwitchMin = (GUICtrlRead($g_hChkGoldSwitchMin) = $GUI_CHECKED)
			$g_iCmbGoldMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMinProfile)
			$g_iTxtMinGoldAmount = GUICtrlRead($g_hTxtMinGoldAmount)

			$g_bChkElixirSwitchMax = (GUICtrlRead($g_hChkElixirSwitchMax) = $GUI_CHECKED)
			$g_iCmbElixirMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMaxProfile)
			$g_iTxtMaxElixirAmount = GUICtrlRead($g_hTxtMaxElixirAmount)
			$g_bChkElixirSwitchMin = (GUICtrlRead($g_hChkElixirSwitchMin) = $GUI_CHECKED)
			$g_iCmbElixirMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMinProfile)
			$g_iTxtMinElixirAmount = GUICtrlRead($g_hTxtMinElixirAmount)

			$g_bChkDESwitchMax = (GUICtrlRead($g_hChkDESwitchMax) = $GUI_CHECKED)
			$g_iCmbDEMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMaxProfile)
			$g_iTxtMaxDEAmount = GUICtrlRead($g_hTxtMaxDEAmount)
			$g_bChkDESwitchMin = (GUICtrlRead($g_hChkDESwitchMin) = $GUI_CHECKED)
			$g_iCmbDEMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMinProfile)
			$g_iTxtMinDEAmount = GUICtrlRead($g_hTxtMinDEAmount)

			$g_bChkTrophySwitchMax = (GUICtrlRead($g_hChkTrophySwitchMax) = $GUI_CHECKED)
			$g_iCmbTrophyMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMaxProfile)
			$g_iTxtMaxTrophyAmount = GUICtrlRead($g_hTxtMaxTrophyAmount)
			$g_bChkTrophySwitchMin = (GUICtrlRead($g_hChkTrophySwitchMin) = $GUI_CHECKED)
			$g_iCmbTrophyMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMinProfile)
			$g_iTxtMinTrophyAmount = GUICtrlRead($g_hTxtMinTrophyAmount)

			; ================================================== NEW ChatBot - by RK MOD ================================= ;

			;$g_bChkChatGlobal = (GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED)
			;$g_bChkScrambleGlobal = (GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED)			
		    ;$g_bChkDelayTime = (GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED)
            ;$g_iTxtDelayTime = GUICtrlRead($g_hTxtDelayTime)			
			;$g_bChkSwitchLang = (GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED) 
			;$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)			
			;$g_bChkRusLang = (GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED)			
			;$g_bChkChatClan = (GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED)				
			;$g_bChkClanUseResponses = (GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED)
			;$g_bChkClanAlwaysMsg = (GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED) 
			;$g_bChkCleverbot = (GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED)
			;$g_bChkUseNotify = (GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED)
			;$g_bChkPbSendNew = (GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED)

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

			GUICtrlSetState($g_hChkGoldSwitchMax, $g_bChkGoldSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMaxProfile, $g_iCmbGoldMaxProfile)
			GUICtrlSetData($g_hTxtMaxGoldAmount, $g_iTxtMaxGoldAmount)
			chkGoldSwitchMax()

			GUICtrlSetState($g_hChkGoldSwitchMin, $g_bChkGoldSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMinProfile, $g_iCmbGoldMinProfile)
			GUICtrlSetData($g_hTxtMinGoldAmount, $g_iTxtMinGoldAmount)
            chkGoldSwitchMin()
			 
			GUICtrlSetState($g_hChkElixirSwitchMax, $g_bChkElixirSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMaxProfile, $g_iCmbElixirMaxProfile)
			GUICtrlSetData($g_hTxtMaxElixirAmount, $g_iTxtMaxElixirAmount)
			chkElixirSwitchMax()
			
			GUICtrlSetState($g_hChkElixirSwitchMin, $g_bChkElixirSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMinProfile, $g_iCmbElixirMinProfile)
			GUICtrlSetData($g_hTxtMinElixirAmount, $g_iTxtMinElixirAmount)
            chkElixirSwitchMin()
			
			GUICtrlSetState($g_hChkDESwitchMax, $g_bChkDESwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMaxProfile, $g_iCmbDEMaxProfile)
			GUICtrlSetData($g_hTxtMaxDEAmount, $g_iTxtMaxDEAmount)
			chkDESwitchMax()
			
			GUICtrlSetState($g_hChkDESwitchMin, $g_bChkDESwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMinProfile, $g_iCmbDEMinProfile)
			GUICtrlSetData($g_hTxtMinDEAmount, $g_iTxtMinDEAmount)
            chkDESwitchMin()
			
			GUICtrlSetState($g_hChkTrophySwitchMax, $g_bChkTrophySwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMaxProfile, $g_iCmbTrophyMaxProfile)
			GUICtrlSetData($g_hTxtMaxTrophyAmount, $g_iTxtMaxTrophyAmount)
			chkTrophySwitchMax()
			
			GUICtrlSetState($g_hChkTrophySwitchMin, $g_bChkTrophySwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMinProfile, $g_iCmbTrophyMinProfile)
			GUICtrlSetData($g_hTxtMinTrophyAmount, $g_iTxtMinTrophyAmount)
			chkTrophySwitchMin()

			; ================================================== NEW ChatBot - by RK MOD ======================================== ;

			;GUICtrlSetState($g_hChkGlobalChat, $g_bChkChatGlobal ? $GUI_CHECKED : $GUI_UNCHECKED)
			;GUICtrlSetState($g_hChkGlobalScramble, $g_bChkScrambleGlobal ? $GUI_CHECKED : $GUI_UNCHECKED)			
			;GUICtrlSetState($g_hChkDelayTime, $g_bChkDelayTime ? $GUI_CHECKED : $GUI_UNCHECKED)
            ;GUICtrlSetData($g_hTxtDelayTime, $g_iTxtDelayTime)			
			;GUICtrlSetState($g_hChkSwitchLang, $g_bChkSwitchLang ? $GUI_CHECKED : $GUI_UNCHECKED)
			;_GUICtrlComboBox_SetCurSel($g_hCmbLang, $g_iCmbLang)			
			;GUICtrlSetState($g_hChkRusLang, $g_bChkRusLang ? $GUI_CHECKED : $GUI_UNCHECKED)			
			;GUICtrlSetState($g_hChkClanChat, $g_bChkChatClan ? $GUI_CHECKED : $GUI_UNCHECKED)		
			;GUICtrlSetState($g_hChkUseResponses, $g_bChkClanUseResponses ? $GUI_CHECKED : $GUI_UNCHECKED)
			;GUICtrlSetState($g_hChkUseGeneric, $g_bChkClanAlwaysMsg ? $GUI_CHECKED : $GUI_UNCHECKED)
			;GUICtrlSetState($g_hChkCleverbot, $g_bChkCleverbot ? $GUI_CHECKED : $GUI_UNCHECKED)
			;GUICtrlSetState($g_hChkChatNotify, $g_bChkUseNotify ? $GUI_CHECKED : $GUI_UNCHECKED)
			;GUICtrlSetState($g_hChkPbSendNewChats, $g_bChkPbSendNew ? $GUI_CHECKED : $GUI_UNCHECKED)











   
			
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
