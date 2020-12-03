<?php
    $start = 1;
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
                    <div class="role"><?php echo REPORT_DEFENDER; ?></div>
                </div>
            </div>
        </td>
        <td class="troopHeadline" colspan="<?php if ($dataarray[47]) {
            echo '11';
        } else {
            echo '10';
        } ?>">
            <?php
                if ($targettribe == '1') {
                    echo ' <a href="spieler.php?uid=' . $database->getUserField($dataarray[30], "id", 0) . '">';
                    echo $database->getUserField($dataarray[30], "username", 0);
					$coor = $database->getCoor($dataarray[31]);
                    echo '</a> ' . REPORT_FROM_VIL . ' <a href="position_details.php?x=' . $coor['x'] . '&amp;y=' . $coor['y'] . '">
					' . stripslashes($dataarray[32]) . '</a>';
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
                if ($i == ($start + 9) && !$dataarray[47]) {
                    $last = ' last';
                } else {
                    $last = '';
                }
                echo "<td class=\"uniticon" . $last . "\"><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
            }
            if ($dataarray[47]) {
                echo "<td class=\"uniticon last\"><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
            }
        ?>
    </tr>
    </tbody>
    <tbody class="units">
    <tr>
        <th><?php echo AT_TROOPS; ?></th>
        <?php
            $type = $database->getNotice2($_GET['id'], 'ntype');
            if (($type == 3) || ($type == 17)) $attackerFailed = TRUE; else $attackerFailed = FALSE;
            for ($i = 37; $i <= 46; $i++) {
                if ($i == 46 && !$dataarray[47]) {
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
            if ($dataarray[47]) {
                echo "<td class=\"unit " . ($attackerFailed ? ' none ' : '') . " last\">" . ($attackerFailed ? '?' : $dataarray[47]) . "</td>";
            }
        ?>
    </tr>
    </tbody>
    <tbody class="units last">
    <tr>
        <th><?php echo REPORT_CASUALTIES; ?></th>
        <?php
            for ($i = 48; $i <= 57; $i++) {
                if ($i == 57 && !$dataarray[47]) {
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
            if ($dataarray[47]) {
                if ($dataarray[58] == 0) {
                    echo "<td class=\"unit none last\">" . ($attackerFailed ? '?' : 0) . "</td>";
                } else {
                    echo "<td class=\"unit " . ($attackerFailed ? ' none ' : '') . " last\">" . ($attackerFailed ? '?' : $dataarray[58]) . "</td>";
                }
            }
        ?>
    </tr>
    </tbody>
</table>
