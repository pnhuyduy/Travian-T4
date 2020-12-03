<?php
    $units = $database->getMovement(3, $village->wid, 0);
    $adventures = $database->getMovement(9, $village->wid, 0);
    $settlers = $database->getMovement(5, $village->wid, 0);

    $total_for = count($units);
    $totalmovcount = count($units) + count($adventures) + count($settlers);
    if (!isset($timer)) $timer = 0;
    if ($totalmovcount > 0) {
        echo "<h4 class=\"spacer\">" . AT_TROOPSONTHEIRWAY . " (" . $total_for . ")</h4>";
        if ($total_for > 0) {
            foreach ($units as $tu) {
                switch ($tu['attack_type']) {
                    case 1:
                        $attack_type = AT_ACTIONTYPESCOUT;
                        break;
                    case 2:
                        $attack_type = AT_ACTIONTYPEREINF;
                        break;
                    case 3:
                        $attack_type = AT_ACTIONTYPENATT;
                        break;
                    case 4:
                        $attack_type = AT_ACTIONTYPERAID;
                        break;
                }
                $isoasis = $database->isVillageOases($tu['to']);
                if ($isoasis == 0) {
                    $to = $database->getMInfo($tu['to']);
                    if (defined($to['name'])) $to['name'] = constant($to['name']);
                } else {
                    $to = $database->getOMInfo($tu['to']);
                    if ($to['owner'] == 3) {
                        $to['name'] = VL_UNOCCUPIEDOASIS;
                    } else {
                        $to['name'] = VL_OCCUPIEDOASIS;
                    }
                }
                if ($tu['attack_type'] != 2) {
                    $style = "outRaid";
                }
                ?>
                <table class="troop_details <?php echo $style; ?>" cellpadding="1" cellspacing="1">
                    <thead>
                    <tr>
                        <td class="role">
                            <a href="karte.php?d=<?php echo $village->wid . "&c=" . $generator->getMapCheck($village->wid); ?>">
                                <?php echo $village->vname; ?>
                            </a>
                        </td>
                        <td colspan="11" class="troopHeadline">
                            <a href="karte.php?d=<?php echo $to['wref'] . "&c=" . $generator->getMapCheck($to['wref']); ?>">
                                <?php echo $attack_type . " " . $to['name']; ?>
                            </a>
                            <?php
                                $coor = $database->getCoor($to['wref']);
                                if ($isoasis) {
                                    if (DIRECTION == 'ltr') {
                                        echo " (" . $coor['x'] . "|" . $coor['y'] . ")";
                                    } else {
                                        echo " (" . $coor['y'] . "|" . $coor['x'] . ")";
                                    }
                                }
                            ?>
                        </td>
                    </tr>
                    </thead>
                    <tbody class="units">
                    <?php
                        $tribe = $session->tribe;
                        $start = ($tribe == 1) ? 1 : (($tribe == 2) ? 11 : 21);
                        $start = ($tribe - 1) * 10 + 1;
                        $end = ($tribe * 10);
                        $coor = $database->getCoor($village->wid);
                        echo '<tr><th class="coords"><span class="coordinates coordinatesAligned">';
                        if (DIRECTION == 'ltr') {
                            echo '<span class="coordinateX">(' . $coor['x'] . '</span>'
                                . '<span class="coordinatePipe">|</span>'
                                . '<span class="coordinateY">' . $coor['y'] . ')</span>';
                        } elseif (DIRECTION == 'rtl') {
                            echo '<span class="coordinateY">' . $coor['y'] . ')</span>'
                                . '<span class="coordinatePipe">|</span>'
                                . '<span class="coordinateX">(' . $coor['x'] . '</span>';
                        }
                        echo '</span><span class="clear"></span></th>';
                        for ($i = $start; $i <= ($end); $i++) {
                            echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                        }
                        echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td></tr>";
                        echo "<tr><th>" . AT_TROOPS . "</th>";

                        for ($i = 1; $i <= 11; $i++) {
                            if ($tu['t' . $i] == 0) {
                                echo "<td class=\"none\">";
                            } else {
                                echo "<td>";
                            }
                            echo $tu['t' . $i] . "</td>";
                        }
                    ?>
                    </tr>
                    </tbody>
                    <tbody class="infos">
                    <tr>
                        <th><?php echo AT_ARRIVAL; ?></th>
                        <td colspan="11">
                            <?php
                                echo "<div class=\"in small\"> <span id=timer$timer>" . $generator->getTimeFormat($tu['endtime'] - time()) . "</span>" . AT_HRS . " </div>";
                                $datetime = $generator->procMtime($tu['endtime']);
                                echo "<div class=\"at small\">";
                                echo " " . $datetime[1] . " </div>";
                                if ((time() - $tu['starttime']) <= (max(20, floor(90 / pow(INCREASE_SPEED, 1 / 3))))) {
                                    ?>
                                    <div class="abort"><a
                                            href="build.php?id=39&a=4&aa=<?php echo $tu['moveid']; ?>"><img
                                                src="img/x.gif" class="del" title="<?php echo AT_CANCEL;?>" alt="Annuleren"/></a>
                                    </div>
                                <?php } ?>

                        </td>
                    </tr>
                    </tbody>
                </table>
                <?php
                $timer += 1;
            }
        }
        if ($adventures) {
            $total_for = count($adventures);

            for ($y = 0; $y < $total_for; $y++) {
                $coor = $database->getCoor($adventures[$y]['to']);
                ?>
                <table class="troop_details inAttackOasis" cellpadding="1" cellspacing="1">
                    <thead>
                    <tr>
                        <td class="role"><a
                                href="karte.php?d=<?php echo $village->wid . "&c=" . $generator->getMapCheck($village->wid); ?>"><?php echo $village->vname; ?></a>
                        </td>
                        <td colspan="11" class="troopHeadline"><a
                                href="karte.php?d=<?php echo $adventures[$y]['to'] . "&c=" . $generator->getMapCheck($adventures[$y]['to']); ?>"><?php echo HS_ADVENTURE; ?>
                                (<?php echo(DIRECTION == 'ltr' ? $coor['x'] . "|" . $coor['y'] : $coor['y'] . "|" . $coor['x']); ?>
                                )</a></td>
                    </tr>
                    </thead>
                    <tbody class="units">
                    <?php
                        $tribe = $session->tribe;
                        $start = ($tribe - 1) * 10 + 1;
                        $end = ($tribe * 10);

                        echo "<tr><th class=\"coords\">
						<span class=\"coordinates coordinatesAligned\">";
                        if (DIRECTION == 'ltr') {
                            echo '<span class="coordinateX">(' . $coor['x'] . '</span>'
                                . '<span class="coordinatePipe">|</span>'
                                . '<span class="coordinateY">' . $coor['y'] . ')</span>';
                        } elseif (DIRECTION == 'rtl') {
                            echo '<span class="coordinateY">' . $coor['y'] . ')</span>'
                                . '<span class="coordinatePipe">|</span>'
                                . '<span class="coordinateX">(' . $coor['x'] . '</span>';
                        }
                        echo "</span>
		            <span class=\"clear\"></span></th>";
                        for ($i = $start; $i <= ($end); $i++) {
                            echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                        }
                        echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
                    ?>
                    </tr>
                    <tr>
                        <th><?php echo AT_TROOPS; ?></th>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td>1</td>

                    </tr>
                    </tbody>
                    <tbody class="infos">
                    <tr>
                        <th><?php echo AT_ARRIVAL; ?></th>
                        <td colspan="11">
                            <?php
                                echo "<div class=\"in small\"><span id=timer$timer>" . $generator->getTimeFormat($adventures[$y]['endtime'] - time()) . "</span> ".AT_HRS."</div>";
                                $datetime = $generator->procMtime($adventures[$y]['endtime']);
                                echo "<div class=\"at small\">";
                                echo $datetime[1]." ".AT_HRS."</div>";
                                if ((time() - $adventures[$y]['starttime']) <= (max(20, floor(90 / pow(INCREASE_SPEED, 1 / 3))))) {
                                    ?>
                                    <div class="abort"><a
                                        href="build.php?id=39&a=4&aa=<?php echo $adventures[$y]['moveid']; ?>"><img
                                            src="img/x.gif" class="del" title="<?php echo AT_CANCEL;?>" alt="Annuleren"/></a>
                                    </div><?php } ?>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <?php
                $timer += 1;
            }
        }
        ?>
        <?php
        if ($settlers) {
            $total_for = count($settlers);

            for ($y = 0; $y < $total_for; $y++) {
                $coor = $database->getCoor($settlers[$y]['to']);
                ?>
                <table class="troop_details" cellpadding="1" cellspacing="1">
                    <thead>
                    <tr>
                        <td class="role"><a
                                href="karte.php?d=<?php echo $village->wid . "&c=" . $generator->getMapCheck($village->wid); ?>"><?php echo $village->vname; ?></a>
                        </td>
                        <td colspan="10" class="troopHeadline"><a
                                href="karte.php?d=<?php echo $settlers[$y]['to'] . "&c=" . $generator->getMapCheck($settlers[$y]['to']); ?>"><?php echo AT_NEWVILLAGEFND;?>
                                (<?php echo(DIRECTION == 'ltr' ? $coor['x'] . "|" . $coor['y'] : $coor['y'] . "|" . $coor['x']); ?>
                                )</a></td>
                    </tr>
                    </thead>
                    <tbody class="units">
                    <?php
                        $tribe = $session->tribe;
                        $start = ($tribe - 1) * 10 + 1;
                        $end = ($tribe * 10);

                        echo "<tr><th class=\"coords\">
						<span class=\"coordinates coordinatesAligned\">
		            <span class=\"coordinateX\">(" . $coor['x'] . "</span>
		            <span class=\"coordinatePipe\">|</span>
						<span class=\"coordinateY\">" . $coor['y'] . ")</span>
		            </span>
		            <span class=\"clear\"></span></th>";
                        for ($i = $start; $i <= ($end); $i++) {
                            echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                        }
                    ?>
                    </tr>
                    <tr>
                        <th><?php echo AT_TROOPS; ?></th>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td class="none">0</td>
                        <td>3</td>

                    </tr>
                    </tbody>
                    <tbody class="infos">
                    <tr>
                        <th><?php echo AT_ARRIVAL; ?></th>
                        <td colspan="10">
                            <?php
                                echo "<div class=\"in small\"><span id=timer$timer>" . $generator->getTimeFormat($settlers[$y]['endtime'] - time()) . "</span> ".AT_HRS."</div>";
                                $datetime = $generator->procMtime($settlers[$y]['endtime']);
                                echo "<div class=\"at small\">";
                                echo " " . $datetime[1] . "</div>";
                                if ((time() - $settlers[$y]['starttime']) <= (max(20, floor(90 / pow(INCREASE_SPEED, 1 / 3))))){
                            ?>
                            <div class="abort"><a
                                    href="build.php?id=39&a=4&aa=<?php echo $settlers[$y]['moveid']; ?>"><img
                                        src="img/x.gif" class="del" title="Annuleren" alt="Annuleren"/></a><?php } ?>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <?php
                $timer += 1;
            }
        }
    }
?>