<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Village.php");
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['newdid'])) {
        $_SESSION['wid'] = $_GET['newdid'];
        header("Location: " . $_SERVER['PHP_SELF']);
    } else {
        $message->noticeType($_GET);
        $message->procNotice($_POST);
    }
    include "Templates/html.tpl";
    if ($_SESSION['qst'] == 11) {
        $_SESSION['done'][0] = 1;
        $q = "SELECT COUNT(id) FROM " . TB_PREFIX . "ndata WHERE ntype = 9 AND viewed=1 AND uid=" . $session->uid;
        $result = mysql_query($q);
        $data = mysql_fetch_assoc($result);
        if ($data['COUNT(id)'] > 0) {
            $_SESSION['done'][1] = 1;
        }
    }
?>
<body class='v35 gecko reports perspectiveBuildings'>
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
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.ir/"
                       target="_blank"
                       title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id='content' class='reports'>
                        <h1 class="titleInHeader"><?php echo MS_REPORTS; ?></h1>

                        <div class="contentNavi subNavi">
                            <div title="" class="container <?php if (!isset($_GET['t'])) {
                                echo "active";
                            } else {
                                echo "normal";
                            } ?>">
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="berichte.php"><span
                                            class="tabItem"><?php echo HEADER_ALL; ?></span></a></div>
                            </div>
                            <div title="" class="container <?php if (isset($_GET['t']) && $_GET['t'] == 1) {
                                echo "active";
                            } else {
                                echo "normal";
                            } ?>">
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="berichte.php?t=1"><span
                                            class="tabItem"><?php echo HEADER_TRADE; ?></span></a></div>
                            </div>
                            <div title="" class="container <?php if (isset($_GET['t']) && $_GET['t'] == 2) {
                                echo "active";
                            } else {
                                echo "normal";
                            } ?>">
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="berichte.php?t=2"><span
                                            class="tabItem"><?php echo HEADER_REINFORCEMENT; ?></span></a></div>
                            </div>
                            <div title="" class="container <?php if (isset($_GET['t']) && $_GET['t'] == 3) {
                                echo "active";
                            } else {
                                echo "normal";
                            } ?>">
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="berichte.php?t=3"><span
                                            class="tabItem"><?php echo HEADER_MISCELLANEOUS; ?></span></a></div>
                            </div>
                            <?php if ($session->plus) { ?>
                                <div title="" class="container <?php if (isset($_GET['t']) && $_GET['t'] == 4) {
                                    echo "active";
                                } else {
                                    echo "normal";
                                } ?>">
                                    <div class="background-start">&nbsp;</div>
                                    <div class="background-end">&nbsp;</div>
                                    <div class="content"><a href="berichte.php?t=4"><span
                                                class="tabItem"><?php echo MS_ARCHIVE; ?></span></a></div>
                                </div> <?php } ?>
                            <div class="clear"></div>
                        </div>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>

                        <?php

                            if (isset($_GET['n1']) && isset($_GET['del']) == 1) {
                                $database->delNotice($_GET['n1'], $session->uid);
                                header("Location: berichte.php");
                            }
                            if (isset($_GET['aid'])) {
                                if ($session->alliance == $_GET['aid']) {
                                    if (isset($_GET['id'])) {
                                        $type = $database->getNotice2($_GET['id'], 'ntype');
                                        switch ($type) {
                                            case 0:
                                            case 1:
                                            case 2:
                                            case 3:
                                                $type = 1;
                                                break;
                                            case 4:
                                            case 5:
                                            case 6:
                                            case 7:
                                                $type = 4;
                                                break;
                                            case 10:
                                            case 11:
                                            case 12:
                                            case 13:
                                            case 14:
                                                $type = 10;
                                                break;
                                            case 15:
                                            case 16:
                                            case 17:
                                            case 18:
                                            case 19:
                                                $type = 1;
                                                break;
                                        }
                                        include("Templates/Notice/" . $type . ".tpl");
                                    }
                                }
                            } else {
                                if (isset($_GET['t'])) {
                                    include("Templates/Notice/t_" . $_GET['t'] . ".tpl");
                                } elseif (isset($_GET['id'])) {
                                    if ($database->getNotice2($_GET['id'], 'uid') == $session->uid || $session->access >= MULTIHUNTER) {
                                        $type = ($message->readingNotice['ntype'] == 5) ? $message->readingNotice['archive'] : $message->readingNotice['ntype'];
                                        switch ($type) {
                                            case 0:
                                            case 1:
                                            case 2:
                                            case 3:
                                                $type = 1;
                                                break;
                                            case 4:
                                            case 5:
                                            case 6:
                                            case 7:
                                                $type = 4;
                                                break;
                                            case 10:
                                            case 11:
                                            case 12:
                                            case 13:
                                            case 14:
                                                $type = 10;
                                                break;
                                            case 15:
                                            case 16:
                                            case 17:
                                            case 18:
                                            case 19:
                                                $type = 1;
                                                break;
                                        }
                                        include("Templates/Notice/" . $type . ".tpl");
                                    }
                                } else {
                                    include("Templates/Notice/all.tpl");
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