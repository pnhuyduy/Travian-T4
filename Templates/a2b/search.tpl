<div class="destination"><div class="boxes boxesColor gray"><div class="boxes-tl"></div><div class="boxes-tr"></div><div class="boxes-tc"></div><div class="boxes-ml"></div><div class="boxes-mr"></div><div class="boxes-mc"></div><div class="boxes-bl"></div><div class="boxes-br"></div><div class="boxes-bc"></div><div class="boxes-contents">
<table cellpadding="0" cellspacing="0" class="transparent compact">
				<tbody>
					<tr>
						<td>
							<span><?php echo VL_VILLAGE;?>:</span>
						</td>
						<td class="compactInput">
                        <input class="text" id="enterVillageName" class="text village" name="dname" value="" maxlength="20" type="text" >
						</td>
					</tr>
				</tbody>
			</table>

			<table cellpadding="0" cellspacing="0" class="transparent compact">
				<tbody>
					<tr>
						<td>
							<span class="or"><?php echo AT_COORDINATIONS;?>:</span>
<?php
	if (isset($_GET['z'])) {
		$coor = $database->getCoor($_GET['z']);
	} elseif (isset($_GET['bid'])) {
		$coor = $database->getCoor($dataarray['31']);
	} elseif (isset($_GET['x']) && isset($_GET['y'])) {
		$coor['x'] = $_GET['x'];
		$coor['y'] = $_GET['y'];
	} else {
		$coor['x'] = '';
		$coor['y'] = '';
	}
?>							
			<div class="coordinatesInput">
				<div class="xCoord">
					<label for="xCoordInput">X:</label>
					<input class="text" name="x" value="<?php echo $coor['x']; ?>" maxlength="4" type="text">
				</div>
				<div class="yCoord">
					<label for="yCoordInput">Y:</label>
					<input class="text" name="y" value="<?php echo $coor['y']; ?>" maxlength="4" type="text">
				</div>
				<div class="clear"></div>
			</div>
									<div class="clear"></div>
						</td>
					</tr>
				</tbody>
			</table>
									<script type="text/javascript">
							window.addEvent('domready', function()
							{
								new Travian.Game.AutoCompleter.VillageName('enterVillageName');
							});
						</script>
								</div>
				</div>	</div>
                
                <div class="option">
		<label>
			<input class="radio" name="c" <?php if (!$checked) {echo 'checked="checked"';}?> value="2" type="radio" <?php echo $disabledr; ?>>
			<?php echo AT_REINFORCEMENT;?></label>
		<br>

		<label>
			<input class="radio" name="c" value="3" type="radio" <?php echo $disabled ?>>
			<?php echo AT_ATTACK_NORMAL;?></label>
		<br>

		<label>
			<input class="radio" name="c" <?php if ($checked) {echo 'checked="checked"';}?> value="4" type="radio">
			<?php echo AT_ATTACK_RAID;?></label>

	</div>
    <div class="clear"></div>
    <button type="submit" value="ok" name="s1" id="btn_ok" class="green ">
		<div class="button-container addHoverClick">
			<div class="button-background">
				<div class="buttonStart">
					<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content"><?php echo AT_CONFIRM;?></div></div></button></form>
    
    <p class="error"><?php echo $form->getError("error"); ?></p>
    <div class="clear">&nbsp;</div>
