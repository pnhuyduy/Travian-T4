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
if(isset($_GET['del_cookie'])) {
	setcookie("COOKUSR","",time()-3600*24,"/");
	header("Location: login.php");
}
if(!isset($_COOKIE['COOKUSR'])) {
	$_COOKIE['COOKUSR'] = "";
}
include "Templates/html.tpl";

?>
<script src="unx.js" type="text/javascript"></script>
<script src="crypt2.js?1343048922" type="text/javascript"></script>
<div id="content" class="activate">

<?php
echo '
<body class="v35 gecko login perspectiveBuildings">
	<script type="text/javascript">
		window.ajaxToken = '.md5($_SERVER["REQUEST_TIME"]).';
	</script>

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

		<li class="active">
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
';
?>


<h1 class="titleInHeader"><?php echo REG; ?></h1>

<?php
if(!isset($_GET['token']) && !isset($_GET['cv']) && !isset($_GET['form'])){

	if(isset($_GET['e']) && !is_numeric($_GET['e']))
		$_GET['e'] = 1;
	if(isset($_GET['e'])) {
		switch($_GET['e']) {
			case 1:
			include("Templates/activate/delete.tpl");
			break;
			case 2:
			include("Templates/activate/activated.tpl");
			break;
			case 3:
			include("Templates/activate/cantfind.tpl");
			break;
		}
	} else if(isset($_GET['id']) && isset($_GET['c'])) {
		if(isset($_GET['id']) && !is_numeric($_GET['id'])) die('Attempt of sql injection blocked');
		$c=$database->getActivateField($_GET['id'],"email",0);
		if($_GET['c'] == $generator->encodeStr($c,5)){
			include("Templates/activate/delete.tpl");
		} else {
			include("Templates/activate/activate.tpl");
		}
	} else {
		include("Templates/activate/activate.tpl");
	}

}else{






if (isset($_GET['token']) && isset($_GET['cv'])){

if ($_GET['token'] != $_SESSION['token']) {
    unset($_SESSION['token']);
    header("Location: login.php");
    exit;
}
unset($_SESSION['token']);
$_GET['cv'] = filter_var($_GET['cv'], FILTER_SANITIZE_MAGIC_QUOTES);
$_SESSION['MYUID'] = $_GET['cv'];
function generateHash($plainText, $salt = 1)
{
    $salt = substr($salt, 0, 9);
    return $salt . sha1($salt . $plainText);
}

for ($i = 1; $i <= 50; $i++) {
    if (generateHash($i) == $_GET['cv']) {
        $_GET['cv'] = $i;
        break;
    }
}
// echo $_GET['cv'];
// $_SESSION['MYUID'] = $_GET['cv'];

$_SESSION['MYP'] = 123123;
?>
<form method="POST" action="activate.php?form=activator">
<button type="submit" value="" name="">
<SCRIPT LANGUAGE="JavaScript">document.forms[0].submit();</SCRIPT>
<?php
}
// echo $_SESSION['MYUID'];
// echo $_GET['form'];
// echo $_GET['step'];

if (isset($_SESSION['MYUID']) && $_GET['form'] == 'activator' && !isset($_GET['step'])) {
$_GET['cv'] = filter_var($_GET['cv'], FILTER_SANITIZE_NUMBER_INT);
$_GET['cv'] = filter_var($_GET['cv'], FILTER_SANITIZE_MAGIC_QUOTES);
$result = mysql_query("SELECT `reg2` FROM " . TB_PREFIX . "users WHERE id='" . $_SESSION['MYUID'] . "' LIMIT 1");
$row = mysql_fetch_array($result);
$reg2 = $row['reg2'];

if ($reg2 != 1 AND $_SESSION['MYUID'] == '') {
    header("Location: login.php");
    exit;
}
?>
<div id="vid">
    <div class="ffBug"></div>
    <div class="greenbox boxVidInfo">
        <div class="greenbox-top"></div>
        <div class="greenbox-content">
            <div>از اینکه اکانت خود را فعال کردید متشکریم.</div>
        </div>
        <div class="greenbox-bottom"></div>
        <div class="clear"></div>
    </div>
    <div class="boxes boxGrey boxesColor gray">
        <div class="boxes-tl"></div>
        <div class="boxes-tr"></div>
        <div class="boxes-tc"></div>
        <div class="boxes-ml"></div>
        <div class="boxes-mr"></div>
        <div class="boxes-mc"></div>
        <div class="boxes-bl"></div>
        <div class="boxes-br"></div>
        <div class="boxes-bc"></div>
        <div class="boxes-contents cf">
            <div class="content">
                <form method="POST" action="activate.php?form=activator&step=2"><input
                        type="hidden" name="vid" value="3"/>
						<input type="hidden" name="uid"value="<?php echo $_SESSION['MYUID']; ?>"/>
                    <div class="container">
                        <div class="vidDescription">نژاد خود را برای این جهان (سرور) انتخاب کنید. <br/>
اگر به تازگی با تراوین آشنا شده‌اید ما توصیه می‌کنیم گول‌ها را انتخاب کنید.
                        </div>
                        <div class="vidSelect">
                            <div class="kind">
                                <div id="vid3" class="vid vid3"></div>
                                <div id="vid1" class="vid vid1"></div>
                                <div id="vid2" class="vid vid2"></div>
                            </div>
                            <div class="description-container">
                                <div class="description vid1">
                                    <div class="bubble"></div>
                                    <div class="text">
                                        <div class="headline">رومی ها</div>
                                        <div class="text">
                                            <div class="special">خصوصیات: </div>
                                            <ul>
                                                <li>زمان نیاز باید مدیریت شده باشد.<br/>
                                                </li>
                                                <li>می‌توانند سریع‌تر از بقیه دهکده‌ی خود را وسعت دهند.<br/>
                                                </li>
                                                <li>لشکریان قدرتمند ولی گرانبهایی دارند؛ پیاده نظام‌های
                                                بسیار قدرتمندی دارند.</li>
                                                <li>این نژاد مراحل ابتدایی بازی بسیار سخت می‌باشد و , برای بازیکن‌های جدید این نژاد توصیه نمی‌شود<br />
												</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="avatar vid1"></div>
                                </div>
                                <div class="description vid2">
                                    <div class="bubble"></div>
                                    <div class="text">
                                        <div class="headline">توتن‌ها</div>
                                        <div class="text">
                                            <div class="special">خصوصیات:</div>
                                            <ul>
                                                <li>زمان کافی برای بازیکن‌های مهاجم وجود دارد.<br/>
                                                </li>
                                                <li>لشکریان ارزان آن را می‌توان سریع تربیت کرد و برای غارت <br/> خوب هستند.</li>
                                                <li>برای بازیکن‌های مهاجم و با تجربه.</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="avatar vid2"></div>
                                </div>
                                <div class="description vid3">
                                    <div class="bubble"></div>
                                    <div class="text">
                                        <div class="headline">گول‌ها</div>
                                        <div class="text">
                                            <div class="special">خصوصیات:</div>
                                            <ul>
                                                <li>زمان کمی نیاز می‌باشد.<br/>
                                                </li>
                                                <li>از همان ابتدای بازی در مقابل غارت‌ها دفاع بهتری دارند.<br/>
                                                </li>
                                                <li>سواره نظام‌های عالی و سریع‌ترین نیروها را در بازی دارند.
                                                </li>
                                                <li>برای بازیکن‌های تازه وارد بهترین انتخاب می‌باشد.</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="avatar vid3"></div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="submitButton">
                        <button type="submit" value="Choose A tribe" name="submitKind" id="submitKind"
                                class="green ">
                            <div class="button-container addHoverClick ">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content">یک نژاد انتخاب کنید</div>
                            </div>
                        </button>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                if ($('submitKind')) {
                                    $('submitKind').addEvent('click', function () {
                                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "Choose a tribe", "name": "submitKind", "id": "submitKind", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                    });
                                }
                            });
                        </script>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var vid = new Travian.Game.Vid('vid3');
</script>
<div id="tpixeliframe_loading"
     style="display: none; z-index: 1000; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; background-color: #000; opacity: 0.4; -moz-opacity: 0.4; FILTER: progid : DXImageTransform.Microsoft.Alpha ( opacity = 40 );"></div>
<script type="text/javascript">
    var tg_load_handler = function () {
        document.getElementById("tpixeliframe_loading").style.display = "none";
    }
    tg_load_handler.delay(1000);
    window.onload = function () {
        tg_iframe = document.getElementById("tpixeliframe");
        tg_iframe.onload = tg_load_handler;
    }
    document.getElementById("tpixeliframe_loading").style.display = "block";
</script>
<?php
}else if (isset($_GET['step']) && $_GET['step'] == 2) {
    $_SESSION['MYVID'] = $_POST['vid'];
    header("Location: activate.php?form=activator&step=1");
    exit;
}else if (isset($_GET['step']) && $_GET['step'] == 1) {
?>
    <div id="sector">
        <form name="snd" method="POST" action="activate.php">
		<input type="hidden" name="uid" value="<?php echo $_SESSION['MYUID']; ?>"/>
            <div class="ffBug"></div>
            <input type="hidden" name="vid" value="<?php echo $_SESSION['MYVID']; ?>"/>
            <input type="hidden" name="ft" value="a0"/>

            <div class="greenbox boxVidInfo">
                <div class="greenbox-top"></div>
                <div class="greenbox-content">
                    <div> شما نژاد <?php $vid = $_SESSION['MYVID'];
                        if ($vid == 3) {
                            echo "گول ها ";
                        } else if ($vid == 1) {
                            echo "رومی ها ";
                        } else if ($vid == 2) {
                            echo "توتن ها ";
                        } ?> را انتخاب کرده اید .
                        از این به بعد <?php if ($vid == 3) {
                            echo "'' آمبریکس '' ";
                        } else if ($vid == 1) {
                            echo "'' کوآنتس '' ";
                        } else if ($vid == 2) {
                            echo "'' هنزیک '' ";
                        } ?>
                         راهنمای شما خواهد بود.
                    </div>

                    <div class="changeVid"><a href="activate.php?form=activator">تغییر نژاد</a>
                    </div>
                </div>
                <div class="greenbox-bottom"></div>
                <div class="clear"></div>
            </div>
            <div class="boxes boxGrey boxesColor gray">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents cf">
                    <div class="content">
                        <div class="sectorDescription">دهکده‌ی خود را اینجا بسازید و یا محل انتخابی را با کلیک روی نقشه عوض کنید.
                        </div>
                        <div class="sectorSelect">
                            <div class="map">
                                <div id="nw" class="sector nw a">
                                    <div class="highlight"></div>
                                </div>
                                <div id="no" class="sector no a">
                                    <div class="highlight"></div>
                                </div>
                                <div id="sw" class="sector sw a">
                                    <div class="highlight"></div>
                                </div>
                                <div id="so" class="sector so a">
                                    <div class="highlight"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="start">
                                <div class="center"><select name="sector">
                                        <option value="nw">شما در شمال-غربی شروع خواهید کرد.</option>
                                        <option value="no">شما در شمال-شرقی شروع خواهید کرد.</option>
                                        <option value="sw">شما در جنوب-غربی شروع خواهید کرد.</option>
                                        <option value="so">شما در جنوب-شرقی شروع خواهید کرد.</option>
                                    </select></div>
                            </div>
                            <div class="buttonContainer">
                                <button type="submit" value="Create village" name="submitSector" id="submitSector"
                                        class="green submitSector">
                                    <div class="button-container addHoverClick">
                                        <div class="button-background">
                                            <div class="buttonStart">
                                                <div class="buttonEnd">
                                                    <div class="buttonMiddle"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-content">ایجاد دهکده</div>
                                    </div>
                                </button>
                                <script type="text/javascript">
                                    window.addEvent('domready', function () {
                                        if ($('submitSector')) {
                                            $('submitSector').addEvent('click', function () {
                                                window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "Create village", "name": "submitSector", "id": "submitSector", "class": "green submitSector", "title": "", "confirm": "", "onclick": ""}]);
                                            });
                                        }
                                    });
                                </script>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <?php if ($vid == 3) {
                            $class = "avatar vid3";
                        } else if ($vid == 1) {
                            $class = "avatar vid1";
                        } else if ($vid == 2) {
                            $class = "avatar vid2";
                        } ?>
                        <div class="<?php echo $class; ?>"></div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript">
        var sector = new Travian.Game.Sector('nw');
    </script>
    <?php }

}
?>
<div class="clear">&nbsp;</div>
    </div>
    <div class="clear"></div>
</div>
<div class="contentFooter">&nbsp;</div>
</div>
<div id="sidebarAfterContent" class="sidebar afterContent">
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
                if (NEWSBOX1){
                echo '<div class="news news1"><center style="font-family:arial;direction:rtl;"> ';
                ?>
                <a href="#" class="newsContent newsContentWithLink"
                   onclick="$H({data:{cmd:'News',id:'1'}}).dialog(); return false;">
                    <?php
                    $t1 = trim(file_get_contents("Templates/News/newsbox1.tpl"));
                    echo $t1 . "</a><br>";
                    echo '<a class="newsContentMoreInfoLink" target="_blank" href="' . HOMEPAGE . '">...&#1575;&#1591;&#1604;&#1575;&#1593;&#1575;&#1578; &#1576;&#1610;&#1588;&#1578;&#1585;</a></center></div>
			';?>
            </div>
            <div class="innerBox footer">
            </div>
        </div>
    </div>
    <?php } ?>
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
                if (NEWSBOX2){
                echo '<div class="news news2"><center style="font-family:arial;direction:rtl;">';
                ?>
                <a href="#" class="newsContent newsContentWithLink"
                   onclick="$H({data:{cmd:'News',id:'2'}}).dialog(); return false;">
                    <?php
                    $t2 = trim(file_get_contents("Templates/News/newsbox2.tpl"));
                    echo $t2 . "</a><br>";
                    echo '<a class="newsContentMoreInfoLink" target="_blank" href="' . HOMEPAGE . '">...&#1575;&#1591;&#1604;&#1575;&#1593;&#1575;&#1578; &#1576;&#1610;&#1588;&#1578;&#1585;</a></div>';
                    }
                    ?>
            </div>
            <div class="innerBox footer">

            </div>
        </div>
    </div>

</div>
</div>

<?php
include('Templates/footer.tpl');
echo '</div>';
//include("bugreport.php");
?>
<div id="ce"></div>
</div>
</div>
</div>
</body>
</html>