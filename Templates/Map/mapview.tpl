<?php
    if (isset($_GET['x']) && isset($_GET['y'])) {
        $coorproc['x'] = $_GET['x'];
        $coorproc['y'] = $_GET['y'];
    } elseif (isset($_GET['d'])) {
        $_GET['d'] = (int)$_GET['d'];
        $coorproc = $database->getCoor($_GET['d']);
    } else {
        $coorproc = $database->getCoor($village->wid);
    }
    $sql = mysql_query("SELECT `id`,`wref`,`dif` FROM " . TB_PREFIX . "adventure WHERE end = 0 and uid = " . $session->uid . " ORDER BY time ASC");
    $query = mysql_num_rows($sql);
    include('Templates/Auction/alt.tpl');
    $adv = array();
    if ($query != 0) {
        while ($row = mysql_fetch_assoc($sql)) {
            $coor = $database->getCoor($row['wref']);
            $to = array('x' => $coor['x'], 'y' => $coor['y']);
            if (!$row['dif']) {
                $dif = 1;
            } else {
                $dif = 0;
            }
            $t = ($dif == 1) ? "{a.ad1}" : "{a.ad0}";
            $adv[] = '{"x":' . $coor['x'] . ',"y":' . $coor['y'] . ',"s":[{"dataId":"adventure' . $row['id'] . '","x":"' . $coor['x'] . '","y":"' . $coor['y'] . '","type":"adventure","parameters":{"difficulty":"' . $dif . '"},"title":"\u0645\u0627\u062c\u0631\u0627\u062c\u0648\u06cc\u06cc","text":"{a.ad} ' . $t . '"}]},';
        }
    }
?>
<div id="content" class="map">
<h1 class="titleInHeader">Map</h1>

<div class="map2">
<div id="mapContainer">
    <div class="innerShadow">
        <div class="innerShadow-tl">
            <div class="innerShadow-tr">
                <div class="innerShadow-tc"></div>
            </div>
        </div>
        <div class="innerShadow-ml">
            <div class="innerShadow-mr"></div>
        </div>
        <div class="innerShadow-bl">
            <div class="innerShadow-br">
                <div class="innerShadow-bc"></div>
            </div>
        </div>
    </div>
    <div id="toolbar" class="toolbar">
        <div class="ml">
            <div class="mr">
                <div class="mc">
                    <div class="contents">
                        <div class="iconButton zoomIn" title="<?php echo MP_ZOOMIN;?>"></div>
                        <div class="iconButton zoomOut" title="<?php echo MP_ZOOMIN;?>"></div>
                        <div class="dropdown">
                            <div class="dataContainer">
                                <div class="entry display">100%</div>
                                <div class="entry hide">50%</div>
                            </div>
                            <div class="iconButton dropDownImage" title="Zoom level"></div>
                        </div>

                        <div class="iconButton <?php if (!$session->plus) {
                            echo 'iconRequireGold';
                        } else {
                            if (isset($_GET['fullscreen'])) {
                                echo "viewNormal";
                            } else {
                                echo 'viewFull';
                            }
                        } ?> " id="iconFullscreen">
                            <?php if (!$session->plus) { ?>
                                <div class="iconButton view<?php if (isset($_GET['fullscreen'])) {
                                    echo "Normal";
                                } else {
                                    echo "FullGold";
                                } ?> " title="<?php echo MP_LARGMAPDESC;?>"></div>
                            <?php } else { ?>
                                <div class="iconButton "
                                     title="<?php echo MP_LARGMAPDESC;?>"></div>
                            <?php } ?>
                        </div>
                        <div class="iconButton <?php if (!$session->goldclub) {
                            echo 'iconRequireGold';
                        } else {
                            echo 'linkCropfinder';
                        } ?>" id="iconCropfinder">
                            <?php if (!$session->goldclub) { ?>
                                <div class="iconButton linkCropfinder"
                                     title="<?php echo MP_CROPFINDER;?>"></div>
                            <?php } else { ?>
                                <div class="iconButton "
                                     title="<?php echo MP_CROPFINDER;?>"></div>
                            <?php } ?>
                        </div>
                        <div class="separator"></div>
                        <div class="text"><?php echo MP_FILTER;?></div>
                        <div class="iconButton filterMy checked" title="<?php echo MP_SHOWMARKS;?>"></div>
                        <div class="iconButton filterAlliance checked" title="<?php echo MP_SHOWALLYMARK;?>"></div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bl">
            <div class="br">
                <div class="bc"></div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        Travian.Game.Map.Options.Toolbar.filterPlayer.checked = true;
        Travian.Game.Map.Options.Toolbar.filterAlliance.checked = false;
    </script>
    <?php if (!$session->goldclub) { ?>
        <script type="text/javascript">window.addEvent('domready', function () {
                $('iconFullscreen').addEvent('click', function () {
                    window.fireEvent("buttonClicked", [this, {"plusDialog": {"featureKey": "fullScreen", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=Travian Answers#go2answer"}}]);
                })
            });</script>
        <script type="text/javascript">window.addEvent('domready', function () {
                $('iconCropfinder').addEvent('click', function () {
                    window.fireEvent("buttonClicked", [this, {"goldclubDialog": {"featureKey": "cropFinder", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=Travian Answers#go2answer"}}]);
                })
            });</script>
    <?php } ?>
    <form id="mapCoordEnter" action="karte.php" method="get" class="toolbar ">
        <div class="ml">
            <div class="mr">
                <div class="mc">
                    <div class="contents">
                        <div class="coordinatesInput">
                            <div class="xCoord">
                                <label for="xCoordInputMap">X:</label>
                                <input maxlength="4" value="<?php echo $coorproc['x']; ?>" name="x" id="xCoordInputMap"
                                       class="text coordinates x "/>
                            </div>
                            <div class="yCoord">
                                <label for="yCoordInputMap">Y:</label>
                                <input maxlength="4" value="<?php echo $coorproc['y']; ?>" name="y" id="yCoordInputMap"
                                       class="text coordinates y "/>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <button type="submit" value="OK" id="button52e8d5760b7e4" class="green small">
                            <div class="button-container addHoverClick ">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content"><?php echo OK;?></div>
                            </div>
                        </button>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="minimapContainer">
        <div class="background"></div>
        <div class="headline">
            <div class="title"><?php echo MP_MINIMAP;?></div>
            <div class="iconButton small"></div>
            <div class="clear"></div>
        </div>
        <div id="miniMap"><img class="map" style="width: 185px; height: 109px;" src="minimap.php" alt="MiniMap"/></div>
        <div class="bl">
            <div class="br">
                <div class="bc"></div>
            </div>
        </div>
    </div>
    <div id="outline">
        <div class="tl">
            <div class="tr">
                <div class="tc"></div>
            </div>
        </div>
        <div class="background"></div>
        <div id="mapMarks">
            <div class="headline">
                <div class="title"><?php echo MP_OUTLINE;?></div>
                <div class="iconButton small"></div>
                <div class="clear"></div>
            </div>
            <div class="tabContainer">
                <div class="tab">
                    <div class="entry selected">
                        <div class="tab-container">
                            <div class="tab-position">
                                <div class="tab-tl">
                                    <div class="tab-tr">
                                        <div class="tab-tc"></div>
                                    </div>
                                </div>
                                <div class="tab-ml">
                                    <div class="tab-mr">
                                        <div class="tab-mc"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-contents">
                                <a href="#" onClick="
								if (!$(this).up('.entry').hasClass('selected'))
								{
									$('tabPlayer').show();
									$('tabAlliance').hide();
									$(this).up('.entry').toggleClass('selected').next('.entry').toggleClass('selected');
								}
								$('mapContainer')._map.mapMarks.player.update(false);
								return false;
							">Players</a>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div id="tabPlayer" class="dataTab"></div>
                <div id="tabAlliance" class="dataTab"></div>
            </div>
        </div>
    </div>
</div>

<div id="contextmenu">
    <div class="background">
        <div class="background-tl">
            <div class="background-tr">
                <div class="background-tc"></div>
            </div>
        </div>
        <div class="background-ml">
            <div class="background-mr">
                <div class="background-mc"></div>
            </div>
        </div>
        <div class="background-bl">
            <div class="background-br">
                <div class="background-bc"></div>
            </div>
        </div>
    </div>
    <div class="background-content">
        <div>
            <div class="tl">
                <div class="tr">
                    <div class="tc"></div>
                </div>
            </div>
            <div class="ml">
                <div class="mr">
                    <div class="mc">
                        <div class="contents">
                            <div id="contextMenuSendTroops" class="entry">
                                <a href="#flag"><?php echo MP_SENDTROOP;?></a>
                            </div>
                            <div id="contextMenuSendTraders" class="entry">
                                <a href="#flag"><?php echo MP_SENDMERCHANT;?></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bl">
                <div class="br">
                    <div class="bc"></div>
                </div>
            </div>
        </div>
        <div class="separator separatorActions"></div>

        <div>
            <div class="tl">
                <div class="tr">
                    <div class="tc"></div>
                </div>
            </div>
            <div class="ml">
                <div class="mr">
                    <div class="mc">
                        <div class="contents">
                            <div class="hideIE6 title">
                                <?php echo MK_PLAYERS;?>
                            </div>
                            <div id="contextMenuMarkPlayerAlliance" class="hideIE6 entry">
                                <a href="#flag"><?php echo MP_MARKALLY;?></a>
                            </div>
                            <div id="contextMenuMarkPlayerPlayer" class="hideIE6 entry">
                                <a href="#flag"><?php echo MP_MARKPLAYER;?></a>
                            </div>
                            <div id="contextMenuFlagPlayer" class="hideIE6 entry">
                                <a href="#flag"><?php echo MP_MARKFIELD;?></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bl">
                <div class="br">
                    <div class="bc"></div>
                </div>
            </div>
        </div>

    </div>
</div>
</div>


<script type="text/javascript">
    Travian.Translation.add(
        {
            'k.spieler': '<?php echo AL_PLAYER;?>',
            'k.einwohner': '<?php echo POPUALTION;?>',
            'k.allianz': '<?php echo AL_ALLIANCE;?>',
            'k.volk': '<?php echo TRIBE;?>',
            'k.dt': '<?php echo VL_VILLAGE;?>',
            'k.bt': '<?php echo VL_OCCUPIEDOASIS;?>',
            'k.fo': '<?php echo VL_UNOCCUPIEDOASIS;?>',
            'k.vt': '<?php echo VL_ABANDONVALLEY;?>',
            'k.loadingData': '<?php echo FD_LOADING;?>',

            'a.v1': '<?php echo TRIBE1;?>',
            'a.v2': '<?php echo TRIBE2;?>',
            'a.v3': '<?php echo TRIBE3;?>',
            'a.v4': '<?php echo TRIBE4;?>',
            'a.v5': '<?php echo TRIBE5;?>',

            'k.f1': '3-3-3-9',
            'k.f2': '3-4-5-6',
            'k.f3': '4-4-4-6',
            'k.f4': '4-5-3-6',
            'k.f5': '5-3-4-6',
            'k.f6': '1-1-1-15',
            'k.f7': '4-4-3-7',
            'k.f8': '3-4-4-7',
            'k.f9': '4-3-4-7',
            'k.f10': '3-5-4-6',
            'k.f11': '4-3-5-6',
            'k.f12': '5-4-3-6',
            'k.f99': '<?php echo VL_NATARVILL;?>',

            'b.ri1': '<?php echo NOTICE2;?>',
            'b.ri2': '<?php echo NOTICE3;?>',
            'b.ri3': '<?php echo NOTICE4;?>',
            'b.ri4': '<?php echo NOTICE5;?>',
            'b.ri5': '<?php echo NOTICE6;?>',
            'b.ri6': '<?php echo NOTICE7;?>',
            'b.ri7': '<?php echo NOTICE8;?>',

            'b:ri1': '&lt;img src="img/x.gif" class="iReport iReport1"/&gt;'.unescapeHtml(),
            'b:ri2': '&lt;img src="img/x.gif" class="iReport iReport2"/&gt;'.unescapeHtml(),
            'b:ri3': '&lt;img src="img/x.gif" class="iReport iReport3"/&gt;'.unescapeHtml(),
            'b:ri4': '&lt;img src="img/x.gif" class="iReport iReport4"/&gt;'.unescapeHtml(),
            'b:ri5': '&lt;img src="img/x.gif" class="iReport iReport5"/&gt;'.unescapeHtml(),
            'b:ri6': '&lt;img src="img/x.gif" class="iReport iReport6"/&gt;'.unescapeHtml(),
            'b:ri7': '&lt;img src="img/x.gif" class="iReport iReport7"/&gt;'.unescapeHtml(),

            'b:bi0': '&lt;img class="carry empty" src="img/x.gif" alt="Bounty" /&gt;'.unescapeHtml(),
            'b:bi1': '&lt;img class="carry half" src="img/x.gif" alt="Bounty" /&gt;'.unescapeHtml(),
            'b:bi2': '&lt;img class="carry" src="img/x.gif" alt="Bounty" /&gt;'.unescapeHtml(),

            'a.r1': '<?PHP ECHO VL_LUMBER;?>',
            'a.r2': '<?PHP ECHO VL_CLAY;?>',
            'a.r3': '<?PHP ECHO VL_IRON;?>',
            'a.r4': '<?PHP ECHO VL_CROP;?>',

            'a.atm1': 'Adventure 1',
            'a.atm2': 'Adventure 2',
            'a.atm3': 'Adventure 3',
            'a.atm4': 'Adventure 4',
            'a.atm5': 'Adventure 5',
            'a.atm6': 'Adventure 6',
            'a.atm7': 'Adventure 7',
            'a.atm8': 'Adventure 8',
            'a.atm9': 'Adventure 9',
            'a.atm10': 'Adventure 10',
            'a.atm11': 'Adventure 11',
            'a.atm12': 'Adventure 12',
            'a.atm13': 'Adventure 13',
            'a.ad': '<?php echo HR_DIFFICULTY;?>:',
            'a.ad0': '<?php echo HR_HARD;?>',
            'a.ad1': '<?php echo HR_NORMAL;?>',
            'a.ad2': '<?php echo HR_NORMAL;?>',
            'a.ad3': '<?php echo HR_NORMAL;?>',

            'a:r1': '&lt;img alt="Lumber" src="img/x.gif" class="r1"&gt;'.unescapeHtml(),
            'a:r2': '&lt;img alt="Clay" src="img/x.gif" class="r2"&gt;'.unescapeHtml(),
            'a:r3': '&lt;img alt="Iron" src="img/x.gif" class="r3"&gt;'.unescapeHtml(),
            'a:r4': '&lt;img alt="Crop" src="img/x.gif" class="r4"&gt;'.unescapeHtml(),

            'k.arrival': 'arrival at',
            'k.ssupport': 'reinforcement',
            'k.sspy': 'scouting',
            'k.sreturn': 'return',
            'k.sraid': 'raid',
            'k.sattack': 'attack'
        });
</script>

<script type="text/javascript">
window.addEvent('domready', function () {
    var containerViewSize = {
        width: 543,
        height: 401
    };
    <?php if($_GET['fullscreen'] == 1){ ?>
    var resizeTimer;
    window.addEvent('resize', function () {
        clearTimeout(resizeTimer); //firefox fix for resize event
        resizeTimer = (function () {
            window.location.reload();
        }).delay(50);
    });
    <?php } ?>
    var fnDelayMe = function () {

        <?php if($_GET['fullscreen'] == 1){ ?>
        if ($('betaBox')) {
            $('betaBox').dispose();
        }

        var fullScreenSize = $(window.document).getCoordinates();
        var body = $(document.body).addClass('fullScreen');
        var mapContainer = $('mapContainer').dispose();

        containerViewSize.width = fullScreenSize.width - 25; // rulers Y left || right
        containerViewSize.height = fullScreenSize.height - 20; // rulers X
        mapContainer.inject(body).setStyles(
            {
                position: 'absolute',
                left: fullScreenSize.left + 1, // rulers Y left || right
                top: fullScreenSize.top,
                width: containerViewSize.width,
                height: containerViewSize.height
            });
        <?php } ?>
        var fnInit = function () {
            Travian.Game.Map.Options.Rulers.steps = Object.merge({},
                Travian.Game.Map.Options.Rulers.steps, {
                    "x": {"1": 1, "2": 1, "3": 10, "4": 20},
                    "y": {"1": 1, "2": 1, "3": 10, "4": 20}
                });

            Travian.Game.Map.Options.Default.dataStore = Object.merge({}, Travian.Game.Map.Options.Default.dataStore, {"cachingTimeForType": {"blocks": 1800000, "symbol": 600000, "tile": 600000, "tooltip": 300000}, "persistentStorage": false, "useStorageForType": {"blocks": false, "symbol": false, "tile": false, "tooltip": false}, "clearStorageForType": {"blocks": false, "symbol": false, "tile": false, "tooltip": false}});

            Travian.Game.Map.Options.Default.updater = Object.merge({}, Travian.Game.Map.Options.Default.updater, {"maxRequestCount": 4, "requestDelayTime": {"multiple": 100, "position": 300}, "url": "ajax.php", "positionOptions": {"areaAroundPosition": {"1": {"left": -5, "top": -4, "right": 5, "bottom": 4}, "2": {"left": -10, "top": -8, "right": 10, "bottom": 8}, "3": {"left": -15, "top": -15, "right": 15, "bottom": 15}, "4": {"left": -15, "top": -15, "right": 15, "bottom": 15}}}});

            Travian.Game.Map.Options.Default.tileDisplayInformation.type = 'dialog';

            Travian.Game.Map.Options.MapMark.Flag.dialog.html = '<div class=\"mapMarkField\">\n	<div class=\"flag {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\">\n		<input id=\"coordinateDialogText\" class=\"text {inputText}\" type=\"text\" />\n	<\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';

            Travian.Game.Map.Options.MapMark.Mark.dialog.html = '<div class=\"mapMarkMark\">\n	<div class=\"color {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\"><\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';


            Travian.Game.Map.Options.Default.mapMarks.player.layers.alliance.dialog.html = '<div class=\"mapMarkMark\">\n	<div class=\"color {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\"><\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';

            Travian.Game.Map.Options.Default.mapMarks.player.layers.player.dialog.html = '<div class=\"mapMarkMark\">\n	<div class=\"color {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\"><\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';

            Travian.Game.Map.Options.Default.mapMarks.alliance.layers.alliance.dialog.html = '<div class=\"mapMarkMark\">\n	<div class=\"color {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\"><\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';

            Travian.Game.Map.Options.Default.mapMarks.alliance.layers.player.dialog.html = '<div class=\"mapMarkMark\">\n	<div class=\"color {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\"><\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';


            Travian.Game.Map.Options.Default.mapMarks.player.layers.flag.dialog.html = '<div class=\"mapMarkField\">\n	<div class=\"flag {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\">\n		<input id=\"coordinateDialogText\" class=\"text {inputText}\" type=\"text\" />\n	<\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';

            Travian.Game.Map.Options.Default.mapMarks.alliance.layers.flag.dialog.html = '<div class=\"mapMarkField\">\n	<div class=\"flag {select}\"><\/div>\n	<div class=\"{coord}\">\n		\n			<div class=\"coordinatesInput\">\n				<div class=\"xCoord\">\n					<label for=\"coordinateDialogX\">X:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"x\" id=\"coordinateDialogX\" class=\"text coordinates x {inputX}\" />\n				<\/div>\n				<div class=\"yCoord\">\n					<label for=\"coordinateDialogY\">Y:<\/label>\n					<input maxlength=\"4\" value=\"\" name=\"y\" id=\"coordinateDialogY\" class=\"text coordinates y {inputY}\" />\n				<\/div>\n				<div class=\"clear\"><\/div>\n			<\/div>\n			<\/div>\n	<div class=\"{textDisplay}\">\n		<input id=\"coordinateDialogText\" class=\"text {inputText}\" type=\"text\" />\n	<\/div>\n	<p class=\"error errorMessage\"><\/p>\n<\/div>';


            Travian.Game.Map.Tips.tooltipHtml = '<span class=\"coordinates coordinatesWithText\"><span class=\"coordinatesWrapper\"><span class=\"coordinateX\">{x})<\/span><span class=\"coordinatePipe\">|<\/span><span class=\"coordinateY\">({y}<\/span><\/span><\/span>';

            Travian.Game.Map.Options.Default.block.tooltipHtml = '<span class=\"coordinates coordinatesWithText\"><span class=\"coordinatesWrapper\"><span class=\"coordinateX\">({x}<\/span><span class=\"coordinatePipe\">|<\/span><span class=\"coordinateY\">{y})<\/span><\/span><\/span><br />{k.loadingData}';

            Travian.Game.Map.Options.MiniMap.tooltipHtml = '<span class=\"coordinates coordinatesWithText\"><span class=\"coordinatesWrapper\"><span class=\"coordinateX\">{x})<\/span><span class=\"coordinatePipe\">|<\/span><span class=\"coordinateY\">({y}<\/span><\/span><\/span>';

            new Travian.Game.Map.Container(Object.merge({}, Travian.Game.Map.Options.Default, {
                blockOverflow: 1,
                blockSize: {
                    width: 600,
                    height: 600
                },
                containerViewSize: containerViewSize,
                mapInitialPosition: {
                    x:    <?php echo $coorproc['x'];?>,
                    y:    <?php echo $coorproc['y'];?>
                },
                transition: {
                    zoomOptions: {
                        level: 1,
                        sizes: [
                            {"x": 10, "y": 10},
                            {"x": 20, "y": 20}
                        ]
                    }
                },

                data: {
                    "elements": [
                        <?php
                        foreach($adv as $adventure){echo $adventure;}

                        $pflagsQ = mysql_query("SELECT `id`,`x`,`y`,`index`,`text`,`dataId` FROM ".TB_PREFIX."map_marks WHERE uid = ".$session->uid." AND type !='player' ORDER BY id ASC")or die(mysql_error());
                        while($row = mysql_fetch_assoc($pflagsQ)){
                            echo '{"x":'.$row['x'].',"y":'.$row['y'].',"s":[{"index": "'.$row['index'].'","text": "'.$row['text'].'","kid": "1","plus": "0","type": "flag","layer": "player","dataId": "'.$row['dataId'].'"}]},';
                        }
                        ?>
                    ],
                    "blocks": {
                    }
                },

                mapMarks: {
                    player: {
                        data: [
                            <?php
                            $pflagsQ = mysql_query("SELECT `id`,`uid`,`x`,`y`,`index`,`text` FROM ".TB_PREFIX."map_marks WHERE uid = ".$session->uid." AND type = 'player' ORDER BY id ASC")or die(mysql_error());
                            while($rows = mysql_fetch_assoc($pflagsQ)){
                                echo '{"color":"'.$rows['index'].'","text":"'.$rows['text'].'","markId":"'.$rows['uid'].'","layer":"player","dataId":"'.$rows['id'].'"},';
                            }
                            $flagsQ = mysql_query("SELECT `id`,`x`,`y`,`index`,`text` FROM ".TB_PREFIX."map_marks WHERE uid = ".$session->uid." AND type !='player' ORDER BY id ASC")or die(mysql_error());

                            while($row = mysql_fetch_assoc($flagsQ)){
                                echo '{"index":"'.$row['index'].'","text":"'.$row['text'].'","plus":"'.$row['plus'].'","layer":"flag","dataId":"'.$row['id'].'","x":'.$row['x'].',"y":'.$row['y'].'},';
                            }
                            ?>
                        ],

                        layers: {
                            alliance: {
                                title: '<?php echo AL_ALLIANCE;?>',
                                dialog: {
                                    title: '<?php echo MP_OWNALLYMARK;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                },
                                optionsData: {
                                    urlLink: 'allianz.php?aid={markId}'
                                }
                            },
                            player: {

                                title: '<?php echo MK_PLAYERS;?>',
                                dialog: {
                                    title: '<?php echo MP_OWNPLYMARK;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                },
                                optionsData: {
                                    urlLink: 'spieler.php?uid={markId}'
                                }
                            },
                            flag: {
                                title: 'flags',
                                dialog: {
                                    title: '<?php echo MP_OWNFLDMARK;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                }
                            }
                        }
                    },
                    alliance: {
                        enabled: false,
                        data: null,
                        layers: {
                            alliance: {
                                editable: false,
                                title: '<?php echo AL_ALLIANCE;?>',
                                dialog: {
                                    title: '<?php echo MP_ALLYMARKMYALL;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                },
                                optionsData: {
                                    urlLink: 'allianz.php?aid={markId}'
                                }
                            },
                            player: {
                                editable: false,
                                title: '<?php echo AL_PLAYER;?>',
                                dialog: {
                                    title: '<?php echo MP_PLYMARKMYALL;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                },
                                optionsData: {
                                    urlLink: 'spieler.php?uid={markId}'
                                }
                            },
                            flag: {
                                editable: false,
                                title: '<?php echo MP_FLAGS;?>',
                                dialog: {
                                    title: '<?php echo MP_FLDYMARKMYALL;?>',
                                    textOkay: '<?php echo SI_SAVE;?>',
                                    textCancel: '<?php echo AT_CANCEL;?>'
                                }
                            }
                        }
                    }
                }
            }));
        };
        if ((!Browser.safari && !Browser.chrome) || $('mapContainer').getSize().y == containerViewSize.height) {
            fnInit();
        } else {
            fnDelayMe.delay(100);
        }
    };
    fnDelayMe();
});
</script>
</div>