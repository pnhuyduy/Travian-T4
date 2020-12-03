<?php
    include('menu.tpl');
?>
<table id="overview" cellpadding="1" cellspacing="1">
    <thead>
    <tr>
        <td> <?php echo VL_VILLAGE; ?> </td>
        <td> <?php echo AT_ATTACKS; ?> </td>
        <td> <?php echo FD_BUILDINGS; ?> </td>
        <td> <?php echo AT_TROOPS; ?> </td>
        <td> <?php echo MK_MERCHANTS; ?> </td>
    </tr>
    </thead>
    <tbody>
    <?php
        $varray = $database->getProfileVillages($session->uid);
        foreach ($varray as $vil) {
            $vid = $vil['wref'];
            $vdata = $database->getVillage($vid);
            $jobs = $database->getJobs($vid);
            $unit = $database->getTraining($vid);
            $totalmerchants = $building->getTypeLevel(17, $vid);
            $availmerchants = $totalmerchants - $database->totalMerchantUsed($vid);
            $incoming_attacks = $database->getMovement(3, $vid, 1);
            $bui = '<span class="none">-</span>';
            $tro = '<span class="none">-</span>';
            $att = '<span class="none">-</span>';

            if (count($incoming_attacks) > 0) {
                $inc_atts = count($incoming_attacks);
                for ($i = 0; $i < count($incoming_attacks); $i++) {
                    if ($incoming_attacks[$i]['attack_type'] == 2) {
                        $inc_atts -= 1;
                    }
                }
                if ($inc_atts > 0) {
                    $att = '<a href="build.php?newdid=' . $vid . '&id=39"><img class="att1" src="img/x.gif" title="' . count($incoming_attacks) . 'x ' . AT_ATTACKS . (count($incoming_attacks) > 1 ? '' : '') . '" alt="' . count($incoming_attacks) . 'x ' . AT_ATTACKS . (count($incoming_attacks) > 1 ? '' : '') . '"></a>';
                }

            }
            foreach ($jobs as $b) {
                $bui = '<a href="build.php?newdid=' . $vid . '&id=' . $b['field'] . '"><img class="bau" src="img/x.gif" title="' . $building->procResType($b['type']) . '" alt="' . $building->procResType($b['type']) . '"></a>';
            }

            foreach ($unit as $c) {
                $tro = '<a href="build.php?newdid=' . $vid . '&gid=19"><img class="unit u' . $c['unit'] . '" src="img/x.gif" title="' . $c['amt'] . 'x ' . $technology->getUnitName($c['unit']) . '" alt="' . $c['amt'] . 'x ' . $technology->getUnitName($c['unit']) . '"></a>';
            }

            if ($vdata['capital'] == 1) {
                $class = 'hl';
            } else {
                $class = 'hover';
            }
            $vname = $vdata['name'];
            if (defined($vname)) $vname = constant($vname);
            echo '
<tr class="' . $class . '">
<td class="vil fc"><a href="dorf1.php?newdid=' . $vid . '">' . $vname . '</a></td>
<td class="att">' . $att . '</td>
<td class="bui">' . $bui . '</td>
<td class="tro">' . $tro . '</td>
<td class="tra lc">' . ($totalmerchants > 0 ? '<a href="build.php?newdid=' . $vid . '&amp;gid=17">' : '') . $availmerchants . '/' . $totalmerchants . '</a></td>
</tr>';

        }
    ?>
    </tbody>
</table>
