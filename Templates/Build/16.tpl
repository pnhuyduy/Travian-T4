<h1 class="titleInHeader"><?php echo B16; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid16">
    <div class="contentNavi subNavi ">
        <div class="container active">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey0">
                <a href="build.php?id=<?php echo $id; ?>" class="tabItem"><?php echo BL_OVERVIEW; ?>

                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div id="overviewRallyPoint" class="content favor favorActive favorKey1">
                <a href="a2b.php" class="tabItem"><?php echo AT_SENDTROOPS; ?>
                     
                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey2">
                <a href="warsim.php" class="tabItem"><?php echo AT_COMBATSIMULATOR; ?>

                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey3">
                <a href="build.php?id=<?php echo $id; ?>&t=99" class="tabItem"><?php echo AT_FARMLIST; ?>

                </a>
            </div>
        </div>
        <div class="container gold normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey99">
                <a id="button5300d0c550a3c" href="<?php if ($session->goldclub) {
                    echo 'build.php?id=' . $id . '&t=100';
                } else {
                    echo '#';
                } ?>" class="tabItem"><?php echo AT_GOLDCLUB; ?>

                </a>
            </div>
        </div>
        <script type="text/javascript">
            if ($('button5300d0c550a3c')) {
                $('button5300d0c550a3c').addEvent('click', function () {
                    window.fireEvent('tabClicked', [this, {
                        "class": "gold normal",
                        "title": "<?php echo AT_FARMLISTDESC;?>",
                        "target": false,
                        "id": "button5300d0c550a3c",
                        "href": "#",
                        "onclick": false,
                        "enabled": true,
                        "text": "Farm List",
                        "dialog": false,
                        "plusDialog": false,
                        <?php if(!$session->goldclub){ echo '"goldclubDialog":{"featureKey":"raidList","infoIcon":"http:\/\/t4.answers.travian.ir\/index.php?aid=Travian Answers#go2answer"},';} ?>"containerId": "",
                        "buttonIdentifier": "button5300d0c550a3c"
                    }]);
                });
            }
        </script>
        <div class="clear"></div>
    </div>

    <script type="text/javascript">
        window.addEvent('domready', function () {
            $$('.subNavi').each(function (element) {
                new Travian.Game.Menu(element);
            });
        });
    </script>
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(16,4);" class="build_logo">
            <img class="g16 big white" src="img/x.gif" alt="<?php echo B16; ?>" title="<?php echo B16; ?>"/>
        </a>
        <?php echo B4_DESC; ?></div>
    <?php
    include("upgrade.tpl");
    ?>
    <div class="contentNavi"></div>
    <div class="round spacer listTitle">
        <div class="listTitleText">
            <?php echo AT_RALLYPOINT; ?>
        </div>
        <div class="clear"></div>
    </div>
    <?php
    if (!$village->resarray['f' . $id] < 1) {
        include("16_incomming.tpl");
        include("16_walking.tpl");
        ?>

        <h4 class="spacer"><?php echo AT_TROOPSATHOME; ?></h4>
        <table class="troop_details" cellpadding="1" cellspacing="1">
            <thead>
            <tr>
                <td class="role"><a
                        href="karte.php?d=<?php echo $village->wid . "&c=" . $generator->getMapCheck($village->wid); ?>"><?php echo $village->vname; ?></a>
                </td>
                <td colspan="11">
                    <a href="spieler.php?uid=<?php echo $session->uid; ?>">Units in village</a></td>
            </tr>
            </thead>
            <tbody class="units">
            <?php include("16_troops.tpl");

            ?>
            </tbody>
        </table>

        <?php

        if (count($village->enforcetome) > 0) {
            foreach ($village->enforcetome as $enforce) {
                $isoasis = $database->isVillageOases($enforce['from']);
                $fromVillage = $database->getMInfo($enforce['from']);

                if ($isoasis || $fromVillage['owner'] == 4) {
                    $fromVillage = $database->getOMInfo($enforce['from']);
                    if ($fromVillage['conqured']) {
                        $fromVillage['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $fromVillage['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $fromVillage['name'] .= '(' . $fromVillage['x'] . "|" . $fromVillage['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $fromVillage['name'] .= '(' . $fromVillage['y'] . "|" . $fromVillage['x'] . ')';
                    }
                    $fromTribe = 4;
                    $start = ($fromTribe - 1) * 10 + 1;
                    $end = ($fromTribe * 10);

                    for ($i = $start; $i <= ($start + 9); $i++) {
                        if ($enforce['u' . $i] != 0) {
                            $enforceheyvun['u' . $i] = $enforce['u' . $i];
                        }
                    }
                    $heyvoon = 1;
                } else {
                    //$fromVillage = $database->getMInfo($enforce['from']);
                    //var_dump($fromVillage);die;
                    if (defined($fromVillage['name'])) $fromVillage['name'] = constant($fromVillage['name']);

                    $fromTribe = $database->getUserField($fromVillage["owner"], "tribe", 0);
                    echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
				        <a href=\"spieler.php?uid=" . $fromVillage['owner'] . "\">Units " . $database->getUserField($fromVillage['owner'], "username", 0) . "</a></td>";
                    if ($enforce['hero'] > 0) {
                        echo "<td colspan=\"11\">";
                    } else {
                        echo "<td colspan=\"10\">";
                    }
                    echo "<a href=\"position_details.php?x=" . $fromVillage['x'] . "&y=" . $fromVillage['y'] . "\">" . $fromVillage['name'] . "</a>";
                    echo "</td></tr></thead><tbody class=\"units\">";
                    $start = ($fromTribe - 1) * 10 + 1;
                    $end = ($fromTribe * 10);
                    echo '<tr><th class="coords"><span class="coordinates coordinatesAligned">';
                    if (DIRECTION == 'ltr') {
                        echo '<span class="coordinateX">(' . $fromVillage['x'] . '</span>'
                            . '<span class="coordinatePipe">|</span>'
                            . '<span class="coordinateY">' . $fromVillage['y'] . ')</span>';
                    } elseif (DIRECTION == 'rtl') {
                        echo '<span class="coordinateY">' . $fromVillage['y'] . ')</span>'
                            . '<span class="coordinatePipe">|</span>'
                            . '<span class="coordinateX">(' . $fromVillage['x'] . '</span>';
                    }
                    echo '</span><span class="clear"></span></th>';
                    for ($i = $start; $i <= ($end); $i++) {
                        echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" /></td>";
                    }
                    if ($enforce['hero'] > 0) {
                        echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" /></td>";
                    }
                    echo "</tr><tr><th>".AT_TROOPS."</th>";
                    for ($i = $start; $i <= ($start + 9); $i++) {
                        if ($enforce['u' . $i] == 0) {
                            echo "<td class=\"none\">";
                        } else {
                            echo "<td>";
                        }
                        echo $enforce['u' . $i] . "</td>";
                    }
                    if ($enforce['hero'] > 0) {
                        if ($enforce['hero'] == 0) {
                            echo "<td class=\"none\">";
                        } else {
                            echo "<td>";
                        }
                        echo $enforce['hero'] . "</td>";
                    }
                    echo "</tr></tbody>
				<tbody class=\"infos\"><tr><th>" . VL_WHEATCONSUMPTION . "</th>";
                    if ($enforce['hero'] > 0) {
                        echo "<td colspan=\"11\">";
                    } else {
                        echo "<td colspan=\"10\">";
                    }
                    echo "<div class='sup'>" . $technology->getUpkeep($enforce, $fromTribe) . "<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />" . BL_PER_HR . " </div><div class='sback'><a href='a2b.php?w=" . $enforce['id'] . "'>" . AT_PULLBACK . "</a></div></td></tr>";

                    echo "</tbody></table>";
                }
            }
            if($heyvoon != 0){
                //if (defined($fromVillage['name'])) $fromVillage['name'] = constant($fromVillage['name']);

                $fromTribe = 4;
                echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
				        <a href=\"spieler.php?uid=" . $fromVillage['owner'] . "\">Units " . $database->getUserField($fromVillage['owner'], "username", 0) . "</a></td>";

                echo "<td colspan=\"10\">";
                //echo "<a href=\"position_details.php?x=" . $fromVillage['x'] . "&y=" . $fromVillage['y'] . "\">" . $fromVillage['name'] . "</a>";
                echo "</td></tr></thead><tbody class=\"units\">";
                $start = ($fromTribe - 1) * 10 + 1;
                $end = ($fromTribe * 10);
                echo '<tr><th class="coords"><span class="coordinates coordinatesAligned">';
                echo '</span><span class="clear"></span></th>';
                for ($i = $start; $i <= ($end); $i++) {
                    echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" /></td>";
                }
                echo "</tr><tr><th>".AT_TROOPS."</th>";
                for ($i = $start; $i <= ($start + 9); $i++) {
                    if ($enforceheyvun['u' . $i] == 0) {
                        echo "<td class=\"none\">";
                    } else {
                        echo "<td>";
                    }
                    echo $enforceheyvun['u' . $i] . "</td>";
                }
                echo "</tr></tbody>
				<tbody class=\"infos\"><tr><th>" . VL_WHEATCONSUMPTION . "</th>";
                echo "<td colspan=\"10\">";
                echo "<div class='sup'>0<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />" . BL_PER_HR . " </div><div class='sback'><a href='a2b.php?anim'>" . AT_TRAPPED_KILL . "</a></div></td></tr>";
                echo "</tbody></table>";
            }
        }

        if (count($village->enforcetoyou) > 0) {
            echo "<h4 class=\"spacer\">" . AT_REINFORCEMENT . "</h4>";
            foreach ($village->enforcetoyou as $enforce) {
                $isoasis = $database->isVillageOases($enforce['from']);
                if ($isoasis) {
                    $fromVillage = $database->getOMInfo($enforce['from']);
                    if ($fromVillage['conqured']) {
                        $fromVillage['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $fromVillage['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $fromVillage['name'] .= '(' . $fromVillage['x'] . "|" . $fromVillage['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $fromVillage['name'] .= '(' . $fromVillage['y'] . "|" . $fromVillage['x'] . ')';
                    }
                } else {
                    $fromVillage = $database->getMInfo($enforce['from']);
                    if (defined($fromVillage['name'])) $fromVillage['name'] = constant($fromVillage['name']);
                }
                $isoasis = $database->isVillageOases($enforce['vref']);
                if ($isoasis) {
                    $vrefVillage = $database->getOMInfo($enforce['vref']);
                    if ($vrefVillage['conqured']) {
                        $vrefVillage['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $vrefVillage['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    if (DIRECTION == 'ltr') {
                        $vrefVillage['name'] .= '(' . $vrefVillage['x'] . "|" . $vrefVillage['y'] . ')';
                    } elseif (DIRECTION == 'rtl') {
                        $vrefVillage['name'] .= '(' . $vrefVillage['y'] . "|" . $vrefVillage['x'] . ')';
                    }
                } else {
                    $vrefVillage = $database->getMInfo($enforce['vref']);
                    if (defined($vrefVillage['name'])) $vrefVillage['name'] = constant($vrefVillage['name']);
                }

                echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
                  <a href=\"karte.php?d=" . $enforce['from'] . "&c=" . $generator->getMapCheck($enforce['from']) . "\">" . $fromVillage['name'] . "</a></td>";
                if ($enforce['hero'] > 0) {
                    echo "<td colspan=\"11\">";
                } else {
                    echo "<td colspan=\"10\">";
                }
                echo "<a href=\"karte.php?d=" . $enforce['vref'] . "&c=" . $generator->getMapCheck($enforce['vref']) . "\">" . AT_REINFORCEMENTTO . ' ' . $vrefVillage["name"] . " </a>";
                echo "</td></tr></thead><tbody class=\"units\">";
                $tribe = $database->getUserField($database->getVillageField($enforce['from'], "owner"), "tribe", 0);
                $start = ($tribe - 1) * 10 + 1;
                $end = ($tribe * 10);
                $coor = $database->getCoor($enforce['vref']);
                echo "<tr>
                  <th class=\"coords\">
					<span class=\"coordinates coordinatesAligned\">
                    <span class=\"coordinateX\">(" . $coor['x'] . "</span>
					<span class=\"coordinatePipe\">|</span>
					<span class=\"coordinateY\">" . $coor['y'] . ")</span>
                    </span>
                    <span class=\"clear\"></span></th>";
                for ($i = $start; $i <= ($end); $i++) {
                    echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
                }
                if ($enforce['hero'] > 0) {
                    echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" /></td>";
                }
                echo "</tr><tr><th>Troops</th>";
                for ($i = $start; $i <= ($start + 9); $i++) {
                    if ($enforce['u' . $i] == 0) {
                        echo "<td class=\"none\">";
                    } else {
                        echo "<td>";
                    }
                    echo $enforce['u' . $i] . "</td>";
                }
                if ($enforce['hero'] > 0) {
                    if ($enforce['hero'] == 0) {
                        echo "<td class=\"none\">";
                    } else {
                        echo "<td>";
                    }
                    echo $enforce['hero'] . "</td>";
                }
                echo "</tr></tbody>
            <tbody class=\"infos\"><tr><th>" . VL_WHEATCONSUMPTION . "</th>";
                if ($enforce['hero'] > 0) {
                    echo "<td colspan=\"11\">";
                } else {
                    echo "<td colspan=\"10\">";
                }
                echo "<div class='sup'>" . $technology->getUpkeep($enforce, $tribe) . "<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />Per hour</div><div class='sback'><a href='a2b.php?r=" . $enforce['id'] . "'>" . AT_PULLBACK . "</a></div></td></tr>";

                echo "</tbody></table>";
            }
        }
    }


    if (count($village->trappedinme) > 0) {
        echo "<h4 class=\"spacer\">" . AT_TRAPPED_INME . "</h4>";
        foreach ($village->trappedinme as $trappedinme) {
            $isoasis = $database->isVillageOases($trappedinme['from']);
            if ($isoasis) {
                $fromVillage = $database->getOMInfo($trappedinme['from']);
                if ($fromVillage['conqured']) {
                    $fromVillage['name'] = VL_OCCUPIEDOASIS;
                } else {
                    $fromVillage['name'] = VL_UNOCCUPIEDOASIS;
                }
                if (DIRECTION == 'ltr') {
                    $fromVillage['name'] .= '(' . $fromVillage['x'] . "|" . $fromVillage['y'] . ')';
                } elseif (DIRECTION == 'rtl') {
                    $fromVillage['name'] .= '(' . $fromVillage['y'] . "|" . $fromVillage['x'] . ')';
                }
            } else {
                $fromVillage = $database->getMInfo($trappedinme['from']);
                if (defined($fromVillage['name'])) $fromVillage['name'] = constant($fromVillage['name']);
            }
            $fromTribe = $database->getUserField($fromVillage["owner"], "tribe", 0);
            echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
			<a href=\"spieler.php?uid=" . $fromVillage['owner'] . "\">Units " . $database->getUserField($fromVillage['owner'], "username", 0) . "</a></td>";
            if ($trappedinme['hero'] > 0) {
                echo "<td colspan=\"11\">";
            } else {
                echo "<td colspan=\"10\">";
            }
            echo "<a href=\"position_details.php?x=" . $fromVillage['x'] . "&y=" . $fromVillage['y'] . "\">" . $fromVillage['name'] . "</a>";
            echo "</td></tr></thead><tbody class=\"units\">";
            $start = ($fromTribe - 1) * 10 + 1;
            $end = ($fromTribe * 10);
            echo '<tr><th class="coords"><span class="coordinates coordinatesAligned">';
            if (DIRECTION == 'ltr') {
                echo '<span class="coordinateX">(' . $fromVillage['x'] . '</span>'
                    . '<span class="coordinatePipe">|</span>'
                    . '<span class="coordinateY">' . $fromVillage['y'] . ')</span>';
            } elseif (DIRECTION == 'rtl') {
                echo '<span class="coordinateY">' . $fromVillage['y'] . ')</span>'
                    . '<span class="coordinatePipe">|</span>'
                    . '<span class="coordinateX">(' . $fromVillage['x'] . '</span>';
            }
            echo '</span><span class="clear"></span></th>';
            for ($i = $start; $i <= ($end); $i++) {
                echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" /></td>";
            }
            if ($trappedinme['hero'] > 0) {
                echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" /></td>";
            }
            echo "</tr><tr><th>" . AT_TROOPS . "</th>";
            for ($i = $start; $i <= ($start + 9); $i++) {
                if ($trappedinme['u' . $i] == 0) {
                    echo "<td class=\"none\">";
                } else {
                    echo "<td>";
                }
                echo $trappedinme['u' . $i] . "</td>";
            }
            if ($trappedinme['hero'] > 0) {
                if ($trappedinme['hero'] == 0) {
                    echo "<td class=\"none\">";
                } else {
                    echo "<td>";
                }
                echo $trappedinme['hero'] . "</td>";
            }
            echo "</tr></tbody>
			<tbody class=\"infos\"><tr><th>" . VL_WHEATCONSUMPTION . "</th>";
            if ($trappedinme['hero'] > 0) {
                echo "<td colspan=\"11\">";
            } else {
                echo "<td colspan=\"10\">";
            }
            echo "<div class='sup'>0<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />per hour </div><div class='sback'><a href='a2b.php?f=" . $trappedinme['id'] . "'>" . AT_TRAPPED_FREE . "</a> " . AT_OR_STR . " <a href='a2b.php?k=" . $trappedinme['id'] . "'>" . AT_TRAPPED_KILL . "</a></div></td></tr>";

            echo "</tbody></table>";
        }
    }


    if (count($village->trappedinyou) > 0) {
        echo "<h4 class=\"spacer\">" . AT_TRAPPED_INYOU . "</h4>";
        foreach ($village->trappedinyou as $trappedinyou) {
            $fromVillage = $database->getMInfo($trappedinyou['from']);
            if (defined($fromVillage['name'])) $fromVillage['name'] = constant($fromVillage['name']);
            $vrefVillage = $database->getMInfo($trappedinyou['vref']);
            if (defined($vrefVillage['name'])) $vrefVillage['name'] = constant($vrefVillage['name']);
            echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
	                  <a href=\"karte.php?d=" . $trappedinyou['from'] . "&c=" . $generator->getMapCheck($trappedinyou['from']) . "\">" . $fromVillage["name"] . "</a></td>";
            if ($trappedinyou['hero'] > 0) {
                echo "<td colspan=\"11\">";
            } else {
                echo "<td colspan=\"10\">";
            }
            echo "<a href=\"karte.php?d=" . $trappedinyou['vref'] . "&c=" . $generator->getMapCheck($trappedinyou['vref']) . "\">" . AT_TRAPPED_IN . ' ' . $vrefVillage["name"] . " </a>";
            echo "</td></tr></thead><tbody class=\"units\">";
            $tribe = $database->getUserField($database->getVillageField($trappedinyou['from'], "owner"), "tribe", 0);
            $start = ($tribe - 1) * 10 + 1;
            $end = ($tribe * 10);
            $coor = $database->getCoor($trappedinyou['vref']);
            echo "<tr><th class=\"coords\"><span class=\"coordinates coordinatesAligned\"><span class=\"coordinateX\">(" . $coor['x'] . "</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateY\">" . $coor['y'] . ")</span></span><span class=\"clear\"></span></th>";
            for ($i = $start; $i <= ($end); $i++) {
                echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
            }
            if ($trappedinyou['hero'] > 0) {
                echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" /></td>";
            }
            echo "</tr><tr><th>" . AT_TROOPS . "</th>";
            for ($i = $start; $i <= ($start + 9); $i++) {
                if ($trappedinyou['u' . $i] == 0) {
                    echo "<td class=\"none\">";
                } else {
                    echo "<td>";
                }
                echo $trappedinyou['u' . $i] . "</td>";
            }
            if ($trappedinyou['hero'] > 0) {
                if ($trappedinyou['hero'] == 0) {
                    echo "<td class=\"none\">";
                } else {
                    echo "<td>";
                }
                echo $trappedinyou['hero'] . "</td>";
            }
            echo "</tr></tbody><tbody class=\"infos\"><tr><th>" . VL_WHEATCONSUMPTION . "</th>";
            if ($trappedinyou['hero'] > 0) {
                echo "<td colspan=\"11\">";
            } else {
                echo "<td colspan=\"10\">";
            }
            echo "<div class='sup'>" . $technology->getUpkeep($trappedinyou, $tribe) . "<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />Per hour</div><div class='sback'><a href='a2b.php?k=" . $trappedinyou['id'] . "'>" . AT_PULLBACK . "</a></div></td></tr>";

            echo "</tbody></table>";
        }
    }

    ?>
    </p></div>