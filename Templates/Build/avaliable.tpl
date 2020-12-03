<?php
    $artEffGrt = $database->getArtEffGrt($village->wid);

    foreach ($session->villages as $vil) {
        if ($database->getArtEffGrt($vil) > 0) {
            $artEffGrt_warehouse = $database->getArtEffGrt($vil);
            break;
        }
    }
    $mainbuilding = $building->getTypeLevel(15);
    $cranny = $building->getTypeLevel(23);
    $granary = $building->getTypeLevel(11);
    $warehouse = $building->getTypeLevel(10);
    $embassy = $building->getTypeLevel(18);
    $twall = 32;
    if ($session->tribe <= 3) {
        $twall = $session->tribe + 30;
    }
    $wall = $building->getTypeLevel($twall);
    $rallypoint = $building->getTypeLevel(16);
    $hero = $building->getTypeLevel(37);
    $market = $building->getTypeLevel(17);
    $barrack = $building->getTypeLevel(19);
    $cropland = $building->getTypeLevel(4);
    $grainmill = $building->getTypeLevel(8);
    $residence = $building->getTypeLevel(25);
    $academy = $building->getTypeLevel(22);
    $woodcutter = $building->getTypeLevel(1);
    $palace = $building->getTypeLevel(26);
    $hasPalaceAnywhere = $building->hasPalaceAnywhere();
    $claypit = $building->getTypeLevel(2);
    $ironmine = $building->getTypeLevel(3);
    $blacksmith = $building->getTypeLevel(12);
    $stable = $building->getTypeLevel(20);
    $trapper = $building->getTypeLevel(36);
    $treasury = $building->getTypeLevel(27);
    $sawmill = $building->getTypeLevel(5);
    $brickyard = $building->getTypeLevel(6);
    $ironfoundry = $building->getTypeLevel(7);
    $workshop = $building->getTypeLevel(21);
    $stonemasonslodge = $building->getTypeLevel(34);
    $townhall = $building->getTypeLevel(24);
    $tournamentsquare = $building->getTypeLevel(14);
    $bakery = $building->getTypeLevel(9);
    $tradeoffice = $building->getTypeLevel(28);
    $greatbarracks = $building->getTypeLevel(29);
    $greatstable = $building->getTypeLevel(30);
    $brewery = $building->getTypeLevel(35);
    $horsedrinkingtrough = $building->getTypeLevel(41);
    $herosmansion = $building->getTypeLevel(37);
    $greatwarehouse = $building->getTypeLevel(38);
    $greatgranary = $building->getTypeLevel(39);
    $greatworkshop = $building->getTypeLevel(42);
    //$ww = $building->getTypeLevel(40);
    $hasWW = $database->getFieldType($village->wid, 99);

    $res = $database->getJobs($village->wid);
    foreach ($res as $bdata) {
        $UnderConstruction = strtolower(str_replace(array(" ", "'"), "", $building->procResType($bdata['type'])));
        $$UnderConstruction = ($$UnderConstruction == 0 ? -1 : $$UnderConstruction);
    }
?>
<h1 class="titleInHeader"><?php echo BL_AVALABLELIST; ?></h1>
<div id="build" class="gid0">
<?php
    if ($mainbuilding == 0 && !$database->getBuildList(15, $village->wid) && $id != 39 && $id != 40) {
        include("avaliable/mainbuilding.tpl");
    }
    if ((($cranny == 0 && !$database->getBuildList(23, $village->wid)) || $cranny == 10) && $mainbuilding >= 1 && $id != 39 && $id != 40) {
        include("avaliable/cranny.tpl");
    }
    if ((($granary == 0 && !$database->getBuildList(11, $village->wid)) || $granary == 20) && $mainbuilding >= 1 && $id != 39 && $id != 40) {
        include("avaliable/granary.tpl");
    }
    if ($wall == 0 && !$database->getBuildList(32, $village->wid)) {
        if ($session->tribe == 1 && $id != 39) {
            include("avaliable/citywall.tpl");
        }
        if ($session->tribe == 2 && $id != 39) {
            include("avaliable/earthwall.tpl");
        }
        if ($session->tribe == 3 && $id != 39) {
            include("avaliable/palisade.tpl");
        }
        if ($session->tribe == 4 && $id != 39) {
            include("avaliable/earthwall.tpl");
        }
        if ($session->tribe == 5 && $id != 39) {
            include("avaliable/citywall.tpl");
        }
    }
    if ((($warehouse == 0 && !$database->getBuildList(10, $village->wid)) || $warehouse == 20) && $id != 39 && $id != 40) {
        include("avaliable/warehouse.tpl");
    }
    if ($mainbuilding >= 10 && ($artEffGrt_warehouse > 0 || $hasWW == 40) && (($greatwarehouse == 0) || ($greatwarehouse == 20)) && $id != 39 && $id != 40) {
        include("avaliable/greatwarehouse.tpl");
    }
    if ($mainbuilding >= 10 && ($artEffGrt_warehouse > 0 || $hasWW == 40) && (($greatgranary == 0) || ($greatgranary == 20)) && $id != 39 && $id != 40) {
        include("avaliable/greatgranary.tpl");
    }
    if (($trapper == 0 || $trapper == 20) && !$database->getBuildList(36, $village->wid) && $rallypoint >= 1 && $session->tribe == 3 && $id != 39 && $id != 40) {
        include("avaliable/trapper.tpl");
    }
    if ($rallypoint == 0 && !$database->getBuildList(16, $village->wid) && $id != 40) {
        include("avaliable/rallypoint.tpl");
    }
    if ($embassy == 0 && !$database->getBuildList(18, $village->wid) && $id != 39 && $id != 40) {
        include("avaliable/embassy.tpl");
    }
    if ($hero == 0 && !$database->getBuildList(37, $village->wid) && $mainbuilding >= 3 && $rallypoint >= 1 && $id != 39 && $id != 40) {
        include("avaliable/hero.tpl");
    }
    if ($rallypoint >= 1 && !$database->getBuildList(19, $village->wid) && $mainbuilding >= 3 && $barrack == 0 && $id != 39 && $id != 40) {
        include("avaliable/barracks.tpl");
    }
    if ($cropland >= 5 && !$database->getBuildList(8, $village->wid) && $grainmill == 0 && $id != 39 && $id != 40) {
        include("avaliable/grainmill.tpl");
    }
    if ($granary >= 1 && !$database->getBuildList(17, $village->wid) && $warehouse >= 1 && $mainbuilding >= 3 && $market == 0 && $id != 39 && $id != 40) {
        include("avaliable/marketplace.tpl");
    }
    if ($mainbuilding >= 5 && !$database->getBuildList(25, $village->wid) && !$database->getBuildList(26, $village->wid) && $residence == 0 && $id != 39 && $id != 40 && $palace == 0) {
        include("avaliable/residence.tpl");
    }
    if ($academy == 0 && !$database->getBuildList(22, $village->wid) && $mainbuilding >= 3 && $barrack >= 3 && $id != 39 && $id != 40) {
        include("avaliable/academy.tpl");
    }
    if ($hasWW != 40 && $palace == 0 && !$database->getBuildList(26, $village->wid) && !$database->getBuildList(25, $village->wid) && !$hasPalaceAnywhere && $embassy >= 1 && $mainbuilding >= 5 && $id != 39 && $id != 40 && $residence == 0) {
        include("avaliable/palace.tpl");
    }
    if ($blacksmith == 0 && !$database->getBuildList(12, $village->wid) && $academy >= 1 && $mainbuilding >= 3 && $id != 39 && $id != 40) {
        include("avaliable/blacksmith.tpl");
    }
    if ($stonemasonslodge == 0 && !$database->getBuildList(34, $village->wid) && $palace >= 3 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/stonemason.tpl");
    }
    if ($stable == 0 && !$database->getBuildList(20, $village->wid) && $blacksmith >= 3 && $academy >= 5 && $id != 39 && $id != 40) {
        include("avaliable/stable.tpl");
    }
    if ($hasWW != 40 && $treasury == 0 && !$database->getBuildList(27, $village->wid) && $mainbuilding >= 10 && $id != 39 && $id != 40) {
        include("avaliable/treasury.tpl");
    }
    if ($brickyard == 0 && !$database->getBuildList(6, $village->wid) && $claypit >= 10 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/brickyard.tpl");
    }
    if ($sawmill == 0 && !$database->getBuildList(5, $village->wid) && $woodcutter >= 10 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/sawmill.tpl");
    }
    if ($ironfoundry == 0 && !$database->getBuildList(7, $village->wid) && $ironmine >= 10 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/ironfoundry.tpl");
    }
    if ($workshop == 0 && !$database->getBuildList(21, $village->wid) && $academy >= 10 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/workshop.tpl");
    }
    if ($tournamentsquare == 0 && !$database->getBuildList(14, $village->wid) && $rallypoint >= 15 && $id != 39 && $id != 40) {
        include("avaliable/tsquare.tpl");
    }
    if ($bakery == 0 && !$database->getBuildList(9, $village->wid) && $grainmill >= 5 && $cropland >= 10 && $mainbuilding >= 5 && $id != 39 && $id != 40) {
        include("avaliable/bakery.tpl");
    }
    if ($townhall == 0 && !$database->getBuildList(24, $village->wid) && $mainbuilding >= 10 && $academy >= 10 && $id != 39 && $id != 40) {
        include("avaliable/townhall.tpl");
    }
    if ($tradeoffice == 0 && !$database->getBuildList(28, $village->wid) && $market == 20 && $stable >= 10 && $id != 39 && $id != 40) {
        include("avaliable/tradeoffice.tpl");
    }
    if ($session->tribe == 1 && !$database->getBuildList(41, $village->wid) && $horsedrinkingtrough == 0 && $rallypoint >= 10 && $stable == 20 && $id != 39 && $id != 40) {
        include("avaliable/horsedrinking.tpl");
    }
    if ($session->tribe == 2 && !$database->getBuildList(35, $village->wid) && $brewery == 0 && $rallypoint >= 10 && $granary == 20 && $id != 39 && $id != 40) {
        include("avaliable/brewery.tpl");
    }
    if ($greatbarracks == 0 && !$database->getBuildList(29, $village->wid) && $barrack == 20 && $village->capital == 0 && $id != 39 && $id != 40) {
        include("avaliable/greatbarracks.tpl");
    }
    if ($greatstable == 0 && !$database->getBuildList(30, $village->wid) && $stable == 20 && $village->capital == 0 && $id != 39 && $id != 40) {
        include("avaliable/greatstable.tpl");
    }
    if ($greatworkshop == 0 && !$database->getBuildList(42, $village->wid) && $workshop == 20 && $village->capital == 0 && $id != 39 && $id != 40 && GREAT_WKS) {
        include("avaliable/greatworkshop.tpl");
    }
    if ($id != 39 && $id != 40) {
        ?>
        <div class="switch"><a id="soon_link" class="openedClosedSwitch switchClosed"
                               href="javascript:show_build_list('soon');"><?php echo BL_SHOWSOONAVAILABLE; ?></a></div>
        <div id="build_list_soon" class="hide">
            <?php
                if ($trapper == 0 && $rallypoint == 0 && $session->tribe == 3) {
                    include("soon/trapper.tpl");
                }
                if ($hero == 0 && ($mainbuilding <= 2 || $rallypoint == 0)) {
                    include("soon/hero.tpl");
                }
                if ($barrack == 0 && ($rallypoint == 0 || $mainbuilding <= 2)) {
                    include("soon/barracks.tpl");
                }
                if ($cropland >= 3 && $cropland <= 4) {
                    include("soon/grainmill.tpl");
                }
                if ($market == 0 && ($mainbuilding <= 2 || $granary <= 0 || $warehouse <= 0)) {
                    include("soon/marketplace.tpl");
                }
                if ($residence == 0 && $palace == 0 && $mainbuilding <= 4 && $mainbuilding >= 2) {
                    include("soon/residence.tpl");
                }
                if ($academy == 0 && ($mainbuilding <= 2 || $barrack <= 2)) {
                    include("soon/academy.tpl");
                }
                if (($embassy == 0 || $mainbuilding >= 2) && $mainbuilding <= 4 && $residence == 0) {
                    include("soon/palace.tpl");
                }
                if ($blacksmith == 0 && ($academy <= 0 || $mainbuilding <= 2)) {
                    include("soon/blacksmith.tpl");
                }
                if ($stonemasonslodge == 0 && $palace <= 2 && $palace != 0 && $mainbuilding >= 2 && $mainbuilding <= 4 && $residence == 0) {
                    include("soon/stonemason.tpl");
                }
                if ($stable == 0 && (($blacksmith <= 2 && $blacksmith != 0) || ($academy >= 2 && $academy <= 4))) {
                    include("soon/stable.tpl");
                }
                if ($hasWW != 40 && $treasury == 0 && $mainbuilding <= 9 && $mainbuilding >= 5) {
                    include("soon/treasury.tpl");
                }
                if ($brickyard == 0 && $claypit <= 9 && $claypit >= 5 && $mainbuilding >= 2 && $mainbuilding <= 4) {
                    include("soon/brickyard.tpl");
                }
                if ($sawmill == 0 && $woodcutter <= 9 && $woodcutter >= 5 && $mainbuilding >= 2 && $mainbuilding <= 4) {
                    include("soon/sawmill.tpl");
                }
                if ($ironfoundry == 0 && $ironmine <= 9 && $ironmine >= 5 && $mainbuilding >= 2 && $mainbuilding <= 4) {
                    include("soon/ironfoundry.tpl");
                }
                if ($workshop == 0 && $academy <= 9 && $academy >= 5 && $mainbuilding >= 2 && $mainbuilding <= 4) {
                    include("soon/workshop.tpl");
                }
                if ($tournamentsquare == 0 && $rallypoint <= 14 && $rallypoint >= 7) {
                    include("soon/tsquare.tpl");
                }
                if ($bakery == 0 && $grainmill <= 4 && $grainmill != 0 && $cropland >= 5 && $cropland <= 9 && $mainbuilding >= 2 && $mainbuilding <= 4) {
                    include("soon/bakery.tpl");
                }
                if ($townhall == 0 && ($mainbuilding <= 9 && $mainbuilding >= 5) || ($academy >= 5 && $academy <= 9)) {
                    include("soon/townhall.tpl");
                }
                if ($tradeoffice == 0 && $market <= 19 && $market >= 10 || $stable >= 5 && $stable <= 9) {
                    include("soon/tradeoffice.tpl");
                }
                if ($session->tribe == 1 && $horsedrinkingtrough == 0 && $rallypoint <= 9 && $rallypoint >= 5 || $stable <= 19 && $stable >= 10 && $session->tribe == 1) {
                    include("soon/horsedrinking.tpl");
                }
                if ($brewery == 0 && $session->tribe == 2 && $rallypoint >= 5 && $granary >= 10 && ($rallypoint <= 9 || $granary <= 19)) {
                    include("soon/brewery.tpl");
                }
                if (!$database->getBuildList(38, $village->wid) && ($artEffGrt_warehouse > 0)
                    && (($greatwarehouse > 17 && $mainbuilding > 8) && (($greatwarehouse > 0 && $greatwarehouse < 20) || $mainbuilding < 10))
                ) {
                    include("soon/greatwarehouse.tpl");
                }
                if (!$database->getBuildList(38, $village->wid) && ($artEffGrt_warehouse > 0)
                    && (($greatgranary > 17 && $mainbuilding > 8) && (($greatgranary >= 20 && $greatgranary < 20) || $mainbuilding < 10))
                ) {
                    include("soon/greatgranary.tpl");
                }
                if ($greatbarracks == 0 && $barrack >= 15 && $village->capital == 0) {
                    include("soon/greatbarracks.tpl");
                }
                if ($greatstable == 0 && $stable >= 15 && $village->capital == 0) {
                    include("soon/greatstable.tpl");
                }
                if ($greatworkshop == 0 && $workshop >= 15 && $village->capital == 0 && GREAT_WKS) {
                    include("soon/greatworkshop.tpl");
                }
            ?>
        </div>
        <div class="switch"><a id="all_link" class="openedClosedSwitch switchClosed hide" href="#"><?php echo UN_MORE;?></a></div>
        <div id="build_list_all" class="hide">
            <?php
                if ($academy == 0 && ($mainbuilding == 1 || $barrack == 0)) {
                    include("soon/academy.tpl");
                }
                if ($palace == 0 && ($embassy == 0 || $mainbuilding <= 2)) {
                    include("soon/palace.tpl");
                }
                if ($blacksmith == 0 && ($academy == 0 || $mainbuilding == 1)) {
                    include("soon/blacksmith.tpl");
                }
                if ($stonemasonslodge == 0 && ($palace == 0 || $mainbuilding <= 2) && $residence == 0) {
                    include("soon/stonemason.tpl");
                }
                if ($stable == 0 && ($blacksmith == 0 || $academy <= 2)) {
                    include("soon/stable.tpl");
                }
                if ($hasWW != 40 && $treasury == 0 && $mainbuilding <= 5) {
                    include("soon/treasury.tpl");
                }
                if ($brickyard == 0 && ($claypit <= 5 || $mainbuilding <= 2)) {
                    include("soon/brickyard.tpl");
                }
                if ($sawmill == 0 && ($woodcutter <= 5 || $mainbuilding <= 2)) {
                    include("soon/sawmill.tpl");
                }
                if ($ironfoundry == 0 && ($ironmine <= 5 || $mainbuilding <= 2)) {
                    include("soon/ironfoundry.tpl");
                }
                if ($workshop == 0 && ($academy <= 5 || $mainbuilding <= 2)) {
                    include("soon/workshop.tpl");
                }
                if ($tournamentsquare == 0 && $rallypoint <= 7) {
                    include("soon/tsquare.tpl");
                }
                if ($bakery == 0 && ($grainmill == 0 || $cropland <= 5 || $mainbuilding <= 2)) {
                    include("soon/bakery.tpl");
                }
                if ($townhall == 0 && ($mainbuilding <= 5 || $academy <= 5)) {
                    include("soon/townhall.tpl");
                }
                if ($tradeoffice == 0 && ($market <= 10 || $stable <= 5)) {
                    include("soon/tradeoffice.tpl");
                }
                if ($session->tribe == 1 && $horsedrinkingtrough == 0 && ($rallypoint <= 5 || $stable <= 10)) {
                    include("soon/horsedrinking.tpl");
                }
                if ($brewery == 0 && ($rallypoint <= 5 || $granary <= 10) && $session->tribe == 2) {
                    include("soon/brewery.tpl");
                }
                if ($greatbarracks == 0 && $barrack >= 10 && $village->capital == 0) {
                    include("soon/greatbarracks.tpl");
                }
                if ($greatstable == 0 && $stable >= 10 && $village->capital == 0) {
                    include("soon/greatstable.tpl");
                }
                if ($greatworkshop == 0 && $workshop >= 15 && $village->capital == 0 && GREAT_WKS) {
                    include("soon/greatworkshop.tpl");
                }
                if ($greatwarehouse == 0 && ($artEffGrt_warehouse > 0 || $hasWW == 40) && $id != 39 && $id != 40) {
                    include("soon/greatwarehouse.tpl");
                }
                if ($greatgranary == 0 && ($artEffGrt_warehouse > 0 || $hasWW == 40) && $id != 39 && $id != 40) {
                    include("soon/greatgranary.tpl");
                }
            ?>
        </div>
        <script language="JavaScript" type="text/javascript">
            window.addEvent('domready', function () {
                Object.each(
                    {
                        'all_link': 'all',
                        'soon_link': 'soon'
                    }, function (list, element) {
                        if ($(element)) {
                            $(element).addEvent('click', function (e) {
                                e.stop();
                                // aktuelle liste, aktueller link
                                var build_list = $('build_list_' + list);
                                var link = $(list + '_link');

                                var all_link = $('all_link');
                                var soon_link = $('soon_link');

                                var build_list_all = $('build_list_all');
                                var build_list_soon = $('build_list_soon');

                                Travian.toggleSwitch(build_list, link);
                                if (!build_list.hasClass('hide')) {
                                    if (link == soon_link) {
                                        link.innerHTML = '<?php echo BL_HIDESOONAVAILABLE;?>';
                                        if (all_link !== null) {
                                            all_link.removeClass('hide');
                                        }
                                    }
                                    else {
                                        link.innerHTML = '<?php echo BL_HIDEMORE;?>';
                                    }
                                }
                                else {
                                    if (link == soon_link) {
                                        link.innerHTML = '<?php echo BL_SHOWSOONAVAILABLE;?>';
                                        if (all_link !== null) {
                                            all_link.innerHTML = '<?php echo BL_SHOWMORE;?>';
                                            all_link.addClass('hide');
                                            build_list_all.addClass('hide');
                                        }
                                    }
                                    else {
                                        link.innerHTML = '<?php echo BL_SHOWMORE;?>';
                                    }
                                }
                            });
                        }
                    });
            });
        </script>
    <?php
    }
?>
</div>
