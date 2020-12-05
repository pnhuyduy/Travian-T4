<style>
    .white {
        color: white;
    }

    h1 span {
        color: white;
    }

    h4 {
        color: white;
    }

    td {
        color: white;
    }

    body {
        text-align: right;
        direction: rtl;
        margin: 0;
        background-color: #000000;
        background-repeat: repeat-x;
        background-attachment: scroll;
        background-image: url(../../img/layout/bgVs.jpg);
        color: #252525;
        font-size: 13px;
        font-family: Arial, Helvetica, Verdana, sans-serif;
        font-weight: normal;
        line-height: 16px;
        min-width: 990px;
    }
</style>

<div style="position: absolute; opacity: 100; z-index: 8010; left: 0px; top: 0px;">
<div id="content" class="positionDetails">
<?php
    $d = $database->getVilWref($_GET['y'], $_GET['x']);
    if ($database->getOasisV($d)) {
        $basearray = $database->getOMInfo($d);
    } else {
        $basearray = $database->getMInfo($d);
    }
?>

<h1 class="titleInHeader">
        <span class="coordinates coordinatesWithText">
        <span class="coordText">
        <?php if (!$basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {
            echo VL_UNOCCUPIEDOASIS;
        } elseif ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {
            echo VL_OCCUPIEDOASIS;
        } elseif ($basearray['occupied'] && !$basearray['oasistype'] && $basearray['fieldtype']) {
            echo $basearray['name'];
        } else {
            echo VL_ABANDONVALLEY;
        } ?>
        </span>
        <span class="coordinateY"><?php echo "" . $basearray['x'] . ")"; ?></span>
        <span class="coordinatePipe">|</span>
        <span class="coordinateX"><?php echo "(" . $basearray['y'] . ""; ?></span>
        </span>
    <span class="clear">‎</span>
    <?php if ($basearray['occupied'] && $basearray['capital']) {
        echo "<span class=\"mainVillage\">(" . BL_CAPITAL . ")</span>";
    } ?>
    <span class="clear">&nbsp;</span>
</h1><br/>

<div id="tileDetails"
     class="village <?php echo ($basearray['fieldtype'] == 0) ? 'oasis-' . $basearray['oasistype'] : 'village-' . $basearray['fieldtype'] ?>">
    <div class="detailImage">
        <div id="options">
            <div class="option"><a onclick="position_popup(1);" class="a arrow"><?php echo MP_CENTERMAP; ?></a></div>
            <?php if (!$basearray['occupied']) { ?>
                <div class="option">
                    <?php
                        $mode = CP;
                        $total = count($database->getProfileVillages($session->uid));
                        $need_cps = ${'cp' . $mode}[$total + 1];
                        $cps = $database->getUserField($session->uid, 'cp', 0);

                        if ($cps >= $need_cps) {
                            $enough_cp = true;
                        } else {
                            $enough_cp = false;
                        }

                        $otext = ($basearray['occupied'] == 1) ? VL_OCCUPIEDOASIS : VL_UNOCCUPIEDOASIS;
                        if ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND $enough_cp) {
                            $test = "<a onclick=\"position_popup(2);\" class=\"a arrow\" >" . AT_NEWVILLAGE . "</a>";
                        } elseif ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND !$enough_cp) {
                            $test = "<span class=\"a arrow disabled\" title=\"(" . $cps . "/" . $need_cps . " " . BL_CULTUREPOINTS . ")\">" . MP_FOUNDNEWVILLAGE . "</span>";
                        } else {
                            $test = "<span class=\"a arrow disabled\">" . MP_FOUNDNEWVILLAGE . ".</span>";
                        }

                        echo ($basearray['fieldtype'] == 0) ?
                            ($village->resarray['f39'] == 0) ?
                                ($basearray['owner'] == $session->uid) ?


                                    "<a onclick=\"position_popup(3);\" class=\"a arrow\"> " . AT_RAID . " $otext (" . AT_BUILDRALLYPOINTTORAID . ")</a>" :
                                    "<span class=\"a arrow disabled\"> " . AT_RAID . " $otext (" . AT_BUILDRALLYPOINTTORAID . ")</span>" :


                                "<a onclick=\"position_popup(4);\" class=\"a arrow\"> " . AT_RAID . " $otext</a>" :
                            "$test"
                    ?>
                </div>
            <?php
            } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] == 0 && $basearray['wref'] != $_SESSION['wid']) {
                ?>
                <div class="option">
                    <?php
                        $query1 = mysql_query('SELECT `owner` FROM `' . TB_PREFIX . 'vdata` WHERE `wref` = ' . $d . '');
                        $data1 = mysql_fetch_assoc($query1);
                        $query2 = mysql_query('SELECT `id`,`protect`,`username` FROM `' . TB_PREFIX . 'users` WHERE `id` = ' . $data1['owner'] . ' LIMIT 1');
                        $data2 = mysql_fetch_assoc($query2);

                        if ($database->checkBan($data2['id'])) {
                            echo "<span class=\"a arrow disabled\" title=\"" . AT_CANTATTACKBANNED . "\">" . AT_ATTACKS . "</span>";
                        } else if ($data2['protect'] < time()) {
                            echo $village->resarray['f39'] ? "<a onclick=\"position_popup(5)();\" class=\"a arrow\" >" . AT_ATTACKS . "</a>" : "<span class=\"a arrow disabled\" title=\"(" . AT_BUILDRALLYPOINTTORAID . ")\">" . AT_ATTACKS . "</span>";
                        } else {
                            echo "<span class=\"a arrow disabled\" title=\"(" . AT_BEGPROTECTION . ")\">" . AT_ATTACKS . "</span>";
                        }
                    ?>
                </div>
                <div class="option">
                    <?php
                        echo $building->getTypeLevel(17) ? "<a onclick=\"position_popup(6);\" class=\"a arrow\">" . AT_SENDMERCHANTS . "</a>" : "<span class=\"a arrow disabled\" title=\"(" . MK_BUILDMARKET . ")\">" . AT_SENDMERCHANTS . "</span>"; ?>
                </div>
                <?php if ($session->goldclub == 1) { ?>
                    <div class="option">
                        <form action="build.php?gid=16&t=99" method="post">
                            <input type="hidden" name="action" value="addList">
                            <input type="hidden" id="did" name="did" type="text" value="<?php echo $village->wid; ?>">
                            <input type="hidden" id="name" name="name" type="text"
                                   value="<?php echo $data2['username']; ?>">
                            <input type="hidden" name="type"
                                   value="addfarm"><?php $t = $database->getAInfo($database->getVillageID($data2['id'])); ?>
                            <input type="hidden" name="x" value="<?php echo $t['x']; ?>">
                            <input type="hidden" name="y" value="<?php echo $t['y']; ?>">

                            <button class="a arrow" type="submit" value="create" value="reportButton repeat"
                                    class="icon"
                                    title="<?php echo AT_ADDTOFARM; ?>"><?php echo AT_ADDTOFARM; ?></button>
                        </form>
                    </div>

                <?php
                }
            } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] != 0 && $basearray['wref'] != $_SESSION['wid']) {
                ?>

                <div class="option">
                    <?php
                        echo $village->resarray['f39'] ? "<a onclick=\"position_popup(7);\" class=\"a arrow\" >" . AT_ATTACKS . "</a>" : "<span class=\"a arrow disabled\" title=\"(" . AT_BUILDRALLYPOINTTORAID . ")\">" . AT_ATTACKS . "</span>";
                    ?>
                </div>
            <?php } ?>

        </div>
    </div>
</div>
<div id="map_details">
<?php if ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) { ?>
    <table cellpadding="0" cellspacing="0" id="village_info" class="transparent">
        <?php
            $uinfo = $database->getUserArray($basearray['owner'], 1);
            $vilowner = $database->getVillage($basearray['conqured']);
        ?>
        <tbody>
        <tr class="first">
            <th><?php echo TRIBE; ?></th>
            <td><?php switch ($uinfo['tribe']) {
                    case 1:
                        echo TRIBE1;
                        break;
                    case 2:
                        echo TRIBE2;
                        break;
                    case 3:
                        echo TRIBE3;
                        break;
                    case 5:
                        echo TRIBE5;
                        break;
                } ?></td>
        </tr>
        <tr>
            <th><?php echo AL_ALLIANCE; ?></th>
            <?php if ($uinfo['alliance'] == 0) {
                echo '<td>-</td>';
            } else echo '
			<td><a onclick="position_popup(8);">' . $database->getUserAlliance($basearray['owner']) . '</a></td>'; ?>
        </tr>
        <tr>
            <th><?php echo US_OWNER; ?></th>
            <td>
                <a onclick="position_popup(9);"><?php echo $database->getUserField($basearray['owner'], 'username', 0); ?></a>
            </td>
        </tr>
        <tr>
            <th><?php echo VL_VILLAGE;?></th>
            <td><a onclick="position_popup(10);"><?php echo $vilowner['name']; ?></a></td>
        </tr>
        </tbody>
    </table><Br/>
<?php } ?>
<h4><?php if (!$basearray['fieldtype'] && $basearray['oasistype']) {
        echo AL_POINTS;
    } else {
        echo VL_LANDDIS;
    } ?></h4>
<table cellpadding="0" cellspacing="0" id="distribution" class="transparent">
    <tbody>
    <?php
        switch ($basearray['fieldtype']) {
            case 1:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 3</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 3</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 3</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 9</td>";

                break;
            case 2:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 3</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 4</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 5</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 3:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 4</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 4</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 4</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 4:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 4</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 5</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 3</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 5:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 5</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 3</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 4</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 6:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 1</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 1</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 1</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 15</td>";
                break;
            case 7:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 4</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 4</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 3</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 7</td>";
                break;
            case 8:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 3</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 4</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 4</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 7</td>";
                break;
            case 9:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 4</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 3</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 4</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 7</td>";
                break;
            case 10:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 3</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 5</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 4</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 11:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 4</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 3</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 5</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 12:
                $tt = "
<td><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"> 5</td>
<td><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"> 4</td>
<td><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"> 3</td>
<td><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"> 6</td>";
                break;
            case 0:
                switch ($basearray['oasistype']) {
                    case 1:
                        $tt = "
<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_LUMBER . "</td>";
                        break;
                    case 2:
                        $tt = "
<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" . VL_LUMBER . "</td>";
                        break;
                    case 3:
                        $tt = "
<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"" . VL_LUMBER . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_LUMBER . "</td></tr>
<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CROP . "</td></tr>";
                        break;
                    case 4:
                        $tt = "
<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CLAY . "</td>";
                        break;
                    case 5:
                        $tt = "
<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" . VL_CLAY . "</td>";
                        break;
                    case 6:
                        $tt = "
<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"" .  VL_CLAY . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_CLAY . "</td></tr>
<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" .  VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_CROP . "</td></tr>";
                        break;
                    case 7:
                        $tt = "
<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" .  VL_IRON . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_IRON . "</td>";
                        break;
                    case 8:
                        $tt = "
<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" .  VL_IRON . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" .  VL_IRON . "</td>";
                        break;
                    case 9:
                        $tt = "
<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" .  VL_IRON . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_IRON . "</td></tr>
<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" .  VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_CROP . "</td></tr>";
                        break;
                    case 10:
                    case 11:
                        $tt = "
<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" .  VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" .  VL_CROP . "</td>";
                        break;
                    case 12:
                        $tt = "
<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" .  VL_CROP . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" .  VL_CROP . "</td>";
                        break;
                }
                break;
        }
        echo $tt;
    ?>

    </tbody>
</table>
<?php if ($basearray['fieldtype'] == 0 && !$basearray['occupied']) {
    ?><br/>
    <h4><?php echo AT_TROOPS;?></h4>
    <table cellpadding="0" cellspacing="0" id="troop_info" class="transparent">
        <tbody>
        <?php
            $unit = $database->getUnit($d);
            $unarray = array(31 => U31, U32, U33, U34, U35, U36, U37, U38, U39, U40);
            $a = 0;
            for ($i = 31; $i <= 40; $i++) {
                if ($unit['u' . $i]) {
                    echo '<tr>';
                    echo '<td class="ico"><img class="unit u' . $i . '" src="img/x.gif" alt="' . $unarray[$i] . '" title="' . $unarray[$i] . '" /></td>';
                    echo '<td class="val">' . $unit['u' . $i] . '</td>';
                    echo '<td class="desc">' . $unarray[$i] . '</td>';
                    echo '</tr>';
                } else {
                    $a = $a + 1;
                }
            }
            if ($a == 10) {
                echo '<tr><td>'.AL_NONE.'</td></tr>';
            }


        ?>
        </tbody>
    </table>
<?php
} else if ($basearray['occupied'] && !$basearray['oasistype']) {
    ?><br/>
    <h4><?php echo AL_PLAYER;?></h4>
    <table cellpadding="0" cellspacing="0" id="village_info" class="transparent">
        <?php $uinfo = $database->getUserArray($basearray['owner'], 1); ?>
        <tbody class=white>
        <tr class="first">
            <th><?php echo TRIBE;?></th>
            <td><?php switch ($uinfo['tribe']) {
                    case 1:
                        echo TRIBE1;
                        break;
                    case 2:
                        echo TRIBE2;
                        break;
                    case 3:
                        echo TRIBE3;
                        break;
                    case 5:
                        echo TRIBE4;
                        break;
                } ?></td>
        </tr>
        <tr>
            <th><?php echo AL_ALLIANCE;?></th>
            <?php if ($uinfo['alliance'] == 0) {
                echo '<td>-</td>';
            } else echo '
			<td><a onclick="position_popup(8);">' . $database->getUserAlliance($basearray['owner']) . '</a></td>'; ?>
        </tr>
        <tr>
            <th><?php echo US_OWNER;?></th>
            <td>
                <a onclick="position_popup(9);"><?php echo $database->getUserField($basearray['owner'], 'username', 0); ?></a>
            </td>
        </tr>
        <tr>
            <th><?php echo POPUALTION;?></th>
            <td><?php echo $basearray['pop']; ?></td>
        </tr>
        </tbody>
    </table>
<?php } ?>
<br/>

<h4><?PHP echo HDR_REPORTS;?></h4>
<table cellpadding="0" cellspacing="0" id="troop_info" class="rep transparent">
    <tbody>
    <?php

        $noticeClass = array(NOTICE1,NOTICE2,NOTICE3,NOTICE4,NOTICE5,NOTICE6,NOTICE7,NOTICE8,NOTICE9,NOTICE10,NOTICE11,NOTICE12,NOTICE13,NOTICE14,NOTICE15,
            NOTICE16,NOTICE17,NOTICE18,NOTICE19,NOTICE20,NOTICE21,NOTICE22,NOTICE23);

        if ($session->uid == $database->getVillage($d)) {
            $limit = "ntype=0 and ntype=4 and ntype=5 and ntype=6 and ntype=7";
        } else {
            $limit = "ntype!=8 and ntype!=9 and ntype!=10 and ntype!=11 and ntype!=12 and ntype!=13 and ntype!=14";
        }

        $result = mysql_query("SELECT * FROM " . TB_PREFIX . "ndata WHERE $limit AND uid = " . $session->uid . " AND toWref = " . $d . " ORDER BY time DESC Limit 5");

        while ($row = mysql_fetch_assoc($result)) {
            $dataarray = explode(",", $row['data']);
            $type = $row['ntype'];
            echo "<tr><td>";
            echo "<img src=\"img/x.gif\" class=\"iReport iReport" . $row['ntype'] . "\" title=\"" . $noticeClass[$type] . "\"> ";
            $date = $generator->procMtime($row['time']);
            echo "<a onclick=\"position_popup(11);\">" . $date[0] . " " . date('H:i', $row['time']) . "</a> ";
            echo "</td></tr>";
        }
    ?>
    </tbody>
</table>
</div>
</div>
<div class="clear"></div>

<script type="text/javascript">
    function position_popup(id) {
        if (id === 1) {
            window.top.location.href = "karte.php?x=<?php echo $basearray['y']; ?>&y=<?php echo $basearray['x']; ?>";
        }
        if (id === 2) {
            window.top.location.href = "build.php?id=39&t=2&ids=<?php echo $d;?>&s=1";
        }
        if (id === 3) {
            window.top.location.href = "build.php?id=39";
        }
        if (id === 4) {
            window.top.location.href = "build.php?id=39&t=2&z=<?php echo $d;?>&o";
        }
        if (id === 5) {
            window.top.location.href = "build.php?id=39&t=2&z=<?php echo $d;?>";
        }
        if (id === 6) {
            window.top.location.href = "build.php?z=<?php echo $d;?>&id=<?php echo $building->getTypeField(17);?>&t=1";
        }
        if (id === 7) {
            window.top.location.href = "build.php?id=39&t=2&z=<?php echo $d;?>";
        }
        if (id === 8) {
            window.top.location.href = "allianz.php?aid=<?php echo $uinfo['alliance'];?>";
        }
        if (id === 9) {
            window.top.location.href = "spieler.php?uid=<?php echo $basearray['owner']; ?>";
        }
        if (id === 10) {
            window.top.location.href = "karte.php?z=<?php echo $basearray['wref']; ?>";
        }
        if (id === 11) {
            window.top.location.href = "berichte.php?id=<?php echo $row['id'];?>";
        }
    }
</script>