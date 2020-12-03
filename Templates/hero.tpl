<div id="attributes" class="hero-alive">
<div class="boxes main boxesColor gray">
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
<div class="attribute heroStatus">
<div class="heroStatusMessage ">
<?php
    function get_hero_revive_time($level)
    {
        return ceil(min($level + 1, 24) / floor(SPEED / 3 + 1) * 3600);
    }

    function trickyRounding($value, $lvl)
    {
        if ($lvl < 5) {
            $round_size = 10;
        } else if ($lvl < 10) {
            $round_size = 50;
        } else {
            $round_size = 100;
        }

        return round($value / $round_size) * $round_size;
    }

    function get_hero_revive_cost($lvl, $tribe_id)
    {
        $tribe_costs = array(
            array(130, 115, 180, 75),
            array(180, 130, 115, 75),
            array(115, 180, 130, 75),
        );
        $cost = array();
        for ($r = 0; $r < 4; $r++) {
            $cost[$r] = trickyRounding($tribe_costs[$tribe_id - 1][$r] * (1 + $lvl / 24) * (1 + $lvl), $lvl);
        }

        return $cost;
    }

    $hero_levels = $GLOBALS["hero_levels"];
    $hero = $database->getHeroData($session->uid);
    $checkT = $database->getHeroTrain($hero['wref']);

    if ((empty($checkT) || !$checkT) && (isset($_GET['revive']) == 1 && $hero['dead'] == 1)) {
        $current_res = array($village->awood, $village->aclay, $village->airon, $village->acrop);
        $cost = get_hero_revive_cost($hero['level'], $session->tribe);
        $no = false;
        for ($i = 0; $i < 4; ++$i) {
            if ($current_res[$i] < $cost[$i]) {
                $no = true;
            }
        }
        if (!$no) {
            $database->trainHero($village->wid, get_hero_revive_time($hero['level']), get_hero_revive_time($hero['level']), 0);
            $database->modifyResource($village->wid, $cost[0], $cost[1], $cost[2], $cost[3], 0);
            $database->modifyHero($session->uid, 0, 'wref', $village->wid, 0);
        }
    }

    if (isset($_GET['kill']) && $hero['dead'] == 0) {
        $hero = 0;
        /***************************
        Function to check Hero Not in Village
        Made by: Shadow and brainiacX
         ***************************/
        function HeroNotInVil($id)
        {
            global $database;
            $heronum = 0;
            $outgoingarray = $database->getMovement(3, $id, 0);
            if (!empty($outgoingarray)) {
                foreach ($outgoingarray as $out) {
                    $heronum += $out['t11'];
                }
            }
            $outgoingarray = $database->getMovement(9, $id, 0);
            if (!empty($outgoingarray)) {
                // foreach($outgoingarray as $out) {
                $heronum += 1;
                // }
            }
            $returningarray = $database->getMovement(4, $id, 1);
            if (!empty($returningarray)) {
                foreach ($returningarray as $ret) {
                    if ($ret['attack_type'] != 1) {
                        $heronum += $ret['t11'];
                    }
                }
            }

            return $heronum;
        }

        foreach ($session->villages as $myvill) {
            $q1 = "SELECT SUM(hero) from " . TB_PREFIX . "enforcement where `from` = '" . $myvill . "'"; // check if hero is send as reinforcement
            $result1 = mysql_query($q1, $database->connection) or die(mysql_error());
            $he1 = mysql_fetch_array($result1);
            $hero += $he1[0];
            if ($hero > 0) {
                $reason = HERO_SENDASREINF;
                break;
            }
            $q2 = "SELECT SUM(hero) from " . TB_PREFIX . "units where `vref` = '" . $myvill . "'"; // check if hero is on my account (all villages)
            $result2 = mysql_query($q2, $database->connection) or die(mysql_error());
            $he2 = mysql_fetch_array($result2);
            $hero += $he2[0];
            if ($hero > 0) {
                $reason = HERO_INYOURACCF;
                break;
            }
            $q3 = "SELECT SUM(hero) from " . TB_PREFIX . "trapped where `from` = '" . $myvill . "'"; // check if hero is prisoner
            $result3 = mysql_query($q3, $database->connection) or die(mysql_error());
            $he3 = mysql_fetch_array($result3);
            $hero += $he3[0];
            if ($hero > 0) {
                $reason = HERO_PRISONER;
                break;
            }
            $hero += HeroNotInVil($myvill); // check if hero is not in village (come back from attack , raid , etc.)
            if ($hero > 0) {
                $reason = HERO_NOTINVILL;
                break;
            }
        }
        $yes = true; //fix by ronix
        if ($hero['dead'] == 1 and !$hero) { // check if hero is already dead
            $yes = false;
            if ($yes == false) {
                $reason = HERO_ALREADYDEAD;
            }
        } elseif ($database->getHeroTrain($hero['wref']) and !$hero) { // check if hero is already in revive
            $yes = false;
            if ($yes == false) {
                $reason = HERO_INREVIVE;
            }
        }
        if ($yes and !$hero && $reason == '') {
            $q = "UPDATE " . TB_PREFIX . "hero set `dead` = '1' where uid = '" . $session->uid . "'";
            mysql_query($q, $database->connection) or die(mysql_error());
        }
    }

    $herodetail = $database->getHeroFace($session->uid);
    $tribe = $session->tribe;
    $hero_t = $GLOBALS['hero_t' . $tribe];
    if ($hero['points'] > 0) {
        $pStyle = '';
    } else {
        $pStyle = ' hidden';
    }
    $plevel = $hero['level'] - 1;
    $heroWrefC = $generator->getMapCheck($hero['wref']);
    if ($tribe == 1) {
        $tp = 100;
    } else {
        $tp = 80;
    }
    $rp = 3 * SPEED * $hero['product'];


?>
<div id='attributes'>
<div class='boxes boxesColor gray'>
<div class='boxes-tl'></div>
<div class='boxes-tr'></div>
<div class='boxes-tc'></div>
<div class='boxes-ml'></div>
<div class='boxes-mr'></div>
<div class='boxes-mc'></div>
<div class='boxes-bl'></div>
<div class='boxes-br'></div>
<div class='boxes-bc'></div>
<div class='boxes-contents'>
<div class='attribute'>
    <?Php if ($database->getHeroData2($session->uid)) {
        echo "<img class=\"heroStatus100\" src=\"img/x.gif\" title=\"" . HERO_STATUS . "\" />";
    } else if (!$checkT) {
        echo "<img class=\"heroStatus101\" src=\"img/x.gif\" title=\"" . HERO_ALREADYDEAD . "\" />";
    } else if ($checkT) {
        echo "<img class=\"heroStatus100\" src=\"img/x.gif\" title=\"" . HERO_INREVIVE . "\" />";
    }
        if ($database->getHeroData2($session->uid)) {
            if ($database->getHeroInVillid($session->uid, 1)) {
                $villswref = $database->getHeroInVillid($session->uid, 1);
            }
            if ($database->getHeroInVillid($session->uid, 0)) {
                $villswref2 = $database->getHeroInVillid($session->uid, 0);
                $coor = $database->getCoor($villswref2);
                $x = $coor['y'];
                $y = $coor['x'];
            }
            echo HERO_CURINVILL . ' " <a href = ../position_details.php?x=' . $x . '&y=' . $y . '>' . $villswref . '</a> "';
        } else if (!$checkT) {
            $villswref = $database->getHeroInVillid($session->uid, 1);
            $villswref2 = $database->getHeroInVillid($session->uid, 0);
            if ($database->getHeroInVillid($session->uid, 0)) {
                $villswref2 = $database->getHeroInVillid($session->uid, 0);
                $coor = $database->getCoor($villswref2);
                $x = $coor['y'];
                $y = $coor['x'];
            }
            echo '<font color=red>' . HERO_DEADLASTVILL . ' "<a href = ../karte.php?x=' . $x . '&y=' . $y . '>' . $villswref . '</a>".</font>';
        } else if ($checkT) {
            echo '<font color=orange><b>' . HERO_REVIVEREMTIME . ' : <span id=timer' . $timer . '>' . $generator->getTimeFormat($checkT['eachtime'] - $_SERVER['REQUEST_TIME']) . '</span></b></font>';
        }
    ?>
</div>
<div class="attribute heroStatus">
    <?php
        if ($hero['hide'] == 1) {
            echo HERO_WILLHIDE;
        } else {
            echo HERO_WILLREMAIN;
        } ?>
</div>
<?php if ($hero['dead'] == 0) { ?>
    <div class="attribute health tooltip">
        <div class="element attribName"><?php echo HERO_HEALTH; ?></div>
        <div class="element current powervalue"><span
                class="value">‎‭‭<?php echo round($hero['health']); ?></span>%
        </div>
        <div class="element progress">
            <div class="bar-bg">
                <?php
                    switch ($hero['health']) {
                        case $hero['health'] <= 10:
                            $color = '#F00';
                            break;
                        case $hero['health'] <= 25:
                            $color = '#F0B300';
                            break;
                        case $hero['health'] <= 50:
                            $color = '#FFFF00';
                            break;
                        case $hero['health'] <= 90:
                            $color = '#99C01A';
                            break;
                        default:
                            $color = '#006900';
                            break;
                    }
                ?>
                <div class="bar"
                     style="width:<?php echo $hero['health']; ?>%;background-color:<?php echo $color; ?>"></div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
<?php } else { ?>
    <div class="clear"></div>
    <?php
    $vRes = ($village->awood + $village->aclay + $village->airon + $village->acrop);
    $hRes = ($hero_t[$hero['level']]['wood'] + $hero_t[$hero['level']]['clay'] + $hero_t[$hero['level']]['iron'] + $hero_t[$hero['level']]['crop']);
    $checkT = $database->getHeroTrain($hero['wref']);
    if (!$checkT) {
        if ($village->awood < $hero_t[$hero['level']]['wood'] || $village->aclay < $hero_t[$hero['level']]['clay'] || $village->airon < $hero_t[$hero['level']]['iron'] || $village->acrop < $hero_t[$hero['level']]['crop']) {
            echo '<span class="none">' . HERO_NORESTOREV . '</span>';
        } else {
            echo '<button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="revive" onclick="window.location.href = \'hero_inventory.php?revive=1\'; return false;">
	<div class="button-container addHoverClick">
		<div class="button-background">
			<div class="buttonStart">
				<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">' . HERO_REVIVE . '</div>
	</div>
</button>';
        }
    } else {
        //echo "قهرمان تا <span id='timer$timer'>".$generator->getTimeFormat($checkT['eachtime']-$_SERVER['REQUEST_TIME'])."</span> ساعت زنده ﻣﻰشود.</br>";
    }
    if (!$checkT) {
        ?>
        <div class="regenerateCosts">
            <div class="showCosts">
            	<span class="resources r1 little_res" title="wood">
                	<img class="r1" src="img/x.gif" title="wood"/>
                    <?php echo $hero_t[$hero['level']]['wood']; ?>
                </span>
                <span class="resources r2 little_res" title="clay">
                	<img class="r2" src="img/x.gif" title="clay"/>
                    <?php echo $hero_t[$hero['level']]['clay']; ?>
                </span>
                <span class="resources r3 little_res" title="iron">
                	<img class="r3" src="img/x.gif" title="iron"/>
                    <?php echo $hero_t[$hero['level']]['iron']; ?>
                </span>
                <span class="resources r4 little_res" title="crop">
                	<img class="r4" src="img/x.gif" title="crop"/>
                    <?php echo $hero_t[$hero['level']]['crop']; ?>
                </span>
                <span class="resources r5" title="Crop">
                	<img class="r5" src="img/x.gif" title="Crop"/>
                    6
                </span>

                <div class="clear"></div>
                <?php if (round($village->awood) < $hero_t[$hero['level']]['wood'] || round($village->aclay) < $hero_t[$hero['level']]['clay'] || round($village->airon) < $hero_t[$hero['level']]['iron'] || round($village->acrop) < $hero_t[$hero['level']]['crop']) { ?>
                    <span class="clock">
                	<img class="clock" src="img/x.gif" title="Time">
                        <?php echo $generator->getTimeFormat(round(($hero_t[$hero['level']]['time'] / SPEED * 1.5))); ?>
                </span>
                    <button type="button" value="" class="icon"
                            onclick="window.location.href = 'build.php?gid=17&amp;t=3&amp;r1=<?php echo $hero_t[$hero['level']]['wood']; ?>&amp;r2=<?php echo $hero_t[$hero['level']]['clay']; ?>&amp;r3=<?php echo $hero_t[$hero['level']]['iron']; ?>&amp;r4=<?php echo $hero_t[$hero['level']]['crop']; ?>'; return false;">
                        <img src="img/x.gif" class="npc" alt="npc"></button>
                <?php } ?>
                <div class="clear"></div>
            </div>

            <div class="clear"></div>
        </div>
    <?php
    }
} ?>

<div class="clear"></div>

<div class="attribute experience tooltip">
    <div class="element attribName"><?php echo HERO_EXP; ?></div>
    <div class="element current powervalue experience points"><?php echo $hero['experience']; ?></div>
    <div class="element progress">
        <div class="bar-bg">
            <div class="bar" style="width:<?php
                if ($hero['level'] < 100) {
                    echo round(100 * ($hero['experience'] - $hero_levels[$hero['level'] - 1]) / ($hero_levels[$hero['level']] - $hero_levels[$hero['level'] - 1]));
                } else {
                    echo HEROFULLLVL;
                }
            ?>%;"></div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="clear"></div>
<div class="attribute">
    <div class="speed tooltip"
         title="<?php echo HERO_SPEED; ?>&lt;br /&gt;&lt;span class=&quot;heroAttributeInformation&quot;&gt;<?php echo HERO_SPEED2 . ":" . $hero['speed'] . HERO_HPERH; ?>&lt;/span&gt;">
        <div class="element attribName"><?php echo HERO_SPEED2; ?>:</div>
        <div class="element powervalue">
            <span class="current"><?php echo $hero['speed']; ?></span> <?php echo HERO_HPERH2; ?>
        </div>
    </div>
    <div class="production tooltip"
         title="<?php echo HERO_HEROPRODDESC; ?>&lt;br /&gt;&lt;span class=&quot;heroAttributeInformation&quot;&gt;Hero&acute;s production&lt;img title=&quot;<?php echo HERO_ALLRES; ?>&quot; class=&quot;r0&quot; src=&quot;img/x.gif&quot; /&gt;12 &lrm;&amp;#x202d;&amp;#x202d;0&amp;#x202c;&amp;#x202c;&lrm;6&lt;/span&gt;">
			<span>

                <?php echo HERO_HEROPRODTITLE;
                    if ($hero['r0'] != 0) {
                        ?>
                        <label for="resourceHero0">
                            <img title="all resources" class="r0" src="img/x.gif">
                            <span class="value"> <?php echo $rp; ?></span>
                        </label>
                    <?php } else if ($hero['r1'] != 0) { ?>
                        <label for="resourceHero1">
                            <img title="wood" class="r1" src="img/x.gif">
                            <span class="current"> <?php echo $hero['product'] * 10 * SPEED; ?></span>
                        </label>
                    <?php } else if ($hero['r2'] != 0) { ?>
                        <label for="resourceHero2">
                            <img title="clay" class="r2" src="img/x.gif">
                            <span class="current"> <?php echo $hero['product'] * 10 * SPEED; ?></span>
                        </label>
                    <?php } else if ($hero['r3'] != 0) { ?>
                        <label for="resourceHero3">
                            <img title="iron" class="r3" src="img/x.gif">
                            <span class="current"> <?php echo $hero['product'] * 10 * SPEED; ?></span>
                        </label>
                    <?php } else if ($hero['r4'] != 0) { ?>
                        <label for="resourceHero4">
                            <img title="crop" class="r4" src="img/x.gif">
                            <span class="current"> <?php echo $hero['product'] * 10 * SPEED; ?></span>
                        </label>
                    <?php } ?>

                + <img alt="Crop" class="r4" src="img/x.gif"><span class="current">6</span>
			</span>
    </div>
    <div class="clear"></div>
</div>
<?php echo HERO_REVIVEDESC; ?>
<br><br>
<button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo HERO_KILLHERO; ?>"
        onclick="window.location.href = 'hero_inventory.php?kill=him'; return false;">
    <div class="button-container addHoverClick">
        <div class="button-background">
            <div class="buttonStart">
                <div class="buttonEnd">
                    <div class="buttonMiddle"></div>
                </div>
            </div>
        </div>
        <div class="button-content"><?php echo HERO_KILLHERO; ?></div>
    </div>
</button>
<font color=red><?php echo $reason; ?></font>

<div class="clear"></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="boxes attr boxesColor gray">
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
<div class="openCloseSwitchBar">
    <img alt="Attributes" src="img/x.gif" class="openedClosedSwitch switchOpened">
    <span class="title"><?php echo HERO_ATTR; ?></span>
    <span class="heroAttributesFormMessage notice hide"><?php echo HERO_SAVECHANGE; ?></span>

    <div class="clear"></div>
</div>

<div class="heroPropertiesContent ">
<div class="attribute res" id="setResource">
    <div class="changeResourcesHeadline">
        <?php echo HERO_CHANGERESPROD; ?>
    </div>
    <div class="clear"></div>
    <div class="resource r0">
        <input class="radio" name="resource" value="0" id="resourceHero0" <?php if ($hero['r0'] != 0) {
            echo 'checked="checked"';
        } ?> type="radio">
        <label for="resourceHero0">
            <img alt="all resources" class="r0" src="img/x.gif"><span class="current"><?php echo $rp; ?></span>
        </label>
    </div>
    <div class="resource r1">
        <input class="radio" name="resource" value="1" id="resourceHero1" <?php if ($hero['r1'] != 0) {
            echo 'checked="checked"';
        } ?> type="radio">
        <label for="resourceHero1">
            <img alt="wood" class="r1" src="img/x.gif"><span
                class="current"><?php echo $hero['product'] * 10 * SPEED; ?></span>
        </label>
    </div>
    <div class="resource r2">
        <input class="radio" name="resource" value="2" id="resourceHero2" <?php if ($hero['r2'] != 0) {
            echo 'checked="checked"';
        } ?> type="radio">
        <label for="resourceHero2">
            <img alt="clay" class="r2" src="img/x.gif"><span
                class="current"><?php echo $hero['product'] * 10 * SPEED; ?></span>
        </label>
    </div>
    <div class="resource r3">
        <input class="radio" name="resource" value="3" id="resourceHero3" <?php if ($hero['r3'] != 0) {
            echo 'checked="checked"';
        } ?> type="radio">
        <label for="resourceHero3">
            <img alt="iron" class="r3" src="img/x.gif"><span
                class="current"><?php echo $hero['product'] * 10 * SPEED; ?></span>
        </label>
    </div>
    <div class="resource r4">
        <input class="radio" name="resource" value="4" id="resourceHero4" <?php if ($hero['r4'] != 0) {
            echo 'checked="checked"';
        } ?> type="radio">
        <label for="resourceHero4">
            <img alt="crop" class="r4" src="img/x.gif"><span
                class="current"><?php echo $hero['product'] * 10 * SPEED; ?></span>
        </label>
    </div>
				<span>
			+ <img alt="crop" class="r4" src="img/x.gif"><span class="current">6</span>
		</span>
</div>
<div class="clear"></div>
<div class="attribute attackBehaviour">
    <div class="changeResourcesHeadline">
        <?php echo HERO_HIDEHERO; ?>:
    </div>
    <div class="options">
        <input class="radio" id="attackBehaviourHide" name="attackBehaviour"
               value="hide" <?php if ($hero['hide'] == 1) {
            echo 'checked="checked"';
        } ?> type="radio"><label for="attackBehaviourHide"><?php echo HERO_WILLHIDE; ?></label>
        <br><input class="radio" id="attackBehaviourFight" name="attackBehaviour"
                   value="fight" <?php if ($hero['hide'] == 0) {
            echo 'checked="checked"';
        } ?> type="radio"><label for="attackBehaviourFight"><?php echo HERO_WILLREMAIN; ?></label>
    </div>
</div>
<div class="clear"></div>
<table id="attributesOfHero" class="transparent attributes <?php if ($hero['points'] == 0) echo 'no'; ?>PointsToSet"
       cellpadding="0" cellspacing="0">
    <thead>
    <tr>
        <th class="headline">
            <?php echo HERO_ATTR; ?>
        </th>
        <th class="pointsText" colspan="3">
           <?php echo HERO_AVLPOINTS;?>:
        </th>
        <th class="pointsValue">
            <?php echo $hero['points']; ?>/<span id="availablePoints"><?php echo $hero['points']; ?></span></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <tr id="attributepower" class="attribute power">
        <td class="element attribName tooltip">
            <?php echo HERO_FIGHTSTR;?>
        </td>
        <td class="element current powervalue tooltip">
            <span class="value"><?php echo 100 + $hero['fsperpoint'] * $hero['power'] + $hero['itemfs']; ?></span>
        </td>
        <td class="element progress tooltip">
            <div class="bar-bg">
                <div class="bar" style="width:<?php echo $hero['power']; ?>%;"></div>
                <div class="bar setted" style="width: 0%;"></div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="element pointsValueSetter sub">
            <a class="setPoint" href="#"></a>
        </td>
        <td class="element points"><?php if (!$hero['points']) {
                echo $hero['power'];
            } else {
                echo '<input type="text" class="text" value="' . $hero['power'] . '" name="attributeproductionPoints">';
            } ?></td>
        <td class="element pointsValueSetter add">
            <a class="setPoint" href="#"></a>
        </td>
    </tr>
    <tr id="attributeoffBonus" class="attribute offBonus">
        <td class="element attribName tooltip">
            <?php echo HERO_OFFBONUS;?>
        </td>
        <td class="element current powervalue tooltip">
            <span class="value"><?php echo($hero['offBonus'] / 5); ?></span>%‬‎</span>
        </td>
        <td class="element progress tooltip">
            <div class="bar-bg">
                <div class="bar" style="width:<?php echo $hero['offBonus']; ?>%;"></div>
                <div class="bar setted" style="width: 0%;"></div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="element pointsValueSetter sub">
            <a class="setPoint" href="#"></a>
        </td>
        <td class="element points"><?php if (!$hero['points']) {
                echo $hero['offBonus'];
            } else {
                echo '<input type="text" class="text" value="' . $hero['offBonus'] . '" name="attributeproductionPoints">';
            } ?></td>
        <td class="element pointsValueSetter add">
            <a class="setPoint" href="#"></a>
        </td>
    </tr>
    <tr id="attributedefBonus" class="attribute defBonus">
        <td class="element attribName tooltip">
            <?php echo HERO_DEFBONUS;?>
        </td>
        <td class="element current powervalue tooltip">
            <span class="value">‎‭‭<?php echo($hero['defBonus'] / 5); ?></span>%</span>
        </td>
        <td class="element progress tooltip">
            <div class="bar-bg">
                <div class="bar" style="width:<?php echo $hero['defBonus']; ?>%;"></div>
                <div class="bar setted" style="width: 0%;"></div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="element pointsValueSetter sub">
            <a class="setPoint" href="#"></a>
        </td>
        <td class="element points"><?php if (!$hero['points']) {
                echo $hero['defBonus'];
            } else {
                echo '<input type="text" class="text" value="' . $hero['defBonus'] . '" name="attributeproductionPoints">';
            } ?></td>
        <td class="element pointsValueSetter add">
            <a class="setPoint" href="#"></a>
        </td>
    </tr>
    <tr id="attributeproductionPoints" class="attribute productionPoints">
        <td class="element attribName tooltip">
            <?php echo HERO_RESS;?>
        </td>
        <td class="element current powervalue tooltip">
            <span class="value">‎‭‭<?php echo $hero['product']; ?></span>
        </td>
        <td class="element progress tooltip">
            <div class="bar-bg">
                <div class="bar" style="width:<?php echo $hero['product'] - 4; ?>%;"></div>
                <div class="bar setted" style="width: 0%;"></div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="element pointsValueSetter sub">
            <a class="setPoint" href="#"></a>
        </td>
        <td class="element points"><?php if (!$hero['points']) {
                echo $hero['product'];
            } else {
                echo '<input type="text" class="text" value="' . $hero['product'] . '" name="attributeproductionPoints">';
            } ?></td>
        <td class="element pointsValueSetter add">
            <a class="setPoint" href="#"></a>
        </td>
    </tr>
    </tbody>
</table>

<div class="saveHeroAttributes">
    <button disabled="" type="button" value="<?php echo HERO_SAVECHANGE2;?>" name="saveHeroAttributes" id="saveHeroAttributes"
            class="green disabled">
        <div class="button-container addHoverClick">
            <div class="button-background">
                <div class="buttonStart">
                    <div class="buttonEnd">
                        <div class="buttonMiddle"></div>
                    </div>
                </div>
            </div>
            <div class="button-content"><?php echo HERO_SAVECHANGE2;?></div>
        </div>
    </button>
    <script type="text/javascript">
        window.addEvent('domready', function () {
            if ($('saveHeroAttributes')) {
                $('saveHeroAttributes').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "button", "value": "<?php echo HERO_SAVECHANGE2;?>", "name": "saveHeroAttributes", "id": "saveHeroAttributes", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                });
            }
        });
    </script>
</div>
</div>
<script type="text/javascript">
    window.addEvent('domready', function () {
        $$('.hero_inventory #attributes .openCloseSwitchBar').addEvent('click', function (e) {
            Travian.toggleSwitch($$('.hero_inventory #attributes .heroPropertiesContent'), $$('.hero_inventory #attributes .openCloseSwitchBar .openedClosedSwitch'));
            $$('.hero_inventory #attributes .openCloseSwitchBar .availablePoints').toggleClass('hide');
        });

        var attributeForm = new Travian.Game.Hero.Properties.PropertyForm();
        attributeForm.addInputElementByName('saveHeroAttributes');
        attributeForm.addInputElementByName('resource');
        attributeForm.addInputElementByName('attackBehaviour');
        <?php if($hero['points']){ ?>
        var propertySetterElement = new Travian.Game.Hero.PropertySetter(attributeForm,
            {
                element: 'attributesOfHero',
                elementAvailablePoints: 'availablePoints',
                availablePoints: <?php echo $hero['points']; ?>,
                attributes: [
                    new Travian.Game.Hero.PropertySetter.Attribute.Power(
                        {
                            id: 'power',
                            element: 'attributepower',
                            value: <?php echo $hero['power']; ?>,
                            usedPoints: <?php echo $hero['power']; ?>,
                            maxPoints: 100,
                            valueOfItems: 0,
                            valueBonus: 90
                        }),
                    new Travian.Game.Hero.PropertySetter.Attribute.OffBonus(
                        {
                            id: 'offBonus',
                            element: 'attributeoffBonus',
                            value: <?php echo $hero['offBonus']; ?>,
                            usedPoints: <?php echo $hero['offBonus']; ?>,
                            maxPoints: 100,
                            valueOfItems: 0,
                            valueBonus: 0
                        }),
                    new Travian.Game.Hero.PropertySetter.Attribute.DefBonus(
                        {
                            id: 'defBonus',
                            element: 'attributedefBonus',
                            value: <?php echo $hero['defBonus']; ?>,
                            usedPoints: <?php echo $hero['defBonus']; ?>,
                            maxPoints: 100,
                            valueOfItems: 0,
                            valueBonus: 0
                        }),
                    new Travian.Game.Hero.PropertySetter.Attribute.ProductionPoints(
                        {
                            id: 'productionPoints',
                            element: 'attributeproductionPoints',
                            value: <?php echo $hero['product']*10*SPEED; ?>,
                            usedPoints: <?php echo $hero['product']; ?>,
                            maxPoints: 104,
                            valueOfItems: 0,
                            valueBonus: 0
                        })
                ]
            });
        attributeForm.addElement('properties', propertySetterElement);
        <?php } ?>
        attributeForm.onDirty(false);
    });
</script>
</div>
</div>
</div>