<div class="contentNavi subNavi ">
<?php
$tab_id = isset($_GET['t']) ? $_GET['t'] : 0;
$tab_id = intval($tab_id);
$favor_tab_id = isset($_COOKIE['marketTab']) ? str_replace("favorKey", "", $_COOKIE['marketTab']) : 0;
$favor_tab_id = intval($favor_tab_id);
$current_favor_tab = isset($_GET['t']) ? $_GET['t'] : $favor_tab_id;
?> 
		<div <?php if($current_favor_tab == 0) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey0 <?= !isset($_COOKIE['marketTab']) ? 'favorActive' : ''?> <?= ($_COOKIE['marketTab'] == 'favorKey0') ? 'favorActive' : '' ?>">
				<a href="build.php?id=<?php echo $id; ?>&t=0" class="tabItem"><?php echo AL_OVERVIEW;?>
				<img src="img/x.gif" class="favorIcon" alt="This tab is set as favourite.">
				</a>
			</div>
		</div>
		<div <?php if($current_favor_tab == 1) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div id="overviewRallyPoint" class="content favor favorKey1 <?= ($_COOKIE['marketTab'] == 'favorKey1') ? 'favorActive' : '' ?>">
				<a href="build.php?id=<?php echo $id; ?>&t=1" class="tabItem"><?php echo MK_BUY;?>
				<img src="img/x.gif" class="favorIcon" alt="This tab is set as favourite.">
				</a>
			</div>
		</div>
		<div <?php if($current_favor_tab == 2) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey2 <?= ($_COOKIE['marketTab'] == 'favorKey2') ? 'favorActive' : '' ?>">
				<a href="build.php?id=<?php echo $id; ?>&t=2" class="tabItem"><?php echo HR_SELL;?>
				<img src="img/x.gif" class="favorIcon" alt="This tab is set as favourite.">
				</a>
			</div>
		</div>
		<div <?php if($current_favor_tab == 3) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey3 <?= ($_COOKIE['marketTab'] == 'favorKey3') ? 'favorActive' : '' ?>">
				<a href="build.php?id=<?php echo $id; ?>&t=3" class="tabItem"><?php echo MK_NPCMERCHANT;?>
				<img src="img/x.gif" class="favorIcon" alt="This tab is set as favourite.">
				</a>
			</div>
		</div>
		<div <?php if($current_favor_tab == 99) { echo "class=\"container if($session->goldclub){echo '';}else{echo 'gold';} active\""; } else { echo "class=\"container if($session->goldclub){echo '';}else{echo 'gold';} normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey99 <?= ($_COOKIE['marketTab'] == 'favorKey99') ? 'favorActive' : '' ?>">
				<a id="button5300d0c550a3c2" href="<?php if($session->goldclub){echo 'build.php?id='.$id.'&t=4';}else{echo '#';}?>" class="tabItem"><?php echo MK_TROUTE;?>
				<img src="img/x.gif" class="favorIcon" alt="This tab is set as favourite.">
				</a>
			</div>
		</div>
		<script type="text/javascript">
			if($('button5300d0c550a3c2'))
			{
				$('button5300d0c550a3c2').addEvent('click', function ()
				{
					window.fireEvent('tabClicked', [this, {"class":"gold normal","title":"<?php echo MK_TRADEROUTEDESC;?>","target":false,"id":"button5300d0c550a3c2","href":"#","onclick":false,"enabled":true,"text":"Farm List","dialog":false,"plusDialog":false,<?php if(!$session->goldclub){ echo '"goldclubDialog":{"featureKey":"raidList","infoIcon":"http:\/\/t4.answers.travian.ir\/index.php?aid=Travian Answers#go2answer"},';} ?>"containerId":"","buttonIdentifier":"button5300d0c550a3c2"}]);
				});
			}
		</script>
		<div class="clear"></div>
    </div>

	<script type="text/javascript">
		window.addEvent('domready', function()
		{
			$$('.subNavi').each(function(element)
			{
				new Travian.Game.Menu(element);
			});
		});
	</script>