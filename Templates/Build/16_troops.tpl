<?php
    $tribe = $session->tribe;
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
    echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
?>
</tr>
<tr>
    <th><?php echo AT_TROOPS; ?></th>
    <?php
        for ($i = $start; $i <= $end; $i++) {
            if ($village->unitarray['u' . $i] == 0) {
                echo "<td class=\"none\">";
            } else {
                echo "<td>";
            }
            echo $village->unitarray['u' . $i] . "</td>";
        }
        if ($village->unitarray['hero'] == 0) {
            echo "<td class=\"none\">";
        } else {
            echo "<td>";
        }
        echo $village->unitarray['hero'] . "</td>";
    ?>
</tr></tbody>
<tbody class="infos">
<tr>
    <th><?php echo VL_UPKEEP; ?></th>
    <td colspan="11">
        <div class="sup"><?php echo $technology->getUpkeep($village->unitarray, $session->tribe); ?>
            <img class="r4" src="img/x.gif" alt="Crop"/><?php echo PER_HR; ?>
        </div>
    </td>
</tr>