; #FUNCTION# ====================================================================================================================
; Name ..........: NEW Chatbot by RK MOD
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

#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>
#include <EditConstants.au3>

Func ChatbotReadSettings()	
	$ClanMessages = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "genericMsgClan", "Testing on Chat|Hey all"), "|", 2)
	$ClanResponses0 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "responseMsgClan", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
	Global $ClanResponses1[UBound($ClanResponses0)][2] ;
	For $a = 0 To UBound($ClanResponses0) - 1
		$TmpResp = StringSplit($ClanResponses0[$a], ":", 2)
		If UBound($TmpResp) > 0 Then
			$ClanResponses1[$a][0] = $TmpResp[0]
		Else
			$ClanResponses1[$a][0] = "<invalid>"
		EndIf
		If UBound($TmpResp) > 1 Then
			$ClanResponses1[$a][1] = $TmpResp[1]
		Else
			$ClanResponses1[$a][1] = "<undefined>"
		EndIf
	Next

	$ClanResponses = $ClanResponses1

	$GlobalMessages1 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "globalMsg1", "War Clan Recruiting|Active War Clan accepting applications"), "|", 2)
	$GlobalMessages2 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "globalMsg2", "Join now|Apply now"), "|", 2)
EndFunc   ;==>ChatbotReadSettings


Func chkGlobalChat()  
    $ChatbotChatGlobal = 1  
    If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_ENABLE)
		GUICtrlSetState($cmbLang, $GUI_SHOW)
		GUICtrlSetState($g_hChkRusLang, $GUI_ENABLE)
		GUICtrlSetState($editGlobalMessages1, $GUI_ENABLE)
		GUICtrlSetState($editGlobalMessages2, $GUI_ENABLE)
	Else
	    $ChatbotChatGlobal = 0
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_DISABLE)
		GUICtrlSetState($cmbLang, $GUI_INDETERMINATE)
		GUICtrlSetState($g_hChkRusLang, $GUI_DISABLE)
		GUICtrlSetState($editGlobalMessages1, $GUI_DISABLE)
		GUICtrlSetState($editGlobalMessages2, $GUI_DISABLE)
	EndIf
	If  GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED And GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
	    GUICtrlSetState($cmbLang, $GUI_ENABLE)
	Else
    	GUICtrlSetState($cmbLang, $GUI_DISABLE)
	EndIf	
EndFunc ;==>chkGlobalChat


Func chkGlobalScramble()
	If GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED Then
		$ChatbotScrambleGlobal = 1
	Else
		$ChatbotScrambleGlobal = 0
	EndIf
EndFunc   ;==>chkGlobalScramble	 

Func chkSwitchLang()
	If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
		$ChatbotSwitchLang = 1
	Else
		$ChatbotSwitchLang = 0
	EndIf
	If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
	    GUICtrlSetState($cmbLang, $GUI_ENABLE)
	Else
   	    GUICtrlSetState($cmbLang, $GUI_DISABLE)
	EndIf	
EndFunc   ;==>chkSwitchLang	

Func chkClanChat()
    $ChatbotChatClan = 1
   	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkUseResponses, $GUI_ENABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_ENABLE)
		GUICtrlSetState($g_hChkChatNotify, $GUI_ENABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_ENABLE)
		GUICtrlSetState($editResponses, $GUI_ENABLE)
		GUICtrlSetState($editGeneric, $GUI_ENABLE)
	Else
	    $ChatbotChatClan = 0
		GUICtrlSetState($g_hChkUseResponses, $GUI_DISABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_DISABLE)
		GUICtrlSetState($g_hChkChatNotify, $GUI_DISABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_DISABLE)
		GUICtrlSetState($editResponses, $GUI_DISABLE)
		GUICtrlSetState($editGeneric, $GUI_DISABLE)
	EndIf
EndFunc ;==>chkClanChat

Func chkUseResponses()
	If GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED Then
		$ChatbotClanUseResponses = 1
	Else
		$ChatbotClanUseResponses = 0
	EndIf
EndFunc   ;==>chkUseResponses 

Func chkUseGeneric()
	If GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED Then
		$ChatbotClanAlwaysMsg = 1
	Else
		$ChatbotClanAlwaysMsg = 0
	EndIf
EndFunc   ;==>chkUseGeneric

Func chkChatNotify()
	If GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED Then
		$ChatbotUseNotify = 1
	Else
		$ChatbotUseNotify = 0
	EndIf
EndFunc   ;==>chkChatNotify

Func chkPbSendNewChats()
	If GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED Then
		$ChatbotPbSendNew = 1
	Else
		$ChatbotPbSendNew = 0
	EndIf
EndFunc   ;==>chkPbSendNewChats

Func chkRusLang()
    If GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED Then
    $g_iChkRusLang = 1
    Else
    $g_iChkRusLang = 0
    EndIf
EndFunc ;==>chkRusLang

Func ChatGuiEditUpdate()
 Global $glb1 = GUICtrlRead($editGlobalMessages1)
 Global $glb2 = GUICtrlRead($editGlobalMessages2)

 Global $cResp = GUICtrlRead($editResponses)
 Global $cGeneric = GUICtrlRead($editGeneric)

	; how 2 be lazy 101 =======
	$glb1 = StringReplace($glb1, @CRLF, "|")
	$glb2 = StringReplace($glb2, @CRLF, "|")

	$cResp = StringReplace($cResp, @CRLF, "|")
	$cGeneric = StringReplace($cGeneric, @CRLF, "|")
;	; =========================
    ChatbotReadSettings()
EndFunc   ;==>ChatGuiEditUpdate

; FUNCTIONS ================================================
; All of the following return True if the script should
; continue running, and false otherwise
Func ChatbotChatOpen() ; open the chat area
    ClickP($aAway, 1, 0, "#0000") ;Click Away to prevent any pages on top
	If _Sleep(1000) Then Return
	Click(20, 383, 1, 0) ; open chat
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatOpen

Func ChatbotSelectClanChat() ; select clan tab
	Click(222, 27, 1) ; switch to clan
	If _Sleep(1000) Then Return
	Click(295, 700, 1) ; scroll to top
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotSelectClanChat

Func ChatbotSelectGlobalChat() ; select global tab
	Click(74, 23, 1) ; switch to global
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotChatClose() ; close chat area
	Click(330, 384, 1) ; close chat
	waitMainScreen()
	Return True
EndFunc   ;==>ChatbotChatClose

Func ChatbotChatClanInput() ; select the textbox for clan chat
	Click(276, 707, 1) ; select the textbox
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatClanInput

Func ChatbotChatGlobalInput() ; select the textbox for global chat
	Click(277, 706, 1) ; select the textbox
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatGlobalInput

;============================================
;+++++++++++++Kychera Modified +++++++++++++++
Func ChatbotChatInput($message)
    If _Sleep(1000) Then Return
	Click(33, 707, 1)	
    If $g_iChkRusLang = 1 Then
	  SetLog("Chat send in russia", $COLOR_BLUE)
	 AutoItWinSetTitle('MyAutoItTitle')
    _WinAPI_SetKeyboardLayout(WinGetHandle(AutoItWinGetTitle()), 0x0419)
		_Sleep(500)
		ControlFocus($g_hAndroidWindow, "", "")
		SendKeepActive($g_hAndroidWindow)
		_Sleep(500)
	;Opt("SendKeyDelay", 1000)
	AutoItSetOption("SendKeyDelay", 50)
	  _SendExEx($message)
	   SendKeepActive("")
    Else
	 _Sleep(500)
 	 SendText($message)
	EndIf
	Return True
EndFunc   ;==>ChatbotChatInput
;+++++++++++++++++++++++++++++++++++++++++++++
;Support for the Russian language.
;=============================================

Func ChatbotChatSendClan() ; click send
	If _Sleep(1000) Then Return
	Click(827, 709, 1) ; send
	If _Sleep(2000) Then Return
	Return True
EndFunc   ;==>ChatbotChatSendClan

Func ChatbotChatSendGlobal() ; click send
	If _Sleep(1000) Then Return
	Click(827, 709, 1) ; send
	If _Sleep(2000) Then Return
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
	For $x = 38 To 261
		If _ColorCheck(_GetPixelColor($x, 129), Hex(0x78BC10, 6), 5) Then Return True ; detect the green menu button
	Next
	Return False
EndFunc   ;==>ChatbotIsLastChatNew

Func ChatbotNotifySendChat()
   If Not $ChatbotUseNotify Then Return
   
   Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
   Local $Time = @HOUR & "." & @MIN & "." & @SEC
   _CaptureRegion(0, 0, 320, 675)
   Local $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
   _GDIPlus_ImageSaveToFile($g_hBitmap, $g_sProfileLootsPath & $ChatFile)
   _GDIPlus_ImageDispose($g_hBitmap)
   ;push the file
   SetLog("Chatbot: Sent chat image", $COLOR_GREEN)
   ;========Modified Kychera===========   
   NotifyPushFileToBoth($ChatFile, "Loots", "image/jpeg", $g_sNotifyOrigin & " | Last Clan Chats" & "\n" & $ChatFile)
   ;===================
   ;wait a second and then delete the file
   If _Sleep($DELAYPUSHMSG2) Then Return
   Local $iDelete = FileDelete($g_sProfileLootsPath & $ChatFile)
   If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_RED)
EndFunc

Func ChatbotNotifyQueueChat($Chat)
   If Not $ChatbotUseNotify Then Return
   _ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc

Func ChatbotNotifyQueueChatRead()
   If Not $ChatbotUseNotify Then Return
   $ChatbotReadQueued = True
EndFunc

Func ChatbotNotifyStopChatRead()
   If Not $ChatbotUseNotify Then Return
   $ChatbotReadInterval = 0
   $ChatbotIsOnInterval = False
EndFunc

Func ChatbotNotifyIntervalChatRead($Interval)
   If Not $ChatbotUseNotify Then Return
   $ChatbotReadInterval = $Interval
   $ChatbotIsOnInterval = True
   ChatbotStartTimer()
EndFunc

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
EndFunc   ;==>ChangeLanguageToFra
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
;========================================
; MAIN SCRIPT ==============================================

Func ChatbotMessage() ; run the chatbot
	If $ChatbotChatGlobal Then
		SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
	ElseIf $ChatbotChatClan Then
		SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
	EndIf
	If $ChatbotChatGlobal Then
;========================Kychera modified==========================================
		If $ChatbotSwitchLang = 1 Then
		Switch GUICtrlRead($cmbLang)
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
		; assemble a message
		Global $message[2]
		$message[0] = $GlobalMessages1[Random(0, UBound($GlobalMessages1) - 1, 1)]
		$message[1] = $GlobalMessages2[Random(0, UBound($GlobalMessages2) - 1, 1)]
		If $ChatbotScrambleGlobal Then
			_ArrayShuffle($message)
		EndIf
		; Send the message
		If Not ChatbotSelectGlobalChat() Then Return
		If Not ChatbotChatGlobalInput() Then Return
		If Not ChatbotChatInput(_ArrayToString($message, " ")) Then Return
		If Not ChatbotChatSendGlobal() Then Return
		If Not ChatbotChatClose() Then Return
;==================kychera modified===============================================
		If $ChatbotSwitchLang = 1 Then
			ChangeLanguageToEN()
			  _Sleep(3000)
			waitMainScreen()
			  _Sleep(3000)
		EndIf
;=================================================================================
	EndIf

	If $ChatbotChatClan Then
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
			SetLog("Chatbot: Sending Notify chats", $COLOR_GREEN)

			For $a = 0 To UBound($ChatbotQueuedChats) - 1
			Local $ChatToSend = $ChatbotQueuedChats[$a]
				If Not ChatbotChatClanInput() Then Return
				;===Modified Kychera=====
				If Not ChatbotChatInput(_Encoding_JavaUnicodeDecode($ChatToSend)) Then Return
				;========================
				If Not ChatbotChatSendClan() Then Return
			Next

			Dim $Tmp[0] ; clear queue
			$ChatbotQueuedChats = $Tmp
             _sleep(2000)
			ChatbotNotifySendChat()

			If Not ChatbotChatClose() Then Return
			SetLog("Chatbot: Done", $COLOR_GREEN)
			Return
		EndIf

		If 1 Then
			; get text of the latest message
			Local $sLastChat = ReadChat()
			Local $ChatMsg = StringStripWS($sLastChat, 7)
			SetLog("Found chat message: " & $ChatMsg, $COLOR_GREEN)
			Local $SentMessage = False
			
			If $ChatMsg = "" Or $ChatMsg = " " Then
				If $ChatbotClanAlwaysMsg Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
					$SentMessage = True
				EndIf
			EndIf

			If $ChatbotClanUseResponses And Not $SentMessage Then
				For $a = 0 To UBound($ClanResponses) - 1
					If StringInStr($ChatMsg, $ClanResponses[$a][0]) Then
						Local $Response = $ClanResponses[$a][1]
						SetLog("Sending response: " & $Response, $COLOR_GREEN)
						If Not ChatbotChatClanInput() Then Return
						If Not ChatbotChatInput($Response) Then Return
						If Not ChatbotChatSendClan() Then Return
						$SentMessage = True
						ExitLoop
					EndIf
				Next
			EndIf

			If Not $SentMessage Then
				If $ChatbotClanAlwaysMsg Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
				EndIf
			EndIf

			; send it via Notify if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $ChatbotUseNotify And $ChatbotPbSendNew Then
				If Not $SentClanChat Then ChatbotNotifySendChat()
			EndIf
		ElseIf $ChatbotClanAlwaysMsg Then
			If Not ChatbotChatClanInput() Then Return
			If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
			If Not ChatbotChatSendClan() Then Return
		EndIf

		If Not ChatbotChatClose() Then Return
	EndIf
	If $ChatbotChatGlobal Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	ElseIf $ChatbotChatClan Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	EndIf
EndFunc   ;==>ChatbotMessage

;===========Addied kychera=================
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
;============================================
