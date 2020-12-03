<div class="boxes villageList units">
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
		<table id="troops" cellpadding="1" cellspacing="1">
			<thead>
				<tr>
					<th colspan="3">
						<?php echo TR_TROOPS; ?>
					</th>
				</tr>
			</thead>
			<tbody>
				<?php
                function add_row_to_units(&$units, $row){
                    for($i = 1; $i <= 50; ++$i){
                        if(!$row['u' . $i]) continue;
                        if(!isset($units[$i])) $units[$i] = 0;
                        $units[$i] += $row['u' . $i];
                    }
                    if($row['hero']){
                        if(!isset($units['hero'])) $units['hero'] = 0;
                        $units['hero'] += $row['hero'];
                    }
                }
                $units = array();
                add_row_to_units($units, $database->getUnit($village->wid));
                $enforcement = $database->getEnforceVillage($village->wid, 0);
                foreach($enforcement as $enforce) add_row_to_units($units, $enforce);
				if(!array_sum($units)) {
					echo "<tr><td>".TR_NOTROOPS."</td></tr>";
				} else {
					if($units['hero']>0){
						echo "<tr><td class=\"ico\"><a href=\"build.php?id=39\"><img class=\"unit uhero\" src=\"img/x.gif\" alt=\""
							.U0."\" title=\"".U0
							."\" /></a></td><td class=\"num\">"
							.$units['hero']."</td><td class=\"un\">".U0."</td></tr>";
    
					}
					foreach($units as $tid => $tnum) {
                        if($tid == 'hero') continue;
                        $tname = $technology->unarray[$tid];
                        echo "<tr><td class=\"ico\"><a href=\"build.php?id=39\"><img class=\"unit u"
                            .$tid."\" src=\"img/x.gif\" alt=\""
                            .$tname."\" title=\"".$tname
                            ."\" /></a></td><td class=\"num\">"
                            .$tnum."</td><td class=\"un\">".$tname."</td></tr>";
					}
				}
				?>
            </tbody>
		</table>
	</div> 
</div>
