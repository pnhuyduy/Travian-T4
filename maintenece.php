<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include('GameEngine/Village.php');
    $start = $generator->pageLoadTimeStart();
    include('Templates/html.tpl');
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
                    <div id="content" class="reports">
                        <center><h1><?php echo BD_SERVERMAINT; ?></h1></center>
                        <br><b><?php sprintf(BD_SERVERMAINTDESC, $session->username); ?></b>
                        <br><br>
                        <br><br>
                        <center>
                            <br><br>
                            <?php
                                $q = mysql_query("SELECT * FROM " . TB_PREFIX . "maintenece");
                                $conf = mysql_fetch_assoc($q);

                                if ($conf['active'] != 1) {
                                    header('Location: dorf1.php');
                                    die;
                                }
                                $main = $conf['time'] - time();
                                function secondsToString($seconds)
                                {
                                    $seconds = intval($seconds);
                                    $h = floor($seconds / 3600);
                                    $m = floor($seconds % 3600 / 60);
                                    $s = floor($seconds % 60);
                                    if ($h < 0 || $m < 0 || $s < 0) {
                                        return "0:00:00";
                                    }

                                    return $h . ":" . ($m < 10 ? "0" : "") . $m . ":" . ($s < 10 ? "0" : "") . $s;
                                }

                                $ss = secondsToString($main);
                                if ($ss != '0:00:00') {
                                    echo "<p align=\"center\"><strong><span id=\"timer" . $timer . "\">$ss</span> Till Server back Online</strong></p>";
                                    $timer++;
                                }
                                echo "\t\t<div class=\"l-tl\"><div class=\"l-tr\"><div class=\"l-tc\"></div></div>";
                                echo "<div class=\"l-ml\"><div class=\"l-mr\"><div class=\"l-mc\"><div class=\"l-content\">";
                                echo '<table id="brought_in" cellpadding="1" cellspacing="1" align=center class="auto-style2">
<thead><th colspan="10" class="auto-style1">' . BD_SERVERMAINTDESC2 . '</thead>
<tbody><th>';
                                if (empty($conf['reason'])) {
                                    echo "<font color=darkred><b>".BD_SORYNOREASYET."</b></font>";
                                } elseif (!$empty) {
                                    echo "<font color=green><b>";
                                    echo nl2br($conf['reason']);
                                    echo "</b></font></center>";
                                }
                                echo "</th></tbody></table>";
                                echo "<div class=\"clear\"></div>\r\n\t\t\t\t\t</div></div></div>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"l-bl\"><div class=\"l-br\"><div class=\"l-bc\"></div></div></div>\r\n\t\t\t</form>\r\n\t\t</div>";
                                for ($I = 0; $I <= 10; ++$I) {
                                    if ($I == 10) {
                                        echo "<center>";
                                    }
                                }
                                echo '<br><img src="img/Maintenance.png">';
                                echo "<p class=\"f16\" align=\"center\"><a href=\"maintenece.php?refresh\"><font color=blue>";
                                echo "next";
                                echo "</font></a></p>";
                                echo "<p class=\"f16\" align=\"center\"><a href=\"logout.php\"><font color=red>";
                                echo "Exit";
                                echo "</font></a></p>";
                                if (isset($_GET['refresh'])) {
                                    if (time() > $conf['time']) {
                                        mysql_query("UPDATE " . TB_PREFIX . "maintenece set active=0,time=0,reason=''") or die(mysql_error());
                                        echo "<SCRIPT language='JavaScript'>window.location='dorf1.php';</SCRIPT>";
                                    } else {
                                        echo "<center><font color=red size = 3.5><b>".BD_NOTFINISH."</b></font></center>";
                                    }
                                }
                            ?>
                        </center>
                        <div class="clear">&nbsp;</div>
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