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
    <div class="container active">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo AT_OWNTROOPS; ?></span></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo AT_TROOPSINVILLAGES; ?></span></div>
    </div>
    <div class="clear"></div>
</div>
<table cellpadding="1" cellspacing="1" id="troops">
    <thead>
    <tr>

        <th><?php echo VL_VILLAGE; ?></th>

        <?php
            for ($i = $t; $i <= $t + 9; $i++) {
                echo '<td><img class="unit u' . $i . '" src="img/x.gif"></td>';
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
            $vname = $vil['name'];
            if (defined($vname)) $vname = constant($vname);
            echo '<tr class="' . $class . '"><th class="vil fc"><a href="dorf1.php?newdid=' . $vid . '">' . $vname . '</a></th>';
            for ($i = $t; $i <= $t + 9; $i++) {
                if (!isset($uni[$i])) {
                    $uni[$i] = 0;
                } else {
                    $uni[$i] += $unit['u' . $i];
                }
                if ($unit['u' . $i] != 0) {
                    $cl = '';
                } else {
                    $cl = 'none';
                }
                echo '<td class="' . $cl . '">' . $unit['u' . $i] . '</td>';
                $max[$i] += $unit['u' . $i];
            }
            echo '<td class="' . $cl . '">' . $unit['u50'] . '</td>';
            echo '</tr>';
        }
    ?>
    <tr>
        <td colspan="12" class="empty"></td>
    </tr>
    <th><?php echo BL_TOTAL; ?></th>
    <?php
        for ($i = $t; $i <= $t + 9; $i++) {
            if ($u != 0) {
                $cl = '';
            } else {
                $cl = 'none';
            }
            echo '<td class="' . $cl . '">' . $max[$i] . '</td>';
        }
        // foreach($uni as $u){
        // if($u !=0){
        // $cl = '';
        // $max1 = $max;
        // }else{
        // $cl = 'none';
        // $max1 = 0;
        // }
        // echo '<td class="'.$cl.'">'.$max1.'</td>';
        // }
        if ($unit['u50'] == 0) {
            echo '<td class="none">0</td>';
        } else {
            echo '<td class="">1</td>';
        }
    ?>
    </tr></tbody>
</table>