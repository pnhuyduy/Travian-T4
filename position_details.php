<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include('GameEngine/Village.php');
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "'");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        if (isset($_GET['x']) && isset($_GET['y'])) {
            $_GET['x'] = filter_var($_GET['x'], FILTER_SANITIZE_NUMBER_INT);
            $_GET['y'] = filter_var($_GET['y'], FILTER_SANITIZE_NUMBER_INT);
            header("Location: " . $_SERVER['PHP_SELF'] . "?x=" . $_GET['x'] . "&y=" . $_GET['y']);
            die();
        } else {
            $havecoor = 1;
            $coor = $database->getCoor($_SESSION['wid']);
            header("Location: " . $_SERVER['PHP_SELF'] . "?x=" . $coor['x'] . "&y=" . $coor['y']);
            die();
        }
    } else {
        $building->procBuild($_GET);
    }

    $HTTP_REFERER = array_shift(explode('?', $_SERVER['HTTP_REFERER']));
    $pageref = basename($HTTP_REFERER);

    include 'Templates/html.tpl';

    if ($pageref == 'karte.php') {

///map details///
        if (!isset($_GET['x']) && !isset($_GET['y']) && !$havecoor) {
            header("Location: " . $_SERVER['PHP_SELF'] . "?x=" . $village->coor['x'] . "&y=" . $village->coor['y']);
            die();
        }

        if (isset($_GET['x']) && isset($_GET['y'])) {
            $_GET['x'] = filter_var($_GET['x'], FILTER_SANITIZE_NUMBER_INT);
            $_GET['y'] = filter_var($_GET['y'], FILTER_SANITIZE_NUMBER_INT);
            if ($database->getVilWref($_GET['x'], $_GET['y'])) {
                include('Templates/Map/vilview.tpl');
            } else {
                include('Templates/Map/mapview.tpl');
            }
        } else {
            header('Location: karte.php');
        }
    } else {

        ?>
        <body class="v35 gecko statistics perspectiveBuildings">
        <script type="text/javascript">
            window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
        </script>
        <div id="background">
        <div id="headerBar"></div>
        <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>

        <?php
            include('Templates/Header.tpl');
        ?>
        <div id="center">
        <a id="ingameManual" href="help.php">
            <img class="question" alt="Help" src="img/x.gif">
        </a>

        <div id="sidebarBeforeContent" class="sidebar beforeContent">
            <?php
                include('Templates/heroSide.tpl');
                include('Templates/Alliance.tpl');
                include('Templates/infomsg.tpl');
                include('Templates/links.tpl');
            ?>
            <div class="clear"></div>
        </div>
        <div id="contentOuterContainer">
        <?php include('Templates/res.tpl'); ?>
        <div class="contentTitle">
            <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">&nbsp;</a>
            <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/" target="_blank"
               title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
        </div>
        <div class="contentContainer">
        <div id="content" class="positionDetails">
        <?php
            $d = $database->getVilWref($_GET['x'], $_GET['y']);
            if ($database->getOasisV($d)) {
                $basearray = $database->getOMInfo($d);
            } else {
                $basearray = $database->getMInfo($d);
            }
            if (defined($basearray['name'])) {
                $basearray['name'] = constant($basearray['name']);
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
            <?php if (DIRECTION == 'ltr') { ?>
                <span class="coordinateX"><?php echo "(" . $basearray['x'] . ""; ?></span>
                <span class="coordinatePipe">|</span>
                <span class="coordinateY"><?php echo "" . $basearray['y'] . ")"; ?></span>
            <?php } elseif (DIRECTION == 'rtl') { ?>
                <span class="coordinateY"><?php echo "" . $basearray['y'] . ")"; ?></span>
                <span class="coordinatePipe">|</span>
                <span class="coordinateX"><?php echo "(" . $basearray['x'] . ""; ?></span>
            <?php } ?>
        </span>
            <span class="clear"> </span>
            <?php if (isset($basearray['occupied']) && $basearray['occupied'] && isset($basearray['capital']) && $basearray['capital']) {
                echo "<span class=\"mainVillage\">(capital)</span>";
            } ?>
            <span class="clear">&nbsp;</span>
        </h1>

        <div id="tileDetails"
             class="village <?php echo ($basearray['fieldtype'] == 0) ? 'oasis-' . $basearray['oasistype'] : 'village-' . $basearray['fieldtype'] ?>">
        <div class="detailImage">
            <div id="options">
                <div class="option"><a
                        href="karte.php?x=<?php echo $basearray['x']; ?>&y=<?php echo $basearray['y']; ?>"
                        class="a arrow"><?php echo MP_CENTERMAP; ?></a>
                    <?php
                        if (!$basearray['occupied']) {
                            $mode = CP;
                            $total = count($database->getProfileVillages($session->uid));
                            $need_cps = ${'cp' . $mode}[$total + 1];
                            $cps = $database->getUserField($session->uid, 'cp', 0);

                            if ($cps >= $need_cps) {
                                $enough_cp = TRUE;
                            } else {
                                $enough_cp = FALSE;
                            }
                            $otext = ($basearray['occupied'] == 1) ? VL_OCCUPIEDOASIS : VL_UNOCCUPIEDOASIS;
                            if ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND $enough_cp) {
                                $test = "<a class=\"a arrow\" href=\"a2b.php?id=" . $d . "&amp;s=1\">" . AT_NEWVILLAGE . "</a>";
                            } elseif ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND !$enough_cp) {
                                $test = "<span class=\"a arrow disabled\" title=\"(" . $cps . "/" . $need_cps . " culture points\">" . AT_NEWVILLAGE . "</span>";
                            } else {
                                $test = "<span class=\"a arrow disabled\">" . AT_NEWVILLAGE . "</span>";
                            }
                            echo ($basearray['fieldtype'] == 0) ?
                                ($village->resarray['f39'] == 0) ?
                                    ($basearray['owner'] == $session->uid) ?
                                        "<a class=\"a arrow\" href=\"build.php?id=39\">" . AT_RAID . ' ' . $otext . ' ' . AT_BUILDRALLYPOINTTORAID . "</a>" :
                                        "<span class=\"a arrow disabled\">" . AT_RAID . ' ' . $otext . ' ' . AT_BUILDRALLYPOINTTORAID . "</span>" :
                                    "<a class=\"a arrow\" href=\"a2b.php?z=" . $d . "&o\">" . AT_RAID . ' ' . $otext . "</a>" : "$test";
                        } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] == 0 && $basearray['wref'] != $_SESSION['wid']) {
                            $query1 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'vdata` WHERE `wref` = ' . $d . '');
                            $data1 = mysql_fetch_assoc($query1);
                            $query2 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'users` WHERE `id` = ' . $data1['owner'] . '');
                            $data2 = mysql_fetch_assoc($query2);

                            if ($database->checkBan($data2['id'])) {
                                echo "<span class=\"a arrow disabled\" title=\"" . AT_CANTATTACKBANNED . "\">" . AT_CANTATTACKBANNED . "</span>";
                            } else if ($data2['protect'] < time()) {
                                echo $village->resarray['f39'] ? "<a class=\"a arrow\" href=\"a2b.php?z=" . $d . "\">" . AT_SENDTROOPS . ".</a>" : "<span class=\"a arrow disabled\" title=\"" . AT_BUILDRALLYPOINTTORAID . "\">" . AT_SENDTROOPS . AT_BUILDRALLYPOINTTORAID . "</span>";
                            } else {
                                echo "<span class=\"a arrow disabled\" title=\"" . PF_BEGINERPROTECTION . "\">" . PF_BEGINERPROTECTION . ".</span>"; //need to fix showing protection time
                            }
                            echo $building->getTypeLevel(17) ? "<a class=\"a arrow\" href=\"build.php?z=" . $d . "&id=" . $building->getTypeField(17) . "\">" . AT_SENDMERCHANTS . "</a>" : "<span class=\"a arrow disabled\" title=\"(".MK_BUILDMARKET.")\">" . AT_SENDMERCHANTS . ".</span>";

                            if ($session->goldclub == 1) {
                                echo '
		<form action="build.php?id=39&t=99" method="post">
		<input type="hidden" name="action" value="addList">
		<input type="hidden" id="did" name="did" type="text" value="' . $village->wid . '">
		<input type="hidden" id="name" name="name" type="text" value="' . $data2["username"] . '">
		<input type="hidden" name="type" value="addfarm">
		';
                                $t = $database->getAInfo($database->getVillageID($data2['id']));
                                echo '<input type="hidden" name="x" value="' . $t["x"] . '">
		<input type="hidden" name="y" value="' . $t["y"] . '">
		<button class="a arrow" type="submit" value="create" value="reportButton repeat" class="icon" title="'.AT_ADDTOFARM.'">'.AT_ADDTOFARM.'</button>
		</form>
		';
                            }
                        } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] != 0 && $basearray['wref'] != $_SESSION['wid']) {
                            echo $village->resarray['f39'] ? "<a class=\"a arrow\" href=\"a2b.php?z=" . $d . "\">" . AT_SENDTROOPS . ".</a>" : "<span class=\"a arrow disabled\" title=\"" . AT_SENDTROOPS . "\">" . AT_SENDTROOPS . ".</span>";
                        }
                    ?>
                </div>
            </div>
        </div>
        <div id="map_details">
        <?php if ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) { ?>
            <table cellpadding="0" cellspacing="0" id="village_info" class="transparent">
                <?php
                    $uinfo = $database->getUser($basearray['owner'], 1);
                    $vilowner = $database->getVillage($basearray['conqured']);
                ?>
                <tbody>
                <tr class="first">
                    <th><?php echo TRIBE; ?>:</th>
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
                    <th><?php echo AL_ALLIANCE; ?>:</th>
                    <?php if ($uinfo['alliance'] == 0) {
                        echo '<td>-</td>';
                    } else echo '
			<td><a href="allianz.php?aid=' . $uinfo['alliance'] . '">' . $database->getUserAlliance($basearray['owner']) . '</a></td>'; ?>
                </tr>
                <tr>
                    <th><?php echo US_OWNER; ?>:</th>
                    <td>
                        <a href="spieler.php?uid=<?php echo $basearray['owner']; ?>"><?php echo $database->getUserField($basearray['owner'], 'username', 0); ?></a>
                    </td>
                </tr>
                <tr>
                    <th><?php echo VL_VILLAGE; ?>:</th>
                    <td><a href="karte.php?z=<?php echo $basearray['wref']; ?>"><?php echo $vilowner['name']; ?></a>
                    </td>
                </tr>
                </tbody>
            </table><Br/>
        <?php } ?>
        <h4><?php if (!$basearray['fieldtype'] && !$basearray['oasistype']) {
                echo "";
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
<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"" . VL_CLAY . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CLAY . "</td></tr>
<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CROP . "</td></tr>";
                                break;
                            case 7:
                                $tt = "
<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_IRON . "</td>";
                                break;
                            case 8:
                                $tt = "
<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" . VL_IRON . "</td>";
                                break;
                            case 9:
                                $tt = "
<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"" . VL_IRON . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_IRON . "</td></tr>
<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CROP . "</td></tr>";
                                break;
                            case 10:
                            case 11:
                                $tt = "
<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"></td>
<td class=\"val\">25%</td><td class=\"desc\">" . VL_CROP . "</td>";
                                break;
                            case 12:
                                $tt = "
<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"" . VL_CROP . "\"></td>
<td class=\"val\">50%</td><td class=\"desc\">" . VL_CROP . "</td>";
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
            <h4><?php echo AT_TROOPS; ?>:</h4>
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
                        echo '<tr><td>' . UL_THEREARENOUNITS . '</td></tr>';
                    }


                ?>
                </tbody>
            </table>
        <?php
        } else if ($basearray['occupied'] && !$basearray['oasistype']) {
            ?><br/>
            <h4>Player</h4>
            <table cellpadding="0" cellspacing="0" id="village_info" class="transparent">
                <?php $uinfo = $database->getUser($basearray['owner'], 1); ?>
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
			<td><a href="allianz.php?aid=' . $uinfo['alliance'] . '">' . $database->getUserAlliance($basearray['owner']) . '</a></td>'; ?>
                </tr>
                <tr>
                    <th><?php echo US_OWNER; ?></th>
                    <td>
                        <a href="spieler.php?uid=<?php echo $basearray['owner']; ?>"><?php echo $database->getUserField($basearray['owner'], 'username', 0); ?></a>
                    </td>
                </tr>
                <tr>
                    <th><?php echo POPUALTION; ?></th>
                    <td><?php echo $basearray['pop']; ?></td>
                </tr>
                </tbody>
            </table>
        <?php } ?>
        <br/>

        <h4><?php echo MS_REPORTS; ?></h4>
        <table cellpadding="0" cellspacing="0" id="troop_info" class="rep transparent">
            <tbody>
            <?php

                $noticeClass = array(NOTICE1, NOTICE2, NOTICE3, NOTICE4, NOTICE5, NOTICE6, NOTICE7, NOTICE8, NOTICE9, NOTICE10, NOTICE11, NOTICE12, NOTICE13, NOTICE14, NOTICE15,
                    NOTICE16, NOTICE17, NOTICE18, NOTICE19, NOTICE20, NOTICE21, NOTICE22, NOTICE23);
                if ($session->uid == $database->getVillage($d)) {
                    $limit = "ntype=0 and ntype=4 and ntype=5 and ntype=6 and ntype=7";
                } else {
                    $limit = "ntype!=8 and ntype!=9 and ntype!=10 and ntype!=11 and ntype!=12 and ntype!=13 and ntype!=14";
                }

                $result = mysql_query("SELECT `data`,`ntype`,`time`,`id` FROM " . TB_PREFIX . "ndata WHERE $limit AND uid = " . $session->uid . " AND toWref = " . $d . " ORDER BY time DESC Limit 5");

                while ($row = mysql_fetch_array($result)) {
                    $dataarray = explode(",", $row['data']);
                    $type = $row['ntype'];
                    echo "<tr><td>";
                    echo "<img src=\"img/x.gif\" class=\"iReport iReport" . $row['ntype'] . "\" title=\"" . $noticeClass[$type] . "\"> ";
                    $date = $generator->procMtime($row['time']);
                    echo "<a href=\"berichte.php?id=" . $row['id'] . "\">" . $date[0] . " " . date('H:i', $row['time']) . "</a> ";
                    echo "</td></tr>";
                }
            ?>
            </tbody>
        </table>
        </div>
        </div>
        <div class="clear"></div>
        </div>
        </div>
        <div class="contentFooter">&nbsp;</div>
        </div>
        <div id="sidebarAfterContent" class="sidebar afterContent">
            <div id="sidebarBoxActiveVillage" class="sidebarBox ">
                <div class="sidebarBoxBaseBox">
                    <div class="baseBox baseBoxTop">
                        <div class="baseBox baseBoxBottom">
                            <div class="baseBox baseBoxCenter"></div>
                        </div>
                    </div>
                </div>
                <?php include 'Templates/sideinfo.tpl'; ?>
            </div>
            <?php
                include 'Templates/multivillage.tpl';
                include 'Templates/quest.tpl';
            ?>
        </div>
        <div class="clear"></div>
        ﻿<?php
            include 'Templates/footer.tpl';
        ?>
        </div>
        <div id="ce"></div>
        </div>
        </body>
        </html>
    <?php } ?>