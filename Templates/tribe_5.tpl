<?php
    $start = 41;
    $t32 = explode('[|]', $dataarray[32]);
    if (defined($t32[0])) $t32[0] = constant($t32[0]);
    for ($i = 1; $i < count($t32); $i++) $t32[0] .= $t32[$i];
    $dataarray[32] = $t32[0];
?>
<table cellpadding="0" cellspacing="0">
    <thead>
    <tr>
        <td class="role">
            <div class="boxes boxesColor green">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents">
                    <div class="role"><?php echo REPORT_DEFENDER ?></div>
                </div>
            </div>
        </td>
        <td class="troopHeadline" colspan="<?php if ($dataarray[139]) {
            echo '11';
        } else {
            echo '10';
        } ?>">
            <?php
                if ($targettribe == '5') {
                    echo ' <a href="spieler.php?uid=' . $database->getUserField($dataarray[30], "id", 0) . '">';
                    echo $database->getUserField($dataarray[30], "username", 0);
					$coor = $database->getCoor($dataarray[31]);
                    echo '</a> ' . REPORT_FROM_VIL . ' <a href="position_details.php?x=' . $coor['x'] . '&amp;y=' . $coor['y'] . '">
					' . $dataarray[32] . '</a>';
                } else {
                    echo AT_REINFORCEMENT;
                }
            ?>
        </td>
    </tr>
    </thead>
    <tbody class="units">
    <tr>
        <th class="coords"></th>
        <?php
            for ($i = $start; $i <= ($start + 9); $i++) {
                if ($i == ($start + 9) && !$dataarray[139]) {
                    $last = ' last';
                } else {
                    $last = '';
                }
                echo "<td class=\"uniticon" . $last . "\"><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
            }
            if ($dataarray[139]) {
                echo "<td class=\"uniticon last\"><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
            }
        ?>
    </tr>
    </tbody>
    <tbody class="units">
    <tr>
        <th><?php echo TROOPS; ?></th>
        <?php
            $type = $database->getNotice2($_GET['id'], 'ntype');
            if (($type == 3) || ($type == 17)) $attackerFailed = TRUE; else $attackerFailed = FALSE;
            for ($i = 129; $i <= 138; $i++) {
                if ($i == 138 && !$dataarray[139]) {
                    $last = ' last';
                } else {
                    $last = '';
                }
                if ($dataarray[$i] == 0) {
                    echo "<td class=\"unit none " . $last . "\">" . ($attackerFailed ? '?' : 0) . "</td>";
                } else {
                    echo "<td class=\"unit" . ($attackerFailed ? ' none ' : '') . $last . "\">" . ($attackerFailed ? '?' : $dataarray[$i]) . "</td>";
                }
            }
            if ($dataarray[139]) {
                echo "<td class=\"unit " . ($attackerFailed ? ' none ' : '') . " last\">" . ($attackerFailed ? '?' : $dataarray[139]) . "</td>";
            }
        ?>
    </tr>
    </tbody>
    <tbody class="units last">
    <tr>
        <th><?php echo REPORT_CASUALTIES; ?></th>
        <?php
            for ($i = 140; $i <= 149; $i++) {
                if ($i == 149 && !$dataarray[139]) {
                    $last2 = ' last';
                } else {
                    $last2 = '';
                }
                if ($dataarray[$i] == 0) {
                    echo "<td class=\"unit none " . $last2 . "\">" . ($attackerFailed ? '?' : 0) . "</td>";
                } else {
                    echo "<td class=\"unit" . ($attackerFailed ? ' none ' : '') . $last2 . "\">" . ($attackerFailed ? '?' : $dataarray[$i]) . "</td>";
                }
            }
            if ($dataarray[139]) {
                if ($dataarray[150] == 0) {
                    echo "<td class=\"unit none last\">" . ($attackerFailed ? '?' : 0) . "</td>";
                } else {
                    echo "<td class=\"unit " . ($attackerFailed ? ' none ' : '') . " last\">" . ($attackerFailed ? '?' : $dataarray[150]) . "</td>";
                }
            }
        ?>
    </tr>
    </tbody>
</table>
