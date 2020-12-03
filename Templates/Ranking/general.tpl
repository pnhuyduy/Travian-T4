<?php
    $tribe1 = mysql_query("SELECT `id` FROM " . TB_PREFIX . "users WHERE tribe = 1 and id>4");
    $tribe2 = mysql_query("SELECT `id` FROM " . TB_PREFIX . "users WHERE tribe = 2 and id>4");
    $tribe3 = mysql_query("SELECT `id` FROM " . TB_PREFIX . "users WHERE tribe = 3 and id>4");
    $tribes = array(mysql_num_rows($tribe1), mysql_num_rows($tribe2), mysql_num_rows($tribe3));
    $users = mysql_num_rows(mysql_query("SELECT SQL_CACHE * FROM " . TB_PREFIX . "users WHERE id>4"));


    $config = mysql_fetch_array($database->query("SELECT * FROM " . TB_PREFIX . "config LIMIT 1"));
    //$np = $database->getNatarsProgress();
    //$np['lastexpandat'] = max(isset($np['lastexpandat'])?$np['lastexpandat']:0, COMMENCE);
    //$np['lastpopupat'] = max(isset($np['lastpopupat'])?$np['lastpopupat']:0, COMMENCE);
    // $np['wwbpreleasedat'] = max(isset($np['wwbpreleasedat'])?$np['wwbpreleasedat']:0, COMMENCE);
    // $np['artefactreleasedat'] = max(isset($np['artefactreleasedat'])?$np['artefactreleasedat']:0, COMMENCE);

    $medalsReleaseTime = ($config['lastgavemedal'] + $config['medalinterval']) - time();

    //if($medalsReleaseTime<0) $medalsReleaseTime = 0;
    //$wwPlansRelaseTime = $np['wwbpreleasedat'] - time();

    $artf_time = COMMENCE + (ROUNDLENGHT * 86400 / 3);
    $wwb_time = COMMENCE + (ROUNDLENGHT * 86400 * 2 / 3);

    if ($artf_time > time()) {
        $ArtefactsReleaseTime = $artf_time - time();
    } else {
        $ArtefactsReleaseTime = 1;
    }
    if ($wwb_time > time()) {
        $wwPlansRelaseTime = $wwb_time - time();
    } else {
        $wwPlansRelaseTime = 1;
    }

?>

<h4 class="round"><?php echo PF_STATS; ?></h4>
<table cellpadding="1" cellspacing="1" id="world_player" class="transparent">
    <tbody>
    <tr>
        <th><?php echo PF_REGISTEREDPLAYERS; ?></th>
        <td><?php echo $users; ?></td>
    </tr>
    <tr>
        <th><?php echo PF_ACTIVEPLAYERS; ?></th>
        <td><?php
                $active = mysql_num_rows(mysql_query("SELECT id FROM " . TB_PREFIX . "users WHERE id>4 AND " . time() . "-timestamp < " . (3600 * 24)));
                echo $active; ?></td>
    </tr>
    <tr>
        <th><?php echo PF_ONLINEPLAYERS; ?></th>
        <td><?php
                $online = mysql_num_rows(mysql_query("SELECT id FROM " . TB_PREFIX . "users WHERE id>4 AND " . time() . "-timestamp < " . (60 * 5)));
                echo $online;
            ?></td>
    </tr>
    </tbody>
</table>
<h4 class="round spacer"><?php echo PF_SERVERSTATS;?></h4>
<table cellpadding="1" cellspacing="1" id="world_tribes" class="world">
    <thead>
    <tr class="hover">
        <td><?php echo PF_INFO;?></td>
        <td><?php echo BL_TIME;?></td>
    </tr>
    </thead>
    <tbody>
    <tr class="hover">
        <td><?php echo PF_DAILYGOLD;?></td>
        <td><?php
                if ($config['freegold_value'] > 0) {
                    echo PF_DAILYGOLD.' <b><span id="timer' . $timer . '">' . $generator->getTimeFormat(($config['freegold_lasttime'] + $config['freegold_time']) - time()) . '</span></b> '.MV_HOUR;
                    $timer++;
                } else {
                    echo '<s>'.PF_DISABLED.'</s>';
                }
            ?></td>
    </tr>
    <tr class="hover">
        <td><?php echo AL_MEDALS;?></td>
        <td><?php
                if ($medalsReleaseTime > 0) {
                    echo PF_WILLRELEASEDIN.' <b><span id="timer' . $timer . '">' . $generator->getTimeFormat($medalsReleaseTime) . '</span></b> '.MV_HOUR;
                    $timer++;
                }
            ?></td>
    </tr>
    <tr class="hover">
        <td><?php echo ART_ARTEFACTS;?></td>
        <td><?php
                if ($ArtefactsReleaseTime > 1) {
                    echo PF_WILLRELEASEDIN.' <b><span id="timer' . $timer . '">' . $generator->getTimeFormat($ArtefactsReleaseTime) . '</span></b> '.MV_HOUR;
                    $timer++;
                } else {
                    if (round(abs(($artf_time - time()) / 86400)) < 1) {
                        $time = round(abs(($artf_time - time()) / 3600)) . ' '.PF_HOURAGO;
                    } else {
                        $time = round(abs(($artf_time - time()) / 86400)) . ' '.PF_HOURAGO;
                    }
                    echo PF_RELEASED ." ". $time;
                }
            ?></td>
    </tr>
    <tr class="hover">
        <td><?php echo ART_WONDERBP;?></td>
        <td><?php
                if ($wwPlansRelaseTime > 1) {
                    echo PF_WILLRELEASEDIN.' <b><span id="timer' . $timer . '">' . $generator->getTimeFormat($wwPlansRelaseTime) . '</span></b> '.MV_HOUR;
                    $timer++;
                } else {
                    if (round(abs(($wwb_time - time()) / 86400)) < 1) {
                        $time = round(abs(($wwb_time - time()) / 3600)) . ' '.PF_HOURAGO;
                    } else {
                        $time = round(abs(($wwb_time - time()) / 86400)) . ' '.PF_HOURAGO;
                    }
                    echo PF_RELEASED ." ". $time;
                }
            ?></td>
    </tr>
    </tbody>
</table>

<h4 class="round spacer"><?php echo TRIBE; ?></h4>
<table cellpadding="1" cellspacing="1" id="world_tribes" class="world">
    <thead>
    <tr class="hover">
        <td><?php echo TRIBE; ?></td>
        <td><?php echo PF_REGISTEREDPLAYERS; ?></td>
        <td><?php echo PF_PERCENT; ?></td>
    </tr>
    </thead>
    <tbody>
    <tr class="hover">
        <td><?php echo TRIBE1; ?></td>
        <td><?php echo $tribes[0]; ?></td>
        <td><?php
                $percents = 100 * ($tribes[0] / $users);
                echo $percents = intval($percents);
                echo "%"; ?></td>
    </tr>
    <tr class="hover">
        <td><?php echo TRIBE2; ?></td>
        <td><?php echo $tribes[1]; ?></td>
        <td><?php
                $percents = 100 * ($tribes[1] / $users);
                echo $percents = intval($percents);
                echo "%"; ?></td>
    </tr>
    <tr class="hover">
        <td><?php echo TRIBE3; ?></td>
        <td><?php echo $tribes[2]; ?></td>
        <td><?php
                $percents = 100 * ($tribes[2] / $users);
                echo $percents = intval($percents);
                echo "%"; ?></td>
    </tr>
    </tbody>
</table>