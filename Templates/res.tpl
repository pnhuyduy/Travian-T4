<ul id="stockBar">
	<li id="stockBarWarehouseWrapper" class="stock" title="<?php echo HDR_WAREHOUSE;?>">
		<img class="warehouse" src="img/x.gif" alt="<?php echo HDR_WAREHOUSE;?>" />
		<span class="value" id="stockBarWarehouse"><?php echo $village->maxstore;?></span>
	</li>
			<li id="stockBarResource1" class="stockBarButton" title="<?php echo HDR_WOOD_PROD.$village->getProd('wood').HDR_CLICKMOREINFO;?>">
			<div class="begin"></div>
			<div class="middle">
				<img class="res r1Big" src="img/x.gif" alt="Lumber"/>
				<?php if($golds['b1']) echo '<img src="img/x.gif" class="productionBoost" alt="Wood Production Plus">';?>
								<span id="l1" class="value" style="font-size:<?php if(round($village->awood) > 9999999){echo '9px';}else{echo '11px;';}?>"><?php echo round($village->awood);?></span>
				<div class="barBox">
				<div id="lbar1" class="bar" style="width:100%;"></div>
				</div>
				<a href="production.php?t=1" title="<?php echo HDR_WOOD_PROD.$village->getProd('wood').HDR_CLICKMOREINFO;?>"><img src="img/x.gif" alt="" /></a>
			</div>
			<div class="end"></div>
		</li>
			<li id="stockBarResource2" class="stockBarButton" title="<?php echo HDR_CLAY_PROD.$village->getProd('clay').HDR_CLICKMOREINFO;?>">
			<div class="begin"></div>
			<div class="middle">
				<img class="res r2Big" src="img/x.gif" alt="Clay"/>
				<?php if($golds['b2']) echo '<img src="img/x.gif" class="productionBoost" alt="Clay Production Plus">';?>
				<span id="l2" class="value" style="font-size:<?php if(round($village->aclay) > 9999999){echo '9px';}else{echo '11px;';}?>"><?php echo round($village->aclay);?></span>
				<div class="barBox">
					<div id="lbar2" class="bar" style="width:100%;"></div>
				</div>
				<a href="production.php?t=2" title="<?php echo HDR_CLAY_PROD.$village->getProd('clay').HDR_CLICKMOREINFO;?>"><img src="img/x.gif" alt="" /></a>
			</div>
			<div class="end"></div>
		</li>
			<li id="stockBarResource3" class="stockBarButton" title="<?php echo HDR_IRON_PROD.$village->getProd('iron').HDR_CLICKMOREINFO;?>">
			<div class="begin"></div>
			<div class="middle">
				<img class="res r3Big" src="img/x.gif" alt="Iron"/>
				<?php if($golds['b3']) echo '<img src="img/x.gif" class="productionBoost" alt="Iron Production Plus">';?>
					<span id="l3" class="value" style="font-size:<?php if(round($village->airon) > 9999999){echo '9px';}else{echo '11px;';}?>"><?php echo round($village->airon);?></span>
				<div class="barBox">
					<div id="lbar3" class="bar" style="width:100%;"></div>
				</div>
				<a href="production.php?t=3" title="<?php echo HDR_IRON_PROD.$village->getProd('clay').HDR_CLICKMOREINFO;?>"><img src="img/x.gif" alt="" /></a>
			</div>
			<div class="end"></div>
		</li>
	
	<li id="stockBarGranaryWrapper" class="stock" title="<?php echo HDR_GRANARY;?>">
		<img class="granary" src="img/x.gif" alt="<?php echo HDR_GRANARY;?>" />
		<span class="value" id="stockBarGranary"><?php echo $village->maxcrop;?></span>
	</li>
	
	<li id="stockBarResource4" class="stockBarButton">
		<div class="begin"></div>
		<div class="middle">
			<img class="res r4Big" src="img/x.gif" alt="Crop"/>
			<?php if($golds['b4']) echo '<img src="img/x.gif" class="productionBoost" alt="Crop Production Plus">';?>
				<span id="l4" class="value" style="font-size:<?php if(round($village->acrop) > 9999999){echo '9px';}else{echo '11px;';}?>"><?php echo round($village->acrop);?></span>
			<div class="barBox">
				<div id="lbar4" class="bar" style="width:100%;"></div>
			</div>
			<a href="production.php?t=4" title="<?php echo HDR_CROP_PROD.$village->getProd('crop').HDR_CLICKMOREINFO;?>"><img src="img/x.gif" alt="" /></a>
		</div>
		<div class="end"></div>
	</li>

		<li id="stockBarFreeCropWrapper" class="stockBarButton r5">
		<div class="begin"></div>
		<div class="middle">
			<img class="res r5Big" src="img/x.gif" alt="Free crop"/>
			<span id="stockBarFreeCrop" class="value" style="font-size:<?php if(round($village->allcrop) > 999999){echo '8.5px';}else{echo '11px;';}?>"><?php echo $village->allcrop;?></span>
			<a href="production.php?t=5" title="<?php echo HDR_CROP_PROD2.$village->allcrop;?><Br /><?php echo HDR_CLICKMOREINFO;?>"><img src="img/x.gif" alt="" /></a>
		</div>
		<div class="end"></div>
	</li>
	<li class="clear">&nbsp;</li>
</ul>
<script type="text/javascript">
	var resources = new Object();

	resources.production = {
		"l1": <?php echo $village->getProd('wood'); ?>,"l2": <?php echo $village->getProd('clay'); ?>,"l3": <?php echo $village->getProd('iron'); ?>,"l4": <?php echo $village->getProd('crop'); ?>,"l5": 0	};
	resources.storage = {
		"l1": <?php echo round($village->awood);?>,"l2": <?php echo round($village->aclay);?>,"l3": <?php echo round($village->airon);?>,"l4": <?php echo round($village->acrop);?>	};
	resources.maxStorage = {
		"l1": <?php echo $village->maxstore;?>,"l2": <?php echo $village->maxstore;?>,"l3": <?php echo $village->maxstore;?>,"l4": <?php echo $village->maxcrop;?>	};

	$$('li.stockBarButton').each(function(element)
	{
		Travian.addMouseEvents(element, element);
	});

	var stockBarWarehouse   = $('stockBarWarehouse');
	var stockBarGranary     = $('stockBarGranary');
	var stockBarFreeCrop = $('stockBarFreeCrop');
	var numberFormatter = new Travian.Formatter({forceDecimal:false});

	stockBarWarehouse.set('html', numberFormatter.getFormattedNumber(parseInt(stockBarWarehouse.get('html'))));
	stockBarGranary.set('html', numberFormatter.getFormattedNumber(parseInt(stockBarGranary.get('html'))));
	stockBarFreeCrop.set('html', numberFormatter.getFormattedNumber(parseInt(stockBarFreeCrop.get('html'))));

</script>