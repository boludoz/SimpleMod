; #FUNCTION# ====================================================================================================================
; Name ..........: Functions(AltuFaltu_Mod)
; Description ...: This functions will do Switch between SCID ACC using simple click method. It help to login SCID ACC if Mainscreen stucked on SCID login Screen.
; Syntax ........: SwitchCOCAcc_SCID($NextAccount), _MainScreen_SCIDLogin(), ScanSCIDAcc()
; Parameters ....: $NextAccount
; Return values .: None
; Author ........: AltuFaltu(22-06-18)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SwitchCOCAcc_SCID($NextAccount)

	Local $Success = False
	Setlog("***ALtuFaltu - Start SuperCell ID Switch Account Process***",0x6E0DD0)
	If _Sleep(500) Then Return
	If IsMainPage() Then Click($aButtonSetting[0], $aButtonSetting[1], 1, 0, "Click Setting")
	Setlog("     1.Click on Setting Button",0xFF0099)
	If _Sleep(500) Then Return

	If WaitforVariousImages("SCIDDisconnectBtn",30,1000) = False Then
		SetLog("Cannot load setting page, restart game...", $COLOR_RED)
	Else
		Setlog("     2.Click on SuperCell ID Disconnect Button",0xFF0099)
		If _Sleep(2000) Then Return
		RndClick_AF($g_ClkSCIDDisConnBtnAF)
		If _Sleep(500) Then Return
		If WaitforVariousImages("SCIDLogOutBtn",30,1000) = False Then
			SetLog("Cannot load SuperCell ID LogOut page, restart game...", $COLOR_RED)
		Else
			Setlog("     3.Click on SuperCell ID LogOut Button",0xFF0099)
			If _Sleep(2000) Then Return
			RndClick_AF($g_ClkSCIDLogOutBtnAF)
			If _Sleep(500) Then Return
			If WaitforVariousImages("SCIDLogOutConfirmBtn",30,1000) = False Then
				SetLog("Cannot Find SuperCell ID Confirm Button, restart game...", $COLOR_RED)
			Else
				Setlog("     4.Click on SuperCell ID LogOut Confirm Button",0xFF0099)
				If _Sleep(2000) Then Return
				RndClick_AF($g_ClkSCIDConfirmBtnAF)
				If _Sleep(500) Then Return
				If WaitforVariousImages("SCIDLoginBtn",30,1000) = False Then
					SetLog("Cannot Find SuperCell ID Login Button, restart game...", $COLOR_RED)
				Else
					Setlog("     5.Click on SuperCell ID Login Button",0xFF0099)
					If _Sleep(2000) Then Return
					RndClick_AF($g_ClkSCIDLoginBtnAF)
					If _Sleep(3000) Then Return
					If WaitforVariousImages("SCIDAccSelectPage",30,1000) = False Then
						If WaitforVariousImages("SCIDAccSelectPageSingleAcc",30,1000) = True Then
							SetLog("AltuFaltu - You have only one Acc. of SCID in Emulator and", 0x6E0DD0)
							SetLog("           	You Active Swithch Acc. Soo Funny.", 0x6E0DD0)
							SetLog("Solution - Disable Switch Acc.", 0x6E0DD0)
							BtnStop()
							$g_SwitchSCIDAccFatalErrorAF = True
						Else
							SetLog("Cannot Load SuperCell ID Select Account Page, restart game...", $COLOR_RED)
						EndIf
					Else
						Setlog("     6.Click on SuperCell ID Account No. - " & $NextAccount+1 & ".",0xFF0099)
						If SCIDClickOnAcc($NextAccount) = True Then
							$Success = True
							Wait4MainAF()
						Else
							Setlog(" - ******************* ERROR **************************",0x6E0DD0)
							SetLog(" - Terget Acc is Not Found. Please Check Manually.......", 0x6E0DD0)
							SetLog(" - Suggest to Rescan SCID Accounts........", 0x6E0DD0)
							SetLog("Bot is Stopping Now.", 0xFF0099)
							If Not GUICtrlGetState($btnScanSCIDAcc) Then
								GUICtrlSetState($btnScanSCIDAcc, $GUI_ENABLE)
							EndIf
							$g_SwitchSCIDAccFatalErrorAF = True
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Return $Success

EndFunc

Func _MainScreen_SCIDLogin()

	Local $CurrAccount = -1
	For $i = 0 to 7
		If GUICtrlRead($g_hCmbProfile,_GUICtrlComboBox_GetCurSel($g_hCmbProfile)) = GUICtrlRead($g_ahCmbProfile[$i],_GUICtrlComboBox_GetCurSel($g_ahCmbProfile[$i])) Then
			$CurrAccount = $i
			ExitLoop
		EndIf
	Next
	If $CurrAccount = -1 Then
		If WaitforVariousImages("SCIDAccSelectPageSingleAcc",30,1000) = False Then
			SetLog("AltuFaltu - Login into the Current Profile's Acc is failed.", 0x6E0DD0)
			SetLog("Problem  - You have multiple SCID Acc. in Emulator and ", 0x6E0DD0)
			SetLog("           You didn't specify the Slot of your Current Profile.", 0x6E0DD0)
			SetLog("           So Bot Don't know to Login into which Acc.", 0x6E0DD0)
			SetLog("Solution - Please, Arrange profiles as per Acc Slot in SwitchAcc Section", 0x6E0DD0)
			BtnStop()
		Else
			Setlog("     6.Click on SuperCell ID Single Account Slot.",0xFF0099)
			If _Sleep(2000) Then Return
			Click(380,375)
			If _Sleep(3000) Then Return
			Wait4MainAF()
		EndIf
	Else
		If WaitforVariousImages("SCIDAccSelectPage",30,1000) = False Then
			If WaitforVariousImages("SCIDAccSelectPageSingleAcc",30,1000) = True Then
			SetLog("AltuFaltu - You have only one Acc. of SCID. in Emulator.", 0x6E0DD0)
			SetLog("Warning   - Bot will login to that ID with selected Profile", 0x6E0DD0)
			Setlog("     6.Click on SuperCell ID Single Account Slot.",0xFF0099)
			If _Sleep(2000) Then Return
			Click(380,375)
			If _Sleep(3000) Then Return
			Else
				SetLog("Cannot Load SuperCell ID Select Account Page, restart game...", $COLOR_RED)
			EndIf
		Else
			Setlog("     6.Click on SuperCell ID Account Slot No. - " & $CurrAccount+1 & ".",0xFF0099)
			If SCIDClickOnAcc($CurrAccount) Then
				If _Sleep(3000) Then Return
				Wait4MainAF()
			Else
				Setlog(" - ******************* ERROR **************************",0x6E0DD0)
				SetLog(" - Terget Acc is Not Found. Please Check Manually.......", 0x6E0DD0)
				SetLog(" - Suggest to Rescan SCID Accounts........", 0x6E0DD0)
				SetLog("Bot is Stopping Now.", 0xFF0099)
				If Not GUICtrlGetState($btnScanSCIDAcc) Then
					GUICtrlSetState($btnScanSCIDAcc, $GUI_ENABLE)
				EndIf
				BtnStop()
			EndIf
		EndIf
	EndIf

EndFunc

Func Wait4MainAF($bBuilderBase = False)
	Local $iCount
	For $i = 0 To 105
		$iCount += 1
		If $iCount > 120 Then ExitLoop
		If $g_DebugLogAF = 1 Then Setlog("Wait4Main Loop = " & $i & "   ExitLoop = " & $iCount, $COLOR_DEBUG) ; Debug stuck loop
		ForceCaptureRegion()
		_CaptureRegion()
		If _CheckColorPixelAF($aIsMain[0], $aIsMain[1], $aIsMain[2], $aIsMain[3], $g_bNoCapturePixel, "aIsMain") Then
			If $g_DebugLogAF = 1 Then Setlog("Main Village - Screen cleared, Wait4Main exit", $COLOR_DEBUG)
			Return True
		ElseIf _CheckColorPixelAF($aIsOnBuilderBase[0], $aIsOnBuilderBase[1], $aIsOnBuilderBase[2], $aIsOnBuilderBase[3], $g_bNoCapturePixel, "aIsOnBuilderBase") Then
			If Not $bBuilderBase Then
				ZoomOut()
				SwitchBetweenBases()
				If $i <> 0 Then $i -= 1
				ContinueLoop
			EndIf
			If $g_DebugLogAF = 1 Then Setlog("Builder Base - Screen cleared, Wait4Main exit", $COLOR_DEBUG)
			Return True
		Else
			If TestCapture() = False And _Sleep($DELAYWAITMAINSCREEN1) Then Return
			; village was attacked okay button
			If _ColorCheck(_GetPixelColor(402, 516, $g_bNoCapturePixel), Hex(0xFFFFFF, 6), 5) And _ColorCheck(_GetPixelColor(405, 537, $g_bNoCapturePixel), Hex(0x5EAC10, 6), 20) Then
				;Click($aButtonVillageWasAttackOK[0],$aButtonVillageWasAttackOK[1],1,0,"#VWAO")
				Click(625,30)
				If _Sleep(1000) Then Return
				Click(625,30)
				If _Sleep(1000) Then Return
				$g_abNotNeedAllTime[0] = True
				$g_abNotNeedAllTime[1] = True
				$g_bIsClientSyncError = False
				If _Sleep(500) Then Return True
				$i = 0
				ContinueLoop
			EndIf
			_CaptureRegion2Sync()
			If _checkObstacles($bBuilderBase) Then $i = 0
		EndIf
	Next
	Return False
EndFunc

Func ScanSCIDAcc()

	Local $currentRunState = $g_bRunState
	$g_bRunState = True
	GUICtrlSetState($btnScanSCIDAcc, $GUI_DISABLE)
	Local $SCIDPage = -1
	Setlog("*** ALtuFaltu - Start Scaning SuperCell ID Accounts ***",0x6E0DD0)
	If WaitforVariousImages("SCIDLoginBtn",5,1000) = False Then
		checkMainScreen()
		If _Sleep(500) Then Return
		If IsMainPage() Then Click($aButtonSetting[0], $aButtonSetting[1], 1, 0, "Click Setting")
		Setlog("     1.Click on Setting Button",0xFF0099)
		If _Sleep(500) Then Return
		If WaitforVariousImages("SCIDDisconnectBtn",30,1000) = False Then
			SetLog("Cannot load setting page, restart game...", $COLOR_RED)
		Else
			Setlog("     2.Click on SuperCell ID Disconnect Button",0xFF0099)
			If _Sleep(2000) Then Return
			RndClick_AF($g_ClkSCIDDisConnBtnAF)
			If _Sleep(500) Then Return
			If WaitforVariousImages("SCIDLogOutBtn",30,1000) = False Then
				SetLog("Cannot load SuperCell ID LogOut page, restart game...", $COLOR_RED)
			Else
				Setlog("     3.Click on SuperCell ID LogOut Button",0xFF0099)
				If _Sleep(2000) Then Return
				RndClick_AF($g_ClkSCIDLogOutBtnAF)
				If _Sleep(500) Then Return
					If WaitforVariousImages("SCIDLogOutConfirmBtn",30,1000) = False Then
					SetLog("Cannot Find SuperCell ID Confirm Button, restart game...", $COLOR_RED)
				Else
					Setlog("     4.Click on SuperCell ID LogOut Confirm Button",0xFF0099)
					If _Sleep(2000) Then Return
					RndClick_AF($g_ClkSCIDConfirmBtnAF)
					If _Sleep(500) Then Return
					If WaitforVariousImages("SCIDLoginBtn",30,1000) = False Then
						SetLog("Cannot Find SuperCell ID Login Button, restart game...", $COLOR_RED)
					Else
						Setlog("     5.Click on SuperCell ID Login Button",0xFF0099)
						If _Sleep(2000) Then Return
						RndClick_AF($g_ClkSCIDLoginBtnAF)
						If _Sleep(3000) Then Return
						If WaitforVariousImages("SCIDAccSelectPage",30,1000) = False Then
							If WaitforVariousImages("SCIDAccSelectPageSingleAcc",30,1000) = True Then
								$SCIDPage = 0
							Else
								SetLog("Cannot Load SuperCell ID Select Account Page, restart game...", $COLOR_RED)
							EndIf
						Else
							$SCIDPage = 1
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		Setlog("     5.Click on SuperCell ID Login Button",0xFF0099)
		If _Sleep(2000) Then Return
		RndClick_AF($g_ClkSCIDLoginBtnAF)
		If _Sleep(3000) Then Return
		If WaitforVariousImages("SCIDAccSelectPage",30,1000) = False Then
			If WaitforVariousImages("SCIDAccSelectPageSingleAcc",30,1000) = True Then
				$SCIDPage = 0
			Else
				SetLog("Cannot Load SuperCell ID Select Account Page, restart game...", $COLOR_RED)
			EndIf
		Else
			$SCIDPage = 1
		EndIf
	EndIf
	If $SCIDPage = 1 Then
		SetLog("SuperCell ID Select Account Page Found - MultiAcc", $COLOR_SUCCESS1)
	ElseIf $SCIDPage = 0 Then
		SetLog("SuperCell ID Select Account Page Found - SingleAcc", $COLOR_WARNING)
		SetLog("  -  Scan Aborded")
		Return
	ElseIf $SCIDPage = 1 Then
		SetLog("SuperCell ID Select Account Page Not Found", $COLOR_ERROR)
		SetLog("  -  Scan Aborded")
		Return
	EndIf
	Local $CrossPosY = FindAccCrossMark()
	Local $TotalAccOnFirstPage = UBound($CrossPosY)
	SetLog("No. of Account found in first Page is - " & $TotalAccOnFirstPage & ". Accounts", $COLOR_INFO)
	For $i = 0 to $TotalAccOnFirstPage-1
		CaptureSCID($CrossPosY[$i],$i)
	Next
	If $TotalAccOnFirstPage > 3 Then
		Setlog("Lets Check If More Than 4 Account Exist", 0xFF0099)
		Local $NxtAcc = 4
		If _Sleep(500) Then Return
		ClickDrag(700, 561, 700, 485,2000)
		If _Sleep(2000) Then Return
		While SCIDAccEndScroll() = False
			$NxtAcc = $NxtAcc+1
			ReDim $CrossPosY[UBound($CrossPosY)+1]
			$CrossPosY = FindAccCrossMark()
			_ArraySort($CrossPosY,1)
			CaptureSCID($CrossPosY[0],$NxtAcc-1)
			If _Sleep(500) Then Return
			ClickDrag(700, 561, 700, 485,2000)
			If _Sleep(2000) Then Return
			If $NxtAcc = 8 Then
				ExitLoop
			EndIf
		WEnd
	Else
		$NxtAcc = $TotalAccOnFirstPage
	EndIf
	Setlog("You Have Total " & $NxtAcc & ". SUPERCELL ID Accounts.",0xFF0099)
	Setlog("*** ALtuFaltu - End Scaning SuperCell ID Accounts ***",0x6E0DD0)
	Click(742,140)		;Close SCID Acc Page
	GUICtrlSetState($btnScanSCIDAcc, $GUI_ENABLE)
	$g_bRunState = $currentRunState

EndFunc

Func FindAccCrossMark()

	Local $x = 198, $y = 291, $x1 = 662, $y1 = 608
	Local $Res = QuickMIS("CX", $g_sImgSCIDCross, $x, $y, $x1, $y1, True, True)
	;SetLog("No. of Account found in first Page is - " & UBound($Res) & ". Account")
	Local $CrossPosY[UBound($Res)]
	For $i = 0 to UBound($Res)-1
		Local $Temp = StringSplit($Res[$i], ",", $STR_NOCOUNT)
		If $Temp[0]+$x > 632 and $Temp[0]+$x < 634 Then
			$CrossPosY[$i] = $Temp[1]+$y
			;SetLog(" - " & $Temp[0]+$x & "," & $Temp[1]+$y)
		EndIf
	Next
	_ArraySort($CrossPosY)
	;For $i = 0 to UBound($Res)-1
		;SetLog(" --- " & $CrossPosY[$i])
	;Next
	Return $CrossPosY

EndFunc

Func CaptureSCID($CrossPosY,$AccNo)

	$AccNo = $AccNo+1
	Local $Directory = $g_sImgSCIDAccs & "\Acc" & $AccNo
	If Not FileExists($Directory) And Not StringInStr(FileGetAttrib($Directory),"D") Then
		DirCreate($Directory)
	EndIf
	_CaptureRegion()
	;Local $hCap = GetHHBitmapArea($g_hHBitmap, 227, $CrossPosY-7, 427, $CrossPosY+11)
	Local $hCap = _GDIPlus_BitmapCloneArea($g_hBitmap, 227, $CrossPosY-7, 160, 17, $GDIP_PXF32RGB) ;$GDIP_PXF24RGB)
	_GDIPlus_ImageSaveToFile($hCap, $g_sImgSCIDAccs & "\Acc" & $AccNo & "\Account" & $AccNo & "_99.png")
	If FileExists($g_sImgSCIDAccs & "\Acc" & $AccNo & "\Account" & $AccNo & "_99.png") Then
		SetLog("Account" & $AccNo & "_99.png is Captured.", $COLOR_INFO)
	EndIf
	GdiDeleteHBitmap($hCap)

EndFunc

Func SCIDAccEndScroll()

	If QuickMIS("BC1", $g_sImgSCIDOr, 340, 525, 550, 580, True,True) Then
		Return True
		Setlog("SDID Account Scroll End is Found", $COLOR_INFO)
	Else
		Return False
	EndIf

EndFunc

Func SCIDClickOnAcc($NextAcc)

	If $NextAcc > 3 Then
		For $i = 0 to $NextAcc-4
			If _Sleep(500) Then Return
			ClickDrag(700, 561, 700, 485,2000)
			If _Sleep(2000) Then Return
		Next
	EndIf
	Local $CrossPosY = FindAccCrossMark()
	If $NextAcc < 4 Then
		If CheckSCIDAccImages($NextAcc, $CrossPosY[$NextAcc]) Then
			Click(360,$CrossPosY[$NextAcc])
			If $g_DebugImageAF = 1 Then Setlog("Click on Acc Slot - " & $NextAcc & ". At - " & $CrossPosY[$NextAcc])
			Return True
		Else
			Return False
		EndIf
	Else
		_ArraySort($CrossPosY,1)
		If CheckSCIDAccImages($NextAcc, $CrossPosY[0]) Then
			Click(360,$CrossPosY[0])
			If $g_DebugImageAF = 1 Then Setlog("Click on Acc Slot - " & $NextAcc & ". At - " & $CrossPosY[0])
			Return True
		Else
			Return False
		EndIf
	EndIf

EndFunc

Func _CheckColorPixelAF($x, $y, $sColor, $iColorVariation, $bFCapture = True, $sMsglog = Default)
	Local $hPixelColor = _GetPixelColor2AF($x, $y, $bFCapture)
	Local $bFound = _ColorCheck($hPixelColor, Hex($sColor,6), Int($iColorVariation))
	Local $COLORMSG = ($bFound = True ? $COLOR_BLUE : $COLOR_RED)
	If $sMsglog <> Default And IsString($sMsglog) And $g_bDebugSetlog = True Then
		Local $String = $sMsglog & " - Ori Color: " & Hex($sColor,6) & " at X,Y: " & $x & "," & $y & " Found: " & $hPixelColor
		SetLog($String, $COLORMSG)
	EndIf
	Return $bFound
EndFunc

Func _GetPixelColor2AF($iX, $iY, $bNeedCapture = False)
	Local $aPixelColor = 0
	If $bNeedCapture = False Or $g_bRunState = False Then
		$aPixelColor = _GDIPlus_BitmapGetPixel($g_hBitmap, $iX, $iY)
	Else
		_CaptureRegion($iX - 1, $iY - 1, $iX + 1, $iY + 1)
		$aPixelColor = _GDIPlus_BitmapGetPixel($g_hBitmap, 1, 1)
	EndIf
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor