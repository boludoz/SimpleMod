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

; ================================================ First Request CC Troops - Added by RK MOD ======================================== ;

Global $g_bReqCCFirst = False

; ================================================ AutoCamp - by RK MOD ======================================== ;

Global $g_bChkAutoCamp = False

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


; ================================================ Switch Profile - Added by RK MOD ======================================== ;

Global $profileString = ""
Global $g_iChkGoldSwitchMax, $g_iTxtMaxGoldAmount, $g_iCmbGoldMaxProfile, $g_iChkGoldSwitchMin, $g_iTxtMinGoldAmount, $g_iCmbGoldMinProfile
Global $g_iChkElixirSwitchMax, $g_iTxtMaxElixirAmount, $g_iCmbElixirMaxProfile, $g_iChkElixirSwitchMin, $g_iTxtMinElixirAmount, $g_iCmbElixirMinProfile
Global $g_iChkDESwitchMax, $g_iTxtMaxDEAmount, $g_iCmbDEMaxProfile, $g_iChkDESwitchMin, $g_iTxtMinDEAmount, $g_iCmbDEMinProfile
Global $g_iChkTrophySwitchMax, $g_iTxtMaxTrophyAmount, $g_iCmbTrophyMaxProfile, $g_iChkTrophySwitchMin, $g_iTxtMinTrophyAmount, $g_iCmbTrophyMinProfile

; ========================= Slot11 - Added by RK MOD (ID193-) =============================================================================================;

Global $g_iTotalAttackSlot = 10, $g_bDraggedAttackBar = False ; flag if AttackBar is dragged or not

; ================================================ NEW ChatBot - by RK MOD ======================================== ;
Global $g_bChkChatGlobal = False
Global $g_bChkScrambleGlobal = False
Global $g_bChkSwitchLang = False
Global $g_bChkChatClan = False
Global $g_bChkClanUseResponses = False
Global $g_bChkClanAlwaysMsg = False
Global $g_bChkUseNotify = False
Global $g_bChkPbSendNew = False
Global $g_bChkRusLang = False
Global $g_iCmbLang = 9
Global $g_bChkCleverbot = False
Global $g_bChkDelayTime = False
Global $g_iTxtDelayTime = 10
Global $g_iChkClanMessages = ""
Global $g_iChkClanResponses = ""
Global $g_iChkClanResponses0
Global $g_iChkGlobalMessages1 = ""
Global $g_iChkGlobalMessages2 = ""
Global $g_sGlobalChatLastMsgSentTime = ""
Global $glb1
Global $glb2
Global $cResp
Global $cGeneric
Global $ChatbotStartTime
Global $g_sMessage = ""

;=============================================== Russian Request - by RK MOD ======================================== ;

Global $g_bChkRusLang2 = False

;=============================================== Max logout time - by RK MOD ======================================== ;

Global $g_bTrainLogoutMaxTime = False, $g_iTrainLogoutMaxTime = 4

;=============================================== Request troops for defense - by RK MOD ============================== ;

Global $g_bRequestCCDefense, $g_sRequestCCDefenseText, $g_bRequestCCDefenseWhenPB, $g_iRequestDefenseTime

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
Global Const $g_iLimitBreakGE[12] = [2250, 6300, 90000, 450000, 900000, 1800000, 3600000, 5400000, 7200000, 7650000, 9000000, 10800000];Gold And Elixir Town Hall Level max resource storages at 90%
Global Const $g_iLimitBreakDE[12] = [0, 0, 0, 0, 0, 0, 18000, 72000, 171000, 180000, 180000, 216000];Dark Elixir Town Hall Level max resource storage at 90%

; ================================================== ; Return Home by Time - by RK MOD  ======================================== ;

Global $g_bReturnTimerEnable = False, $g_iTxtReturnTimer = 5

; ================================================== One Gem Boost by RK MOD ================================= ;

Global $g_bChkOneGemBoostBarracks = False, $g_bChkOneGemBoostSpells = False, $g_bChkOneGemBoostHeroes = False

; ================================================== Builder Base Drop Trophies (ID70) ================================= ;

Global $g_iTxtBB_DropTrophies = 0
Global $g_bChkBB_DropTrophies = False
Global $aBB_FindMatchButton[4] = [555, 240 + $g_iBottomOffsetY, 0xFFC346, 10]
Global $aBB_FindMatchButtonRND[4] = [545, 230 + $g_iMidOffsetY, 565, 250 + $g_iMidOffsetY]

; ================================================== SmartTrain - RK MOD (Demen) ======================================== ;

Global $g_bChkSmartTrain = False, $g_bChkPreciseArmyCamp = False, $g_bChkFillArcher = False, $g_bChkFillEQ = False, $g_iTxtFillArcher = 5
Global Enum $g_eFull, $g_eRemained, $g_eNoTrain
Global $g_bWrongTroop, $g_bWrongSpell, $g_sSmartTrainError = ""

; ================================================== ; Attack Priority - by RK MOD  ======================================== ;

Global $g_bChkAttackPriority = False

; ================================================== ; HeroBoost Time - by RK MOD  ======================================== ;

Global $CTime[8][3] = [["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""]]
Global $CurrHeroBTime[3] = ["", "", ""]

; ================================================== ; Priority System - by RK MOD  ======================================== ;

Global $g_bChkPrioritySystem = False, $g_iCmbPrioritySystem = 0
Global $g_iUpgradeLevel[32][3] = [["LevelTroop", "Barb", 8], ["LevelTroop", "Arch", 8], ["LevelTroop", "Giant", 9], ["LevelTroop", "Gobl", 7], ["LevelTroop", "Wall", 8], ["LevelTroop", "Ball", 8], ["LevelTroop", "Wiza", 9], ["LevelTroop", "Heal", 5], ["LevelTroop", "Drag", 7], ["LevelTroop", "Pekk", 8], ["LevelTroop", "BabyD", 6], ["LevelTroop", "Mine", 6], ["LevelTroop", "EDrag", 3], ["LevelSpell", "LSpell", 7], ["LevelSpell", "HSpell", 7], ["LevelSpell", "RSpell", 5], ["LevelSpell", "JSpell", 3], ["LevelSpell", "FSpell", 7], ["LevelSpell", "CSpell", 5], ["LevelSpell", "PSpell", 5], ["LevelSpell", "ESpell", 4], ["LevelSpell", "HaSpell", 4], ["LevelSpell", "SkSpell", 5], ["LevelTroop", "Mini", 8], ["LevelTroop", "Hogs", 8], ["LevelTroop", "Valk", 7], ["LevelTroop", "Gole", 8], ["LevelTroop", "Witc", 4], ["LevelTroop", "Lava", 5], ["LevelTroop", "Bowl", 4], ["LevelSiege", "WallW", 3], ["LevelSiege", "BattleB", 3]]
Global $g_iLabCost[32][10] = [ _
		[0, 50000, 150000, 500000, 1500000, 4500000, 6000000, 8000000, "Max", "Max"], _				 ;Barbarian
		[0, 50000, 250000, 750000, 2250000, 6000000, 7500000, 9000000, "Max", "Max"], _  			 ;Archer
		[0, 100000, 250000, 750000, 2250000, 5000000, 6000000, 9500000, 12000000, "Max"], _  		 ;Giant
		[0, 50000, 250000, 750000, 2250000, 4500000, 6750000, "Max", "Max", "Max"], _  				 ;Goblin
		[0, 100000, 250000, 750000, 200000, 6000000, 9000000, 12000000, "Max", "Max"], _ 			 ;Wall Breaker
		[0, 150000, 450000, 1350000, 2500000, 6000000, 9500000, 12000000, "Max", "Max"], _  		 ;Balloon
		[0, 150000, 450000, 1350000, 2500000, 5000000, 7000000, 9000000, 11000000, "Max"], _ 	 	 ;Wizard
		[0, 750000, 1500000, 3000000, 9500000, "Max", "Max", "Max", "Max", "Max"], _  				 ;Healer
		[0, 2000000, 3000000, 5000000, 7000000, 9000000, 11000000, "Max", "Max", "Max"], _ 			 ;Dragon
		[0, 3000000, 5000000, 6000000, 7500000, 85000000, 10000000, 12000000, "Max", "Max"], _ 		 ;Pekka
		[0, 5000000, 6000000, 7000000, 8000000, 9000000, "Max", "Max", "Max", "Max"], _ 			 ;Baby Dragon
		[0, 6000000, 7000000, 8000000, 9500000, 11000000, "Max", "Max", "Max", "Max"], _ 			 ;Miner
		[0, 9000000, 11000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 					 ;Electro Dragon
		[0, 200000, 500000, 1000000, 2000000, 6000000, 8000000, "Max", "Max", "Max"], _ 			 ;Lightning Spell
		[0, 300000, 600000, 1200000, 2000000, 4000000, 6000000, "Max", "Max", "Max"], _ 			 ;Healing Spell
		[0, 450000, 900000, 1800000, 3000000, "Max", "Max", "Max", "Max", "Max"], _  				 ;Rage Spell
		[0, 3000000, 6000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 			 		 ;Jump Spell
		[0, 3000000, 4000000, 5000000, 7000000, 9500000, 11000000, "Max", "Max", "Max"], _  		 ;Freeze Spell
		[0, 4000000, 6000000, 8000000, 10000000, "Max", "Max", "Max", "Max", "Max"], _  			 ;Clone Spell
		[0, 25000, 50000, 75000, 150000, "Max", "Max", "Max", "Max", "Max"], _  					 ;Poison Spell
		[0, 30000, 60000, 90000, "Max", "Max", "Max", "Max", "Max", "Max"], _ 						 ;Earthquake Spell
		[0, 40000, 80000, 100000, "Max", "Max", "Max", "Max", "Max", "Max"], _ 						 ;Haste Spell
		[0, 50000, 75000, 100000, 125000, "Max", "Max", "Max", "Max", "Max"], _  					 ;Skeleton Spell
		[0, 10000, 20000, 30000, 40000, 100000, 140000, 180000, "Max", "Max"], _  					 ;Minion
		[0, 20000, 30000, 40000, 50000, 100000, 150000, 200000, "Max", "Max"], _  					 ;Hog Rider
		[0, 50000, 60000, 70000, 110000, 150000, 190000, "Max", "Max", "Max"], _ 					 ;Valkerie
		[0, 60000, 70000, 80000, 90000, 150000, 200000, 200000, "Max", "Max"], _  					 ;Golem
		[0, 75000, 160000, 200000, "Max", "Max", "Max", "Max", "Max", "Max"], _  					 ;Witch
		[0, 60000, 70000, 150000, 200000, "Max", "Max", "Max", "Max", "Max"], _ 					 ;Lavahound
		[0, 120000, 200000, 200000, "Max", "Max", "Max", "Max", "Max", "Max"], _  					 ;Bowler
		[0, 6000000, 8000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _  					 ;Wall Wrecker
		[0, 6000000, 8000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"]] ;Battle Blimp


; ================================================== ; TNRQT - by RK MOD  ======================================== ;

GLobal $TroopsQueueFull = False