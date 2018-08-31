; #FUNCTION# ====================================================================================================================
; Name ..........: TNRQT
; Description ...: Train and Remove Queue Troops
; Author ........: Ahsan Iqbal
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func TNRQT()
	Local $TroopCamp = GetCurrentArmy(48, 160)
	local $Troopsdetect = CheckQueueTroops()
	;SetLog("$Troopsdetect = " $Troopsdetect, $COLOR_INFO)
EndFunc