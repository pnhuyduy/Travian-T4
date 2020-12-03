<?php
    $showAllTroops = TRUE;
    if (isset($_GET['aid']) && $_GET['aid'] == $session->alliance) {
        $dataarray = explode(",", $database->getNotice2($_GET['id'], 'data'));
        $rowtopic = $database->getNotice2($_GET['id'], 'topic');
        $topics = explode('[=]', $rowtopic);
        $topCount = count($topics);
        if ($topCount == 2) {
            if ($topics[0] == 'REPORT_REINFATTACKED') {
                $showAllTroops = FALSE;
            }
            $t1 = explode('[|]', $topics[1]);
            if (defined($t1[0])) $t1[0] = constant($t1[0]);
            for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
            $topic = sprintf(constant($topics[0]), $t1[0]);
        } elseif ($topCount == 3) {
            $t1 = explode('[|]', $topics[1]);
            if (defined($t1[0])) $t1[0] = constant($t1[0]);
            for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
            $t2 = explode('[|]', $topics[2]);
            if (defined($t2[0])) $t2[0] = constant($t2[0]);
            for ($i = 1; $i < count($t2); $i++) $t2[0] .= $t2[$i];
            $topic = sprintf(constant($topics[0]), $t1[0], $t2[0]);
        } else {
            $topic = $rowtopic;
        }
        $time = $database->getNotice2($_GET['id'], 'time');
    } else {
        $dataarray = explode(",", $message->readingNotice['data']);
        $rowtopic = $message->readingNotice['topic'];
        $topics = explode('[=]', $rowtopic);
        $topCount = count($topics);
        if ($topCount == 2) {
            if ($topics[0] == 'REPORT_REINFATTACKED') {
                $showAllTroops = FALSE;
            }
            $t1 = explode('[|]', $topics[1]);
            if (defined($t1[0])) $t1[0] = constant($t1[0]);
            for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
            $topic = sprintf(constant($topics[0]), $t1[0]);
        } elseif ($topCount == 3) {
            $t1 = explode('[|]', $topics[1]);
            if (defined($t1[0])) $t1[0] = constant($t1[0]);
            for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
            $t2 = explode('[|]', $topics[2]);
            if (defined($t2[0])) $t2[0] = constant($t2[0]);
            for ($i = 1; $i < count($t2); $i++) $t2[0] .= $t2[$i];
            $topic = sprintf(constant($topics[0]), $t1[0], $t2[0]);
        } else {
            $topic = $rowtopic;
        }
        $time = $message->readingNotice['time'];
    }
    $noticeOwnerUid = $database->getNotice2($_GET['id'], 'uid');
    $defenderUid = $dataarray[30];
    $attackerUid = $dataarray[0];
    if (($noticeOwnerUid != $defenderUid) && ($noticeOwnerUid != $attackerUid) && $session->uid != 4) {
        $showThemAll = FALSE;
    } else {
        $showThemAll = TRUE;
    }
    if ($session->access >= MULTIHUNTER) {
        $showThemAll = TRUE;
        $showAllTroops = TRUE;
    }
    $da1name = $database->getVillageField($dataarray[1], 'name');
    if (defined($da1name)) $da1name = constant($da1name);
?>
<div class="clear"></div>
<div class="paper" id="report_surround">
<div class="layout">
<div class="paperTop">
<div class="paperContent">
<div id="subject">
    <div class="header label"><?php echo AL_SUBJECT; ?></div>
    <div class="header text"><?php echo $topic; ?></div>
    <div class="clear"></div>
</div>

<div id="time">
    <?php $date = $generator->procMtime($time); ?>
    <div class="header label"><?php echo MS_SENT; ?></div>
    <div class="header text"><?php echo $date[0] . "<span> " . AT_AT . " " . $date[1]; ?></span></div>
    <div class="toolList">
        <button type="button" class="icon " onclick="return Travian.Game.Reports.editRights(this,
	{
		text:
		{
			anonymOpponent:		'make opponent anonymous',
			anonymMyself:		'make myself anonymous',
			hiddenOwnTroops:	'hide own troops',
			hiddenOtherTroops:	'hide opposing troops',
			description:		'Description:',
			buttonTextOk:		'save',
			buttonTextCancel:	'cancel',
			title:				'Access permissions'
		},
		datas:
		{
			reportId:	'21073608'
		}
	});"><img src="img/x.gif" class="reportButton access" alt="reportButton access"></button>
        <?php if ($session->plus) { ?>
            <button type="button" value="reportButton delete" class="icon" title="<?php echo AL_DELETE; ?>"
                    onclick="return (function(){
                        ('<?php echo AL_AREYOUSURE; ?>').dialog({
                        onOkay: function(dialog, contentElement){
                        window.location.href = '?n1=<?php echo $_GET['id']; ?>&amp;del=1'}
                        });
                        return false;
                        })()"><img src="img/x.gif" class="reportButton delete" alt="reportButton delete"/></button>
        <?php } ?>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>
<div id="message">
<?php
    $result = mysql_query('SELECT `nopicn` ' . TB_PREFIX . 'users_setting WHERE id = ' . $session->uid . ' LIMIT 1');
    $query = mysql_fetch_assoc($result);
    if ($query['nopicn'] == 0) {
        ?>
        <img src="img/x.gif" class="reportImage reportType1" alt="">
    <?php }
    if ($showThemAll && $showAllTroops) { ?>
        <table id="attacker" cellpadding="0" cellspacing="0">
        <thead>
        <tr>
            <td class="role">
                <div class="boxes boxesColor red">
                    <div class="boxes-tl"></div>
                    <div class="boxes-tr"></div>
                    <div class="boxes-tc"></div>
                    <div class="boxes-ml"></div>
                    <div class="boxes-mr"></div>
                    <div class="boxes-mc"></div>
                    <div class="boxes-bl"></div>
                    <div class="boxes-br"></div>
                    <div class="boxes-bc"></div>
                    <div class="boxes-contents">
                        <div class="role"><?php echo REPORT_ATTACKER; ?></div>
                    </div>
                </div>
            </td>
            <td class="troopHeadline" colspan="11">
                 
<a href="spieler.php?uid=<?php echo $database->getUserField($dataarray[0], "id", 0); ?>"><?php echo $database->getUserField($dataarray[0], "username", 0); ?></a> <?php echo REPORT_FROM_VIL; ?>
               <?php $coor = $database->getCoor($dataarray[1]); ?>
			   <a href="position_details.php?x=<?php echo $coor['x'] . "&amp;y=" . $coor['y']; ?>"><?php echo $da1name; ?></a>

                <div class="toolList">
                    <?php if ($session->plus) { ?>
                        <button type="button" value="reportButton warsim" class="icon"
                                title="<?php echo REPORT_WARSIM; ?>"
                                onclick="window.location.href = 'warsim.php?bid=<?php echo $_GET['id']; ?>'; return false;">
                            <img src="img/x.gif" class="reportButton warsim" alt="reportButton warsim"/></button>
                        <button type="button" value="reportButton repeat" class="icon"
                                title="<?php echo REPORT_ATK_AGAIN; ?>"
                                onclick="window.location.href = 'a2b.php?bid=<?php echo $_GET['id']; ?>'; return false;">
                            <img src="img/x.gif" class="reportButton repeat" alt="reportButton repeat"/></button>
                    <?php } ?>
                    <div class="clear"></div>
                </div>

            </td>
        </tr>
        </thead>
        <tbody class="units">
        <tr>
            <th class="coords"></th>
            <?php
                $start = $dataarray[2] == 1 ? 1 : (($dataarray[2] == 2) ? 11 : (($dataarray[2] == 3) ? 21 : (($dataarray[2] == 4) ? 31 : 41)));
                for ($i = $start; $i <= ($start + 9); $i++) {
                    echo "<td class=\"uniticon\"><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                }
                echo "<td class=\"uniticon last\"><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
                echo "</tr>";

                echo "<tr><th>" . AT_TROOPS . "</th>";
                for ($i = 3; $i <= 12; $i++) {
                    if ($dataarray[$i] == 0) {
                        echo "<td class=\"unit none\">0</td>";
                    } else {
                        echo "<td class=\"unit\">" . $dataarray[$i] . "</td>";
                    }
                }
                if ($dataarray[13] == 0) {
                    echo "<td class=\"unit none last\">0</td>";
                } else {
                    echo "<td class=\"unit last\">" . $dataarray[13] . "</td>";
                }
                if ($dataarray[166] > 0) {
            ?>
        <tr>
            <th><?php echo '<img class="unit u99" src="img/x.gif"/> ' . REPORT_TRAPPED; ?></th>
            <?php
                for ($i = 167; $i <= 176; $i++) {
                    if ($dataarray[$i] == 0) {
                        echo "<td class=\"unit none\">0</td>";
                    } else {
                        echo "<td class=\"unit\">" . $dataarray[$i] . "</td>";
                    }
                }
                if ($dataarray[177] == 0) {
                    echo "<td class=\"unit none last\">0</td>";
                } else {
                    echo "<td class=\"unit last\">" . $dataarray[177] . "</td>";
                }
            ?>
        </tr>
        <?php
            }
        ?>
        </tr>
        </tbody>
        <tbody class="units last">
        <tr>
            <th><?php echo REPORT_CASUALTIES; ?></th>
            <?php
                for ($i = 14; $i <= 23; $i++) {
                    if ($dataarray[$i] == 0) {
                        echo "<td class=\"unit none\">0</td>";
                    } else {
                        echo "<td class=\"unit\">" . $dataarray[$i] . "</td>";
                    }
                }
                if ($dataarray[24] == 0) {
                    echo "<td class=\"unit none last\">0</td>";
                } else {
                    echo "<td class=\"unit last\">" . $dataarray[24] . "</td>";
                }
            ?>
        </tr>
        </tbody>
        <?php if ($dataarray[151] != '' and $dataarray[152] != '' and $dataarray[153] != '') { //ram
            ?>
            <tbody>
            <tr>
                <td class="empty" colspan="12"></td>
            </tr>
            </tbody>
            <tbody class="goods">
            <tr>
                <th><?php echo REPORT_INFORMATION; ?></th>
                <td colspan="11">
                    <img class="unit u<?php echo $dataarray[151]; ?>" src="img/x.gif"
                         alt="<?php echo $technology->unarray[$dataarray[151]]; ?>"
                         title="<?php echo $technology->unarray[$dataarray[151]]; ?>"/>
                    <img class="unit g<?php echo $dataarray[152]; ?>Icon" src="img/x.gif"
                         alt="<?php echo constant('B' . $dataarray[152]); ?>"
                         title="<?php echo constant('B' . $dataarray[152]); ?>"/>
                    <?php
                        $ramp = explode('[=]', $dataarray[153]);
                        if (count($ramp) == 2) {
                            echo sprintf(constant($ramp[0]), $ramp[1]);
                        } else {
                            echo constant($ramp[0]);
                        }
                    ?>
                </td>
            </tr>
            </tbody>
        <?php
        }
            if ($dataarray[154] != '' and $dataarray[155] != '' and $dataarray[156] != '') { //cata
                ?>
                <tbody>
                <tr>
                    <td class="empty" colspan="12"></td>
                </tr>
                </tbody>
                <tbody class="goods">
                <tr>
                    <th><?php echo REPORT_INFORMATION; ?></th>
                    <td colspan="11">
                        <img class="unit u<?php echo $dataarray[154]; ?>" src="img/x.gif"
                             alt="<?php echo $technology->unarray[$dataarray[154]]; ?>"
                             title="<?php echo $technology->unarray[$dataarray[154]]; ?>"/>
                        <img class="unit g<?php echo $dataarray[155]; ?>Icon" src="img/x.gif"
                             alt="<?php echo constant('B' . $dataarray[155]); ?>"
                             title="<?php echo constant('B' . $dataarray[155]); ?>"/>
                        <?php
                            $cps = explode('[=]', $dataarray[156]);
                            if (count($cps) == 4)
                                echo sprintf(constant($cps[0]), constant($cps[1]), $cps[2], $cps[3]);
                            else
                                echo sprintf(constant($cps[0]), constant($cps[1]));
                        ?>
                    </td>
                </tr>
                </tbody>
            <?php
            }
            if ($dataarray[157] != '' and $dataarray[158] != '' and $dataarray[159] != '') { //cata2
                ?>
                <tbody>
                <tr>
                    <td class="empty" colspan="12"></td>
                </tr>
                </tbody>
                <tbody class="goods">
                <tr>
                    <th><?php echo REPORT_INFORMATION; ?></th>
                    <td colspan="11">
                        <img class="unit u<?php echo $dataarray[157]; ?>" src="img/x.gif"
                             alt="<?php echo $technology->unarray[$dataarray[157]]; ?>"
                             title="<?php echo $technology->unarray[$dataarray[157]]; ?>"/>
                        <img class="unit g<?php echo $dataarray[158]; ?>Icon" src="img/x.gif"
                             alt="<?php echo constant('B' . $dataarray[158]); ?>"
                             title="<?php echo constant('B' . $dataarray[158]); ?>"/>
                        <?php
                            $cps = explode('[=]', $dataarray[159]);

                            if (count($cps) == 4)
                                echo sprintf(constant($cps[0]), constant($cps[1]), $cps[2], $cps[3]);
                            else
                                echo sprintf(constant($cps[0]), constant($cps[1]));
                        ?>
                    </td>
                </tr>
                </tbody>
            <?php
            }
            if ($dataarray[160] != '' and $dataarray[161] != '') { //chief
                ?>
                <tbody>
                <tr>
                    <td class="empty" colspan="12"></td>
                </tr>
                </tbody>
                <tbody class="goods">
                <tr>
                    <th><?php echo REPORT_INFORMATION; ?></th>
                    <td colspan="11">
                        <img class="unit u<?php echo $dataarray[160]; ?>" src="img/x.gif"
                             alt="<?php echo $technology->unarray[$dataarray[160]]; ?>"
                             title="<?php echo $technology->unarray[$dataarray[160]]; ?>"/>
                        <?php
                            $lps = explode('[=]', $dataarray[161]);
                            if (count($lps) == 3) {
                                echo sprintf(constant($lps[0]), $lps[1], $lps[2]);
                            } elseif (count($lps) == 1) {
                                echo constant($lps[0]);
                            }
                        ?>
                    </td>
                </tr>
                </tbody>
            <?php } ?>
        <?php if ($dataarray[164] != '' and $dataarray[165] != '') { //hero
            ?>
            <tbody>
            <tr>
                <td class="empty" colspan="12"></td>
            </tr>
            </tbody>
            <tbody class="goods">
            <tr>
                <th><?php echo REPORT_INFORMATION; ?></th>
                <td colspan="11">
                    <img class="unit uhero" src="img/x.gif" alt="hero" title="hero"/>
                    <?php
                        $herop = explode('[=]', $dataarray[165]);
                        if (count($herop) == 1) {
                            echo(defined($dataarray[165]) ? constant($dataarray[165]) : $dataarray[165]);
                        } elseif (count($herop) == 2) {
                            echo sprintf(constant($herop[0]), $herop[1]);
                        }
                    ?>
                </td>
            </tr>
            </tbody>
        <?php } ?>
        <?php if ($dataarray[162] != '' and $dataarray[163] != '') { //spy
            ?>
            <tbody>
            <tr>
                <td class="empty" colspan="12"></td>
            </tr>
            </tbody>
            <tbody class="goods">
            <tr>
                <th><?php echo REPORT_INFORMATION; ?></th>
                <td colspan="11">
                    <?php
                        $spyP = explode('[=]', $dataarray[163]);
                        if (count($spyP) == 4) {
                            $wt = constant('B' . $spyP[2]);
                            echo sprintf(constant($spyP[0]), $spyP[1], $spyP[2], $wt, $wt, $spyP[3]);
                        } elseif (count($spyP) == 6) {
                            echo sprintf(constant($spyP[0]), $spyP[1], $spyP[2], $spyP[3], $spyP[4], $spyP[5]);
                        }
                    ?>
                </td>
            </tr>
            </tbody>
        <?php } ?>
        <tbody>
        <tr>
            <td class="empty" colspan="12"></td>
        </tr>
        </tbody>
        <tbody class="goods">
        <tr>
            <th><?php echo REPORT_BOUNTY; ?></th>
            <td colspan="11">
                <div class="res">
                    <div class="rArea"><img class="r1" src="img/x.gif"
                                            title="<?php echo VL_LUMBER; ?>"><?php echo $dataarray[25]; ?></div>
                    <div class="rArea"><img class="r2" src="img/x.gif"
                                            title="<?php echo VL_CLAY; ?>"><?php echo $dataarray[26]; ?></div>
                    <div class="rArea"><img class="r3" src="img/x.gif"
                                            title="<?php echo VL_IRON; ?>"><?php echo $dataarray[27]; ?></div>
                    <div class="rArea"><img class="r4" src="img/x.gif"
                                            title="<?php echo VL_CROP; ?>"><?php echo $dataarray[28]; ?></div>
                </div>
                <div class="clear"></div>
                <div class="carry">
                    <?php
                        if ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28] == 0) {
                            echo "<img title=\"";
                            echo ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28]) . "/" . $dataarray[29];
                            echo "\" src=\"img/x.gif\" class=\"carry empty\">";
                        } elseif ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28] != $dataarray[29]) {
                            echo "<img title=\"";
                            echo ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28]) . "/" . $dataarray[29];
                            echo "\" src=\"img/x.gif\" class=\"carry half\">";
                        } else {
                            echo "<img title=\"";
                            echo ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28]) . "/" . $dataarray[29];
                            echo "\" src=\"img/x.gif\" class=\"carry full\">";
                        }
                    ?>
                    <?php echo ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28]) . "/" . $dataarray[29]; ?>
                </div>
            </td>
        </tr>
        </tbody>
        </table>
    <?php
    }
    $targettribe = $dataarray['33'];
    if ($showThemAll && $showAllTroops) {
        include "Templates/Notice/tribe_" . $targettribe . ".tpl";
    }
    $ddd = '36';
    for ($s = 1; $s <= 5; $s++) {
        if ($s != $targettribe || !$showAllTroops) {
            if ($dataarray[$ddd] == 1) {
                include "Templates/Notice/tribe_" . $s . ".tpl";
            }
        }
        $ddd += '23';
    }
?>
</td></tr></tbody></table>
<div class="clear"></div>
</div>
</div>
</div>
<div class="paperBottom"></div>
</div>
</div>
<div class="clear"></div>