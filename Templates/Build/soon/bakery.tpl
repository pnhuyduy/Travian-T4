<?php
$_GET['bid'] = 9;
$bid = $_GET['bid'];
$uprequire = $building->resourceRequired($id,$bid);
?>
<h2><?php echo B9;?></h2>
<div class="build_desc">
	<a href="#" onclick="return Travian.Game.iPopup(9,4);" class="build_logo">
		<img class="building big white g9" src="img/x.gif" alt="<?php echo B9;?>">
	</a>
	<?php echo B9_DESC;?></div>
<div id="contract" class="contract contractNew contractWrapper">
	<div class="contractText"><?php echo COSTS;?>:</div>
	<div class="contractCosts">
    <div class="showCosts">
    <span class="resources r1 little_res"><img class="r1" src="img/x.gif" alt="<?php echo VL_WOOD;?>"><?php echo $uprequire['wood']; ?></span>
    <span class="resources r2 little_res"><img class="r2" src="img/x.gif" alt="<?php echo VL_CLAY;?>"><?php echo $uprequire['clay']; ?></span>
    <span class="resources r3 little_res"><img class="r3" src="img/x.gif" alt="<?php echo VL_IRON;?>"><?php echo $uprequire['iron']; ?></span>
    <span class="resources r4"><img class="r4" src="img/x.gif" alt="<?php echo VL_CROP;?>"><?php echo $uprequire['crop']; ?></span>
    <span class="resources r5"><img class="r5" src="img/x.gif" alt="<?php echo VL_UPKEEP;?>"><?php echo $uprequire['pop']; ?></span>
    <div class="clear"></div>
    <span class="clocks"><img class="clock" src="img/x.gif" alt="<?php echo AT_DURATION;?>">
    <?php echo $generator->getTimeFormat($uprequire['time']); ?>
	</span>
    <div class="clear"></div>
    </div></div>
	<div class="contractLink">
    <div class="contractText"><?php echo BL_PREREQUISITE;?>:</div>
    <span class="buildingCondition">
    <a href="#" onclick="return Travian.Game.iPopup(4,4, 'gid');"><?php echo B4;?></a> <span><?php echo BL_LVL;?> 10</span></span>, <span class="buildingCondition"><a href="#" onclick="return Travian.Game.iPopup(15,4, 'gid');"><?php echo B15;?></a> <span><?php echo BL_LVL;?> 5</span></span>, <span class="buildingCondition"><a href="#" onclick="return Travian.Game.iPopup(8,4, 'gid');"><?php echo B8;?></a> <span><?php echo BL_LVL;?> 5</span></span>
    </div>
	<div class="clear"></div>
</div>
<div class="clear"></div><hr>
