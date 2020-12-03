<?php
    $units = $database->getMovement("34", $village->wid, 1);
    $list['extra'] = '';
    $order['by'] = 'distance';
    $coor = $database->getCoor($village->wid);
    $order['x'] = $coor['x'];
    $order['y'] = $coor['y'];
    $order['max'] = 2 * WORLD_MAX + 1;
    $oasats = $database->getVillageOasis($list, 30, $order);
    foreach ($oasats as $os) {
        if ($os['owner'] == $session->uid) {
            $vm = $database->getMovement(34, $os['wref'], 1);
            if (isset($vm) && is_array($vm)) $units = array_merge($units, $vm);
        }
    }
    $total_for = count($units);
    if (!isset($timer)) $timer = 0;
    if ($total_for > 0) {
        echo "<h4 class=\"spacer\">" . AT_INCOMMINGTROOPS . " (" . $total_for . ")</h4>";
        for ($y = 0; $y < $total_for; $y++) {
            if ($units[$y]['sort_type'] == 3) {

                switch($units[$y]['attack_type']){
                    case 3:
                        $actionType = AT_ATTON;
                        break;
                    case 4:
                        $actionType = AT_RAION;
                        break;
                    case 2:
                        $actionType = AT_REION;
                        break;
                }

                $isoasis = $database->isVillageOases($units[$y]['to']);
                if ($isoasis) {
                    $to = $database->getOMInfo($units[$y]['to']);
                    if ($to['conqured']) {
                        $to['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $to['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $to['name'] .= '(' . $to['x'] . "|" . $to['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $to['name'] .= '(' . $to['y'] . "|" . $to['x'] . ')';
                    }
                } else {
                    $to = $database->getMInfo($units[$y]['to']);
                    if (defined($to['name'])) $to['name'] = constant($to['name']);
                }
                $isoasis = $database->isVillageOases($units[$y]['from']);
                if ($isoasis) {
                    $from = $database->getOMInfo($units[$y]['from']);
                    if ($from['conqured']) {
                        $from['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $from['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $from['name'] .= '(' . $from['x'] . "|" . $from['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $from['name'] .= '(' . $from['y'] . "|" . $from['x'] . ')';
                    }
                } else {
                    $from = $database->getMInfo($units[$y]['from']);
                    if (defined($from['name'])) $from['name'] = constant($from['name']);
                }
                if ($units[$y]['attack_type'] != 1) {
                    echo "<table class=\"troop_details ";
                    if ($units[$y]['attack_type'] != 2) {
                        echo "inRaid";
                    } else {
                        echo "inReturn";
                    }
                    echo "\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
					  <a href=\"position_details.php?x=" . $from['x'] . "&y=" . $from['y'] . "\">" . $from['name'] . "</a></td>
					  <td colspan=\"11\" class=\"troopHeadline\">";
                    echo "<a href=\"position_details.php?x=" . $to['x'] . "&y=" . $to['y'] . "\">";
                    echo $actionType . " " . $to['name'];
                    echo " </a></td></tr></thead><tbody class=\"units\">";
                    $tribe = $database->getUserField($from['owner'], "tribe", 0);
                    $start = ($tribe - 1) * 10 + 1;
                    $end = ($tribe * 10);
                    $coor = $database->getCoor($units[$y]['from']);
                    echo "<tr><th class=\"coords\"><span class=\"coordinates coordinatesAligned\"><span class=\"coordinateX\">(" . $coor['x'] . "</span>
						<span class=\"coordinatePipe\">|</span><span class=\"coordinateY\">" . $coor['y'] . ")</span></span><span class=\"clear\">a</span></th>";
                    for ($i = $start; $i <= $end; $i++) {
                        echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                    }
                    echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
                    echo "</tr><tr><th>".AT_TROOPS."</th>";

                    $spyEffect = $database->getArtEffSpy($village->wid);
                    $showtroops = FALSE;
                    $atcount = 0;
                    for ($t = 1; $t <= 11; $t++) {
                        $atcount += $units[$y]['t' . $t];
                    }
                    if ($village->resarray['f39'] > $atcount) $showtroops = TRUE;
                    for ($t = 1; $t <= 11; $t++) {
                        if ($showtroops || $spyEffect > 0) {
                            if ($units[$y]['t' . $t] == 0) {
                                echo "<td>0</td>";
                            } else {
                                echo "<td>?</td>";
                            }
                        } else {
                            echo "<td class=\"none\">?</td>";
                        }
                    }

                    echo "</tr></tbody>";
                    echo '<tbody class="infos"><tr><th>'.AT_ARRIVAL.'</th><td colspan="11">
				<div class="in small"><span id=timer' . $timer . '>' . $generator->getTimeFormat($units[$y]['endtime'] - time()) . '</span> '.AT_HRS.'</div>';
                    $datetime = $generator->procMtime($units[$y]['endtime']);
                    echo "<div class=\"at small\">";
                    echo " " . $datetime[1] . " hrs</div></div></td></tr></tbody>";
                    echo "</table>";

                }
            } elseif ($units[$y]['sort_type'] == 4) {
                if ($units[$y]['attack_type'] == 1 or $units[$y]['attack_type'] == 2 or $units[$y]['attack_type'] == 3 or $units[$y]['attack_type'] == 4) {
                    $actionType = AT_RETURNFROM;
                }

                $to = $database->getMInfo($units[$y]['vref']);
                $isoasis = $database->isVillageOases($units[$y]['from']);
                if ($isoasis) {
                    $from = $database->getOMInfo($units[$y]['from']);
                    if ($from['conqured']) {
                        $from['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $from['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $from['name'] .= '(' . $from['x'] . "|" . $from['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $from['name'] .= '(' . $from['y'] . "|" . $from['x'] . ')';
                    }
                } else {
                    $from = $database->getMInfo($units[$y]['from']);
                    if (defined($from['name'])) $from['name'] = constant($from['name']);
                }
                ?>
                <table class="troop_details inReturn" cellpadding="1" cellspacing="1">
                    <thead>
                    <tr>
                        <td class="role"><a
                                href="karte.php?d=<?php echo $village->wid . "&c=" . $generator->getMapCheck($village->wid); ?>"><?php echo $village->vname; ?></a>
                        </td>
                        <?php if ($units[$y]['t11'] != 0) {
                            $colspan = '11';
                        } else {
                            $colspan = '10';
                        } ?>
                        <td colspan="<?php echo $colspan; ?>" class="troopHeadline"><a
                                href="karte.php?d=<?php echo $from['wref'] . "&c=" . $generator->getMapCheck($from['wref']); ?>"><?php echo $actionType . " " . $from['name']; ?> </a>
                        </td>
                    </tr>
                    </thead>
                    <tbody class="units">
                    <?php
                        $tribe = $session->tribe;
                        $start = ($tribe - 1) * 10 + 1;
                        $end = ($tribe * 10);
                        $coor = $database->getCoor($units[$y]['vref']);
                        echo "<tr><th class=\"coords\"><span class=\"coordinates coordinatesAligned\">
					<span class=\"coordinateX\">(" . $coor['x'] . "</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateY\">" . $coor['y'] . ")</span>
					</span>	<span class=\"clear\"></span></th>";
                        for ($i = $start; $i <= ($end); $i++) {
                            echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                        }
                        if ($units[$y]['t11'] != 0) {
                            echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
                        }
                    ?>
                    </tr>
                    <tr>
                        <th><?php echo AT_TROOPS;?></th>
                        <?php
                            for ($i = 1; $i <= 10; $i++) {
                                if ($units[$y]['t' . $i] == 0) {
                                    echo "<td class=\"none\">";
                                } else {
                                    echo "<td>";
                                }
                                echo $units[$y]['t' . $i] . "</td>";
                            }
                            if ($units[$y]['t11'] != 0) {
                                if ($units[$y]['t11'] == 0) {
                                    echo "<td class=\"none\">";
                                } else {
                                    echo "<td>";
                                }
                                echo $units[$y]['t11'] . "</td>";
                            }
                        ?>
                    </tr>
                    </tbody>
                    <tbody class="infos">
                    <?php
                        if ($units[$y]['attack_type'] == 3 || $units[$y]['attack_type'] == 4) {
                            $dataarray = explode(",", $units[$y]['data']);
                            for ($dac = 0; $dac <= 4; $dac++) {
                                if (!isset($dataarray[$dac])) {
                                    $dataarray[$dac] = 0;
                                }
                            }?>
                            <tr>
                                <th><?php echo AT_BOUNTY;?></th>
                                <td colspan="<?php echo $colspan; ?>">
                                    <div class="res">
                                        <span class="resource" title="Lumber"><img class="r1" src="img/x.gif"
                                                                                   alt="Lumber"><?php echo $dataarray[0]; ?></span>
                                        <span class="resource" title="Clay"><img class="r2" src="img/x.gif"
                                                                                 alt="Clay"><?php echo $dataarray[1]; ?></span>
                                        <span class="resource" title="Iron"><img class="r3" src="img/x.gif"
                                                                                 alt="Iron"><?php echo $dataarray[2]; ?></span>
                                        <span class="resource" title="Crop"><img class="r4" src="img/x.gif"
                                                                                 alt="Crop"><?php echo $dataarray[3]; ?></span>
                                    </div>
                                    <div class="carry">
                                        <?php
                                            if ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3] == 0) {
                                                echo "<img title=\"";
                                                echo ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3]) . "/" . $dataarray[4];
                                                echo "\" src=\"img/x.gif\" class=\"carry empty\">";
                                            } elseif ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3] != $dataarray[4]) {
                                                echo "<img title=\"";
                                                echo ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3]) . "/" . $dataarray[4];
                                                echo "\" src=\"img/x.gif\" class=\"carry half\">";
                                            } else {
                                                echo "<img title=\"";
                                                echo ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3]) . "/" . $dataarray[4];
                                                echo "\" src=\"img/x.gif\" class=\"carry full\">";
                                            }
                                            echo ($dataarray[0] + $dataarray[1] + $dataarray[2] + $dataarray[3]) . "/" . $dataarray[4];
                                        ?>
                                </td>
                            </tr>
                        <?php
                        }
                    ?>
                    <tr>
                        <th><?php echo AT_ARRIVAL; ?></th>
                        <td colspan="<?php echo $colspan; ?>">
                            <?php
                                echo "<div class=\"in small\"><span id=timer" . $timer . ">" . $generator->getTimeFormat($units[$y]['endtime'] - time()) . "</span>" . AT_HRS . ".</div>";
                                $datetime = $generator->procMtime($units[$y]['endtime']);
                                echo "<div class=\"at small\">";
                                echo " " . $datetime[1] . "</div>";
                            ?>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            <?php
            }
            $timer += 1;
        }
    }
?>