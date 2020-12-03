<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include_once('GameEngine/Session.php');
    include_once('GameEngine/Protection.php');
    include_once('Templates/html.tpl');

    function getIp2()
    {
        $http_client_ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : null;
        $http_x_forwarded_for = isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : null;

        if (!empty($http_client_ip)) {
            $host_addr = $http_client_ip;
        } elseif (!empty($http_x_forwarded_for)) {
            $host_addr = $http_x_forwarded_for;
        } else {
            $remote_addr = $_SERVER['REMOTE_ADDR'];
            $host_addr = $remote_addr;
        }

        return $host_addr;
    }

    echo '
<body class="v35 gecko login perspectiveBuildings" '.$onload.'>
	<script type="text/javascript">
		window.ajaxToken = '.md5($_SERVER["REQUEST_TIME"]).';
	</script>
	<link rel="stylesheet" href="img/jquery.countdown.css">
	<style type="text/css">
#defaultCountdown { width: 240px; height: 45px; }
div.innerLoginBox2{height:400px;background-image:url(img/quest_new_village.jpg);}
</style>
	<div id="background">
		<img id="staticElements" src="img/x.gif" alt="">
		<div id="bodyWrapper">
			<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="">
			<div id="header">
				<div id="mtop">
					<a id="logo" href="' . HOMEPAGE . '" target="_blank" title="' . SERVER_NAME . '"></a>
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
		<div class="innerBox header noHeader"></div>
		<div class="innerBox content">
	<ul>
		<li>
			<a href="' . HOMEPAGE . '" title="' . HOME . '">' . HOME . '</a>
		</li>

		<li>
			<a href="login.php" title="' . LOGIN . '">' . LOGIN . '</a>
		</li>

		<li>
			<a href="../?server='.sv_.'#serverRegister" title="' . REG . '">' . REG . '</a>
		</li>

		<li>
			<a href="#" target="_blank" title="' . FORUM . '">' . FORUM . '</a>
		</li>

		<li class="support">
			<a href="contact.php" title="' . SUPPORT . '">' . SUPPORT . '</a>
		</li>

	</ul>
</div>

<div class="innerBox footer">
					</div>
				</div></div></div>
						<div id="contentOuterContainer">
							<div class="contentTitle">
								<a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.ir" target="_blank">&nbsp;</a>
							</div>
							<div class="contentContainer">
								<div id="content" class="login">
<h1 class="titleInHeader">' . LOGIN . '</h1>';
?>
    <h1 class="titleInHeader"><?php echo CT_SECPROBLEM;?></h1>

    <div class="outerLoginBox open">
        <div class="greenbox cf relogin">
            <div class="greenbox-top"></div>
            <div class="greenbox-content">
                <center><font color=red>
                        <?php echo sprintf(CT_SECPROBLEMDESC,getIp2());?><br/><br/><br/>
                </center>
                 <a class="a arrow" href="../"><?php echo HS_RETURN;?></a>

                <div class="greenbox-bottom"></div>
            </div>
        </div>
        <div class="clear">&nbsp;</div>
    </div>
    <?php
        echo '</div>
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
                            <a href="#" class="newsContent newsContentWithLink" onclick="$H({data:{cmd:'News',id:'1'}}).dialog(); return false;"><?php echo $t1;?></a>
                        </div>
                    </div>
                    <div class="innerBox footer">
                        <a class="newsContentMoreInfoLink" target="_blank" href="<?php echo HOMEPAGE;?>">...More information</a>
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
                            <a href="#" class="newsContent newsContentWithLink" onclick="$H({data:{cmd:'News',id:'2'}}).dialog(); return false;"><?php echo $t2;?></a>
                        </div>
                    </div>
                    <div class="innerBox footer">
                        <a class="newsContentMoreInfoLink" target="_blank" href="<?php echo HOMEPAGE;?>">...More information</a>
                    </div>
                </div>
            </div>
        <?php
        }
    }
    echo "</div>";
    include('Templates/footer.tpl');
    echo '</div><div id="ce"></div></div></div></div></body></html>';
?>