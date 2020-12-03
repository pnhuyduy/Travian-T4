<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Session.php");
    $uLang = $_SESSION['lang'];
    $session->Logout();
    $_SESSION['lang'] = $uLang;
    if (isset($_GET['del_cookie'])) {
        header("Location: login.php");
        die;
    }
    include "Templates/html.tpl";
?>
<body class="v35 webkit chrome logout">
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
    <img id="staticElements" src="img/x.gif" alt="">

    <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="">

        <div id="header">
            <div id="mtop">
                <a id="logo" href="<?php echo HOMEPAGE; ?>" target="_blank" title="<?php echo SERVER_NAME; ?>"></a>

                <div class="clear"></div>
            </div>
        </div>
        <div id="center">
            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <div id="sidebarBoxMenu" class="sidebarBox   ">
                    <div class="sidebarBoxBaseBox">
                        <div class="baseBox baseBoxTop">
                            <div class="baseBox baseBoxBottom">
                                <div class="baseBox baseBoxCenter"></div>
                            </div>
                        </div>
                    </div>
                    <div class="sidebarBoxInnerBox">
                        <div class="innerBox header noHeader">
                        </div>
                        <div class="innerBox content">
                            <ul>
                                <li>
                                    <a href="<?php echo HOMEPAGE; ?>"
                                       title="<?php echo HOME; ?>"><?php echo HOME; ?></a>
                                </li>

                                <li class="active">
                                    <a href="login.php" title="<?php echo LOGIN; ?>"><?php echo LOGIN; ?></a>
                                </li>

                                <li>
                                  	<a href="anmelden.php" title="&#1579;&#1576;&#1578; &#1606;&#1575;&#1605;">&#1579;&#1576;&#1578; &#1606;&#1575;&#1605;</a>
                                </li>

                                <li>
                                    <a href="#" target="_blank" title="<?php echo FORUM; ?>"><?php echo FORUM; ?></a>
                                </li>

                                <li class="support">
                                    <a href="contact.php" title="<?php echo SUPPORT; ?>"><?php echo SUPPORT; ?></a>
                                </li>
                            </ul>
                        </div>
                        <div class="innerBox footer">
                        </div>
                    </div>
                </div>
            </div>
            <div id="contentOuterContainer">
                <div class="contentTitle">&nbsp;</div>
                <div class="contentContainer">
                    <div id="content" class="logout">
                        <h1 class="titleInHeader"><?php echo LGO_LOGOUTTITLE; ?></h1>
                        <h4><?php echo LGO_THANKS; ?></h4>

                        <p><?php echo LGO_DESC; ?></p>

                        <p><a class="arrow" href="login.php?del_cookie"><?php echo LGO_LINK; ?></a></p>

                        <div class="clear">&nbsp;</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="contentFooter">&nbsp;</div>
            </div>
            <div id="sidebarAfterContent" class="sidebar afterContent">
                <?php
                    if (NEWSBOX1) {
                        $t1 = trim(file_get_contents("Templates/News/newsbox1.tpl"));
                        if (strlen($t1) > 0) {
                            ?>
                            <div id="sidebarBoxNews1" class="sidebarBox   sidebarBoxNews">
                                <div class="sidebarBoxBaseBox">
                                    <div class="baseBox baseBoxTop">
                                        <div class="baseBox baseBoxBottom">
                                            <div class="baseBox baseBoxCenter"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebarBoxInnerBox">
                                    <div class="innerBox header noHeader"></div>
                                    <div class="innerBox content">
                                        <?php
                                            echo '<div class="news news1">';
                                        ?>
                                        <a href="#" class="newsContent newsContentWithLink"
                                           onclick="$H({data:{cmd:'News',id:'1'}}).dialog(); return false;">
                                            <?php
                                                echo $t1 . "</a><br>";
                                                echo '<a class="newsContentMoreInfoLink" target="_blank" href="' . HOMEPAGE . '">'.LG_MOREINFO.'</a></center></div>';?>
                                    </div>
                                    <div class="innerBox footer">
                                    </div>
                                </div>
                            </div>
                        <?php
                        }
                    }
                    if (NEWSBOX2) {
                        $t2 = trim(file_get_contents("Templates/News/newsbox2.tpl"));
                        if (strlen($t2) > 0) {
                            ?>
                            <div id="sidebarBoxNews2" class="sidebarBox   sidebarBoxNews">

                                <div class="sidebarBoxBaseBox">
                                    <div class="baseBox baseBoxTop">
                                        <div class="baseBox baseBoxBottom">
                                            <div class="baseBox baseBoxCenter"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebarBoxInnerBox">
                                    <div class="innerBox header noHeader"></div>
                                    <div class="innerBox content">
                                        <?php
                                            echo '<div class="news news2">';
                                        ?>
                                        <a href="#" class="newsContent newsContentWithLink"
                                           onclick="$H({data:{cmd:'News',id:'2'}}).dialog(); return false;">
                                            <?php
                                                echo $t2 . "</a><br>";
                                                echo '<a class="newsContentMoreInfoLink" target="_blank" href="' . HOMEPAGE . '">'.LG_MOREINFO.'</a></div>';
                                            ?>
                                    </div>
                                    <div class="innerBox footer">
                                    </div>
                                </div>
                            </div>
                        <?php
                        }
                    }
                ?>

            </div>
        </div>

        <?php
            include('Templates/footer.tpl');
            echo '</div>';
        ?>
        <div id="ce"></div>
    </div>
</div>
</div>
</body>
</html>