<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include "GameEngine/Protection.php";
    include "GameEngine/Village.php";
    include "GameEngine/Units.php";

    $winner = $database->hasWinner();

    if ($winner) {
        header("Location: winner.php");
        die;
    }
    if ($session->access < 2) {
        header("Location: banned.php");
        die;
    }

    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "' LIMIT 1");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        header('Location: ' . $_SERVER['PHP_SELF'] . (isset($_GET['id']) ? '?id=' . preg_replace('/[^a-zA-Z0-9_-]/', '', $_GET['id']) : (isset($_GET['gid']) ? '?gid=' . preg_replace('/[^a-zA-Z0-9_-]/', '', $_GET['gid']) : '')));
        die;
    }
    $start = $generator->pageLoadTimeStart();

    $alliance->procAlliForm($_POST);
    $technology->procTech($_POST);
    $market->procMarket($_POST);

    if (isset($_GET['gid'])) {
        $_GET['id'] = strval($building->getTypeField($_GET['gid']));
    } else if (isset($_POST['id'])) {
        $_GET['id'] = $_POST['id'];
    }
    if (isset($_POST['t'])) {
        $_GET['t'] = $_POST['t'];
    }

    if (isset($_GET['id'])) {
        if (!ctype_digit($_GET['id'])) {
            $_GET['id'] = "1";
        }
        if ($village->resarray['f' . $_GET['id'] . 't'] == 17) {
            $market->procRemove($_GET);
        }
        if ($village->resarray['f' . $_GET['id'] . 't'] == 18) {
            $alliance->procAlliance($_GET);
        }
        if ($village->resarray['f' . $_GET['id'] . 't'] == 12 || $village->resarray['f' . $_GET['id'] . 't'] == 13 || $village->resarray['f' . $_GET['id'] . 't'] == 22) {
            $technology->procTechno($_GET);
        }
        if ($_GET['id'] == 39 && isset($_GET['a']) && $_GET['a'] == 4 && isset($_GET['aa'])) {
            $aaId = intval($_GET['aa']);
            $theMov = $database->getMovementById($aaId);
            if ($theMov["from"] == $village->wid && (time() - $theMov['starttime']) <= (max(20, floor(90 / pow(INCREASE_SPEED, 1 / 3))))) {
                $database->cancelMovement($aaId, $theMov['to'], $theMov['from']);
            }
        }
    }

    if ($session->goldclub == 1 && count($session->villages) > 1) {
        if (isset($_POST['action']) && $_POST['action'] == 'addRoute') {
            if ($session->access != BANNED) {
                if ($session->gold >= 2) {
                    for ($i = 1; $i <= 4; $i++) {
                        if ($_POST['r' . $i] == '') {
                            $_POST['r' . $i] = 0;
                        }
                    }
                    $totalres = preg_replace('/[^0-9]/', '', $_POST['r1']) + preg_replace('/[^0-9]/', '', $_POST['r2']) + preg_replace('/[^0-9]/', '', $_POST['r3']) + preg_replace('/[^0-9]/', '', $_POST['r4']);
                    $reqMerc = ceil(($totalres - 0.1) / $market->maxcarry);


                    $second = date('s');
                    $minute = date('i');
                    $hour = date('G') - $_POST['start'];
                    if (date('G') > $_POST['start']) {
                        $day = 1;
                    } else {
                        $day = 0;
                    }
                    $timestamp = strtotime('-' . $hour . ' hours -' . $second . ' second -' . $minute . ' minutes +' . $day . ' day');
                    if ($totalres > 0) {
                        $database->createTradeRoute($session->uid, $_POST['tvillage'], $village->wid, $_POST['r1'], $_POST['r2'], $_POST['r3'], $_POST['r4'], $_POST['start'], $_POST['deliveries'], $reqMerc, $timestamp);
                        $route = 1;
                        header('Location: build.php?gid=17&t=4');
                        exit;
                    } else {
                        $route = 1;
                        header('Location: build.php?gid=17&t=4&create');
                        exit;
                    }
                }
            } else {
                $route = 0;
                header('Location: banned.php');
                exit;
            }
        }
        if (isset($_POST['action']) && $_POST['action'] == 'editRoute') {
            if ($session->access != BANNED) {
                $totalres = $_POST['r1'] + $_POST['r2'] + $_POST['r3'] + $_POST['r4'];
                $reqMerc = ceil(($totalres - 0.1) / $market->maxcarry);
                if ($totalres > 0) {
                    $database->editTradeRoute($_POST['routeid'], 'wood', $_POST['r1'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'clay', $_POST['r2'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'iron', $_POST['r3'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'crop', $_POST['r4'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'start', $_POST['start'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'deliveries', $_POST['deliveries'], 0);
                    $database->editTradeRoute($_POST['routeid'], 'merchant', $reqMerc, 0);
                    $second = date('s');
                    $minute = date('i');
                    $hour = date('G') - $_POST['start'];
                    if (date('G') > $_POST['start']) {
                        $day = 1;
                    } else {
                        $day = 0;
                    }
                    $timestamp = strtotime('-$hour hours -$second seconds -$minute minutes +$day day');
                    $database->editTradeRoute($_POST['routeid'], 'timestamp', $timestamp, 0);
                }
                $route = 1;
                header('Location: build.php?gid=17&t=4');
                exit;
            } else {
                $route = 0;
                header('Location: banned.php');
                exit;
            }
        }
        if (isset($_GET['action']) && $_GET['action'] == 'delRoute') {
            if ($session->access != BANNED) {
                $traderoute = $database->getTradeRouteUid($_GET['routeid']);
                if ($traderoute == $session->uid) {
                    $database->deleteTradeRoute($_GET['routeid']);
                    $route = 1;
                    header('Location: build.php?gid=17&t=4');
                    exit;
                } else {
                    $route = 1;
                    header('Location: build.php?gid=17&t=4');
                    exit;
                }
            } else {
                $route = 0;
                header('Location: banned.php');
                exit;
            }
        }
    }

    if (isset($_POST['h']) && $_POST['a'] == 'adventure') {
        $units->Adventures($_POST);
    } elseif (isset($_POST['a']) == 533374 && isset($_POST['id']) == 39) {
        $units->Settlers($_POST);
    }
    include "Templates/html.tpl";
?>
<body class='v35 gecko build perspectiveBuildings'>
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
                    require('Templates/heroSide.tpl');
                    require('Templates/Alliance.tpl');
                    require('Templates/infomsg.tpl');
                    require('Templates/links.tpl');
                ?>
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer">
                <?php require('Templates/res.tpl'); ?>
                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="<?php if ($_GET['id'] < 19) {
                        echo 'dorf1.php';
                    } else {
                        echo 'dorf2.php';
                    } ?> " title="<?php echo BL_CLOSE;?>">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank"
                       title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                    <?php
                    $tab_id = isset($_GET['t']) ? $_GET['t'] : 0;
                    ?>
                    <a id="tabFavorButton" class="contentTitleButton" 
                    onclick="Cookie.write('marketTab', 'favorKey<?= $tab_id ?>');$$('.favor').removeClass('favorActive');$$('.favor.favorKey<?= $tab_id ?>').addClass('favorActive');return false;"
                    title="<?php echo BL_FAVOR;?>">&nbsp;</a>
                </div>
                <div class="contentContainer">

                    <div id='content' class='build'>
                        <?php

                            if (isset($_GET['id'])) {
                                if (isset($_GET['s'])) {
                                    if (!ctype_digit($_GET['s'])) {
                                        $_GET['s'] = null;
                                    }
                                }
                                if (isset($_GET['t'])) {
                                    if (!ctype_digit($_GET['t'])) {
                                        $_GET['t'] = null;
                                    }
                                }
                                if (!ctype_digit($_GET['id'])) {
                                    $_GET['id'] = "1";
                                }
                                $id = $_GET['id'];
                                if (($village->resarray['f99t'] == 40) && ($id == '26' || $id == '30' || $id == '31' || $id == '32')) {
                                    $id = 99;
                                    $_GET['id'] = 99;
                                }
                                if ($id == '99') {
                                    if ($village->resarray['f99t'] == 40) {
                                        include("Templates/Build/ww.tpl");
                                    } else {
                                        header('Location: dorf2.php');
                                        exit;
                                    }
                                } elseif ($village->resarray['f' . $_GET['id'] . 't'] == 0 && $_GET['id'] >= 19) {
                                    include("Templates/Build/avaliable.tpl");
                                } else {
                                    if (isset($_GET['t'])) {
                                        if ($_GET['t'] == 1) {
                                            $_SESSION['loadMarket'] = 1;
                                        }
                                        if ($_GET['t'] == 0) {
                                            include("Templates/Build/" . $village->resarray['f' . $_GET['id'] . 't'] . ".tpl");
                                        } else include("Templates/Build/" . $village->resarray['f' . $_GET['id'] . 't'] . "_" . $_GET['t'] . ".tpl");
                                    } else
                                        if (isset($_GET['s'])) {
                                            include("Templates/Build/" . $village->resarray['f' . $_GET['id'] . 't'] . "_" . $_GET['s'] . ".tpl");
                                        } else {
                                            //echo "Templates/Build/".$village->resarray['f'.$_GET['id'].'t'].".tpl";
                                            //die();
                                            $favor_tab_id = isset($_COOKIE['marketTab']) ? str_replace("favorKey", "", $_COOKIE['marketTab']) : 0;
                                            $favor_tab_id = intval($favor_tab_id);
                                            
                                            if ($favor_tab_id && $village->resarray['f' . $_GET['id'] . 't'] == 17) { // Market
                                                include("Templates/Build/" . $village->resarray['f' . $_GET['id'] . 't'] . "_" . $favor_tab_id . ".tpl");
                                            } else include("Templates/Build/" . $village->resarray['f' . $_GET['id'] . 't'] . ".tpl");
                                            
                                        }
                                    if (isset($_GET['t']) == 99) {

                                        if (isset($_GET['action']) && $_GET['action'] == 'addList') {
                                            include("Templates/goldClub/farmlist_add.tpl");
                                        }
                                        if (isset($_GET['action']) && $_GET['action'] == 'showSlot' && $_GET['lid']) {
                                            include("Templates/goldClub/farmlist_addraid.tpl");
                                        } elseif (isset($_GET['action']) && $_GET['action'] == 'showSlot' && $_GET['eid']) {
                                            include("Templates/goldClub/farmlist_editraid.tpl");
                                        }
                                        if (isset($_GET['action']) && $_GET['action'] == 'removeList') {
                                            $database->delFarmList($_GET['lid'], $session->uid);
                                            header("Location: build.php?id=39&t=99");
                                            die;
                                        } elseif (isset($_GET['action']) && $_GET['action'] == 'removeSlot') {
                                            $database->delSlotFarm($_GET['eid']);
                                            header("Location: build.php?id=39&t=99");
                                            die;
                                        }
                                    }
                                }
                            }
                        ?>
                        <div class='clear'>&nbsp;</div>
                    </div>
                    <div class='clear'></div>
                </div>
                <div class='contentFooter'>&nbsp;</div>
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
                    <?php require 'Templates/sideinfo.tpl'; ?>
                </div>
                <?php
                    require 'Templates/multivillage.tpl';

                    require 'Templates/quest.tpl';
                ?>
            </div>
            <div class="clear"></div>
            ﻿<?php
                require 'Templates/footer.tpl';
            ?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>