<div id="sidebarBoxHero" class="sidebarBox toggleable <?php if(isset($_COOKIE['travian_toggle'])){
	$class = explode(',',$_COOKIE['travian_toggle']);
	foreach($class as $cs){
		$expl = explode(':',$cs);
		if($expl[0]  == "hero"){
			echo $expl[1];
		}
		$i++;
	}
}else{echo "expanded";}?>">
	<div class="sidebarBoxBaseBox">
		<div class="baseBox baseBoxTop">
			<div class="baseBox baseBoxBottom">
				<div class="baseBox baseBoxCenter"></div>
			</div>
		</div>
	</div>
	<div class="sidebarBoxInnerBox">
		<div class="innerBox header ">
<?php
$hero_levels = $GLOBALS["hero_levels"];
$hero = $database->getHeroData($session->uid);

if($database->getHeroData2($session->uid)){
	if ($database->getHeroInVillid($session->uid,1)){
		$villswref = $database->getHeroInVillid($session->uid,1);
	}
	$vm['v90'] = $database->getMovement(9,$village->wid,0); if(!is_array($vm['v90'])) $vm['v90'] = array();
	if(count($vm['v90']) > 0){
		$statusInfoText = HS_ADVENTURE;
		$image = 100;
	}else{
		$statusInfoText = HS_INHOME;
		$image = 100;
	}
}else{
	$dead = 1;
	$statusInfoText = HS_HERODEAD;
	$image = 101;
}
if(!$statusInfoText){
	if($villswref){
		$statusInfoText = $villswref;
	}else{
		$adventures = $database->getMovement(9,$village->wid,0);
		$image = 9;
		if($adventures){
			$statusInfoText = HS_MOVING;
		}elseif($database->getMovement(4,$village->wid,1)){
			$statusInfoText = HS_RETURN;
		}else{
			$statusInfoText = HS_NOTINVIL;
		}
	}
}

?>
<button id="heroImageButton" onclick="window.location.href='hero_inventory.php';" class="heroImageButton " type="button" title="<?php echo HS_HEROOVER.$statusInfoText;?>">
		<img src='hero_image.php?uid=<?php echo $session->uid; ?>&size=sideinfo&<?php echo $hero['hash']; ?>' class='heroImage'/>
	</button>
	<?php if($hero['points'] > 0){ ?>
	<div class="bigSpeechBubble levelUp" title="<?php echo HS_HEROPOINT;?>">
		<img src="img/x.gif" alt="">
	</div>
	<?php } if($dead == 1){ ?>
	<div class="bigSpeechBubble dead" title="<?php echo HS_HERODEAD;?>">
		<img src="img/x.gif" alt="">
	</div>
	<?php }?>
	<div class="playerName">
	<img src="img/x.gif" class="nation nation<?php echo $session->tribe;?>"><?php echo $session->username;?></div>
	<button type="button" id="button5225ee283b159" class="layoutButton auctionWhite green" onclick="return false;">
		<div class="button-container addHoverClick ">
			<img src="img/x.gif" alt="">
		</div>
		</button>
	<script type="text/javascript">
		window.addEvent('domready', function()
		{
			var button = $('button5225ee283b159');
			if (button)
			{
				var titleFunction = function()
				{
					button.removeEvent('mouseenter', titleFunction);
					Travian.Game.Layout.loadLayoutButtonTitle(button, 'hero', 'auctionWhite');
				};
				button.addEvent('mouseenter', titleFunction);
			}
		});

		if($('button5225ee283b159'))
		{
			$('button5225ee283b159').addEvent('click', function ()
			{
				window.fireEvent('buttonClicked', [this, {"type":"green","onclick":"return false;","loadTitle":true,"boxId":"hero","disabled":false,"speechBubble":"","class":"","id":"button5225ee283b159","redirectUrl":"hero_auction.php","redirectUrlExternal":""}]);
			});
		}
	</script>
	<button type="button" id="button5225ee283b28a" class="layoutButton adventureWhite green " onclick="return false;">
	<div class="button-container addHoverClick ">
		<img src="img/x.gif" alt="">
	</div>
		
	<div class="speechBubbleContainer ">
		<div class="speechBubbleBackground">
			<div class="start">
				<div class="end">
					<div class="middle"></div>
				</div>
			</div>
		</div>
		<div class="speechBubbleContent"><?php echo mysql_num_rows(mysql_query('SELECT `id` FROM '.TB_PREFIX.'adventure WHERE end = 0 and uid = '.$session->uid.''));?></div>
	</div>
	<div class="clear"></div>	</button>

	<script type="text/javascript">
		window.addEvent('domready', function()
		{
			var button = $('button5225ee283b28a');
			if (button)
			{
				var titleFunction = function()
				{
					button.removeEvent('mouseenter', titleFunction);
					Travian.Game.Layout.loadLayoutButtonTitle(button, 'hero', 'adventureWhite');
				};
				button.addEvent('mouseenter', titleFunction);
			}
		});
		if($('button5225ee283b28a'))
		{
			$('button5225ee283b28a').addEvent('click', function ()
			{
				window.fireEvent('buttonClicked', [this, {"type":"green","onclick":"return false;","loadTitle":true,"boxId":"hero","disabled":false,"speechBubble":"5","class":"","id":"button5225ee283b28a","redirectUrl":"hero_adventure.php","redirectUrlExternal":""}]);
			});
		}
	</script>
</div>
<?php 
$tribe = $session->tribe;
//$hero = $database->getHero($session->uid);
switch($hero['health']){
	case $hero['health'] <= 10:$color = '#F00';break;
	case $hero['health'] <= 25:$color = '#F0B300';break;
	case $hero['health'] <= 50:$color = '#FFFF00';break;
	case $hero['health'] <= 90:$color = '#99C01A';break;
	default:$color = '#006900';break;
}
?>
	<div class="innerBox content">
	<div class="heroStatusMessage">
	<img alt="The hero is completely healthy." src="img/x.gif" class="heroStatus<?php echo $image;?>"><?php echo $statusInfoText;?></div>

	<div class="progressBars">
		<div class="heroHealthBarBox alive" title="<?php echo HS_HEROHEALTH.round($hero['health']); ?>%">
			<img src="img/x.gif" class="injury" alt="Health">
			<div class="bar" style="width:<?php echo $hero['health']; ?>%;background-color:<?php echo $color; ?>">&nbsp;</div>
		</div>

		<div class="heroXpBarBox" title="<?php echo HS_HEROEXP.$hero['experience']; ?>%">
			<img src="img/x.gif" class="iExperience" alt="Experience">
			<div class="bar" style="width:<?php 
								if($hero['level']<100){
									echo round(100*($hero['experience'] - $hero_levels[$hero['level']-1]) / ($hero_levels[$hero['level']] - $hero_levels[$hero['level']-1])); 
								} else {
									echo HEROFULLLVL;
								}
							?>%;"></div>
		</div>
	</div>		</div>
	<div class="innerBox footer">
			<button type="button" class="toggle" onclick="">
	<div class="button-container addHoverClick "></div>
	</button>

	<script type="text/javascript">
		window.addEvent('domready', function()
		{
			Travian.Translation.add(
			{
				'hero_collapsed': '<?php echo HS_DMINFO;?>',
				'hero_expanded': '<?php echo HS_HINFO;?>'
			});

			var box = $('sidebarBoxHero');
			box.down('button.toggle').addEvent('click', function(e)
			{
				Travian.Game.Layout.toggleBox(box, 'travian_toggle', 'hero');
			});
		});
	</script>
		</div>
	</div>
</div>