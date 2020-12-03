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

    if (isset($_POST['name'])) $_POST['name'] = strval($_POST['name']);
    if (isset($_POST['rank'])) $_POST['rank'] = intval($_POST['rank']);

    if ((!isset($_POST['name']) || (isset($_POST['name']) && $_POST['name'] == '')) && (!isset($_POST['rank']) || (isset($_POST['rank']) && ($_POST['rank'] == '' || $_POST['rank'] == 0)))) {
        unset($_POST['name']);
        unset($_POST['rank']);
    }
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['rank'])) {
        $_POST['rank'] = $_GET['rank'];
    }
    if (isset($_GET['newdid'])) {
        $_SESSION['wid'] = $_GET['newdid'];
        header("Location: " . $_SERVER['PHP_SELF']);
        die;
    }
    include "Templates/html.tpl";
    if ($_SESSION['qst'] == 15) {
        $_SESSION['statistics'] = 1;
    }
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
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">
                        &nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank"
                       title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="statistics">
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>

                        <h1 class="titleInHeader">
                            <?php
                                echo HDR_STATIS;
                            ?>
                        </h1>

                        <div class="contentNavi subNavi">
                            <div
                                title="" <?php if (!isset($_GET['tid']) || (isset($_GET['tid']) && ($_GET['tid'] == 1 || $_GET['tid'] == 31 || $_GET['tid'] == 32 || $_GET['tid'] == 7))) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php"><span
                                            class="tabItem"><?php echo AL_OVERVIEW; ?></span></a></div>
                            </div>
                            <div
                                title="" <?php if (isset($_GET['tid']) && ($_GET['tid'] == 4 || $_GET['tid'] == 41 || $_GET['tid'] == 42 || $_GET['tid'] == 43)) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php?tid=4"><span
                                            class="tabItem"><?php echo AL_ALLIANCE; ?></span></a></div>
                            </div>
                            <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 2) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php?tid=2"><span
                                            class="tabItem"><?php echo VILLAGES; ?></span></a></div>
                            </div>
                            <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 8) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php?tid=8"><span
                                            class="tabItem"><?php echo U0; ?></span></a></div>
                            </div>
                            <?php if ($session->plus) { ?>
                                <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 50) {
                                    echo "class=\"container gold active\"";
                                } else {
                                    echo "class=\"container gold normal\"";
                                } ?>>
                                    <div class="background-start">&nbsp;</div>
                                    <div class="background-end">&nbsp;</div>
                                    <div class="content"><a href="statistiken.php?tid=50"><span
                                                class="tabItem"><?php echo PF_PLUS;?></span></a></div>
                                </div>
                            <?php } ?>
                            <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 0) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php?tid=0"><span
                                            class="tabItem"><?php echo PF_GENERAL; ?></span></a></div>
                            </div>
                            <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 9) {
                                echo "class=\"container active\"";
                            } else {
                                echo "class=\"container normal\"";
                            } ?>>
                                <div class="background-start">&nbsp;</div>
                                <div class="background-end">&nbsp;</div>
                                <div class="content"><a href="statistiken.php?tid=9"><span class="tabItem"><?php echo AL_BONUS;?></span></a>
                                </div>
                            </div>
                            <?php if (SHOWWW2 == TRUE) {
                                include "Templates/Ranking/ww2.tpl";
                            }
                                if ($session->uid == 4) {
                                    ?>
                                    <div title='' class='container gold normal'>
                                        <div class='background-start'>&nbsp;</div>
                                        <div class='background-end'>&nbsp;</div>
                                        <div class='content'><a href='Admins.php'><span class='tabItem'><?php echo PF_ADMIN;?></span></a>
                                        </div>
                                    </div> <?php } ?>
                            <div class="clear"></div>
                        </div>
                        <?php
                            if (isset($_GET['tid'])) {
                                switch ($_GET['tid']) {
                                    case 31:
                                        include("Templates/Ranking/player_attack.tpl");
                                        break;
                                    case 32:
                                        include("Templates/Ranking/player_defend.tpl");
                                        break;
                                    case 7:
                                        include("Templates/Ranking/player_top10.tpl");
                                        break;
                                    case 2:
                                        include("Templates/Ranking/villages.tpl");
                                        break;
                                    case 4:
                                        include("Templates/Ranking/alliance.tpl");
                                        break;
                                    case 8:
                                        include("Templates/Ranking/heroes.tpl");
                                        break;
                                    case 9:
                                        include("Templates/Ranking/winner.tpl");
                                        break;
                                    case 41:
                                        include("Templates/Ranking/alliance_attack.tpl");
                                        break;
                                    case 42:
                                        include("Templates/Ranking/alliance_defend.tpl");
                                        break;
                                    case 43:
                                        include("Templates/Ranking/ally_top10.tpl");
                                        break;
                                    case 0:
                                        include("Templates/Ranking/general.tpl");
                                        break;
                                    case 50:
                                        include("Templates/Ranking/2plus.tpl");
                                        break;
                                    case 1:
                                    default:
                                        include("Templates/Ranking/overview.tpl");
                                        break;
                                    case 99:
                                    default:
                                        include("Templates/Ranking/ww.tpl");
                                        break;
                                }
                            } else {
                                include("Templates/Ranking/overview.tpl");
                            }
                        ?>
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