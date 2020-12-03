<?php
    $vm['v341'] = $database->getMovement(34, $village->wid, 1);
    if (!is_array($vm['v341'])) $vm['v341'] = array();
    $vm['v31'] = $database->getMovement(3, $village->wid, 1);
    if (!is_array($vm['v31'])) $vm['v31'] = array();
    $vm['v30'] = $database->getMovement(3, $village->wid, 0);
    if (!is_array($vm['v30'])) $vm['v30'] = array();
    $vm['v90'] = $database->getMovement(9, $village->wid, 0);
    if (!is_array($vm['v90'])) $vm['v90'] = array();
    $vm['v50'] = $database->getMovement(5, $village->wid, 0);
    if (!is_array($vm['v50'])) $vm['v50'] = array();

    $list['extra'] = 'distance<4.9497474683058326708059105347339';
    $order['by'] = 'distance';
    $coor = $database->getCoor($village->wid);
    $order['x'] = $coor['x'];
    $order['y'] = $coor['y'];
    $order['max'] = 2 * WORLD_MAX + 1;
    $oasats = $database->getVillageOasis($list, 30, $order);
    foreach ($oasats as $os) {
        if ($os['owner'] == $session->uid) {
            $vm['o341'] = $database->getMovement(34, $os['wref'], 1);
            if (!is_array($vm['o341'])) $vm['o341'] = array();
            $vm['o31'] = $database->getMovement(3, $os['wref'], 1);
            if (!is_array($vm['o31'])) $vm['o31'] = array();
            $vm['o30'] = $database->getMovement(3, $os['wref'], 0);
            if (!is_array($vm['o30'])) $vm['o30'] = array();
            $vm['o90'] = $database->getMovement(9, $os['wref'], 0);
            if (!is_array($vm['o90'])) $vm['o90'] = array();
            $vm['o50'] = $database->getMovement(5, $os['wref'], 0);
            if (!is_array($vm['o50'])) $vm['o50'] = array();
        }
    }
    if (!isset($vm['o341']) || !is_array($vm['o341'])) $vm['o341'] = array();
    if (!isset($vm['o31']) || !is_array($vm['o31'])) $vm['o31'] = array();
    if (!isset($vm['o30']) || !is_array($vm['o30'])) $vm['o30'] = array();
    if (!isset($vm['o90']) || !is_array($vm['o90'])) $vm['o90'] = array();
    if (!isset($vm['o50']) || !is_array($vm['o50'])) $vm['o50'] = array();

    $waves1 = array_merge($vm['v31'], $vm['o31']); //$database->getMovement(3,$village->wid,1);
    $waveCount1 = count($waves1);
    for ($i = 0; $i < $waveCount1; $i++) {
        if ($i >= 0 && $waves1[$i]['attack_type'] <= 2) {
            $waveCount1 -= 1;
            array_splice($waves1, $i, 1);
            $i--;
        }
    }
    $waves2 = array_merge($vm['v30'], $vm['o30']); //$database->getMovement(3,$village->wid,0);
    $waveCount2 = count($waves2);
    for ($i = 0; $i < $waveCount2; $i++) {
        if ($i >= 0 && $waves2[$i]['attack_type'] != 2) {
            $waveCount2 -= 1;
            array_splice($waves2, $i, 1);
            $i--;
        }
    }
    $waves3 = array_merge($vm['v341'], $vm['o341']); //$database->getMovement(34,$village->wid,1);
    $waveCount3 = count($waves3);
    for ($i = 0; $i < $waveCount3; $i++) {
        if ($i >= 0 && ($waves3[$i]['attack_type'] != 2 && ($waves3[$i]['vref'] != $village->wid || $waves3[$i]['from'] == $village->wid) && !($waves3[$i]['vref'] == $village->wid && $waves3[$i]['from'] == $village->wid))) {
            $waveCount3 -= 1;
            array_splice($waves3, $i, 1);
            $i--;
        }
    }
    $waves4 = array_merge($vm['v30'], $vm['o30']); //$database->getMovement(3,$village->wid,0);
    $waveCount4 = count($waves4);
    for ($i = 0; $i < $waveCount4; $i++) {
        if ($i >= 0 && ($waves4[$i]['attack_type'] != 3 && $waves4[$i]['attack_type'] != 4 && $waves4[$i]['attack_type'] != 1)) {
            $waveCount4 -= 1;
            array_splice($waves4, $i, 1);
            $i--;
        }
    }
    $waves5 = array_merge($vm['v50'], $vm['o50']); //$database->getMovement2(5,$village->wid,0);
    $waveCount5 = count($waves5);

    $waves6 = array_merge($vm['v90'], $vm['o90']); //$database->getMovement2(9,$village->wid,0);
    $waveCount6 = count($waves6);

    $max = $waveCount1+$waveCount2+$waveCount3+$waveCount4+$waveCount5+$waveCount6;

    if ($max > 0) {
        $class = '';
        $true = 1;
    } else {
        $class = 'hide';
        $true = 0;
    }
    if ($true == 1) {
        ?>
        <div class="movements <?php echo $class ?>">
            <div class="boxes villageList movements">
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
                    <table id="movements" cellpadding="1" cellspacing="1">
                        <thead>
                        <tr>
                            <th colspan="3">
                                <?php echo MV_TROOPMOVEMENT; ?>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                            /* attack/raid on you! */


                            if ($waveCount1 > 0) {
                                $action = 'att1';
                                $aclass = 'a1';
                                $title = MV_ARIATTTROOP;
                                $short = MV_ATTACK;
                                $receive = $waves1[0];
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="'
                                    . $aclass . '">' . $waveCount1 . '&nbsp;' . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer'
                                    . $timer . '">' . $generator->getTimeFormat($receive['endtime'] - time())
                                    . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }
                            /* Units send to reinf. (to another town) */


                            if ($waveCount2 > 0) {
                                $action = 'def2';
                                $aclass = 'd2';
                                $title = MV_OWNREINTROOP;
                                $short = MV_REINF_SHORT;
                                $receive = $waves2[0];
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="' . $aclass . '">' . $waveCount2 . '&nbsp;'
                                    . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer' . $timer . '">'
                                    . $generator->getTimeFormat($receive['endtime'] - time()) . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }

                            /* Units send to reinf. (to my town) */


                            if ($waveCount3 > 0) {
                                $action = 'def1';
                                $aclass = 'd1';
                                $title = MV_OWNREINTROOP;
                                $short = MV_REINF_SHORT;
                                $receive = $waves3[0];
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="' . $aclass . '">' . $waveCount3 . '&nbsp;'
                                    . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer'
                                    . $timer . '">' . $generator->getTimeFormat($receive['endtime'] - time()) . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }

                            /* on attack, raid to another village*/


                            if ($waveCount4 > 0) {
                                $action = 'att2';
                                $aclass = 'a2';
                                $title = MV_OWNATTTROOP;
                                $short = MV_ATTACK;
                                $receive = $waves4[0];
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="' . $aclass . '">' . $waveCount4 . '&nbsp;'
                                    . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer'
                                    . $timer . '">' . $generator->getTimeFormat($receive['endtime'] - time()) . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }

                            if ($waveCount5 > 0) {
                                foreach ($waves5 as $receive) {
                                    $action = 'att3';
                                    $aclass = 'a3';
                                    $title = MV_NEWVILLAGE;
                                    $short = MV_NEWVILLAGE;
                                }
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="' . $aclass . '">' . $waveCount5 . '&nbsp;'
                                    . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer'
                                    . $timer . '">' . $generator->getTimeFormat($receive['endtime'] - time()) . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }

                            if ($waveCount6 > 0) {
                                foreach ($waves6 as $receive) {
                                    $action = 'att3';
                                    $aclass = 'a3';
                                    $title = MV_ADVENTURE;
                                    $short = MV_ADVENTURE;
                                }
                                echo '<tr><td class="typ"><a href="build.php?id=39"><img src="img/x.gif" class="'
                                    . $action . '" alt="' . $title . '" title="' . $title . '" /></a><span class="'
                                    . $aclass . '">&raquo;</span></td><td><div class="mov"><span class="' . $aclass . '">' . $waveCount6 . '&nbsp;'
                                    . $short . '</span></div><div class="dur_r">&nbsp;<span id="timer'
                                    . $timer . '">' . $generator->getTimeFormat($receive['endtime'] - time()) . '</span>&nbsp;' . MV_HOUR . '</div></div></td></tr>';
                                $timer += 1;
                            }
                        ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <?php
    } else {
        echo '<div class="movements"></div>';
    }
?>
