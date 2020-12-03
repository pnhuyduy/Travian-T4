<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Account.php");
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
                            <a href="<?php echo HOMEPAGE; ?>" title="<?php echo HOME; ?>"><?php echo HOME; ?></a>
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
    <div id="content" class="activate">
    <h1 class="titleInHeader"><?php echo LOGIN; ?></h1>
    <div id="passwordForgotten">
<?php
    $npw = $_GET['npw'];
    $act = $_GET['cpw'];
    $user = $_GET['user'];
    $pagehide = FALSE;


    function generateHash($plainText, $salt = 1)
    {
        $salt = substr($salt, 0, 9);

        return $salt . md5($salt . $plainText);
    }

    if ($database->checkExist($user, 0)) {
        $getUser = $database->getUser($user, 0);
        $getProc = $database->getNewProc($getUser['id']);
        if ($npw == $getProc['npw']) {
            if ($act == $getProc['act']) {
                $newPassword = generateHash($npw);
                $database->updateUserField($user, 'password', $newPassword, 0);
                $database->editTableField('newproc', 'proc', 1, 'uid', $getUser['id']);
                echo PF_PASSWORDCHANGED . '<br /><br />' . PF_PASSFOLLOW . '<a class="a arrow" href="login.php?user=' . $user . '&pw=' . $npw . '">' . LOGIN . '</a>';
                $database->removeProc($getUser['id']);
            } else {
                echo '<font color="#FF0000">' . PF_PASSWRONGCODE . '</font>';
            }
        } else {
            echo '<font color="#FF0000">' . PF_PASSWRONG . '</font>';
        }
    } else {
        echo '<font color="#FF0000">' . PF_PASSNOTAUSER . '</font>';
    }

    echo '
        </div> </div>
        <div class="clear"></div>
		</div>
<div class="contentFooter">&nbsp;</div>
</div>
<div id="sidebarAfterContent" class="sidebar afterContent">
';
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
                        <div class="news news1">
                            <a href="#" class="newsContent newsContentWithLink"
                               onclick="$H({data:{cmd:'News',id:'1'}}).dialog(); return false;"><?php echo $t1; ?></a>
                        </div>
                    </div>
                    <div class="innerBox footer">
                        <a class="newsContentMoreInfoLink" target="_blank" href="<?php echo HOMEPAGE; ?>"><?php echo LG_MOREINFO;?></a>
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
                        <div class="news news2">
                            <a href="#" class="newsContent newsContentWithLink"
                               onclick="$H({data:{cmd:'News',id:'2'}}).dialog(); return false;"><?php echo $t2; ?></a>
                        </div>
                    </div>
                    <div class="innerBox footer">
                        <a class="newsContentMoreInfoLink" target="_blank" href="<?php echo HOMEPAGE; ?>"><?php echo LG_MOREINFO;?></a>
                    </div>
                </div>
            </div>
        <?php
        }
    }
    echo '</div></div>';
    include('Templates/footer.tpl');
    echo '</div><div id="ce"></div></div></div></div></body></html>';