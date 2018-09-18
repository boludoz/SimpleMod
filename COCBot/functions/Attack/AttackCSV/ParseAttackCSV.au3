; #FUNCTION# ====================================================================================================================
; Name ..........: ParseAttackCSV
; Description ...:
; Syntax ........: ParseAttackCSV([$debug = False])
; Parameters ....: $debug               - [optional]
; Return values .: None
; Author ........: Sardo (2016)
; Modified ......: MMHK (07-2017)(01-2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func ParseAttackCSV($debug = False)

	Local $rownum = 0
	Local $bForceSideExist = False
	Local $sErrorText, $sTargetVectors = ""
	Local $iTroopIndex, $bWardenDrop = False
	Local $SWIPE = ""
    Local $sides2drop[4] = [False, False , False , False]
	
;====================== Simple Mod ===========================
    For $v = 0 To 25 ; Zero all 26 vectors from last atttack in case here is error MAKE'ing new vectors
		Assign("ATTACKVECTOR_" & Chr(65 + $v), "", $ASSIGN_EXISTFAIL) ; start with character "A" = ASCII 65
		If @error Then SetLog("Failed to erase old vector: " & Chr(65 + $v) & ", ask code monkey to fix!", $COLOR_ERROR)
	Next
;====================== Simple Mod ===========================

	;Local $filename = "attack1"
	If $g_iMatchMode = $DB Then
		Local $filename = $g_sAttackScrScriptName[$DB]
	Else
		Local $filename = $g_sAttackScrScriptName[$LB]
	EndIf
	SetLog("execute " & $filename)

	Local $f, $line, $acommand, $command
	Local $value1 = "", $value2 = "", $value3 = "", $value4 = "", $value5 = "", $value6 = "", $value7 = "", $value8 = "", $value9 = ""
	If FileExists($g_sCSVAttacksPath & "\" & $filename & ".csv") Then
		Local $aLines = FileReadToArray($g_sCSVAttacksPath & "\" & $filename & ".csv")

		; Read in lines of text until the EOF is reached
		For $iLine = 0 To UBound($aLines) - 1
			$line = $aLines[$iLine]
			$rownum = $line + 1
			$sErrorText = "" ; empty error text each row
			debugAttackCSV("line: " & $iLine + 1)
			If @error = -1 Then ExitLoop
			If $debug = True Then SetLog("parse line:<<" & $line & ">>")
			debugAttackCSV("line content: " & $line)
			$acommand = StringSplit($line, "|")
			If $acommand[0] >= 8 Then
				$command = StringStripWS(StringUpper($acommand[1]), $STR_STRIPTRAILING)
				If $command = "TRAIN" Or $command = "REDLN" Or $command = "DRPLN" Or $command = "CCREQ" Then ContinueLoop ; discard setting commands
				; Set values
				For $i = 2 To (UBound($acommand) - 1)
					Assign("value" & Number($i - 1), StringStripWS(StringUpper($acommand[$i]), $STR_STRIPTRAILING))
				Next

				Switch $command
					Case ""
						debugAttackCSV("comment line")
					Case "MAKE"
						ReleaseClicks()
						If CheckCsvValues("MAKE", 2, $value2) Then
							Local $sidex = StringReplace($value2, "-", "_")
							If $sidex = "RANDOM" Then
								Switch Random(1, 4, 1)
									Case 1
										$sidex = "FRONT_"
										If Random(0, 1, 1) = 0 Then
											$sidex &= "LEFT"
										Else
											$sidex &= "RIGHT"
										EndIf
										$sides2drop[0] = True
									Case 2
										$sidex = "BACK_"
										If Random(0, 1, 1) = 0 Then
											$sidex &= "LEFT"
										Else
											$sidex &= "RIGHT"
										EndIf
										$sides2drop[1] = True
									Case 3
										$sidex = "LEFT_"
										If Random(0, 1, 1) = 0 Then
											$sidex &= "FRONT"
										Else
											$sidex &= "BACK"
										EndIf
										$sides2drop[2] = True
									Case 4
										$sidex = "RIGHT_"
										If Random(0, 1, 1) = 0 Then
											$sidex &= "FRONT"
										Else
											$sidex &= "BACK"
										EndIf
										$sides2drop[3] = True
								EndSwitch
							EndIf
							Switch Eval($sidex)
								Case StringInStr(Eval($sidex), "TOP-LEFT") > 0
									$sides2drop[0] = True
								Case StringInStr(Eval($sidex), "TOP-RIGHT") > 0
									$sides2drop[1] = True
								Case StringInStr(Eval($sidex), "BOTTOM-LEFT") > 0
									$sides2drop[2] = True
								Case StringInStr(Eval($sidex), "BOTTOM-RIGHT") > 0
									$sides2drop[3] = True
							EndSwitch
							If CheckCsvValues("MAKE", 1, $value1) And CheckCsvValues("MAKE", 5, $value5) Then
								$sTargetVectors = StringReplace($sTargetVectors, $value3, "", Default, $STR_NOCASESENSEBASIC) ; if re-making a vector, must remove from target vector string
								If CheckCsvValues("MAKE", 8, $value8) Then ; Vector is targeted towards building v7.2
									; new field definitions:
									; $side = target side string
									; value3 = Drop point count can be 1 or 5 value only
									; value4 = addtiles Ignore if value3 = 5, only used when dropping in sigle point
									; value5 = versus ignore direction
									; value6 = RandomX ignored as image find location will be "random" without need to add more variability
									; value7 = randomY ignored as image find location will be "random" without need to add more variability
									; value8 = Building target for drop points
									If $value3 = 1 Or $value3 = 5 Then ; check for valid number of drop points
										Local $tmpArray = MakeTargetDropPoints(Eval($sidex), $value3, $value4, $value8)
										If @error Then
											$sErrorText = "MakeTargetDropPoints: " & @error ; set flag
										Else
											Assign("ATTACKVECTOR_" & $value1, $tmpArray) ; assing vector
											$sTargetVectors &= $value1 ; add letter of every vector using building target to string to error check DROP command
										EndIf
									Else
										$sErrorText = "value 3"
									EndIf
								Else ; normal redline based drop vectors
									Assign("ATTACKVECTOR_" & $value1, MakeDropPoints(Eval($sidex), $value3, $value4, $value5, $value6, $value7))
								EndIf
							Else
								$sErrorText = "value1 or value 5"
							EndIf
						Else
							$sErrorText = "value2"
						EndIf
						If $sErrorText <> "" Then ; log error message
							SetLog("Discard row, bad " & $sErrorText & " parameter: row " & $iLine + 1)
							debugAttackCSV("Discard row, bad " & $sErrorText & " parameter: row " & $iLine + 1)
						Else ; debuglog vectors
							For $i = 0 To UBound(Execute("$ATTACKVECTOR_" & $value1)) - 1
								Local $pixel = Execute("$ATTACKVECTOR_" & $value1 & "[" & $i & "]")
								debugAttackCSV($i & " - " & $pixel[0] & "," & $pixel[1])
							Next
						EndIf
					Case "DROP"
						KeepClicks()
						;index...
						Local $index1, $index2, $indexArray, $indexvect
						$indexvect = StringSplit($value2, "-", 2)
						If UBound($indexvect) > 1 Then
							$indexArray = 0
							If Int($indexvect[0]) > 0 And Int($indexvect[1]) > 0 Then
								$index1 = Int($indexvect[0])
								$index2 = Int($indexvect[1])
							Else
								$index1 = 1
								$index2 = 1
							EndIf
						Else
							$indexArray = StringSplit($value2, ",", 2)
							If UBound($indexArray) > 1 Then
								$index1 = 0
								$index2 = UBound($indexArray) - 1
							Else
								$indexArray = 0
								If Int($value2) > 0 Then
									$index1 = Int($value2)
									$index2 = Int($value2)
								Else
									$index1 = 1
									$index2 = 1
								EndIf
							EndIf
						EndIf
						;quantities : With %
						Local $qty1, $qty2, $qtyvect, $bUpdateQuantity = False
						If StringInStr($value3, "%") > 0 Then
							$qtyvect = StringSplit($value3, "%", 2)
							If UBound($qtyvect) > 0 Then
								Local $iPercentage = $qtyvect[0]
								If UBound($qtyvect) > 1 Then $bUpdateQuantity = (($qtyvect[1] = "U") ? True : False)
								Local $theTroopPosition = -2

								;get the integer index of the troop name specified
								Local $troopName = $value4
								Local $iTroopIndex = TroopIndexLookup($troopName)
								If $iTroopIndex = -1 Then
									SetLog("CSV CMD '%' troop name '" & $troopName & "' is unrecognized.")
									Return
								EndIf

								For $i = 0 To UBound($g_avAttackTroops) - 1
									If $g_avAttackTroops[$i][0] = $iTroopIndex Then
										$theTroopPosition = $i
										ExitLoop
									EndIf
								Next
								If $bUpdateQuantity = True Then
									If $theTroopPosition >= 0 Then
										SetLog("Updating Available " & NameOfTroop($iTroopIndex, 1) & " Quantities", $COLOR_INFO)
										$theTroopPosition = UpdateTroopQuantity($troopName)
									EndIf
								EndIf
								If $theTroopPosition >= 0 And UBound($g_avAttackTroops) > $theTroopPosition Then
									If Int($qtyvect[0]) > 0 Then
										$qty1 = Round((Number($qtyvect[0]) / 100) * Number($g_avAttackTroops[Number($theTroopPosition)][1]))
										$qty2 = $qty1
										SetLog($qtyvect[0] & "% Of x" & Number($g_avAttackTroops[$theTroopPosition][1]) & " " & NameOfTroop($g_avAttackTroops[$theTroopPosition][0], 1) & " = " & $qty1, $COLOR_INFO)
									Else
										$index1 = 1
										$qty2 = 1
									EndIf
								Else
									$qty1 = 0
									$qty2 = 0
								EndIf
							Else
								If Int($value3) > 0 Then
									$qty1 = Int($value3)
									$qty2 = Int($value3)
								Else
									$qty1 = 1
									$qty2 = 1
								EndIf
							EndIf
						Else
							$qtyvect = StringSplit($value3, "-", 2)
							If UBound($qtyvect) > 1 Then
								If Int($qtyvect[0]) > 0 And Int($qtyvect[1]) > 0 Then
									$qty1 = Int($qtyvect[0])
									$qty2 = Int($qtyvect[1])
								Else
									$index1 = 1
									$qty2 = 1
								EndIf
							Else
								If Int($value3) > 0 Then
									$qty1 = Int($value3)
									$qty2 = Int($value3)
								Else
									$qty1 = 1
									$qty2 = 1
								EndIf
							EndIf
						EndIf
						;delay between points
						Local $delaypoints1, $delaypoints2, $delaypointsvect
						$delaypointsvect = StringSplit($value5, "-", 2)
						If UBound($delaypointsvect) > 1 Then
							If Int($delaypointsvect[0]) >= 0 And Int($delaypointsvect[1]) >= 0 Then
								$delaypoints1 = Int($delaypointsvect[0])
								$delaypoints2 = Int($delaypointsvect[1])
							Else
								$delaypoints1 = 1
								$delaypoints2 = 1
							EndIf
						Else
							If Int($value5) >= 0 Then
								$delaypoints1 = Int($value5)
								$delaypoints2 = Int($value5)
							Else
								$delaypoints1 = 1
								$delaypoints2 = 1
							EndIf
						EndIf
						;delay between  drops in same point
						Local $delaydrop1, $delaydrop2, $delaydropvect
						$delaydropvect = StringSplit($value6, "-", 2)
						If UBound($delaydropvect) > 1 Then
							If Int($delaydropvect[0]) >= 0 And Int($delaydropvect[1]) >= 0 Then
								$delaydrop1 = Int($delaydropvect[0])
								$delaydrop2 = Int($delaydropvect[1])
							Else
								$delaydrop1 = 1
								$delaydrop2 = 1
							EndIf
						Else
							If Int($value6) >= 0 Then
								$delaydrop1 = Int($value6)
								$delaydrop2 = Int($value6)
							Else
								$delaydrop1 = 1
								$delaydrop2 = 1
							EndIf
						EndIf
						;sleep time after drop
						Local $sleepdrop1, $sleepdrop2, $sleepdroppvect
						$sleepdroppvect = StringSplit($value7, "-", 2)
						If UBound($sleepdroppvect) > 1 Then
							If Int($sleepdroppvect[0]) >= 0 And Int($sleepdroppvect[1]) >= 0 Then
								$sleepdrop1 = Int($sleepdroppvect[0])
								$sleepdrop2 = Int($sleepdroppvect[1])
							Else
								$index1 = 1
								$sleepdrop2 = 1
							EndIf
						Else
							If Int($value7) >= 0 Then
								$sleepdrop1 = Int($value7)
								$sleepdrop2 = Int($value7)
							Else
								$sleepdrop1 = 1
								$sleepdrop2 = 1
							EndIf
						EndIf
;====================== Simple Mod ===========================
                        ;sleep time before drop
                        Local $sleepbeforedrop1 = 0, $sleepbeforedrop2 = 0, $sleepbeforedroppvect
                        $sleepbeforedroppvect = StringSplit($value8, "-", 2)
                        If UBound($sleepbeforedroppvect) > 1 Then
                            If Int($sleepbeforedroppvect[0]) > 0 And Int($sleepbeforedroppvect[1]) > 0 Then
                                $sleepbeforedrop1 = Int($sleepbeforedroppvect[0])
                                $sleepbeforedrop2 = Int($sleepbeforedroppvect[1])
                            Else
                                $sleepbeforedrop1 = 0
                                $sleepbeforedrop2 = 0
                            EndIf
                        Else
                            If Int($value3) > 0 Then
                                $sleepbeforedrop1 = Int($value8)
                                $sleepbeforedrop2 = Int($value8)
                            Else
                                $sleepbeforedrop1 = 0
                                $sleepbeforedrop2 = 0
                            EndIf
                        EndIf
;====================== Simple Mod ===========================
						; check for targeted vectors and validate index numbers, need too many values for check logic to use CheckCSVValues()
						Local $tmpVectorList = StringSplit($value1, "-", $STR_NOCOUNT) ; get array with all vector(s) used
						For $v = 0 To UBound($tmpVectorList) - 1 ; loop thru each vector in target list
							If StringInStr($sTargetVectors, $tmpVectorList[$v], $STR_NOCASESENSEBASIC) = True Then
								If IsArray($indexArray) Then ; is index comma separated list?
									For $i = $index1 To $index2 ; check that all values are less 5?
										If $indexArray[$i] < 1 Or $indexArray[$i] > 5 Then
											$sErrorText &= "Invalid INDEX for near building DROP"
											SetDebugLog("$index1: " & $index1 & ", $index2: " & $index2 & ", $indexArray[" & $i & "]: " & $indexArray[$i], $COLOR_ERROR)
											ExitLoop
										EndIf
									Next
								ElseIf $indexArray = 0 Then ; index is either 2 values comma separated, range "-" separated between 1 & 5, or single index
									Select
										Case $index1 = 1 And $index1 = $index2
											; do nothing, is valid
										Case $index1 >= 1 And $index1 <= 5 And $index2 > 1 And $index2 <= 5
											; do nothing valid index values for near location targets
										Case Else
											$sErrorText &= "Invalid INDEX for building target"
											SetDebugLog("$index1: " & $index1 & ", $index2: " & $index2, $COLOR_ERROR)
									EndSelect
								Else
									SetDebugLog("Monkey found a bad banana checking Bdlg target INDEX!", $COLOR_ERROR)
								EndIf
							EndIf
						Next
						If $sErrorText <> "" Then
							SetLog("Discard row, " & $sErrorText & ": row " & $iLine + 1)
							debugAttackCSV("Discard row, " & $sErrorText & ": row " & $iLine + 1)
						Else
; ============= Simple Mod - REMAIN TROOPS CVS ========================
                            ; REMAIN CMD from @chalicucu | ProMac Updated 
                            ;If $value4 = "REMAIN" or DropRemain Then
                            If $value4 = "REMAIN" Then
                                SetLog("Drop|Remain:  Dropping left over troops", $COLOR_BLUE)
                                ; Let's get the troops again and quantities
                                If PrepareAttack($g_iMatchMode, True) > 0 Then
                                    ; a Loop from all troops
                                    For $ii = $eBarb To $eBowl ; lauch all remaining troops
                                        ; Loop on all detected troops
                                        For $x = 0 To UBound($g_avAttackTroops) - 1
                                            ; If the Name exist and haves more than zero is deploy it
                                            If $g_avAttackTroops[$x][0] = $ii and $g_avAttackTroops[$x][1] > 0 Then
                                                Local $plural = 0
                                                If $g_avAttackTroops[$x][1] > 1 Then $plural = 1
                                                Local $name = NameOfTroop($g_avAttackTroops[$x][0], $plural)
                                                Setlog("Name: " & $name, $COLOR_DEBUG)
                                                Setlog("Qty: " & $g_avAttackTroops[$x][1], $COLOR_DEBUG)
                                                DropTroopFromINI($value1, $index1, $index2, $indexArray, $g_avAttackTroops[$x][1], $g_avAttackTroops[$x][1], $g_asTroopShortNames[$ii], $delaypoints1, $delaypoints2, $delaydrop1, $delaydrop2, $sleepdrop1, $sleepdrop2, $sleepbeforedrop1, $sleepbeforedrop2, $debug)
                                                CheckHeroesHealth()
                                                If _Sleep($DELAYALGORITHM_ALLTROOPS5) Then Return
                                            EndIf
                                        Next
                                    Next
                                EndIf
                            Else
                                DropTroopFromINI($value1, $index1, $index2, $indexArray, $qty1, $qty2, $value4, $delaypoints1, $delaypoints2, $delaydrop1, $delaydrop2, $sleepdrop1, $sleepdrop2, $sleepbeforedrop1, $sleepbeforedrop2, $debug)
                            EndIf
; ============= Simple Mod - REMAIN TROOPS CVS ========================
						EndIf
						ReleaseClicks($g_iAndroidAdbClicksTroopDeploySize)
						If _Sleep($DELAYRESPOND) Then Return ; check for pause/stop
						;set flag if warden was dropped and sleep after delay was to short for icon to update properly
						$iTroopIndex = TroopIndexLookup($value4, "ParseAttackCSV") ; obtain enum
						$bWardenDrop = ($iTroopIndex = $eWarden) And ($sleepdrop1 < 1000)
					Case "WAIT"
						ReleaseClicks()
						;sleep time
						Local $sleep1, $sleep2, $sleepvect
						$sleepvect = StringSplit($value1, "-", 2)
						If UBound($sleepvect) > 1 Then
						$sleepvect[0]
							If Int($sleepvect[0]) > 0 And Int($sleepvect[1]) > 0 Then
								$sleep1 = Int($sleepvect[0]) ;/ $g_iMultWaitCVS)
								$sleep2 = Int($sleepvect[1]) ;/ $g_iMultWaitCVS)
							Else
								$sleep1 = 1
								$sleep2 = 1
							EndIf
						Else
							If Int($value3) > 0 Then
								$sleep1 = Int($value1)
								$sleep2 = Int($value1)
							Else
								$sleep1 = 1
								$sleep2 = 1
							EndIf
						EndIf
						If $sleep1 <> $sleep2 Then
							Local $sleep = Random(Int($sleep1), Int($sleep2), 1)
						Else
							Local $sleep = Int($sleep1)
						EndIf
						Local $iSleepS = Int($sleep1 / $g_iMultWaitCVS)
						Setlog("Wait time: " & $sleep & " /" & $g_iMultWaitCVS & " = " & $iSleepS, $COLOR_GREEN)
						$sleep = Int($sleep1 / $g_iMultWaitCVS)

						debugAttackCSV("wait " & $sleep)
						;If _Sleep($sleep) Then Return
						Local $Gold = 0
						Local $Elixir = 0
						Local $DarkElixir = 0
						Local $Trophies = 0
						Local $exitOneStar = 0
						Local $exitTwoStars = 0
						Local $exitNoResources = 0
						Local $hSleepTimer = __TimerInit()
						While __TimerDiff($hSleepTimer) < $sleep
							CheckHeroesHealth()
							;READ RESOURCES
							$Gold = getGoldVillageSearch(48, 69)
							$Elixir = getElixirVillageSearch(48, 69 + 29)
							If _Sleep($DELAYRESPOND) Then Return ; check for pause/stop
							$Trophies = getTrophyVillageSearch(48, 69 + 99)
							If $Trophies <> "" Then ; If trophy value found, then base has Dark Elixir
								$DarkElixir = getDarkElixirVillageSearch(48, 69 + 57)
							Else
								$DarkElixir = ""
								$Trophies = getTrophyVillageSearch(48, 69 + 69)
							EndIf
							CheckHeroesHealth()
							If $g_bDebugSetlog Then SetLog("detected [G]: " & $Gold & " [E]: " & $Elixir & " [DE]: " & $DarkElixir, $COLOR_INFO)
							;EXIT IF RESOURCES = 0
							If $g_abStopAtkNoResources[$g_iMatchMode] And Number($Gold) = 0 And Number($Elixir) = 0 And Number($DarkElixir) = 0 Then
								If Not $g_bDebugSetlog Then SetDebugLog("detected [G]: " & $Gold & " [E]: " & $Elixir & " [DE]: " & $DarkElixir, $COLOR_INFO) ; log if not down above
								SetDebugLog("From Attackcsv: Gold & Elixir & DE = 0, end battle ", $COLOR_DEBUG)
								$exitNoResources = 1
								ExitLoop
							EndIf
							;CALCULATE TWO STARS REACH
							If $g_abStopAtkTwoStars[$g_iMatchMode] And _CheckPixel($aWonTwoStar, True) Then
								SetDebugLog("From Attackcsv: Two Star Reach, exit", $COLOR_SUCCESS)
								$exitTwoStars = 1
								ExitLoop
							EndIf
							;CALCULATE ONE STARS REACH
							If $g_abStopAtkOneStar[$g_iMatchMode] And _CheckPixel($aWonOneStar, True) Then
								SetDebugLog("From Attackcsv: One Star Reach, exit", $COLOR_SUCCESS)
								$exitOneStar = 1
								ExitLoop
							EndIf
							If $g_abStopAtkPctHigherEnable[$g_iMatchMode] And Number(getOcrOverAllDamage(780, 527 + $g_iBottomOffsetY)) > Int($g_aiStopAtkPctHigherAmt[$g_iMatchMode]) Then
								ExitLoop
							EndIf
							If _Sleep($DELAYRESPOND) Then Return ; check for pause/stop
						WEnd
						If $exitOneStar = 1 Or $exitTwoStars = 1 Or $exitNoResources = 1 Then ExitLoop ;stop parse CSV file, start exit battle procedure

					Case "RECALC"
						ReleaseClicks()
						PrepareAttack($g_iMatchMode, True)
					Case "SWIPE"
						ReleaseClicks()
						$value1 = StringStripWS($value1, $STR_STRIPALL)
						$value2 = Int(StringStripWS($value2, $STR_STRIPALL))
						$value3 = Int(StringStripWS($value3, $STR_STRIPALL))
						$value4 = Int(StringStripWS($value4, $STR_STRIPALL))

						If $value3 = 0 Then $value3 = 400
						If $value4 = 0 Then $value4 = 250

						Local $iDragPixelDistance = 700
						If $value2 <> 0 Then
							$iDragPixelDistance	= Random($value2 - 5, $value2 + 5, 1)
						Else
							$iDragPixelDistance = Random(695 - 5, 705, 1)
						EndIf
						Select
							Case $value1 = "RIGHT"
								$SWIPE = "RIGHT"
								SetLog("SWIPE RIGHT")
								Local $iStartX = Random(770,780,1)
								ClickDrag($iStartX,Random(680,690,1),$iStartX - $iDragPixelDistance,Random(680,690,1),$value4)
								If _Sleep($value3) Then Return
								PrepareAttack($g_iMatchMode, True)
							Case $value1 = "LEFT"
								$SWIPE = "LEFT"
								SetLog("SWIPE LEFT")
								Local $iStartX = Random(35,45,1)
								ClickDrag($iStartX,Random(680,690,1),$iStartX + $iDragPixelDistance,Random(680,690,1),$value4)
								If _Sleep($value3) Then Return
								PrepareAttack($g_iMatchMode, True)
						EndSelect
						
					Case "SIDE"
						ReleaseClicks()
						SetLog("Calculate main side... ")
						Local $heightTopLeft = 0, $heightTopRight = 0, $heightBottomLeft = 0, $heightBottomRight = 0
						If StringUpper($value8) = "TOP-LEFT" Or StringUpper($value8) = "TOP-RIGHT" Or StringUpper($value8) = "BOTTOM-LEFT" Or StringUpper($value8) = "BOTTOM-RIGHT" Then
							$MAINSIDE = StringUpper($value8)
							SetLog("Forced side: " & StringUpper($value8), $COLOR_INFO)
							$bForceSideExist = True
						Else


							For $i = 0 To UBound($g_aiPixelMine) - 1
								Local $str = ""
								Local $pixel = $g_aiPixelMine[$i]
								If UBound($pixel) = 2 Then
									Switch StringLeft(Slice8($pixel), 1)
										Case 1, 2
											$heightBottomRight += Int($value1)
										Case 3, 4
											$heightTopRight += Int($value1)
										Case 5, 6
											$heightTopLeft += Int($value1)
										Case 7, 8
											$heightBottomLeft += Int($value1)
									EndSwitch
								EndIf
							Next

							For $i = 0 To UBound($g_aiPixelElixir) - 1
								Local $str = ""
								Local $pixel = $g_aiPixelElixir[$i]
								If UBound($pixel) = 2 Then
									Switch StringLeft(Slice8($pixel), 1)
										Case 1, 2
											$heightBottomRight += Int($value2)
										Case 3, 4
											$heightTopRight += Int($value2)
										Case 5, 6
											$heightTopLeft += Int($value2)
										Case 7, 8
											$heightBottomLeft += Int($value2)
									EndSwitch
								EndIf
							Next

							For $i = 0 To UBound($g_aiPixelDarkElixir) - 1
								Local $str = ""
								Local $pixel = $g_aiPixelDarkElixir[$i]
								If UBound($pixel) = 2 Then
									Switch StringLeft(Slice8($pixel), 1)
										Case 1, 2
											$heightBottomRight += Int($value3)
										Case 3, 4
											$heightTopRight += Int($value3)
										Case 5, 6
											$heightTopLeft += Int($value3)
										Case 7, 8
											$heightBottomLeft += Int($value3)
									EndSwitch
								EndIf
							Next

							If IsArray($g_aiCSVGoldStoragePos) Then
								For $i = 0 To UBound($g_aiCSVGoldStoragePos) - 1
									Local $pixel = $g_aiCSVGoldStoragePos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							If IsArray($g_aiCSVElixirStoragePos) Then
								For $i = 0 To UBound($g_aiCSVElixirStoragePos) - 1
									Local $pixel = $g_aiCSVElixirStoragePos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value5)
											Case 3, 4
												$heightTopRight += Int($value5)
											Case 5, 6
												$heightTopLeft += Int($value5)
											Case 7, 8
												$heightBottomLeft += Int($value5)
										EndSwitch
									EndIf
								Next
							EndIf

							Switch StringLeft(Slice8($g_aiCSVDarkElixirStoragePos), 1)
								Case 1, 2
									$heightBottomRight += Int($value6)
								Case 3, 4
									$heightTopRight += Int($value6)
								Case 5, 6
									$heightTopLeft += Int($value6)
								Case 7, 8
									$heightBottomLeft += Int($value6)
							EndSwitch

							Local $pixel = StringSplit($g_iTHx & "-" & $g_iTHy, "-", 2)
							Switch StringLeft(Slice8($pixel), 1)
								Case 1, 2
									$heightBottomRight += Int($value7)
								Case 3, 4
									$heightTopRight += Int($value7)
								Case 5, 6
									$heightTopLeft += Int($value7)
								Case 7, 8
									$heightBottomLeft += Int($value7)
							EndSwitch
						EndIf

						If $bForceSideExist = False Then
							Local $maxValue = $heightBottomRight
							Local $sidename = "BOTTOM-RIGHT"

							If $heightTopLeft > $maxValue Then
								$maxValue = $heightTopLeft
								$sidename = "TOP-LEFT"
							EndIf

							If $heightTopRight > $maxValue Then
								$maxValue = $heightTopRight
								$sidename = "TOP-RIGHT"
							EndIf

							If $heightBottomLeft > $maxValue Then
								$maxValue = $heightBottomLeft
								$sidename = "BOTTOM-LEFT"
							EndIf

							SetLog("Mainside: " & $sidename & " (top-left:" & $heightTopLeft & " top-right:" & $heightTopRight & " bottom-left:" & $heightBottomLeft & " bottom-right:" & $heightBottomRight)
							$MAINSIDE = $sidename
						EndIf

						Switch $MAINSIDE
							Case "BOTTOM-RIGHT"
								$FRONT_LEFT = "BOTTOM-RIGHT-DOWN"
								$FRONT_RIGHT = "BOTTOM-RIGHT-UP"
								$RIGHT_FRONT = "TOP-RIGHT-DOWN"
								$RIGHT_BACK = "TOP-RIGHT-UP"
								$LEFT_FRONT = "BOTTOM-LEFT-DOWN"
								$LEFT_BACK = "BOTTOM-LEFT-UP"
								$BACK_LEFT = "TOP-LEFT-DOWN"
								$BACK_RIGHT = "TOP-LEFT-UP"
							Case "BOTTOM-LEFT"
								$FRONT_LEFT = "BOTTOM-LEFT-UP"
								$FRONT_RIGHT = "BOTTOM-LEFT-DOWN"
								$RIGHT_FRONT = "BOTTOM-RIGHT-DOWN"
								$RIGHT_BACK = "BOTTOM-RIGHT-UP"
								$LEFT_FRONT = "TOP-LEFT-DOWN"
								$LEFT_BACK = "TOP-LEFT-UP"
								$BACK_LEFT = "TOP-RIGHT-UP"
								$BACK_RIGHT = "TOP-RIGHT-DOWN"
							Case "TOP-LEFT"
								$FRONT_LEFT = "TOP-LEFT-UP"
								$FRONT_RIGHT = "TOP-LEFT-DOWN"
								$RIGHT_FRONT = "BOTTOM-LEFT-UP"
								$RIGHT_BACK = "BOTTOM-LEFT-DOWN"
								$LEFT_FRONT = "TOP-RIGHT-UP"
								$LEFT_BACK = "TOP-RIGHT-DOWN"
								$BACK_LEFT = "BOTTOM-RIGHT-UP"
								$BACK_RIGHT = "BOTTOM-RIGHT-DOWN"
							Case "TOP-RIGHT"
								$FRONT_LEFT = "TOP-RIGHT-DOWN"
								$FRONT_RIGHT = "TOP-RIGHT-UP"
								$RIGHT_FRONT = "TOP-LEFT-UP"
								$RIGHT_BACK = "TOP-LEFT-DOWN"
								$LEFT_FRONT = "BOTTOM-RIGHT-UP"
								$LEFT_BACK = "BOTTOM-RIGHT-DOWN"
								$BACK_LEFT = "BOTTOM-LEFT-DOWN"
								$BACK_RIGHT = "BOTTOM-LEFT-UP"
						EndSwitch

					Case "SIDEB"
						ReleaseClicks()
						If $bForceSideExist = False Then
							SetLog("Recalculate main side for additional defense buildings... ", $COLOR_INFO)

							Switch StringLeft(Slice8($g_aiCSVEagleArtilleryPos), 1)
								Case 1, 2
									$heightBottomRight += Int($value1)
								Case 3, 4
									$heightTopRight += Int($value1)
								Case 5, 6
									$heightTopLeft += Int($value1)
								Case 7, 8
									$heightBottomLeft += Int($value1)
							EndSwitch

							If IsArray($g_aiCSVInfernoPos) Then
								For $i = 0 To UBound($g_aiCSVInfernoPos) - 1
									Local $pixel = $g_aiCSVInfernoPos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							If IsArray($g_aiCSVXBowPos) Then
								For $i = 0 To UBound($g_aiCSVXBowPos) - 1
									Local $pixel = $g_aiCSVXBowPos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							If IsArray($g_aiCSVWizTowerPos) Then
								For $i = 0 To UBound($g_aiCSVWizTowerPos) - 1
									Local $pixel = $g_aiCSVWizTowerPos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							If IsArray($g_aiCSVMortarPos) Then
								For $i = 0 To UBound($g_aiCSVMortarPos) - 1
									Local $pixel = $g_aiCSVMortarPos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							If IsArray($g_aiCSVAirDefensePos) Then
								For $i = 0 To UBound($g_aiCSVAirDefensePos) - 1
									Local $pixel = $g_aiCSVAirDefensePos[$i]
									If UBound($pixel) = 2 Then
										Switch StringLeft(Slice8($pixel), 1)
											Case 1, 2
												$heightBottomRight += Int($value4)
											Case 3, 4
												$heightTopRight += Int($value4)
											Case 5, 6
												$heightTopLeft += Int($value4)
											Case 7, 8
												$heightBottomLeft += Int($value4)
										EndSwitch
									EndIf
								Next
							EndIf

							Local $maxValue = $heightBottomRight
							Local $sidename = "BOTTOM-RIGHT"

							If $heightTopLeft > $maxValue Then
								$maxValue = $heightTopLeft
								$sidename = "TOP-LEFT"
							EndIf

							If $heightTopRight > $maxValue Then
								$maxValue = $heightTopRight
								$sidename = "TOP-RIGHT"
							EndIf

							If $heightBottomLeft > $maxValue Then
								$maxValue = $heightBottomLeft
								$sidename = "BOTTOM-LEFT"
							EndIf

							SetLog("New Mainside: " & $sidename & " (top-left:" & $heightTopLeft & " top-right:" & $heightTopRight & " bottom-left:" & $heightBottomLeft & " bottom-right:" & $heightBottomRight, $COLOR_INFO)
							$MAINSIDE = $sidename
						EndIf
						Switch $MAINSIDE
							Case "BOTTOM-RIGHT"
								$FRONT_LEFT = "BOTTOM-RIGHT-DOWN"
								$FRONT_RIGHT = "BOTTOM-RIGHT-UP"
								$RIGHT_FRONT = "TOP-RIGHT-DOWN"
								$RIGHT_BACK = "TOP-RIGHT-UP"
								$LEFT_FRONT = "BOTTOM-LEFT-DOWN"
								$LEFT_BACK = "BOTTOM-LEFT-UP"
								$BACK_LEFT = "TOP-LEFT-DOWN"
								$BACK_RIGHT = "TOP-LEFT-UP"
							Case "BOTTOM-LEFT"
								$FRONT_LEFT = "BOTTOM-LEFT-UP"
								$FRONT_RIGHT = "BOTTOM-LEFT-DOWN"
								$RIGHT_FRONT = "BOTTOM-RIGHT-DOWN"
								$RIGHT_BACK = "BOTTOM-RIGHT-UP"
								$LEFT_FRONT = "TOP-LEFT-DOWN"
								$LEFT_BACK = "TOP-LEFT-UP"
								$BACK_LEFT = "TOP-RIGHT-UP"
								$BACK_RIGHT = "TOP-RIGHT-DOWN"
							Case "TOP-LEFT"
								$FRONT_LEFT = "TOP-LEFT-UP"
								$FRONT_RIGHT = "TOP-LEFT-DOWN"
								$RIGHT_FRONT = "BOTTOM-LEFT-UP"
								$RIGHT_BACK = "BOTTOM-LEFT-DOWN"
								$LEFT_FRONT = "TOP-RIGHT-UP"
								$LEFT_BACK = "TOP-RIGHT-DOWN"
								$BACK_LEFT = "BOTTOM-RIGHT-UP"
								$BACK_RIGHT = "BOTTOM-RIGHT-DOWN"
							Case "TOP-RIGHT"
								$FRONT_LEFT = "TOP-RIGHT-DOWN"
								$FRONT_RIGHT = "TOP-RIGHT-UP"
								$RIGHT_FRONT = "TOP-LEFT-UP"
								$RIGHT_BACK = "TOP-LEFT-DOWN"
								$LEFT_FRONT = "BOTTOM-RIGHT-UP"
								$LEFT_BACK = "BOTTOM-RIGHT-DOWN"
								$BACK_LEFT = "BOTTOM-LEFT-DOWN"
								$BACK_RIGHT = "BOTTOM-LEFT-UP"
						EndSwitch

					Case Else
						Switch StringLeft($command, 1)
							Case ";", "#", "'"
								; also comment
								debugAttackCSV("comment line")
							Case Else
								SetLog("attack row bad, discard: row " & $iLine + 1, $COLOR_ERROR)
						EndSwitch
				EndSwitch
			Else
				If StringLeft($line, 7) <> "NOTE  |" And StringLeft($line, 7) <> "      |" And StringStripWS(StringUpper($line), 2) <> "" Then SetLog("attack row error, discard: row " & $iLine + 1, $COLOR_ERROR)
			EndIf
			If $bWardenDrop = True Then ;Check hero, but skip Warden if was dropped with sleepafter to short to allow icon update
				Local $bHold = $g_bCheckWardenPower ; store existing flag state, should be true?
				$g_bCheckWardenPower = False ;temp disable warden health check
				CheckHeroesHealth()
				$g_bCheckWardenPower = $bHold ; restore flag state
			Else
				CheckHeroesHealth()
			EndIf
			If _Sleep($DELAYRESPOND) Then Return ; check for pause/stop after each line of CSV
		Next
		For $i = 0 To 3
			If $sides2drop[$i] Then $g_iSidesAttack += 1
		Next
		ReleaseClicks()
	Else
		SetLog("Cannot find attack file " & $g_sCSVAttacksPath & "\" & $filename & ".csv", $COLOR_ERROR)
	EndIf
EndFunc   ;==>ParseAttackCSV
