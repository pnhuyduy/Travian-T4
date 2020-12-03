<?php

    if (isset($_SESSION['NEXT_AVAILABE']) && $_SESSION['NEXT_AVAILABE'] > time()) {

        echo PL_FARMLISTAVIN . " :";
        echo "<span id=timer" . $timer . ">" . $generator->getTimeFormat($_SESSION['NEXT_AVAILABE'] - time()) . "</span>";
        $timer++;
        if ($_SESSION['NEXT_AVAILABE'] < time()) unset($_SESSION['NEXT_AVAILABE'], $_SESSION['LAST_RAID']);
    }
    if (isset($_GET['t']) == 99 && isset($_GET['action']) == 0) {
        if (isset($_GET['t']) == 99 && isset($_POST['action']) == 'addList') {
            $database->createFarmList($_POST['did'], $session->uid, $_POST['name']);
        }

        $sql = mysql_query("SELECT * FROM " . TB_PREFIX . "farmlist WHERE owner = $session->uid ORDER BY wref = $village->wid DESC");
        $query = mysql_num_rows($sql);
        while ($row = mysql_fetch_array($sql)) {
            $lid = $row["id"];
            $lname = $row["name"];
            $lowner = $row["owner"];
            $lwref = $row["wref"];
            $lvname = $database->getVillageField($row["wref"], 'name');
            if ($lwref == $village->wid) {
                ?>
                <div id="list<?php echo $lid; ?>" class="listEntry">
                <form action="startRaid.php?id=39&t=99&action=startRaid" method="post">
                <input type="hidden" name="action" value="startRaid">
                <input type="hidden" name="a" value="c35">
                <input type="hidden" name="sort" value="distance">
                <input type="hidden" name="tribe" value="<?php echo $session->tribe; ?>">
                <input type="hidden" name="direction" value="asc">
                <input type="hidden" name="lid" value="<?php echo $lid; ?>">

                <div class="round spacer listTitle"
                     onclick="Travian.Game.RaidList.toggleList(<?php echo $lid; ?>);">
                    <div class="listTitleText">
                        <img alt="del" class="del" src="img/x.gif" onclick="
                            '<?php echo PL_CONFIRMDELLIST; ?>'.dialog(
                            {
                            onOkay: function(dialog, contentElement)
                            {
                            window.location = 'build.php?id=39&amp;t=99&amp;action=removeList&amp;lid=<?php echo $lid; ?>';
                            }
                            });
                            event.stop();
                            ">
                        <?php echo $lvname; ?> - <?php echo $lname; ?>
                        <img alt="<?php echo FD_LOADING; ?>" class="loading hide" src="img/x.gif"
                             align="absmiddle">
                    </div>
                    <div class="openedClosedSwitch switchOpened"><?php echo AL_DETAILS; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="listContent ">
                    <div class="detail">
                        <table class="list" cellpadding="1" cellspacing="1">
                            <thead>
                            <tr>
                                <td class="checkbox edit"></td>
                                <td class="village sortable"
                                    onclick="Travian.Game.RaidList.sort(<?php echo $lid; ?>, 'village');"><?php echo VL_VILLAGE; ?></td>
                                <td class="ew sortable"
                                    onclick="Travian.Game.RaidList.sort(<?php echo $lid; ?>, 'ew');"><?php echo PL_EW; ?></td>
                                <td class="distance sortable"
                                    onclick="Travian.Game.RaidList.sort(<?php echo $lid; ?>, 'distance');"><?php echo MP_DISTANCE; ?></td>
                                <td class="troops sortable"
                                    onclick="Travian.Game.RaidList.sort(<?php echo $lid; ?>, 'troops');"><?php echo AT_TROOPS; ?></td>
                                <td class="lastRaid sortable"
                                    onclick="Travian.Game.RaidList.sort(<?php echo $lid; ?>, 'lastRaid');"><?php echo PL_LASTRAID; ?></td>
                                <td class="action"></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                                $sql2 = mysql_query("SELECT * FROM " . TB_PREFIX . "raidlist WHERE lid = $lid ORDER BY distance ASC");
                                $query2 = mysql_num_rows($sql2);
                                if ($query2 == 0) {
                                    echo '<td class="noData" colspan="7">' . PL_NOFARMLIST . '</td>';
                                } else {
                                    while ($row = mysql_fetch_array($sql2)) {
                                        $id = $row['id'];
                                        $lid = $row['lid'];
                                        $towref = $row['towref'];
                                        $x = $row['x'];
                                        $y = $row['y'];
                                        if ($village->wid == $towref) {
                                            $distance = '0';
                                        } else {
                                            $distance = $row['distance'];
                                        }
                                        $t1 = $row['t1'];
                                        $t2 = $row['t2'];
                                        $t3 = $row['t3'];
                                        $t4 = $row['t4'];
                                        $t5 = $row['t5'];
                                        $t6 = $row['t6'];
                                        $t7 = $row['t7'];
                                        $t8 = $row['t8'];
                                        $t9 = $row['t9'];
                                        $t10 = $row['t10'];
                                        $isoasis = $database->isVillageOases($towref);
                                        if ($isoasis) {
                                            $vdata = $database->getOMInfo($towref);
                                            if ($vdata['conqured']) {
                                                $vdata['name'] = VL_OCCUPIEDOASIS;
                                            } else {
                                                $vdata['name'] = VL_UNOCCUPIEDOASIS;
                                            }
                                            $vdata['name'] .= ' (' . $vdata['x'] . '|' . $vdata['y'] . ')';
                                        } else {
                                            $vdata = $database->getMInfo($towref);
                                        }
                                        ?>
                                        <tr class="slotRow">
                                            <td class="checkbox">
                                                <input id="slot<?php echo $id; ?>"
                                                       name="slot[<?php echo $id; ?>]" type="checkbox"
                                                       class="markSlot"
                                                       onclick="Travian.Game.RaidList.markSlotForRaid(<?php echo $lid; ?>, <?php echo $id; ?>, this.checked);">
                                            </td>
                                            <td class="village">
                                                <?php
                                                    $incoming_attacks = $database->getMovement(3, $towref, 1);
                                                    $att = '';
                                                    if (count($incoming_attacks) > 0) {
                                                        $inc_atts = count($incoming_attacks);
                                                        if ($incoming_attacks[$i]['attack_type'] == 2) {
                                                            $inc_atts -= 1;
                                                        }
                                                        if ($inc_atts > 0) {
                                                            echo '<img class="att2" src="img/x.gif" title="' . PL_INCOMINGATTACK . '" />';
                                                        }
                                                    }?>
                                                <label for="slot<?php echo $id; ?>">
                                                            <span class="coordinates coordinatesWithText"><span
                                                                    class="coordText"><?php echo $vdata['name']; ?></span></span><span
                                                        class="clear">‎</span>
                                                </label>
                                            </td>
                                            <td class="ew"><?php echo $vdata['pop']; ?></td>
                                            <td class="distance"><?php echo $distance; ?></td>
                                            <td class="troops">
                                                <?php
                                                    $ct = ($session->tribe - 1) * 10;
                                                    for ($uc = 1; $uc <= 10; $uc++) {
                                                        if (${'t' . $uc} != 0) {
                                                            echo '<div class="troopIcon"><img class="unit u' . ($uc + $ct) . '" title="'
                                                                . constant('U' . ($uc + $ct)) . '" src="img/x.gif"><span class="troopIconAmount">' . ${'t' . $uc} . '</span></div>';
                                                        }
                                                    }
                                                ?>
                                            </td>
                                            <td class="lastRaid">
                                                <?php
                                                    $noticeClass = array(NOTICE1, NOTICE2, NOTICE3, NOTICE4, NOTICE5, NOTICE6, NOTICE7, NOTICE8, NOTICE9, NOTICE10, NOTICE11,
                                                        NOTICE12, NOTICE13, NOTICE14, NOTICE15, NOTICE16, NOTICE17, NOTICE18, NOTICE19, NOTICE20, NOTICE21, NOTICE22, NOTICE23);
                                                    $limits = "ntype!=4 and ntype!=5 and ntype!=6 and ntype!=7";
                                                    $getnotice = mysql_query("SELECT * FROM " . TB_PREFIX . "ndata WHERE $limits AND toWref = "
                                                        . $towref . " ORDER BY time DESC Limit 1");

                                                    while ($row2 = mysql_fetch_array($getnotice)) {
                                                        $dataarray = explode(",", $row2['data']);
                                                        $type2 = $row2['ntype'];
                                                        echo "<img src=\"img/x.gif\" class=\"iReport iReport" . $row2['ntype'] . "\" title=\""
                                                            . $noticeClass[$type2] . "\"> ";
                                                        $allres = ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28]);
                                                        $carry = $dataarray[29];
                                                        if ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28] == 0) {
                                                            echo "<img title=\"bounty: " . $allres . " resouces max carry: " . $carry
                                                                . " resouces.\" src=\"img/x.gif\" class=\"carry empty\">";
                                                        } elseif ($dataarray[25] + $dataarray[26] + $dataarray[27] + $dataarray[28] != $dataarray[29]) {
                                                            echo "<img title=\"bounty: " . $allres . " resouces. max carry: " . $carry
                                                                . " resouces.\" src=\"img/x.gif\" class=\"carry half\">";
                                                        } else {
                                                            echo "<img title=\"bounty: " . $allres . " resouces. max carry: " . $carry
                                                                . " resouces.\" src=\"img/x.gif\" class=\"carry full\">";
                                                        }
                                                        $date = $generator->procMtime($row2['time']);
                                                        echo "<a href=\"berichte.php?id=" . $row2['id'] . "\">" . $date[0] . " " . date('H:i', $row2['time']) . "</a> ";
                                                    }
                                                ?>
                                                <div class="clear"></div>
                                            </td>
                                            <td class="action">
                                                <a class="arrow" href="#"
                                                   onclick="Travian.Game.RaidList.editSlot(<?php echo $lid; ?>, <?php echo $id; ?>); return false;">edit</a>
                                            </td>
                                        </tr>
                                    <?php
                                    }
                                }
                            ?>
                            </tbody>
                        </table>
                        <div class="markAll">
                            <input type="checkbox" id="raidListMarkAll<?php echo $lid; ?>" class="markAll"
                                   onclick="Travian.Game.RaidList.markAllSlotsOfAListForRaid(<?php echo $lid; ?>, this.checked);">
                            <label for="raidListMarkAll<?php echo $lid; ?>"><?php echo SELECTALL; ?></label>
                        </div>
                        <div class="addSlot">
                            <button type="button" class="green " value="<?php echo PL_ADD; ?>"
                                    onclick="Travian.Game.RaidList.addSlot(<?php echo $lid; ?>);">
                                <div class="button-container addHoverClick">
                                    <div class="button-background">
                                        <div class="buttonStart">
                                            <div class="buttonEnd">
                                                <div class="buttonMiddle"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-content"><?php echo PL_ADDRAID; ?></div>
                                </div>
                            </button>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="troopSelection">
                        <?php
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $un = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                echo '<span class="troopSelectionUnit">
										<img class="unit u' . $i . '" title="' . $technology->unarray[$i] . '" src="img/x.gif">
										<span class="troopSelectionValue">0</span>
									</span>';
                            }
                        ?>
                        <div class="clear"></div>
                    </div>
                    <button type="submit" class="green " value="<?php echo PL_STARTRAID; ?>">
                        <div class="button-container addHoverClick">
                            <div class="button-background">
                                <div class="buttonStart">
                                    <div class="buttonEnd">
                                        <div class="buttonMiddle"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="button-content"><?php echo PL_STARTRAID; ?></div>
                        </div>
                    </button>
                </div>
                </form>
                </div>
            <?php
            } else {
                ?>
                <div id="list<?php echo $lid; ?>" class="listEntry">
                    <div class="round spacer listTitle"
                         onclick="Travian.Game.RaidList.toggleList(<?php echo $lid; ?>);">
                        <div class="listTitleText">
                            <img alt="del" class="del" src="img/x.gif" onclick="
                                '<?php echo PL_CONFIRMDELLIST; ?>'.dialog(
                                {
                                onOkay: function(dialog, contentElement)
                                {
                                window.location = 'build.php?gid=16&amp;t=99&amp;action=removeList&amp;lid=<?php echo $lid; ?>';
                                }
                                });
                                event.stop();
                                ">
                            <?php echo $lvname; ?> - <?php echo $lname; ?>
                            <img alt="<?php echo FD_LOADING; ?>" class="loading hide" src="img/x.gif" align="absmiddle">
                        </div>
                        <div class="openedClosedSwitch switchClosed"><?php echo AL_DETAILS; ?></div>
                        <div class="clear"></div>
                    </div>
                    <div class="listContent hide"></div>
                </div>
            <?php
            }
        }?>
        <div class="options">
            <a class="arrow" href="build.php?gid=16&t=99&action=addList"><?php echo PL_CREATELIST; ?></a>
        </div>
    <?php
    }

    $getUnit = $database->getUnit($village->wid);


    switch ($session->tribe) {
        case 1:
            $unit1 = $getUnit['u1'];
            $unit2 = $getUnit['u2'];
            $unit3 = $getUnit['u3'];
            $unit4 = $getUnit['u4'];
            $unit5 = $getUnit['u5'];
            $unit6 = $getUnit['u6'];
            $unit7 = $getUnit['u7'];
            $unit8 = $getUnit['u8'];
            $unit9 = $getUnit['u9'];
            $unit10 = $getUnit['u10'];
            break;
        case 2:
            $unit1 = $getUnit['u11'];
            $unit2 = $getUnit['u12'];
            $unit3 = $getUnit['u13'];
            $unit4 = $getUnit['u14'];
            $unit5 = $getUnit['u15'];
            $unit6 = $getUnit['u16'];
            $unit7 = $getUnit['u17'];
            $unit8 = $getUnit['u18'];
            $unit9 = $getUnit['u19'];
            $unit10 = $getUnit['u20'];
            break;
        case 3:
            $unit1 = $getUnit['u21'];
            $unit2 = $getUnit['u22'];
            $unit3 = $getUnit['u23'];
            $unit4 = $getUnit['u24'];
            $unit5 = $getUnit['u25'];
            $unit6 = $getUnit['u26'];
            $unit7 = $getUnit['u27'];
            $unit8 = $getUnit['u28'];
            $unit9 = $getUnit['u29'];
            $unit10 = $getUnit['u30'];
            break;
    }

    if (!$database->getVilFarmlist($village->wid)) {
        ?>
        <script type="text/javascript">
            window.addEvent('domready', function () {
                Travian.Game.RaidList.setData([]);
            });
        </script>
    <?php } else { ?>
        <script type="text/javascript">
            window.addEvent('domready', function () {
                Travian.Game.RaidList.setData({
                    <?php
                    $result = mysql_query('SELECT * FROM '.TB_PREFIX.'farmlist WHERE wref = '.$village->wid.'');
                    $query1 = mysql_num_rows($result);
                    $NUM1 = 1;
                    while($row = mysql_fetch_array($result)){
                    $lid = $row['id'];

                    ?>
                    "<?php echo $lid; ?>": {
                        "troops": {"1":<?php echo $unit1; ?>, "2":<?php echo $unit2; ?>, "3":<?php echo $unit3; ?>, "4":<?php echo $unit4; ?>, "5":<?php echo $unit5; ?>, "6":<?php echo $unit6; ?>, "7":<?php echo $unit7; ?>, "8":<?php echo $unit8; ?>, "9":<?php echo $unit9; ?>, "10":<?php echo $unit10; ?>, "11":<?php echo $getUnit['hero']; ?>},
                        "directions": {"village": "none", "ew": "none", "distance": "asc", "troops": "none", "lastRaid": "none"},
                        "slots": {<?php
$result3 = mysql_query('SELECT * FROM '.TB_PREFIX.'raidlist WHERE lid = '.$lid.'');
$query2 = mysql_num_rows($result3);
$NUM2 = 1;
while($row3 = mysql_fetch_array($result3)){
$id = $row3['id'];
$t1 = $row3['t1'];$t2 = $row3['t2'];$t3 = $row3['t3'];$t4 = $row3['t4'];$t5 = $row3['t5'];$t6 = $row3['t6'];$t7 = $row3['t7'];
$t8 = $row3['t8'];$t9 = $row3['t9'];$t10 = $row3['t10'];

echo '"'.$id.'":{"troops":{"1":'.$t1.',"2":'.$t2.',"3":'.$t3.',"4":'.$t4.',"5":'.$t5.',"6":'.$t6.',"7":'.$t7.',"8":'.$t8.',"9":'.$t9.',"10":'.$t10.',"11":0}}';
if($NUM2 != $query2){
	echo ',';
}
$NUM2++;
}
echo '
					}
				}';
if($NUM1 != $query1){
echo ',
';
}
$NUM1++;
}
?>

                        });
                (new Fx.Scroll(window, {
                    duration: 100
                })).toElement('list<?php echo $lid2; ?>');
            });
        </script>
    <?php } ?>
