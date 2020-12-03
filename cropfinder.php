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
    if ($session->access < 2) {
        header("Location: banned.php");
    }
    if ($session->goldclub == 0) {
        header("Location: dorf1.php");
    }

    if ($_POST['type'] == 15) {
        header("Location: " . $_SERVER['PHP_SELF'] . "?s=1&x=" . $_POST['x'] . '&y=' . $_POST['y']);
        die;
    } elseif ($_POST['type'] == 9) {
        header("Location: " . $_SERVER['PHP_SELF'] . "?s=2&x=" . $_POST['x'] . '&y=' . $_POST['y']);
        die;
    } elseif ($_POST['type'] == 'both') {
        header("Location: " . $_SERVER['PHP_SELF'] . "?s=3&x=" . $_POST['x'] . '&y=' . $_POST['y']);
        die;
    }
    include "Templates/html.tpl";
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
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="Close Window">
                        &nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank"
                       title="Travian Answers">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="cropfinder">

                        <?php include "Templates/cropfinder.tpl"; ?>
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
