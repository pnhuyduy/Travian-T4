<?php
    include('menu.tpl');

    $varray = $database->getProfileVillages($session->uid);

    $tribe = $session->tribe;

    switch ($tribe) {
        case 1:
            $t = 1;
            break;
        case 2:
            $t = 11;
            break;
        case 3:
            $t = 21;
            break;
        case 4:
            $t = 41;
            break;
    }

?>
<div class="contentNavi tabNavi">
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=5"><span class="tabItem"><?php echo AT_OWNTROOPS;?></span></a></div>
    </div>
    <div class="container active">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=6"><span class="tabItem"><?php echo AT_TROOPSINVILLAGES;?></span></a></div>
    </div>
    <div class="clear"></div>
</div>
<table cellpadding="1" cellspacing="1" id="troops">
    <thead>
    <tr>

        <th><?php echo VL_VILLAGE;?></th>
        <?php
            foreach ($varray as $vil) {

                $vid = $vil['wref'];

                if ($vil['capital'] == 1) {
                    $class = 'hl';
                } else {
                    $class = 'hover';
                }

                $unit = $database->getUnit($vid);

                for ($i = 1; $i <= 50; $i++) {
                    if ($unit['u' . $i] != 0) {

                        echo '<td><img class="unit u' . $i . '" src="img/x.gif"></td>';
                    }
                }
            }
            echo '<td><img class="unit uhero" src="img/x.gif"></td>';
        ?>
    </tr>
    </thead>
    <tbody>
    <?php

        foreach ($varray as $vil) {

            $vid = $vil['wref'];

            if ($vil['capital'] == 1) {
                $class = 'hl';
            } else {
                $class = 'hover';
            }

            $unit = $database->getUnit($vid);

            echo '<tr class="' . $class . '">
  <th class="vil fc"><a href="dorf1.php?newdid=' . $vid . '">' . $vil['name'] . '</a></th>';

            for ($i = 1; $i <= 50; $i++) {

                if ($unit['u' . $i] != 0) {
                    $uni[$i] += $unit['u' . $i];

                    if ($unit['u' . $i] != 0) {
                        $cl = '';
                    } else {
                        $cl = 'none';
                    }

                    echo '<td class="' . $cl . '">' . $unit['u' . $i] . '</td>';

                }
            }
            echo '<td class="' . $cl . '">' . $unit['u50'] . '</td>';
            echo '</tr>';

        }

    ?>

    <tr>
        <td colspan="12" class="empty"></td>
    </tr>

    <th>Total</th>

    <?php

        foreach ($uni as $u) {

            if ($u != 0) {
                $cl = '';
            } else {
                $cl = 'none';
            }

            echo '<td class="' . $cl . '">' . $u . '</td>';

        }
        if ($unit['u50'] == 0) {
            echo '<td class="none">0</td>';
        } else {
            echo '<td class="">1</td>';
        }

    ?>

    </tr></tbody>
</table>