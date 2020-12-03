<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include('GameEngine/Village.php');
    include('Templates/html.tpl');
?>
<body class="v35 gecko chrome messages perspectiveResources">
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
    <div id="headerBar"></div>
    <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>
        <ul id="outOfGame" class="RTL">
            <li class='logout '>
                <a href='logout.php' title='Logout||logout from game'>
                    <img src='img/x.gif' alt='Logout'/>
                </a>
            </li>
            <script type="text/javascript">
                $$('#outOfGame li.logout a').addEvent('click', function () {
                    Travian.WindowManager.getWindows().each(function ($dialog) {
                        Travian.WindowManager.unregister($dialog);
                    });
                });
            </script>
        </ul>
        <div id="center">
            <a id="ingameManual" href="help.php">
                <img class="question" alt="Help" src="img/x.gif">
            </a>

            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer"><br/><br/><br/><br/>

                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank" title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div class="messagesText">
                        <h1 class='titleInHeader'><?php echo MS_PUBMSGTITLE; ?></h1>

                        <div id='block'>
                            <div id="content" class="messages">
                                <h2><?php echo AC_HELLO . ' ' . $session->username; ?>,</h2><br>
                                <?php include('Templates/text.tpl'); ?>
                            </div>
                        </div>
                        <div style='position:absolute;left:220px;top:500px;'>
                            <button type="submit" value="<?php echo MS_GOTOMYVILLAGE; ?>" name="s1" id="s1" class="green "
                                    onclick="window.location.href = 'dorf1.php?ok'">
                                <div class="button-container addHoverClick ">
                                    <div class="button-background">
                                        <div class="buttonStart">
                                            <div class="buttonEnd">
                                                <div class="buttonMiddle"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-content"><?php echo MS_GOTOMYVILLAGE; ?></div>
                                </div>
                            </button>
                        </div>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                if ($('s1')) {
                                    $('s1').addEvent('click', function () {
                                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "<?php echo MS_GOTOMYVILLAGE; ?>", "name": "s1", "id": "s1", "class": "green ", "title": "", "confirm": "", "onclick": "window.location.href = 'dorf1.php?ok'"}]);
                                    });
                                }
                            });
                        </script>
                    </div>
                </div>
                <div class='contentFooter'>&nbsp;</div>
            </div>
            <div id="sidebarAfterContent" class="sidebar afterContent">

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