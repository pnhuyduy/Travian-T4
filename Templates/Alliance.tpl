<?php
$aid = $session->alliance;
$allianceinfo = $database->getAlliance($aid);
for($t=19;$t<=40;$t++){
	if($village->resarray['f'.$t.'t'] == 18){$to = $t;$x = 1;break;}
}
?>

<div id="sidebarBoxAlliance" class="sidebarBox ">
		<div class="sidebarBoxBaseBox">
			<div class="baseBox baseBoxTop">
				<div class="baseBox baseBoxBottom">
					<div class="baseBox baseBoxCenter"></div>
				</div>
			</div>
		</div>
		<div class="sidebarBoxInnerBox">
			<div class="innerBox header ">
				<button type="button" id="button5225ee283d5ac" class="layoutButton embassyWhite green <?php if($x == 0) echo 'disabled';?> " onclick="return false;" title="<?php if($x == 0){ echo AL_AUCTION.'<br />'.AL_CONSTEMBASY;}?>">
		<div class="button-container addHoverClick">
			<img src="img/x.gif" alt="">
		</div>
		</button>

	<script type="text/javascript">
				window.addEvent('domready', function()
				{
					var button = $('button5225ee283d5ac');
					if (button)
					{
						var titleFunction = function()
						{
							button.removeEvent('mouseenter', titleFunction);
							Travian.Game.Layout.loadLayoutButtonTitle(button, 'alliance', 'embassyWhite');
						};
						button.addEvent('mouseenter', titleFunction);
					}
				});
		
		if($('button5225ee283d5ac'))
		{
			$('button5225ee283d5ac').addEvent('click', function ()
			{
				window.fireEvent('buttonClicked', [this, {"type":"green","onclick":"return false;","loadTitle":true,"boxId":"alliance","disabled":true,"speechBubble":"","class":"","id":"button5225ee283d5ac","redirectUrl":"<?php if($x != 0) echo 'build.php?id='.$to;?>","redirectUrlExternal":""}]);
			});
		}
	</script><button type="button" id="button5225ee283d789" class="layoutButton allianceForumWhite green <?php if($aid == 0) echo 'disabled';?> " onclick="return false;" title="<?php echo AL_ALLYFORUM; if($aid == 0){ echo AL_NOALLY;}else{ echo $allianceinfo['tag'];} ?>">
		<div class="button-container addHoverClick">
			<img src="img/x.gif" alt="">
		</div>
		</button>

	<script type="text/javascript">
		
		if($('button5225ee283d789'))
		{
			$('button5225ee283d789').addEvent('click', function ()
			{
				window.fireEvent('buttonClicked', [this, {"type":"green","onclick":"return false;","loadTitle":false,"boxId":"","disabled":true,"speechBubble":"","class":"","id":"button5225ee283d789","redirectUrl":"<?php if($aid > 0) echo 'allianz.php?s=2';?>","redirectUrlExternal":""}]);
			});
		}
	</script><button type="button" id="button5225ee283d8f8" class="layoutButton overviewWhite green <?php if($aid == 0) echo 'disabled';?> " onclick="return false;" title="<?php echo AL_ALLYOVER; if($aid == 0){ echo AL_NOALLY;}else{ echo $allianceinfo['tag'];} ?>">
		<div class="button-container addHoverClick ">
			<img src="img/x.gif" alt="">
		</div>
		</button>

	<script type="text/javascript">
		
		if($('button5225ee283d8f8'))
		{
			$('button5225ee283d8f8').addEvent('click', function ()
			{
				window.fireEvent('buttonClicked', [this, {"type":"green","onclick":"return false;","loadTitle":false,"boxId":"alliance","disabled":true,"speechBubble":"","class":"","id":"button5225ee283d8f8","redirectUrl":"<?php if($aid > 0) echo 'allianz.php';?>","redirectUrlExternal":""}]);
			});
		}
	</script><div class="clear"></div>

	<div class="boxTitle">
	<?php 
	if(isset($aid) && $aid > 0){
		$allianceinfo = $database->getAlliance($aid);
		echo '<a class=signLink href=allianz.php title='.AL_ALLIANCE.' '.$allianceinfo['tag'].'><span class=wrap>'.$allianceinfo['tag'].'</span></a><a href="allianz.php?s=2" class="crest" title='.AL_TOALLYFORUM.'><img src=img/x.gif></a>';
	}else{
		echo AL_NOALLY;
	}
?>	</div>
			</div>
			<div class="innerBox content"></div>
			<div class="innerBox footer"></div>
		</div>
	</div>