; #FUNCTION# ====================================================================================================================
; Name ..........: Rk Debug GUI Control
; Description ...: This file is used for RK Debug GUI functions of debug will be here.
; Author ........: mmajid
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


Func btnTestHeroBoostOCR()
	SetLog("Test Hero Time OCR", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True

	CheckHeroBoost()

	;Reset to orignal state
	$g_bRunState = $wasRunState

EndFunc   ;==>btnTestHeroBoostOCR

Func btnTestBuilderTimeOCR()
	SetLog("Test Builder Time OCR", $COLOR_DEBUG)

	Local $wasTotalBuilderCount = $g_iTotalBuilderCount
	Local $wasFreeBuilderCount = $g_iFreeBuilderCount
	Local $wasRunState = $g_bRunState

	;For Debug Purpose set these values temporarily
	$g_iTotalBuilderCount = 1
	$g_iFreeBuilderCount = 0
	$g_bRunState = True

	checkMainScreen()
	getBuilderTime()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iTotalBuilderCount = $wasTotalBuilderCount
	$g_iFreeBuilderCount = $wasFreeBuilderCount

EndFunc   ;==>btnTestBuilderTimeOCR

Func btnTestGlobalChatBot()
	SetLog("Test Global Chat Bot", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasChkChatGlobal = $g_iGlobalChat
	Local $wasChkChatClan = $g_iClanChat
	;For Debug Purpose set these values temporarily
	$g_bRunState = True
	$g_iGlobalChat = True
	$g_iClanChat = False

	ChatbotMessage()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iGlobalChat = $wasChkChatGlobal
	$g_iClanChat = $wasChkChatClan

EndFunc   ;==>btnTestGlobalChatBot


Func btnTestClanChatBot()
	SetLog("Test Global Chat Bot", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasChkChatGlobal = $g_iGlobalChat
	Local $wasChkChatClan = $g_iClanChat
	;For Debug Purpose set these values temporarily
	$g_bRunState = True
	$g_iGlobalChat = False
	$g_iClanChat = True

	ChatbotMessage()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iGlobalChat = $wasChkChatGlobal
	$g_iClanChat = $wasChkChatClan

EndFunc   ;==>btnTestClanChatBot

Func btnTestTNRQT()
	SetLog("Test Hero Time OCR", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True

	TNRQT()

	;Reset to orignal state
	$g_bRunState = $wasRunState
EndFunc

Func btnTestCheckOneGem()
	SetLog("Test Check One Gem Boost", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasFirstStart = $g_bFirstStart
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bFirstStart = True

	checkMainScreen()
	OneGemBoost()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_bFirstStart = $wasFirstStart
EndFunc