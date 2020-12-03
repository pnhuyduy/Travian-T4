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
    if (isset($_GET['ok'])) {
        $database->updateUserField($session->username, 'ok', '0', '0');
        $_SESSION['ok'] = '0';
    }
    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "' LIMIT 1");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        header('Location: ' . $_SERVER['PHP_SELF']);
        exit;
    } else {
        $building->procBuild($_GET);
    }
    include "Templates/html.tpl";
    if ($_SESSION['qst'] == 6) {
        $_SESSION['done'][0] = 1;
    }
?>
<body class="v35 gecko chrome village2 perspectiveBuildings">
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
                    <a id="closeContentButton" class="contentTitleButton" href="dorf2.php">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com"
                       target="_blank">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="village2">
                        <div class="villageMapWrapper">
                            <?php include('Templates/dorf2.tpl'); ?>
                        </div>
                        <?php
                            if (NEWSBOX3) {
                                include('Templates/News/newsbox3.tpl');
                            }
                            if ($building->NewBuilding) {
                                include('Templates/Building.tpl');
                            }
                        ?>
                        <div class="clear">&nbsp;</div>
                    </div>
                </div>
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