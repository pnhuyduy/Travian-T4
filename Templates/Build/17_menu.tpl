<div class="contentNavi subNavi ">
		<div <?php if(!isset($_GET['t'])) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey0">
				<a href="build.php?id=<?php echo $id; ?>" class="tabItem"><?php echo AL_OVERVIEW;?>
				</a>
			</div>
		</div>
		<div <?php if(isset($_GET['t']) && $_GET['t'] == 1) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div id="overviewRallyPoint" class="content favor favorActive favorKey1">
				<a href="build.php?id=<?php echo $id; ?>&t=1" class="tabItem"><?php echo MK_BUY;?>
				</a>
			</div>
		</div>
		<div <?php if(isset($_GET['t']) && $_GET['t'] == 2) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey2">
				<a href="build.php?id=<?php echo $id; ?>&t=2" class="tabItem"><?php echo HR_SELL;?>
				</a>
			</div>
		</div>
		<div <?php if(isset($_GET['t']) && $_GET['t'] == 3) { echo "class=\"container active\""; } else { echo "class=\"container normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey3">
				<a href="build.php?id=<?php echo $id; ?>&t=3" class="tabItem"><?php echo MK_NPCMERCHANT;?>
				</a>
			</div>
		</div>
		<div <?php if(isset($_GET['t']) && $_GET['t'] == 4) { echo "class=\"container if($session->goldclub){echo '';}else{echo 'gold';} active\""; } else { echo "class=\"container if($session->goldclub){echo '';}else{echo 'gold';} normal\""; } ?>>
			<div class="background-start">&nbsp;</div>
			<div class="background-end">&nbsp;</div>
			<div class="content favor favorKey99">
				<a id="button5300d0c550a3c2" href="<?php if($session->goldclub){echo 'build.php?id='.$id.'&t=4';}else{echo '#';}?>" class="tabItem"><?php echo MK_TROUTE;?>
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