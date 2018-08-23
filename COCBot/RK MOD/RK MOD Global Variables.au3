; #FUNCTION# ====================================================================================================================
; Name ..........: RK MOD Global Variables
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
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

Global $g_sLastModversion = "" ;latest version from GIT
Global $g_sLastModmessage = "" ;message for last version
Global $g_sOldModversmessage = "" ;warning message for old bot

; ================================================== CSV SPEED - Added by RK MOD =========================================== ;

Global $cmbCSVSpeed[2] = [$LB, $DB]
Global $icmbCSVSpeed[2] = [2, 2]
Global $g_CSVSpeedDivider = 1

; ================================================== Goblin XP - Added by RK MOD =========================================== ;

;SuperXP / GoblinXP
Global $ichkEnableSuperXP = 0, $irbSXTraining = 1, $ichkSXBK = 0, $ichkSXAQ = 0, $ichkSXGW = 0, $iStartXP = 0, $iCurrentXP = 0, $iGainedXP = 0, $iGainedXPHour = 0, $itxtMaxXPtoGain = 500
Global $DebugSX = 0

; [0] = Queen, [1] = Warden, [2] = Barbarian King
; [0][0] = X, [0][1] = Y, [0][2] = XRandomOffset, [0][3] = YRandomOffset
Global $g_DpGoblinPicnic[3][4] = [[300, 205, 5, 5], [340, 140, 5, 5], [290, 220, 5, 5]]
Global $g_BdGoblinPicnic[3] = [0, "5000-7000", "6000-8000"] ; [0] = Queen, [1] = Warden, [2] = Barbarian King
Global $g_ActivatedHeroes[3] = [False, False, False] ; [0] = Queen, [1] = Warden, [2] = Barbarian King , Prevent to click on them to Activate Again And Again
Global Const $g_minStarsToEnd = 1
Global $g_canGainXP = False

; ================================================ Forecast - by RK MOD =============== ;
Global Const $COLOR_DEEPPINK = 0xFF1493
Global Const $COLOR_DARKGREEN = 0x006400
Global $oIE = ObjCreate("Shell.Explorer.2")
Global $grpForecast
Global $ieForecast
Global $dtStamps[0]
Global $lootMinutes[0]
Global $timeOffset = 0
Global $TimerForecast = 0
Global $lootIndexScaleMarkers
Global $currentForecast
Global $chkForecastBoost = 0, $txtForecastBoost = 0
Global $iChkForecastBoost = 0, $iTxtForecastBoost = 6
Global $chkForecastPause = 0, $txtForecastPause = 0
Global $iChkForecastPause = 0, $iTxtForecastPause = 2
Global $cmbForecastHopingSwitchMax = 0, $cmbForecastHopingSwitchMin = 0
Global $chkForecastHopingSwitchMax = 0, $lblForecastHopingSwitchMax = 0, $txtForecastHopingSwitchMax = 2, $chkForecastHopingSwitchMin = 0, $lblForecastHopingSwitchMin = 0, $txtForecastHopingSwitchMin = 0
Global $ichkForecastHopingSwitchMax = 0, $icmbForecastHopingSwitchMax = 0 , $itxtForecastHopingSwitchMax = 2, $ichkForecastHopingSwitchMin = 0, $icmbForecastHopingSwitchMin = 0, $itxtForecastHopingSwitchMin = 2
Global $icmbSwLang = 0
Global $cmbSwLang = 0

; ================================================ Skip Request CC - Added by RK MOD =================================================== ;

Global $g_bSkipRequestCC, $g_iSkipRequestCCTroop, $g_iSkipRequestCCSpell

; ================================================ First Request CC Troops - Added by RK MOD ======================================== ;

Global $g_bReqCCFirst = False

; ================================================ AF_SCID - Added by RK MOD ======================================== ;

;Glabal Variables for Debugging
Global $g_DebugLogAF = 0
Global $g_DebugImageAF = 0

;Global Variables to hold Function Data
Global $g_SwitchSCIDAccFatalErrorAF = False
Global $g_ClkSCIDDisConnBtnAF[4] = [370,215,500,230]
Global $g_ClkSCIDLogOutBtnAF[4] = [605,285,710,310]
Global $g_ClkSCIDConfirmBtnAF[4] = [455,430,615,455]
Global $g_ClkSCIDLoginBtnAF[4] = [120,675,405,700]

Global Const $g_sImgSCIDCross =		@ScriptDir & "\RK MOD\RK AF_SCID\Images\ImgMIS\Cross"
Global Const $g_sImgSCIDAccs =		@ScriptDir & "\RK MOD\RK AF_SCID\Images\ImgAccs"
Global Const $g_sImgSCIDOr =		@ScriptDir & "\RK MOD\RK AF_SCID\Images\ImgMIS\Or"

Global $g_bChkAltuFaltuSCID = False        

; ================================================ AutoCamp - by RK MOD ======================================== ;

Global $g_iChkAutoCamp = 0

; ================================================ Stop For War - Added by RK MOD ======================================== ;
Global $g_bStopForWar
Global $g_iStopTime, $g_bStopBeforeBattle, $g_iReturnTime
Global $g_iStartTimerToRecheck, $g_iTimerToRecheck, $g_sCheckOrStop
Global $g_bTrainWarTroop, $g_bUseQuickTrainWar, $g_aChkArmyWar[3], $g_aiWarCompTroops[$eTroopCount], $g_aiWarCompSpells[$eSpellCount]
Global $g_bRequestCCForWar,	$g_sTxtRequestCCForWar
Global $g_abStopForWar[8]
Global $g_aiStartTimerToRecheck[8], $g_aiTimerToRecheck[8], $g_asCheckOrStop[8]

; ================================================ Bot Humanization - Added by RK MOD ======================================== ;

Global $g_iacmbPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_iacmbMaxSpeed[2] = [1, 1]
Global $g_iacmbPause[2] = [0, 0]
Global $g_iahumanMessage[2] = ["Hello !", "Hello !"]
Global $g_ichallengeMessage = "Can you beat my village?"

Global $g_iMinimumPriority, $g_iMaxActionsNumber, $g_iActionToDo
Global $g_aSetActionPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Global $g_sFrequenceChain =  "Never|Sometimes|Frequently|Often|Very Often"
Global $g_sReplayChain = "1|2|4"
Global $g_ichkUseBotHumanization = 0, $g_ichkUseAltRClick = 0, $g_icmbMaxActionsNumber = 1, $g_ichkCollectAchievements = 0, $g_ichkLookAtRedNotifications = 0

Global $g_aReplayDuration[2] = [0, 0] ; An array, [0] = Minute | [1] = Seconds
Global $g_bOnReplayWindow, $g_iReplayToPause

Global $g_iLastLayout = 0

; ================================================ Grab Healed Heroes - Added by RK MOD ======================================== ;

Global $g_bRestartSearchGrabHero
Global $g_asHeroHealTime[3] = ["", "", ""] 

; ================================================ Switch Profile - Added by RK MOD ======================================== ;

Global $profileString = ""
Global $g_iChkGoldSwitchMax, $g_iTxtMaxGoldAmount, $g_iCmbGoldMaxProfile, $g_iChkGoldSwitchMin, $g_iTxtMinGoldAmount, $g_iCmbGoldMinProfile
Global $g_iChkElixirSwitchMax, $g_iTxtMaxElixirAmount, $g_iCmbElixirMaxProfile, $g_iChkElixirSwitchMin, $g_iTxtMinElixirAmount, $g_iCmbElixirMinProfile
Global $g_iChkDESwitchMax, $g_iTxtMaxDEAmount, $g_iCmbDEMaxProfile, $g_iChkDESwitchMin, $g_iTxtMinDEAmount, $g_iCmbDEMinProfile
Global $g_iChkTrophySwitchMax, $g_iTxtMaxTrophyAmount, $g_iCmbTrophyMaxProfile, $g_iChkTrophySwitchMin, $g_iTxtMinTrophyAmount, $g_iCmbTrophyMinProfile

; ========================= Slot11 - Added by RK MOD (ID193-) =============================================================================================;

Global $g_iTotalAttackSlot = 10, $g_bDraggedAttackBar = False ; flag if AttackBar is dragged or not

; ================================================ NEW ChatBot - by RK MOD ======================================== ;
Global $g_iChkChatGlobal = 0
Global $g_iChkScrambleGlobal = 0
Global $g_iChkSwitchLang = 0
Global $g_iChkChatClan = 0
Global $g_iChkClanUseResponses = 0
Global $g_iChkClanAlwaysMsg = 0
Global $g_iChkUseNotify = 0
Global $g_iChkPbSendNew = 0
Global $g_iChkRusLang = 0
Global $g_iCmbLang = 9
Global $g_iChkClanMessages = ""
Global $g_iChkClanResponses = ""
Global $g_iChkClanResponses0
Global $g_iChkGlobalMessages1 = ""
Global $g_iChkGlobalMessages2 = ""
Global $glb1 
Global $glb2
Global $cResp
Global $cGeneric
Global $ChatbotStartTime
Global $message = ""

;=============================================== Russian Request - by RK MOD ======================================== ;

Global $g_iChkRusLang2 = 0

;=============================================== Max logout time - by RK MOD ======================================== ;

Global $g_bTrainLogoutMaxTime = False, $g_iTrainLogoutMaxTime = 4

;=============================================== Request troops for defense - by RK MOD ============================== ;

Global $g_bRequestTroopsEnableDefense, $g_sRequestTroopsTextDefense, $g_iRequestDefenseEarly 

; ================================================== Boost for Magic Spell by RK MOD ================================= ;

Global $g_iChkBoostBMagic = 0, $g_iCmbBoostBrMagic = 0, $g_iChkBoostCMagic = 0, $g_iCmbBoostClMagic = 0  
Global $g_iXCollect = 0, $g_iYCollect = 0, $g_bCanBoostC = False
Global $g_iLastTime[3] = [0, 0, 0]

; ================================================== Multi Finger - Added by RK MOD ======================================== ;

Global Enum $directionLeft, $directionRight
Global Enum $sideBottomRight, $sideTopLeft, $sideBottomLeft, $sideTopRight
Global Enum $mfRandom, $mfFFStandard, $mfFFSpiralLeft, $mfFFSpiralRight, $mf8FBlossom, $mf8FImplosion, $mf8FPinWheelLeft, $mf8FPinWheelRight

Global $g_iMultiFingerStyle = 1
Global Enum $eCCSpell = $eHaSpell + 1

; ================================================== Unit/Wave Factor  - Added by RK MOD ======================================== ;

Global $g_iChkUnitFactor = 0
Global $g_iTxtUnitFactor = 10
Global $g_iChkWaveFactor = 0
Global $g_iTxtWaveFactor = 100

; ================================================== Check Grand Warden Mode - Added by RK MOD ================================== ;

Global $g_bCheckWardenMode = False, $g_iCheckWardenMode = 0

; ================================================== Upgrade Management - Added by RK MOD ================================== ;

Global $g_ibUpdateNewUpgradesOnly = 0
Global Const $UP = True, $DOWN = False, $TILL_END = True

; ================================================== Fill - Added by RK MOD ================================== ;
Global $g_iSpaceForTroopsFill = 0


; ================================================== GTFO Mod ================================== ;
Global $g_bChkUseGTFO = False, $g_bChkUseKickOut = False, $g_bChkKickOutSpammers = False
Global $g_iTxtMinSaveGTFO_Elixir = 200000, $g_iTxtMinSaveGTFO_DE = 2000, _
	$g_iTxtDonatedCap = 8, $g_iTxtReceivedCap = 35, _
	$g_iTxtKickLimit = 6
Global $g_hTxtClanID, $g_sTxtClanID, $g_iTxtCyclesGTFO
Global $g_bChkGTFOClanHop = False, $g_bChkGTFOReturnClan = False
Global $g_iCycle = 0

; ================================================== Wall/Building Upgrading Priority/Management by RK MOD	======================================== ;

Global $g_iChkUpgrPriority = 0, $g_iCmbUpgrdPriority = 0
Global Const $g_iLimitBreakGE [12] = [2250, 6300, 90000, 450000, 900000, 1800000, 3600000, 5400000, 7200000, 7650000, 9000000, 10800000];Gold And Elixir Town Hall Level max resource storages at 90%
Global Const $g_iLimitBreakDE [12] = [0, 0, 0, 0, 0, 0, 18000, 72000, 171000, 180000, 180000, 216000];Dark Elixir Town Hall Level max resource storage at 90%

; ================================================== SmartTrain - RK MOD (Demen) ======================================== ;

Global $g_bChkSmartTrain = False, $g_bChkPreciseArmyCamp = False, $g_bChkFillArcher = False, $g_bChkFillEQ = False, $g_iTxtFillArcher = 5
Global Enum $g_eFull, $g_eRemained, $g_eNoTrain
Global $g_bWrongTroop, $g_bWrongSpell, $g_sSmartTrainError = ""

; ================================================== ; Return Home by Time - by RK MOD  ======================================== ;

Global $g_bReturnTimerEnable = False, $g_iTxtReturnTimer = 5