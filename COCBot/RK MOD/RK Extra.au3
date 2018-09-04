; #FUNCTION# ====================================================================================================================
; Name ..........: RK MOD Extra
; Description ...:
; Syntax ........:
; Parameters ....: ---
; Return values .: ---
; Author ........: RK
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

Func AttackPriority()
	If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
		TrainSystem()
		If Not $g_bRunState Then Return
		SetDebugLog("Are you ready? " & String($g_bIsFullArmywithHeroesAndSpells))
		If $g_bIsFullArmywithHeroesAndSpells Then
			BoostAllWithMagicSpell()
			OneGemBoost()
			If (isInsideDiamond($g_aiTownHallPos) = False) Then
				BotDetectFirstTime()
			EndIf
			If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
				Setlog("Before any other routine let's attack!!", $COLOR_INFO)
				If Not $g_bRunState Then Return
				AttackMain()
				$g_bSkipFirstZoomout = False
				If $g_bOutOfGold = True Then
					SetLog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
					$g_bFirstStart = True
					Return
				EndIf
				If _Sleep($DELAYRUNBOT1) Then Return
			EndIf
		EndIf
	EndIf
EndFunc   ;==>AttackPriority

Func BalanceRecRec($bSetLog = False)

	If Not $g_bCanRequestCC Then Return False ; Will disable donation
	If Not $g_bUseCCBalanced Then Return True ; will enable the donation

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)

	If Not $g_abRequestCCHours[$hour[0]] Then Return False ; will disable the donation


	If $g_bUseCCBalanced Then
		If $g_iTroopsDonated = 0 And $g_iTroopsReceived = 0 Then ProfileReport()
		If Number($g_iTroopsDonated) <> 0 Then
			If Number(Number($g_iTroopsReceived) / Number($g_iTroopsDonated)) >= (Number($g_iCCReceived) / Number($g_iCCDonated)) Then
				;Stop Donating
				If $bSetLog Then SetLog("Skipping Receive because Donate/Recieve Ratio is wrong", $COLOR_INFO)
				Return False
			Else
				; Continue
				Return True
			EndIf
		EndIf
	Else
		Return True
	EndIf
EndFunc   ;==>BalanceRecRec
