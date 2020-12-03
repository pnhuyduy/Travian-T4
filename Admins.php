<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include_once("GameEngine/Account.php");
include_once("GameEngine/Village.php");
if ($session->access < MULTIHUNTER) {
    die("Hacking Attempt !");
}
include("Templates/html.tpl");

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
                    <div id="content" class="statistics">
                        <h1 class='titleInHeader'>Admin Panel</h1>

                        <div class='contentNavi subNavi'>
                            <div title='' <?php if ((isset($_GET['tid']) && ($_GET['tid'] == 1))) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=1'><span class='tabItem'>&#1575;&#1585;&#1587;&#1575;&#1604; &#1662;&#1740;&#1575;&#1605; &#1583;&#1575;&#1582;&#1604; &#1576;&#1575;&#1586;&#1740;</span></a>
                                </div>
                            </div>
                            <div
                                title='' <?php if (!isset($_GET['tid']) || isset($_GET['tid']) && ($_GET['tid'] == 2)) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=2'><span
                                            class='tabItem'>&#1575;&#1585;&#1587;&#1575;&#1604; &#1662;&#1740;&#1575;&#1605; &#1607;&#1605;&#1711;&#1575;&#1606;&#1740;</span></a></div>
                            </div>
                            <div title='' <?php if (isset($_GET['tid']) && $_GET['tid'] == 3) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=3'><span
                                            class='tabItem'>&#1605;&#1583;&#1740;&#1585;&#1740;&#1578; &#1662;&#1740;&#1575;&#1605; &#1607;&#1575;</span></a></div>
                            </div>
                            <div title='' <?php if (isset($_GET['tid']) && $_GET['tid'] == 4) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=4'><span
                                            class='tabItem'>&#1662;&#1740;&#1575;&#1605; &#1580;&#1593;&#1576;&#1607; &#1575;&#1591;&#1604;&#1575;&#1593;&#1575;&#1578;</span></a></div>
                            </div>
                            <div title='' <?php if (isset($_GET['tid']) && $_GET['tid'] == 5) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=5'><span
                                            class='tabItem'>Auction's</span></a></div>
                            </div>
                            <div title='' <?php if (isset($_GET['tid']) && $_GET['tid'] == 6) {
                                echo 'class=\'container active\'';
                            } else {
                                echo 'class=\'container normal\'';
                            } ?>>
                                <div class='background-start'>&nbsp;</div>
                                <div class='background-end'>&nbsp;</div>
                                <div class='content'><a href='Admins.php?tid=6'><span class='tabItem'>Farm</span></a>
                                </div>
                            </div>
                            <div class='clear'></div>
                        </div>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
                        <?php

                            if (isset($_GET['tid'])) {
                                switch ($_GET['tid']) {
                                    case 1:
                                        include('Templates/Admin/massmessage.tpl');
                                        break;
                                    case 2:
                                        include('Templates/Admin/SMssg.tpl');
                                        break;
                                    case 3:
                                        include('Templates/Admin/MMssg.tpl');
                                        break;
                                    case 4:
                                        include('Templates/Admin/Infobox_message.tpl');
                                        break;
                                    case 5:
                                        include('Templates/Admin/addauction.tpl');
                                        break;
                                    case 6:
                                        include('Templates/Admin/farm.tpl');
                                        break;
                                    default:
                                        include('Templates/Admin/SMssg.tpl');
                                        break;
                                }
                            } else {
                                include('Templates/Admin/SMssg.tpl');
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
            &#65279;<?php
            include 'Templates/footer.tpl';
            ?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>

