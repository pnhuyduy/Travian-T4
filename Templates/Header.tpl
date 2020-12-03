<?php
if ($session->logged_in) {
	$HTTP_REFERER=array_shift(explode('?',$_SERVER['PHP_SELF']));
	$pageref = dirname($HTTP_REFERER);
    $q = "SELECT `ok` FROM " . TB_PREFIX . "users WHERE id = $session->uid LIMIT 1";
    if (mysql_query($q)) {
        $q = mysql_query($q);
        $q = mysql_fetch_assoc($q);
        if ($q['ok'] == 1 && $_SERVER['PHP_SELF'] != $pageref.'/messages.php') header("Location: messages.php");
    }

}
$tt = explode('/',$_SERVER['REQUEST_URI']);
$dorf1 = 0;
foreach($tt as $url){
	if($url == 'dorf1.php'){
		$dorf1 = 1;break;
	}
	$url3 = explode('?id=',$url);
	foreach($url3 as $ul ){
		$ul = (int)$ul;
		if($ul > 0 && $ul < 19){
			$dorf1 = 1;break;
		}
	}
}
?>

<div id="header">
    <a id="logo" href="<?php echo HOMEPAGE; ?>" target="_blank" title="<?php echo SERVER_NAME; ?>"></a>
    <ul id="navigation">
        <li id="n1" class="villageResources">
            <a class="<?php if ($dorf1 == 1) {
                echo 'active';
            } ?>" href="dorf1.php" accesskey="1" title="<?php echo HDR_RES;?>"></a>
        </li>
        <li id="n2" class="villageBuildings">
            <a class="<?php if ($dorf1 == 0) {
                echo 'active';
            } ?> " href="dorf2.php" accesskey="2" title="<?php echo HDR_VILCENTER;?>"></a>
        </li>
        <li id="n3" class="map">
            <a class=" " href="karte.php" accesskey="3" title="<?php echo HDR_MAP;?>"></a>
        </li>
        <li id="n4" class="statistics">
            <a class=" " href="statistiken.php" accesskey="4" title="<?php echo HDR_STATIS;?>"></a>
        </li>
        <?php
        $countmsg = count($database->getMessage($session->uid, 12));
        if ($countmsg >= 1) {
            $unmsg = $countmsg;
        } else {
            $unmsg = $countmsg;
        }
        $countnot = count($database->getNotice5($session->uid));
        if ($countnot >= 1) {
            $unnotice = $countnot;
        } else {
            $unnotice = $countnot;
        }
        ?>
        <li id="n5" class="reports">
            <a href="berichte.php" accesskey="5" title="<?php echo HDR_REPORTS.$unnotice;?>"></a>
            <?php
            if ($message->nunread) {
                echo '<div class="speechBubbleContainer ">
			<div class="speechBubbleBackground">
				<div class="start">
					<div class="end">
						<div class="middle"></div>
					</div>
				</div>
			</div>
			<div class="speechBubbleContent">' . $unnotice . '</div>
		</div>';
            }
            ?>
        </li>
        <li id="n6" class="messages">
            <a href="nachrichten.php" accesskey="6" title="<?php echo HDR_MESSAGES.$unmsg;?>"></a>
            <?php
            if ($message->unread) {
                echo '<div class="speechBubbleContainer ">
			<div class="speechBubbleBackground">
				<div class="start">
					<div class="end">
						<div class="middle"></div>
					</div>
				</div>
			</div>
			<div class="speechBubbleContent">' . $unmsg . '</div>
		</div>';
            }
            ?>

        </li>
        <li id="n7" class="gold">
            <a href="#" title="<?php echo HDR_BUYGOLD;?>" accesskey="7" onclick="window.fireEvent('startPaymentWizard', {}); this.blur(); return false;"
               class=""></a>
        </li>
    </ul>
    <script type="text/javascript">
        window.addEvent('domready', function () {
            Travian.Game.Layout.goldButtonAnimation();
        });
    </script>
    <div id="goldSilver">
        <div class="gold">
            <img src="img/x.gif" alt="<?php echo HDR_GOLD;?>" title="<?php echo HDR_GOLD;?>" class="gold"
                 onclick="window.fireEvent('startPaymentWizard', {data:{activeTab: 'pros'}}); return false;"/>
            <span class="ajaxReplaceableGoldAmount"><?php echo $session->gold; ?></span>
        </div>
        <div class="silver">
            <a href="hero_auction.php"><img src="img/x.gif" alt="<?php echo HDR_SILVER;?>" title="<?php echo HDR_SILVER;?>" class="silver"/></a>
            <span class="ajaxReplaceableSilverAmount"><?php echo $session->silver; ?></span>
        </div>
    </div>
    <ul id="outOfGame" class="LTR">
        <li class="profile">
            <a href="spieler.php?uid=<?php echo $session->uid;?>" title="<?php echo HDR_PROFILE;?>">
                <img src="img/x.gif" alt="<?php echo HDR_PROFILE2;?>"/>
            </a>
        </li>
        <li class="options">
            <a href="options.php" title="<?php echo HDR_OPTION;?>">
                <img src="img/x.gif" alt="<?php echo HDR_OPTION2;?>"/>
            </a>
        </li>
        <li class="forum">
            <a target="_blank" href="#" title="<?php echo HDR_FORUM;?>">
                <img src="img/x.gif" alt="<?php echo HDR_FORUM2;?>"/>
            </a>
        </li>
        <li class="chat">
            <a target="_blank" href="#" title="<?php echo HDR_CHAT;?>">
                <img src="img/x.gif" alt="<?php echo HDR_CHAT2;?>"/>
            </a>
        </li>
        <li class="help">
            <a href="help.php" title="<?php echo HDR_HELP;?>">
                <img src="img/x.gif" alt="<?php echo HDR_HELP2;?>"/>
            </a>
        </li>
        <li class="logout ">
            <a href="logout.php" title="<?php echo HDR_LOGOUT;?>">
                <img src="img/x.gif" alt="<?php echo HDR_LOGOUT2;?>"/>
            </a>
        </li>
        <li class="clear"></li>
    </ul>

    <script type="text/javascript">
        $$('#outOfGame li.logout a').addEvent('click', function () {
            Travian.WindowManager.getWindows().each(function ($dialog) {
                Travian.WindowManager.unregister($dialog);
            });
        });
    </script>
</div>