<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    if (isset($_GET['uid'])) $_GET['uid'] = intval($_GET['uid']);
    include("GameEngine/Protection.php");

    include("GameEngine/Village.php");
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = " . $_GET['newdid'] . " LIMIT 1");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        header("Location: " . $_SERVER['PHP_SELF']);
        die;
    }else{
        $profile->procProfile($_POST);
        $profile->procSpecial($_GET);
    }
    include "Templates/html.tpl";
?>
<body class="v35 gecko player perspectiveResources">
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
                <div class='contentContainer'>
                    <div id='content' class='player'>
                        <?php $username = $database->getUserField($_GET['uid'], "username", 0); ?>
                        <h1 class="titleInHeader">
                            <?php
                                echo AL_PLAYER;
                                if (isset($_GET['uid']) && is_numeric($_GET['uid'])) {
                                    echo "- " . $username;
                                } ?>
                        </h1>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
                        <?php
                            if ((isset($_GET['uid']) && $_GET['uid'] == $session->uid) || !isset($_GET['uid'])) {
                                include("Templates/Profile/menu.tpl");
                            }
                            if (isset($_GET['uid'])) {
                                if ($_GET['uid'] >= 2) {
                                    $user = $database->getUser($_GET['uid'], 1);
                                    if (isset($user['id'])) {
                                        include("Templates/Profile/overview.tpl");
                                    } else {
                                        include("Templates/Profile/notfound.tpl");
                                    }
                                } else {
                                    include("Templates/Profile/special.tpl");
                                }
                            } else if (isset($_GET['s'])) {
                                if ($_GET['s'] == 1) {
                                    include("Templates/Profile/profile.tpl");
                                }
                                elseif ($_GET['s'] == 2) {
                                    include("Templates/Profile/preference.tpl");
                                }
                                elseif ($_GET['s'] == 3) {
                                    include("Templates/Profile/account.tpl");
                                }
                                elseif ($_GET['s'] > 4 or $session->is_sitter == 1) {
                                    header("Location: " . $_SERVER['PHP_SELF'] . "?uid=" . preg_replace("/[^a-zA-Z0-9_-]/", "", $session->uid));
                                    die;
                                }
                            }

                        ?>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
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