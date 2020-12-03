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

//var_dump($_POST);die;

    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "' LIMIT 1");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        header("Location: " . $_SERVER['PHP_SELF']);
        exit;
    } else {
        $message->procMessage($_POST);
    }
    include "Templates/html.tpl";

?>
<body class='v35 gecko messages perspectiveBuildings'>
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
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php"
                       title="<?php echo BL_CLOSE; ?>">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank"
                       title="<?php echo BL_TRAVIANANS; ?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id='content' class='messages'>
                        <h1 class="titleInHeader"><?php echo MS_HEADERMESSAGES; ?></h1>
                        <?php
                            include("Templates/Message/menu.tpl");
                        ?>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
                        <?php
                            if (isset($_GET['token']) && $_GET['token'] == $_SESSION['tok_key']) {
                                echo '<p style="color:red">' . sprintf(MS_SPAMMSG, ANTI_SPAM_TIME) . '</p>';
                            }
                            if (isset($_GET['id']) && !isset($_GET['t'])) {
                                $message->loadMessage($_GET['id']);
                                include("Templates/Message/read.tpl");
                            } elseif (isset($_GET['n1']) && !isset($_GET['t'])) {
                                $database->delMessage($_GET['n1']);
                                header("Location: nachrichten.php");
                                die;
                            } else if (isset($_GET['t'])) {
                                switch ($_GET['t']) {
                                    case 1:
                                        if (isset($_GET['id'])) {
                                            $id = $_GET['id'];
                                        }
                                        include("Templates/Message/write.tpl");
                                        break;
                                    case 2:
                                        include("Templates/Message/sent.tpl");
                                        break;
                                    case 3:
                                        if ($session->goldclub) {
                                            include("Templates/Message/archive.tpl");
                                        }
                                        break;
                                    case 4:
                                        // if($session->plus) {
                                        $message->loadNotes();
                                        include("Templates/Message/notes.tpl");
                                        // }
                                        break;
                                    case 5:
                                        include('Templates/Message/ignore.tpl');
                                        break;
                                    case 6:
                                        include('Templates/Message/reports.tpl');
                                        break;
                                    default:
                                        include("Templates/Message/inbox.tpl");
                                        break;
                                }
                            } else {
                                include("Templates/Message/inbox.tpl");
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