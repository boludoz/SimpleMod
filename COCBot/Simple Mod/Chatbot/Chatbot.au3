; #FUNCTION# ====================================================================================================================
; Name ..........: NEW Chatbot by Simple Mod
; Description ...: This file Read/Save/Apply Simple Mods settings
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by Simple Mod
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>

Func ChatbotReadMessages()
	If IniRead($sChatIni, "ChatSelector", "GlobalChatGUI", "False") = "True" Then $g_bGlobalChatGUI = True
	If IniRead($sChatIni, "ChatSelector", "ClanChatGUI", "False") = "True" Then $g_bClanChatGUI = True
	If IniRead($sChatIni, "ChatSelector", "ChallengeChatGUI", "False") = "True" Then $g_bChallengeChatGUI = True

	If IniRead($sChatIni, "ChatGlobal", "Enable", "False") = "True" Then $g_bChkChatGlobal = True
	If IniRead($sChatIni, "ChatGlobal", "Scramble", "False") = "True" Then $g_bChkScrambleGlobal = True
	If IniRead($sChatIni, "ChatGlobal", "SwitchLang", "False") = "True" Then $g_bChkSwitchLang = True
    $g_iRusLang = IniRead($sChatIni, "Lang", "RusLang", "0")
    $g_iCmbLang = IniRead($sChatIni, "Lang", "cmbLang", "8")
	If IniRead($sChatIni, "ChatClan", "Enable", "False") = "True" Then $g_bChkChatClan = True
	If IniRead($sChatIni, "ChatClan", "Responses", "False") = "True" Then $g_bChkClanUseResponses = True
	If IniRead($sChatIni, "ChatClan", "Generic", "False") = "True" Then $g_bChkClanAlwaysMsg = True
	If IniRead($sChatIni, "ChatClan", "ChatPushbullet", "False") = "True" Then $g_iChatPushbullet = True
	If IniRead($sChatIni, "ChatClan", "PbSendNewChats", "False") = "True" Then $g_iPbSendNewChats = True
	If IniRead($sChatIni, "ChatClan", "ChkCleverbot", "False") = "True" Then $g_bChkCleverbot = True
	If IniRead($sChatIni, "ChatGlobal", "ChkDelayTime", "False") = "True" Then $g_bChkDelayTime = True
    $g_iTxtDelayTime = IniRead($sChatIni, "ChatGlobal", "TxtDelayTime", "10") 
	
	; Challenge
	
	If IniRead($sChatIni, "ChatChallenge", "ChkChngOn", "False") = "True" Then $g_bChkChngOn = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkDelayChng", "False") = "True" Then $g_bChkDelayChng = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage1", "False") = "True" Then $g_bChkVillage1 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage4", "False") = "True" Then $g_bChkVillage4 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage2", "False") = "True" Then $g_bChkVillage2 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage5", "False") = "True" Then $g_bChkVillage5 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage3", "False") = "True" Then $g_bChkVillage3 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkVillage6", "False") = "True" Then $g_bChkVillage6 = True       
	If IniRead($sChatIni, "ChatChallenge", "ChkAttackChng", "False") = "True" Then $g_bChkAttackChng = True       
	
	
	$sClanMessages = StringSplit(IniRead($sChatIni, "ChatClan", "GenericMessages", "Testing on Chat|Hey all"), "|", 2)
	Global $g_sClanResponses0 = StringSplit(IniRead($sChatIni, "ChatClan", "ResponseMessages", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
	Global $g_sClanResponses1[UBound($g_sClanResponses0)][2]
	For $a = 0 To UBound($g_sClanResponses0) - 1
		Local $TmpResp = StringSplit($g_sClanResponses0[$a], ":", 2)
		If UBound($TmpResp) > 0 Then
			$g_sClanResponses1[$a][0] = $TmpResp[0]
		Else
			$g_sClanResponses1[$a][0] = "<invalid>"
		EndIf
		If UBound($TmpResp) > 1 Then
			$g_sClanResponses1[$a][1] = $TmpResp[1]
		Else
			$g_sClanResponses1[$a][1] = "<undefined>"
		EndIf
	Next

	$g_sClanResponses = $g_sClanResponses1

	$GlobalMessages[0] = IniRead($sChatIni, "ChatGlobal", "GlobalMessages1" , "War Clan Recruiting|Active War Clan accepting applications")
	$GlobalMessages[1] = IniRead($sChatIni, "ChatGlobal", "GlobalMessages2", "Join now|Apply now")
	$GlobalMessages[2] = IniRead($sChatIni, "ChatGlobal", "GlobalMessages3", "250 war stars min|Must have 250 war stars")
	$GlobalMessages[3] = IniRead($sChatIni, "ChatGlobal", "GlobalMessages4", "Adults Only| 18+")

	$GlobalMessagesGUI_0 = StringSplit($GlobalMessages[0], "|", 2)
	$GlobalMessagesGUI_1 = StringSplit($GlobalMessages[1], "|", 2)
	$GlobalMessagesGUI_2 = StringSplit($GlobalMessages[2], "|", 2)
	$GlobalMessagesGUI_3 = StringSplit($GlobalMessages[3], "|", 2)

EndFunc   ;==>ChatbotReadMessages

Func ChatbotGUICheckbox()
	$g_bGlobalChatGUI = GUICtrlRead($g_hGlobalChatGUI) = $GUI_CHECKED
	$g_bClanChatGUI = GUICtrlRead($g_hClanChatGUI) = $GUI_CHECKED
	$g_bChallengeChatGUI = GUICtrlRead($g_hChallengeChatGUI) = $GUI_CHECKED

	$g_bChkChatGlobal = GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED
	$g_bChkScrambleGlobal = GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED
	$g_bChkSwitchLang = GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED

	$g_bChkChatClan = GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED
	$g_bChkClanUseResponses = GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED
	$g_bChkClanAlwaysMsg = GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED
	$g_iChatPushbullet = GUICtrlRead($g_hChkChatPushbullet) = $GUI_CHECKED
	$g_iPbSendNewChats = GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED
    If GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED Then
		$g_iRusLang = 1
	Else
		$g_iRusLang = 0
	EndIf
	$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)
	$g_iTxtDelayTime = GUICtrlRead($g_hTxtDelayTime)
	$g_bChkCleverbot = GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED
	$g_bChkDelayTime = GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED
	$g_bChkDelayTime = GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED
	$g_bChkCleverbot = GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED
	
	; Challenge
	$g_bChkChngOn     = GUICtrlRead($g_hChkChngOn) = $GUI_CHECKED
	$g_bChkDelayChng  = GUICtrlRead($g_hChkDelayChng) = $GUI_CHECKED	
	$g_bChkVillage1   = GUICtrlRead($g_hChkVillage1) = $GUI_CHECKED	
	$g_bChkVillage4   = GUICtrlRead($g_hChkVillage4) = $GUI_CHECKED	
	$g_bChkVillage2   = GUICtrlRead($g_hChkVillage2) = $GUI_CHECKED	
	$g_bChkVillage5   = GUICtrlRead($g_hChkVillage5) = $GUI_CHECKED	
	$g_bChkVillage3   = GUICtrlRead($g_hChkVillage3) = $GUI_CHECKED	
	$g_bChkVillage6   = GUICtrlRead($g_hChkVillage6) = $GUI_CHECKED	
	$g_bChkAttackChng = GUICtrlRead($g_hChkAttackChng) = $GUI_CHECKED	
	
	IniWrite($sChatIni, "ChatSelector", "GlobalChatGUI", $g_bGlobalChatGUI)
	IniWrite($sChatIni, "ChatSelector", "ClanChatGUI", $g_bClanChatGUI)
	IniWrite($sChatIni, "ChatSelector", "ChallengeChatGUI", $g_bChallengeChatGUI)
	
	IniWrite($sChatIni, "Lang", "cmbLang", $g_iCmbLang)
	IniWrite($sChatIni, "ChatGlobal", "Enable", $g_bChkChatGlobal)
	IniWrite($sChatIni, "ChatGlobal", "Scramble", $g_bChkScrambleGlobal)
	IniWrite($sChatIni, "ChatGlobal", "SwitchLang", $g_bChkSwitchLang)
	IniWrite($sChatIni, "ChatGlobal", "ChkDelayTime", $g_bChkDelayTime)
	IniWrite($sChatIni, "ChatGlobal", "TxtDelayTime", $g_iTxtDelayTime)

	IniWrite($sChatIni, "ChatClan", "Enable", $g_bChkChatClan)
	IniWrite($sChatIni, "ChatClan", "Responses", $g_bChkClanUseResponses)
	IniWrite($sChatIni, "ChatClan", "Generic", $g_bChkClanAlwaysMsg)
	IniWrite($sChatIni, "ChatClan", "ChatPushbullet", $g_iChatPushbullet)
	IniWrite($sChatIni, "ChatClan", "PbSendNewChats", $g_iPbSendNewChats)
    IniWrite($sChatIni, "Lang", "RusLang", $g_iRusLang)
	IniWrite($sChatIni, "ChatClan", "ChkCleverbot", $g_bChkCleverbot)
	
	; Challenge
	IniWrite($sChatIni, "ChatChallenge", "ChkChngOn", $g_bChkChngOn)
	IniWrite($sChatIni, "ChatChallenge", "ChkDelayChng", $g_bChkDelayChng)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage1", $g_bChkVillage1)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage4", $g_bChkVillage4)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage2", $g_bChkVillage2)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage5", $g_bChkVillage5)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage3", $g_bChkVillage3)
	IniWrite($sChatIni, "ChatChallenge", "ChkVillage6", $g_bChkVillage6)
	IniWrite($sChatIni, "ChatChallenge", "ChkAttackChng", $g_bChkAttackChng)

    ChatbotGUICheckboxControl()

EndFunc   ;==>ChatbotGUICheckbox

Func ChatbotGUICheckboxControl()

	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_ENABLE)
		GUICtrlSetState($g_hCmbLang, $GUI_SHOW)
		For $i = 0 To 3
			GUICtrlSetState($g_hEditGlobalMessages[$i], $GUI_ENABLE)
		Next
		; Delay RK
		GUICtrlSetState($g_hChkDelayTime, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_DISABLE)
	    GUICtrlSetState($g_hCmbLang, $GUI_INDETERMINATE)
		For $i = 0 To 3
			GUICtrlSetState($g_hEditGlobalMessages[$i], $GUI_DISABLE)
		Next
		; Delay RK
		GUICtrlSetState($g_hChkDelayTime, $GUI_DISABLE)
	EndIf
	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkUseResponses, $GUI_ENABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_ENABLE)
		GUICtrlSetState($g_hChkChatPushbullet, $GUI_ENABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_ENABLE)
		GUICtrlSetState($g_hEditResponses, $GUI_ENABLE)
		GUICtrlSetState($g_hEditGeneric, $GUI_ENABLE)
		; RK Cleverbot
		GUICtrlSetState($g_hChkCleverbot, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hChkUseResponses, $GUI_DISABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_DISABLE)
		GUICtrlSetState($g_hChkChatPushbullet, $GUI_DISABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_DISABLE)
		GUICtrlSetState($g_hEditResponses, $GUI_DISABLE)
		GUICtrlSetState($g_hEditGeneric, $GUI_DISABLE)
		; RK Cleverbot
		GUICtrlSetState($g_hChkCleverbot, $GUI_DISABLE)
	EndIf
	If  GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
			GUICtrlSetState($g_hCmbLang, $GUI_ENABLE)
		Else
			GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
		EndIf
		; Delay Time RK
		If GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED Then
			GUICtrlSetState($g_hTxtDelayTime, $GUI_ENABLE)
		Else
			GUICtrlSetState($g_hTxtDelayTime, $GUI_DISABLE)
		EndIf
	Else
		GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtDelayTime, $GUI_DISABLE)
	EndIf
	
	If $g_iRusLang = 1 Then
		GUICtrlSetState($g_hChkRusLang, $GUI_CHECKED)

	ElseIf $g_iRusLang = 0 Then
		GUICtrlSetState($g_hChkRusLang, $GUI_UNCHECKED)
	EndIf
	
	_GUICtrlComboBox_SetCurSel($g_hCmbLang, $g_iCmbLang)
	$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)
	
	GUICtrlSetData($g_hTxtDelayTime, $g_iTxtDelayTime)
	$g_iTxtDelayTime = GUICtrlRead($g_hTxtDelayTime)
	
		; GLOBAL
	If GUICtrlRead($g_hGlobalChatGUI) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkGlobalChat        , $GUI_SHOW)
		GUICtrlSetState($g_hChkGlobalScramble    , $GUI_SHOW)
		GUICtrlSetState($g_hChkDelayTime         , $GUI_SHOW)
		GUICtrlSetState($g_hChkSwitchLang        , $GUI_SHOW)
		GUICtrlSetState($g_hEditGlobalMessages[0], $GUI_SHOW)
		GUICtrlSetState($g_hEditGlobalMessages[1], $GUI_SHOW)
		GUICtrlSetState($g_hEditGlobalMessages[2], $GUI_SHOW)
		GUICtrlSetState($g_hEditGlobalMessages[3], $GUI_SHOW)
		GUICtrlSetState($g_hTxtDelayTime         , $GUI_SHOW)
		GUICtrlSetState($g_hCmbLang         	 , $GUI_SHOW)
	ElseIf GUICtrlRead($g_hGlobalChatGUI) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkGlobalChat        , $GUI_HIDE)
		GUICtrlSetState($g_hChkGlobalScramble    , $GUI_HIDE)
		GUICtrlSetState($g_hChkDelayTime         , $GUI_HIDE)
		GUICtrlSetState($g_hChkSwitchLang        , $GUI_HIDE)
		GUICtrlSetState($g_hEditGlobalMessages[0], $GUI_HIDE)
		GUICtrlSetState($g_hEditGlobalMessages[1], $GUI_HIDE)
		GUICtrlSetState($g_hEditGlobalMessages[2], $GUI_HIDE)
		GUICtrlSetState($g_hEditGlobalMessages[3], $GUI_HIDE)
		GUICtrlSetState($g_hTxtDelayTime         , $GUI_HIDE)
		GUICtrlSetState($g_hCmbLang         	 , $GUI_HIDE)
	EndIf
		; CHAT
	If GUICtrlRead($g_hClanChatGUI) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkClanChat      , $GUI_SHOW)
		GUICtrlSetState($g_hChkRusLang       , $GUI_SHOW)
		GUICtrlSetState($g_hGroupChatRandom  , $GUI_SHOW)
		GUICtrlSetState($g_hChkUseResponses  , $GUI_SHOW)
		GUICtrlSetState($g_hEditResponses    , $GUI_SHOW)
		GUICtrlSetState($g_hChkCleverbot     , $GUI_SHOW)
		GUICtrlSetState($g_hGroupChatSmart   , $GUI_SHOW)
		GUICtrlSetState($g_hChkUseGeneric    , $GUI_SHOW)
		GUICtrlSetState($g_hEditGeneric      , $GUI_SHOW)
		GUICtrlSetState($g_hGroupTelegram    , $GUI_SHOW)
		GUICtrlSetState($g_hChkChatPushbullet, $GUI_SHOW)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_SHOW)
	ElseIf GUICtrlRead($g_hClanChatGUI) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkClanChat      , $GUI_HIDE)
		GUICtrlSetState($g_hChkRusLang       , $GUI_HIDE)
		GUICtrlSetState($g_hGroupChatRandom  , $GUI_HIDE)
		GUICtrlSetState($g_hChkUseResponses  , $GUI_HIDE)
		GUICtrlSetState($g_hEditResponses    , $GUI_HIDE)
		GUICtrlSetState($g_hChkCleverbot     , $GUI_HIDE)
		GUICtrlSetState($g_hGroupChatSmart   , $GUI_HIDE)
		GUICtrlSetState($g_hChkUseGeneric    , $GUI_HIDE)
		GUICtrlSetState($g_hEditGeneric      , $GUI_HIDE)
		GUICtrlSetState($g_hGroupTelegram    , $GUI_HIDE)
		GUICtrlSetState($g_hChkChatPushbullet, $GUI_HIDE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_HIDE)
	EndIf
		; CHALLENGE
	If GUICtrlRead($g_hChallengeChatGUI) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkChngOn            , $GUI_SHOW)
		GUICtrlSetState($g_hChkDelayChng         , $GUI_SHOW)
		GUICtrlSetState($g_hEditChngMsg          , $GUI_SHOW)
		GUICtrlSetState($g_hDelayInput           , $GUI_SHOW)
		GUICtrlSetState($g_hGroupVillageRandom   , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage1          , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage4          , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage2          , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage5          , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage3          , $GUI_SHOW)
		GUICtrlSetState($g_hChkVillage6          , $GUI_SHOW)
		GUICtrlSetState($g_hGroupChallengeMessage, $GUI_SHOW)
		GUICtrlSetState($g_hOriginalChngMsg      , $GUI_SHOW)
		GUICtrlSetState($g_hRemplaceChallengeText, $GUI_SHOW)
		GUICtrlSetState($g_hTxtChng              , $GUI_SHOW)
		GUICtrlSetState($g_hChkAttackChng        , $GUI_SHOW)
		GUICtrlSetState($g_sLabelTextToFind      , $GUI_SHOW)
	ElseIf GUICtrlRead($g_hChallengeChatGUI) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkChngOn            , $GUI_HIDE)
		GUICtrlSetState($g_hChkDelayChng         , $GUI_HIDE)
		GUICtrlSetState($g_hEditChngMsg          , $GUI_HIDE)
		GUICtrlSetState($g_hDelayInput           , $GUI_HIDE)
		GUICtrlSetState($g_hGroupVillageRandom   , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage1          , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage4          , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage2          , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage5          , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage3          , $GUI_HIDE)
		GUICtrlSetState($g_hChkVillage6          , $GUI_HIDE)
		GUICtrlSetState($g_hGroupChallengeMessage, $GUI_HIDE)
		GUICtrlSetState($g_hOriginalChngMsg      , $GUI_HIDE)
		GUICtrlSetState($g_hRemplaceChallengeText, $GUI_HIDE)
		GUICtrlSetState($g_hTxtChng              , $GUI_HIDE)
		GUICtrlSetState($g_hChkAttackChng        , $GUI_HIDE)
		GUICtrlSetState($g_sLabelTextToFind      , $GUI_HIDE)
	EndIf

EndFunc   ;==>ChatbotGUICheckboxControl

Func ChatbotGUICheckboxDisable()
	For $i = $g_hChkGlobalChat To $g_hEditGeneric ; Save state of all controls on tabs
		GUICtrlSetState($i, $GUI_DISABLE)
	Next
EndFunc   ;==>ChatbotGUICheckboxDisable
Func ChatbotGUICheckboxEnable()
	For $i = $g_hChkGlobalChat To $g_hEditGeneric ; Save state of all controls on tabs
		GUICtrlSetState($i, $GUI_ENABLE)
	Next
	ChatbotGUICheckboxControl()
EndFunc   ;==>ChatbotGUICheckboxEnable

Func ChatbotGUIEditMessages()
Global $g_sGlb[4]

	For $i = 0 To UBound($GlobalMessages) - 1
	$g_sGlb[$i] = GUICtrlRead($g_hEditGlobalMessages[$i])
	$g_sGlb[$i] = StringReplace($g_sGlb[$i], @CRLF, "|")
Next

	IniWrite($sChatIni, "ChatGlobal", "GlobalMessages1", $g_sGlb[0])
	IniWrite($sChatIni, "ChatGlobal", "GlobalMessages2", $g_sGlb[1])
	IniWrite($sChatIni, "ChatGlobal", "GlobalMessages3", $g_sGlb[2])
	IniWrite($sChatIni, "ChatGlobal", "GlobalMessages4", $g_sGlb[3])

	Global $cResp = GUICtrlRead($g_hEditResponses)
	Global $cGeneric = GUICtrlRead($g_hEditGeneric)

	$cResp = StringReplace($cResp, @CRLF, "|")
	$cGeneric = StringReplace($cGeneric, @CRLF, "|")

	IniWrite($sChatIni, "ChatClan", "GenericMessages", $cGeneric)
	IniWrite($sChatIni, "ChatClan", "ResponseMessages", $cResp)

	ChatbotReadMessages()
EndFunc   ;==>ChatbotGUIEditMessages

Func ChatbotChatOpen() ; open the chat area
	Local $aButtonChatOpen[4] = [20, 351 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aButtonChatOpen[0], $aButtonChatOpen[1], True), Hex($aButtonChatOpen[2], 6), $aButtonChatOpen[3]) Then
		Click($aButtonChatOpen[0], $aButtonChatOpen[1], 1)
		If _Sleep(1000) Then Return True
	EndIf
	Return False
EndFunc   ;==>ChatbotChatOpen

Func ChatbotSelectClanChat() ; select clan tab
	Local $aSelectClanChat[4] = [200, 22, 0x383828, 20]
	;Local $aSelectClanChat2[4] = [280, 680 + $g_iMidOffsetY, 0xFDFFFF, 20]
	If _ColorCheck(_GetPixelColor($aSelectClanChat[0], $aSelectClanChat[1], True), Hex($aSelectClanChat[2], 6), $aSelectClanChat[3]) Then
		Click($aSelectClanChat[0], $aSelectClanChat[1], 1)
		If _Sleep(1000) Then Return
	EndIf
	;If _ColorCheck(_GetPixelColor($aSelectClanChat2[0], $aSelectClanChat2[1], True), Hex($aSelectClanChat2[2], 6), $aSelectClanChat2[3]) Then
	;	Click($aSelectClanChat2[0], $aSelectClanChat2[1], 1)
	;	If _Sleep(1000) Then Return
	;EndIf
	Return True
EndFunc   ;==>ChatbotSelectClanChat

Func ChatbotSelectGlobalChat() ; select global tab
	Local $aSelectGlobalChat[4] = [48, 22, 0x383828, 20]
	Local $aSelectGlobalChat2[4] = [280, 680 + $g_iMidOffsetY, 0xFDFFFF, 20]
	If _ColorCheck(_GetPixelColor($aSelectGlobalChat[0], $aSelectGlobalChat[1], True), Hex($aSelectGlobalChat[2], 6), $aSelectGlobalChat[3]) Then
		Click($aSelectGlobalChat[0], $aSelectGlobalChat[1], 1)
		If _Sleep(1000) Then Return
	EndIf
	If _ColorCheck(_GetPixelColor($aSelectGlobalChat2[0], $aSelectGlobalChat2[1], True), Hex($aSelectGlobalChat2[2], 6), $aSelectGlobalChat2[3]) Then
		Click($aSelectGlobalChat2[0], $aSelectGlobalChat2[1], 1)
		If _Sleep(1000) Then Return
	EndIf
	Return True
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotChatClose() ; close chat area
	Local $aButtonChatClose[4] = [330, 352 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aButtonChatClose[0], $aButtonChatClose[1], True), Hex($aButtonChatClose[2], 6), $aButtonChatClose[3]) Then
		Click($aButtonChatClose[0], $aButtonChatClose[1], 1)
		waitMainScreen()
	EndIf
	Return True
EndFunc   ;==>ChatbotChatClose

Func ChatbotChatClanInput() ; select the textbox for clan chat
	Local $aChatClanInput[4] = [276, 677 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aChatClanInput[0], $aChatClanInput[1], True), Hex($aChatClanInput[2], 6), $aChatClanInput[3]) Then
		Click($aChatClanInput[0], $aChatClanInput[1], 1)
		If _Sleep(1000) Then Return True
	EndIf
	Return False
EndFunc   ;==>ChatbotChatClanInput

Func ChatbotChatGlobalInput() ; select the textbox for global chat
	Local $aChatGlobalInput[4] = [276, 677 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aChatGlobalInput[0], $aChatGlobalInput[1], True), Hex($aChatGlobalInput[2], 6), $aChatGlobalInput[3]) Then
		Click($aChatGlobalInput[0], $aChatGlobalInput[1], 1)
		If _Sleep(1000) Then Return
	EndIf
	Return True
EndFunc   ;==>ChatbotChatGlobalInput

Func ChatbotChatInput($g_sMessage)
	Local $aChatInput[4] = [276, 677 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aChatInput[0], $aChatInput[1], True), Hex($aChatInput[2], 6), $aChatInput[3]) Then
		Click($aChatInput[0], $aChatInput[1], 1)
		If _Sleep(1000) Then Return
	EndIf
	If $g_iRusLang = 1 Then
	  SetLog("Chat send in russia", $COLOR_BLUE)
	 AutoItWinSetTitle('MyAutoItTitle')
    _WinAPI_SetKeyboardLayout(WinGetHandle(AutoItWinGetTitle()), 0x0419)
		Sleep(500)
		ControlFocus($g_hAndroidWindow, "", "")
		SendKeepActive($g_hAndroidWindow)
		Sleep(500)
	;Opt("SendKeyDelay", 1000)
	AutoItSetOption("SendKeyDelay", 50)
	  _SendExEx($g_sMessage)
	   SendKeepActive("")
    Else
	  Sleep(500)
 	 SendText($g_sMessage)
	EndIf
	Return True
EndFunc   ;==>ChatbotChatInput

Func ChatbotChatSendClan() ; click send
	Local $aChatSendClan[4] = [842, 690 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aChatSendClan[0], $aChatSendClan[1], True), Hex($aChatSendClan[2], 6), $aChatSendClan[3]) Then
		Click($aChatSendClan[0], $aChatSendClan[1], 1)
		If _Sleep(2000) Then Return
	EndIf
	Return True
EndFunc   ;==>ChatbotChatSendClan

Func ChatbotChatSendGlobal() ; click send
	Local $aChatSendGlobal[4] = [842, 690 + $g_iMidOffsetY, 0xFFFFFF, 20]
	If _ColorCheck(_GetPixelColor($aChatSendGlobal[0], $aChatSendGlobal[1], True), Hex($aChatSendGlobal[2], 6), $aChatSendGlobal[3]) Then
		Click($aChatSendGlobal[0], $aChatSendGlobal[1], 1)
		If _Sleep(2000) Then Return
	EndIf
	Return True
EndFunc   ;==>ChatbotChatSendGlobal

Func ChatbotStartTimer()
	$ChatbotStartTime = TimerInit()
EndFunc   ;==>ChatbotStartTimer

Func ChatbotIsInterval()
Local $Time_Difference = TimerDiff($ChatbotStartTime)
	If $Time_Difference > $ChatbotReadInterval * 1000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>ChatbotIsInterval

Func ChatbotIsLastChatNew() ; returns true if the last chat was not by you, false otherwise
	_CaptureRegion()
	For $y = 552 To 643
		For $x = 33 To 110
			If _ColorCheck(_GetPixelColor($x, $y), Hex(0x92EE4D, 6), 20) Then Return True
		Next
	Next
	Return False
EndFunc   ;==>ChatbotIsLastChatNew

Func ChatbotPushbulletSendChat()
   If Not $g_iChatPushbullet Then Return
   _CaptureRegion(0, 0, 320, 675)
   Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
   Local $Time = @HOUR & "." & @MIN & "." & @SEC

   Local $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
   $g_sProfileLootsPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Loots\"
   _GDIPlus_ImageSaveToFile($g_hBitmap, $g_sProfileLootsPath & $ChatFile)
   _GDIPlus_ImageDispose($g_hBitmap)
   ;push the file
   SetLog("Chatbot: Sent chat image", $COLOR_GREEN)
   NotifyPushFileToTelegram($ChatFile, "Loots", "image/jpeg", $g_sNotifyOrigin & " | Last Clan Chats" & "\n" & $ChatFile)
   ;wait a second and then delete the file
   _Sleep(500)
   Local $iDelete = FileDelete($g_sProfileLootsPath & $ChatFile)
   If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_RED)
EndFunc

Func ChatbotPushbulletQueueChat($Chat)
   If Not $g_iChatPushbullet Then Return
   _ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc

Func ChatbotPushbulletQueueChatRead()
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadQueued = True
EndFunc

Func ChatbotPushbulletStopChatRead()
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadInterval = 0
   $ChatbotIsOnInterval = False
EndFunc

Func ChatbotPushbulletIntervalChatRead($Interval)
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadInterval = $Interval
   $ChatbotIsOnInterval = True
   ChatbotStartTimer()
EndFunc

Func ChatbotMessage() ; run the chatbot
Local $bCanGlobalChat = False
	While 1
	$bCanGlobalChat = False
	
	If $g_bChkDelayTime = False And $g_bChkChatGlobal Then
		$bCanGlobalChat = True
		Else
		$bCanGlobalChat = False
	EndIf
	If $g_bChkDelayTime = True And $g_bChkChatGlobal Then
		Local $iSendChatGlobalDelay = DelayTime("GLOBAL")
		If $iSendChatGlobalDelay = True Then
			$g_sGlobalChatLastMsgSentTime = _NowCalc() ;Store msg sent time
			$bCanGlobalChat = True
			Else
			$bCanGlobalChat = False
		EndIf
	EndIf
	
	If $g_bChkChngOn = True Then
		If Not ChatbotChatOpen() Then Return
		SetLog("Chatbot: Challenge", $COLOR_GREEN)
		If Not ChatbotSelectClanChat() Then Return
			If _Sleep(500) Then Return
			Local $aChangeColors[2][3] = [[0x94D53C, 0, 1], [0x9CD944, 0, 2]]
			Local $aColorsButton = _MultiPixelSearch(125, 678, 313, 731, 1, 1, Hex(0xC5EC90, 6), $aChangeColors, 35)
			If _Sleep(500) Then Return
			ClickP($aColorsButton)
				If _Sleep(500) Then Return
				Local $aChangeStart[2][3] = [[0x98D840, 0, 1], [0x8CD134, 0, 2]]
				Local $aStartButton = _MultiPixelSearch(438, 271, 607, 325, 1, 1, Hex(0xEEFEDB, 6), $aChangeStart, 35)
				If _Sleep(500) Then Return
				ClickP($aStartButton)

		If $g_bChkChatClan = False And $bCanGlobalChat = False Then
		ExitLoop
		EndIf
	EndIf
	
	If $g_bChkChatClan Then
		If Not ChatbotChatOpen() Then Return
		SetLog("Chatbot: Sending chats to clan", $COLOR_GREEN)
		If Not ChatbotSelectClanChat() Then Return

		Local $SentClanChat = False
		_Sleep(2000)
		If $ChatbotReadQueued Then
			ChatbotNotifySendChat()
			$ChatbotReadQueued = False
			$SentClanChat = True
		ElseIf $ChatbotIsOnInterval Then
			If ChatbotIsInterval() Then
				ChatbotStartTimer()
				ChatbotNotifySendChat()
				$SentClanChat = True
			EndIf
		EndIf
        
		If UBound($ChatbotQueuedChats) > 0 Then
			SetLog("Chatbot: Sending pushbullet chats", $COLOR_GREEN)
        
			For $a = 0 To UBound($ChatbotQueuedChats) - 1
			Local $ChatToSend = $ChatbotQueuedChats[$a]
				If Not ChatbotChatClanInput() Then Return
				If Not ChatbotChatInput(_Encoding_JavaUnicodeDecode($ChatToSend)) Then Return
				If Not ChatbotChatSendClan() Then Return
			Next
        
			Dim $Tmp[0] ; clear queue
			$ChatbotQueuedChats = $Tmp
        
			ChatbotPushbulletSendChat()
        
			SetLog("Chatbot: Done", $COLOR_GREEN)
			Return
		EndIf

		If Not ChatbotIsLastChatNew() Then
			Local $sLastChat = ReadChat()
			Local $ChatMsg = StringStripWS($sLastChat, 7)
			SetLog("Found chat message: " & $ChatMsg, $COLOR_GREEN)
			Local $SentMessage = False

			If $ChatMsg = "" Or $ChatMsg = " " Then
				If $g_bChkClanAlwaysMsg Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($sClanMessages[Random(0, UBound($sClanMessages) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
					$SentMessage = True
				EndIf
			EndIf
			
			If ($g_bChkCleverbot = True) And Not $SentMessage Then
				Local $Response = runHelper($ChatMsg)
				If (Not $Response = False) And Not $ChatMsg = "" And Not $ChatMsg = " " Then
					If Not _Encoding_JavaUnicodeDecode($sString) Then Return
					SetLog("Got cleverbot response: " & $Response, $COLOR_GREEN)
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($Response) Then Return
					If Not ChatbotChatSendClan() Then Return
					$SentMessage = True
				EndIf
			EndIf

			If $g_bChkClanUseResponses And Not $SentMessage Then
				For $a = 0 To UBound($g_sClanResponses) - 1
					If StringInStr($ChatMsg, $g_sClanResponses[$a][0]) Then
						Local $Response = $g_sClanResponses[$a][1]
						SetLog("Sending response: " & $Response, $COLOR_GREEN)
						If Not ChatbotChatClanInput() Then Return
						If Not ChatbotChatInput($Response) Then Return
						If Not ChatbotChatSendClan() Then Return
						$SentMessage = True
					EndIf
				Next
			EndIf

			If Not $SentMessage Then
				If $g_bChkClanAlwaysMsg Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($sClanMessages[Random(0, UBound($sClanMessages) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
				EndIf
			EndIf

			; send it via pushbullet if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $g_iChatPushbullet And $g_iPbSendNewChats Then
				If Not $SentClanChat Then ChatbotPushbulletSendChat()
			EndIf
		ElseIf $g_bChkClanAlwaysMsg Then
			If Not ChatbotChatClanInput() Then Return
			If Not ChatbotChatInput($sClanMessages[Random(0, UBound($sClanMessages) - 1, 1)]) Then Return
			If Not ChatbotChatSendClan() Then Return
		EndIf

	EndIf
	
	If $bCanGlobalChat = True Then
		;========================Kychera modified==========================================
		If $g_bChkSwitchLang = 1 Then
			Switch GUICtrlRead($g_hCmbLang)
				Case "FR"
					ChangeLanguageToFRA()
				Case "DE"
					ChangeLanguageToDE()
				Case "ES"
					ChangeLanguageToES()
				Case "IT"
					ChangeLanguageToITA()
				Case "NL"
					ChangeLanguageToNL()
				Case "NO"
					ChangeLanguageToNO()
				Case "PR"
					ChangeLanguageToPR()
				Case "TR"
					ChangeLanguageToTR()
				Case "RU"
					ChangeLanguageToRU()
					Sleep(3000)
			EndSwitch
			Sleep(3000)
			waitMainScreen()
		EndIf
		;======================================================================================
		If Not ChatbotChatOpen() Then Return
		SetLog("Chatbot: Sending chats to global", $COLOR_GREEN)
		If Not ChatbotSelectGlobalChat() Then Return
		If Not ChatbotChatGlobalInput() Then Return
		Global $g_sMessage[4] = ["", "", "", ""]
	
		; assemble a message
		For $i = 0 To UBound($GlobalMessages) - 1
			Local $TmpGlobMsg = StringSplit($GlobalMessages[$i], "|", 2)
	
		If $g_bChkScrambleGlobal Then
	
			Local $i2 = 0
			$i2 = Random(0, 3, 1)
			If $i2 = 0 Then $g_sMessage[0] = $TmpGlobMsg[Random(0, UBound($TmpGlobMsg) - 1, 1)]
			If $i2 = 1 Then $g_sMessage[1] = $TmpGlobMsg[Random(0, UBound($TmpGlobMsg) - 1, 1)]
			If $i2 = 2 Then $g_sMessage[2] = $TmpGlobMsg[Random(0, UBound($TmpGlobMsg) - 1, 1)]
			If $i2 = 3 Then $g_sMessage[3] = $TmpGlobMsg[Random(0, UBound($TmpGlobMsg) - 1, 1)]
	
			Else
				$g_sMessage[$i] = $TmpGlobMsg[Random(0, UBound($TmpGlobMsg) - 1, 1)]
			EndIf
		Next
	
		; Send the message
		If Not ChatbotSelectGlobalChat() Then Return
		If Not ChatbotChatGlobalInput() Then Return
		If Not ChatbotChatInput(_ArrayToString($g_sMessage, " ")) Then Return
		If Not ChatbotChatSendGlobal() Then Return
		;==================kychera modified===============================================
		If $g_bChkSwitchLang = True Then
			ChangeLanguageToEN()
			_Sleep(3000)
			waitMainScreen()
			_Sleep(3000)
		EndIf
		;=================================================================================
	EndIf
	
	If $g_bChkChatGlobal Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	ElseIf $g_bChkChatClan Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	EndIf
	ExitLoop
	WEnd
	setlog("dbg")
If Not ChatbotChatClose() Then Return
EndFunc   ;==>ChatbotMessage

; Returns the response from cleverbot or simsimi, if any
Func runHelper($msg) ; run a script to get a response from cleverbot.com or simsimi.com
	Local $command, $DOS, $HelperStartTime, $Time_Difference, $sString
	Dim $DOS, $g_sMessage = ''

	$command = ' /c "phantomjs.exe phantom-cleverbot-helper.js '

	$DOS = Run(@ComSpec & $command & $msg & '"', "", @SW_HIDE, 8)
	$HelperStartTime = TimerInit()
	SetLog("Waiting for chatbot helper...")
	While ProcessExists($DOS)
		ProcessWaitClose($DOS, 20)
		SetLog("Still waiting for chatbot helper...")
		$Time_Difference = TimerDiff($HelperStartTime)
		If $Time_Difference > 100000 Then
			SetLog("Chatbot helper is taking too long!", $COLOR_RED)
			ProcessClose($DOS)
				_RunDos("taskkill /im phantomjs.exe") ; force kill
			Return False
		EndIf
	WEnd
	$g_sMessage = ''
	While 1
		$g_sMessage &= StdoutRead($DOS)
		If @error Then
			ExitLoop
		EndIf
	WEnd
	Return StringStripWS($g_sMessage, 7)
EndFunc   ;==>runHelper

Func DelayTime($chatType = 0)
	If $chatType = "GLOBAL" Then
		If $g_sGlobalChatLastMsgSentTime = "" Then ;If GlobalLastMsgSentTime sent time is empty means it's first time sms allow it
			Return True
		Else
			Local $sDateTimeDiffOfLastMsgInMin = _DateDiff("s", $g_sGlobalChatLastMsgSentTime, _NowCalc())/60;For getting float value of minutes(s) we divided the diffsec by 60
			SetDebugLog("$g_iTxtDelayTime = " & $g_iTxtDelayTime)
			SetDebugLog("$g_sGlobalChatLastMsgSentTime = " & $g_sGlobalChatLastMsgSentTime &", $sDateTimeDiffOfLastMsgInMin = " & $sDateTimeDiffOfLastMsgInMin )
			If $sDateTimeDiffOfLastMsgInMin > $g_iTxtDelayTime Then ;If GlobalLastMsgSentTime sent time is empty means it's first time sms
				Return True
			Else
				;----------- LOGIC JUST FOR BEAUTIFUL TIME LOG -------------------
				Local $hour = 0, $min = 0, $sec = 0
				Local $sDateTimeDiffOfLastMsgInSec = _DateDiff("s", _NowCalc() , _DateAdd( 'n',$g_iTxtDelayTime, $g_sGlobalChatLastMsgSentTime))
				SetDebugLog("$sDateTimeDiffOfLastMsgInSec = " & $sDateTimeDiffOfLastMsgInSec)
				_TicksToTime($sDateTimeDiffOfLastMsgInSec*1000, $hour, $min, $sec)
				;----------- LOGIC JUST FOR BEAUTIFUL TIME LOG -------------------

				SetLog("Chatbot: Skip sending chats to global chat", $COLOR_INFO)
				SetLog("Delay Time " &  StringFormat("%02i:%02i:%02i", $hour, $min, $sec)& " left before sending new msg.", $COLOR_INFO)
				Return False
			EndIf
		EndIf
	EndIf
EndFunc ;==>DelayTime
; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_JavaUnicodeDecode
; Description ...: Decode string from Java Unicode format.
; Syntax ........: _Encoding_JavaUnicodeDecode($sString)
; Parameters ....: $sString             - String to decode.
; Return values .: Decoded string.
; Author ........: amel27
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Encoding_JavaUnicodeDecode($sString)
	Local $iOld_Opt_EVS = Opt('ExpandVarStrings', 0)
	Local $iOld_Opt_EES = Opt('ExpandEnvStrings', 0)

	Local $sOut = "", $aString = StringRegExp($sString, "(\\\\|\\'|\\u[[:xdigit:]]{4}|[[:ascii:]])", 3)

	For $i = 0 To UBound($aString) - 1
		Switch StringLen($aString[$i])
			Case 1
				$sOut &= $aString[$i]
			Case 2
				$sOut &= StringRight($aString[$i], 1)
			Case 6
				$sOut &= ChrW(Dec(StringRight($aString[$i], 4)))
		EndSwitch
	Next

	Opt('ExpandVarStrings', $iOld_Opt_EVS)
	Opt('ExpandEnvStrings', $iOld_Opt_EES)

	Return $sOut
EndFunc ;==>_Encoding_JavaUnicodeDecode

Func ChangeLanguageToEN()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	ClickDrag(775, 180, 775, 440)
	If _Sleep(1000) Then Return
	Click(165, 180, 1) ;English
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language EN", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToEN

Func ChangeLanguageToFRA()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 230, 1) ;Franch
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language FRA", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToFRA
;===========Modified Kychera================
Func ChangeLanguageToRU()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(173, 607, 1) ;Russian
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language RU", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToRU

Func ChangeLanguageToDE()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 273, 1) ;DEUTCH
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language DE", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToDE

Func ChangeLanguageToES()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 325, 1) ;Ispanol
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language ES", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToES

Func ChangeLanguageToITA()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 375, 1) ;ITALYA
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language ITA", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToITA

Func ChangeLanguageToNL()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 425, 1) ;NL
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language NL", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToNL

Func ChangeLanguageToNO()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 475, 1) ;NORSK
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language NO", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToNO

Func ChangeLanguageToPR()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 525, 1) ;PORTUGAL
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language PR", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToPR

Func ChangeLanguageToTR()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 575, 1) ;TURK
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language TR", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToTR