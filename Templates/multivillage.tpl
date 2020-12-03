<div id="sidebarBoxPlusFuture" class="sidebarBox ">
    <div class="sidebarBoxBaseBox">
        <div class="baseBox baseBoxTop">
            <div class="baseBox baseBoxBottom">
                <div class="baseBox baseBoxCenter"></div>
            </div>
        </div>
    </div>
    <div class="sidebarBoxInnerBox">
        <div class="innerBox header ">
            <div class="clear"></div>
            <div class="boxTitle"></div>
            <button type="button" id="button5225ee283d5acasd" class="layoutButton bulbActive2 gold "
                    onclick="return false;" title="<?php echo MV_PLUS; ?>">
                <div class="button-container addHoverClick">
                    <img src="img/x.gif" alt="">
                </div>
            </button>
            <script type="text/javascript">
                if ($('button5225ee283d5acasd')) {
                    $('button5225ee283d5acasd').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": true, "boxId": "alliance", "disabled": true, "speechBubble": "", "class": "", "id": "button5225ee283d5acasd", "redirectUrl": "plus.php", "redirectUrlExternal": ""}]);
                    });
                }
            </script>
            <b><?php echo MV_PLUS2; ?></b>
        </div>
        <div class="innerBox content"></div>
        <div class="innerBox footer"></div>
    </div>
</div>

<div id="sidebarBoxTravianBank" class="sidebarBox ">
    <div class="sidebarBoxBaseBox">
        <div class="baseBox baseBoxTop">
            <div class="baseBox baseBoxBottom">
                <div class="baseBox baseBoxCenter"></div>
            </div>
        </div>
    </div>
    <div class="sidebarBoxInnerBox">
        <div class="innerBox header ">
            <div class="clear"></div>
            <div class="boxTitle"></div>
            <button type="button" id="button522583d5acasd" class="layoutButton bulbActive3 gold "
                    onclick="return false;" title="<?php echo MV_BANK;?>">
                <div class="button-container addHoverClick">
                    <img src="img/x.gif" alt="">
                </div>
            </button>
            <script type="text/javascript">
                if ($('button522583d5acasd')) {
                    $('button522583d5acasd').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": true, "boxId": "alliance", "disabled": true, "speechBubble": "", "class": "", "id": "button522583d5acasd", "redirectUrl": "plus.php?bank", "redirectUrlExternal": ""}]);
                    });
                }
            </script>
            <b><?php echo MV_BANK2;?></b>
        </div>
        <div class="innerBox content"></div>
        <div class="innerBox footer"></div>
    </div>
</div>

<?php
    $total_vill = count($session->villages);
    for ($i = 1; $i <= $total_vill; $i++) {
        if ($session->plus) {
            //$i = 0;

            $vm['v31'] = $database->getMovement(3, $village->wid, 1);
            if (!is_array($vm['v31'])) $vm['v31'] = array();

            $list['extra'] = 'distance<4.9497474683058326708059105347339';
            $order['by'] = 'distance';
            $coor = $database->getCoor($village->wid);
            $order['x'] = $coor['x'];
            $order['y'] = $coor['y'];
            $order['max'] = 2 * WORLD_MAX + 1;

            $oasats = $database->getVillageOasis($list, 30, $order);
            foreach ($oasats as $os) {
                if ($os['owner'] == $session->uid) {

                    $vm['o31'] = $database->getMovement(3, $os['wref'], 1);
                    if (!is_array($vm['o31'])) $vm['o31'] = array();
                }
            }
            $waveser = array_merge($vm['v31'], $vm['o31']); //$database->getMovement(3,$village->wid,1);
            $waveCountW = count($waveser);
            for ($ixx = 0; $ixx < $waveCountW; $ixx++) {
                if ($ixx >= 0 && $waveser[$ixx]['attack_type'] <= 2) {
                    $waveCountW -= 1;
                    array_splice($waveser, $ixx, 1);
                    $ixx--;
                }
            }

            if ($waveCountW > 0) {
                $village_attack[$session->villages[$i - 1]] = 'att1';
                $village_title[$session->villages[$i - 1]] = 'attacks on this village: ' . $aantal;
            } else {
                $village_attack[$session->villages[$i - 1]] = '';
                $village_title[$session->villages[$i - 1]] = htmlspecialchars($returnVillageArray[$i - 1]['name']);
            }
        }

        if (isset($_GET['id'])) {
            $_GET['id'] = filter_var($_GET['id'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&id=' . $_GET['id'];
        } else if (isset($_GET['gid'])) {
            $_GET['gid'] = filter_var($_GET['gid'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&gid=' . $_GET['gid'];
        } else if (isset($_GET['w'])) {
            $_GET['w'] = filter_var($_GET['w'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&w=' . $_GET['w'];
        } else if (isset($_GET['r'])) {
            $_GET['r'] = filter_var($_GET['r'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&r=' . $_GET['r'];
        } else if (isset($_GET['z'])) {
            $_GET['z'] = filter_var($_GET['z'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&z=' . $_GET['z'];
        } else if (isset($_GET['o'])) {
            $_GET['o'] = filter_var($_GET['o'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&o=' . $_GET['o'];
        } else if (isset($_GET['s'])) {
            $_GET['s'] = filter_var($_GET['s'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&s=' . $_GET['s'];
        } else if (isset($_GET['c'])) {
            $_GET['c'] = filter_var($_GET['c'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&c=' . $_GET['c'];
        } else if (isset($_GET['t'])) {
            $_GET['t'] = filter_var($_GET['t'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&t=' . $_GET['t'];
        } else if (isset($_GET['d'])) {
            $_GET['d'] = filter_var($_GET['d'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&d=' . $_GET['d'];
        } else if (isset($_GET['aid'])) {
            $_GET['aid'] = filter_var($_GET['aid'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&aid=' . $_GET['aid'];
        } else if (isset($_GET['uid'])) {
            $_GET['uid'] = filter_var($_GET['uid'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&uid=' . $_GET['uid'];
        } else if (isset($_GET['tid'])) {
            $_GET['tid'] = filter_var($_GET['tid'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&tid=' . $_GET['tid'];
        } else if (isset($_GET['vill']) && isset($_GET['id'])) {
            $_GET['vill'] = filter_var($_GET['vill'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&id=' . $_GET['id'] . '&vill=' . $_GET['vill'];
        } else if (isset($_GET['t']) && isset($_GET['id'])) {
            $_GET['t'] = filter_var($_GET['t'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&id=' . $_GET['id'] . '&t=' . $_GET['t'];
        } else if (isset($_GET['x']) && isset($_GET['y'])) {
            $_GET['x'] = filter_var($_GET['x'], FILTER_SANITIZE_MAGIC_QUOTES);
            $_GET['y'] = filter_var($_GET['y'], FILTER_SANITIZE_MAGIC_QUOTES);
            $vill = '&x=' . $_GET['x'] . '&y=' . $_GET['y'];
        } else {
            $vill = '';
        }
        $gid = $_GET['gid'];
    }

?>
<div id="sidebarBoxVillagelist" class="sidebarBox toggleable <?php if (isset($_COOKIE['travian_toggle'])) {
    $class = explode(',', $_COOKIE['travian_toggle']);
    foreach ($class as $cs) {
        $expl = explode(':', $cs);
        if ($expl[0] == "villagelist") {
            echo $expl[1];
        }
        $i++;
    }
} else {
    echo "collapsed";
}?>">
    <div class="sidebarBoxBaseBox">
        <div class="baseBox baseBoxTop">
            <div class="baseBox baseBoxBottom">
                <div class="baseBox baseBoxCenter"></div>
            </div>
        </div>
    </div>
    <div class="sidebarBoxInnerBox">
        <div class="innerBox header ">
            <button type="button" id="button5229e52550643" class="layoutButton toggleCoordsWhite green  toggle"
                    onclick="return false;" title="نمایش مختصات">
                <div class="button-container addHoverClick">
                    <img src="img/x.gif" alt=""/>
                </div>
            </button>

            <script type="text/javascript">

                if ($('button5229e52550643')) {
                    $('button5229e52550643').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "toggle", "id": "button5229e52550643", "redirectUrl": "", "redirectUrlExternal": ""}]);
                    });
                }
            </script>
            <button type="button" id="button5229e52550762" class="layoutButton overviewWhite green  "
                    onclick="return false;" title="دید کلی دهکده">
                <div class="button-container addHoverClick">
                    <img src="img/x.gif" alt=""/>
                </div>
            </button>

            <script type="text/javascript">

                if ($('button5229e52550762')) {
                    $('button5229e52550762').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button5229e52550762", "redirectUrl": "dorf3.php", "redirectUrlExternal": ""}]);
                    });
                }
            </script>
            <div class="clear"></div>
            <?php
                $q = mysql_query("SELECT `cp` FROM " . TB_PREFIX . "users WHERE `id` =" . $session->uid);
                $row = mysql_fetch_assoc($q);
                $x = $row['cp'];
                $max = count($session->villages);

                switch ($max) {
                    case 1:
                        $vmax = 2000;
                        $t = 1;
                        $wid = 30;
                        break;
                    case 2:
                        $vmax = 8000;
                        $t = 2;
                        $wid = 30;
                        break;
                    case 3:
                        $vmax = 20000;
                        $t = 3;
                        $wid = 30;
                        break;
                }
                $TT[1] = 0;
                $TT[2] = 2000;
                $TT[3] = 8000;
                $TT[4] = 20000;
                $TT['level'] = $max;
                $TT['experience'] = $x;
                $t1 = ($TT['experience'] - $TT[$TT['level']]);
                $t2 = ($TT[$TT['level'] + 1] - $TT[$TT['level']]);
                $wids = round(100 * ($t1 / $t2), 1) > 0 ? round(100 * ($t1 / $t2), 1) : 0;
                if ($TT['experience'] >= 2000 && $TT['experience'] < 8000 && $max == 1) {
                    $wids = 100;
                }
                if ($TT['experience'] >= 8000 && $TT['experience'] < 20000 && $max <= 2) {
                    $wids = 100;
                }
                if ($TT['experience'] >= 20000) {
                    $wids = 100;
                }
                $wids = $max == 3 ? 100 : $wids;
            ?>
            <div class="expansionSlotInfo"
                 title="<?php echo MV_VILL.$t; ?>/<?php echo $max; ?> </br><?php echo MV_CULTURE.$x; ?> / <?php echo $vmax; ?>">
                <div class="boxTitleAdditional"><?php echo $t; ?>/<?php echo $max; ?>&#8207;</div>
                <div class="boxTitle"><?php echo MV_VILL2;?></div>
                <div class="villageListBarBox">
                    <div class="bar" style="width:<?php echo $wids; ?>%">&nbsp;</div>
                </div>
            </div>

            <script type="text/javascript">
                window.addEvent('domready', function () {
                    Travian.Translation.add(
                        {
                            'villagelist_collapsed': '<?php echo MV_SHOWCORD;?>',
                            'villagelist_expanded': '<?php echo MV_HIDECORD;?>'
                        });

                    var box = $('sidebarBoxVillagelist');
                    box.down('button.toggle').addEvent('click', function (e) {
                        Travian.Game.Layout.toggleBox(box, 'travian_toggle', 'villagelist');
                    });
                });
            </script>
        </div>
        <div class="innerBox content">
            <ul>
                <?php
                    for ($i = 1; $i <= $max; $i++) {
                        if ($session->villages[$i - 1] == $village->wid) {
                            $select = 'active';
                            $sid = 'currentVillage';
                        } else {
                            $select = '';
                            $sid = '';
                        }
                        $coorproc = $database->getCoor($session->villages[$i - 1]);
                        ?>
                    <li class=" <?php echo $select; ?>"
                        title="<?php echo $database->getVillageField($session->villages[$i - 1], 'name') . '  (' . $coorproc['x'] . '|' . $coorproc['y'] . ')    '; ?>">
                        <a href="?newdid=<?php echo $session->villages[$i - 1]."&".$vill; ?>" accesskey="b"
                           class="<?php echo $select; ?>">
                            <img src="img/x.gif" class="<?php echo $village_attack[$session->villages[$i - 1]];?>"/>

                            <div
                                class="name"><?php echo $database->getVillageField($session->villages[$i - 1], 'name'); ?></div>
                            &#8207;&#x202e;<span
                                class="coordinates coordinatesWrapper coordinatesAligned coordinatesLTR"><span
                                    class="coordinateX">(<?php echo $coorproc['x']; ?></span><span
                                    class="coordinatePipe">|</span><span
                                    class="coordinateY"><?php echo $coorproc['y']; ?>)</span></span>&#x202c;&#8207;
                        </a>
                        </li><?php } ?>
            </ul>
        </div>
        <div class="innerBox footer">
        </div>
    </div>
</div>