<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include('GameEngine/Village.php');
    $winner = $database->hasWinner();
    if ($winner) {
        header("Location: winner.php");
        die;
    }
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['rank'])) {
        $_POST['rank'] == $_GET['rank'];
    }
    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "'");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        if (isset($_GET['tid'])) {
            if (preg_match('/[^0-9]/', $_GET['tid'])) {
                $tid = filter_var($_GET['tid'], FILTER_SANITIZE_STRING, FILTER_SANITIZE_NUMBER_INT);
            } else {
                $tid = 1;
            }
            header('Location: statistiken.php?tid=' . $tid . '');
            exit;
        } else {
            header('Location: statistiken.php');
            exit;
        }
    }
    include('Templates/html.tpl');
?>
<body class="v35 gecko production perspectiveBuildings">
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
<div id="headerBar"></div>
<div id="bodyWrapper">
<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>

<?php
    include('Templates/Header.tpl');
?>
<div id="center">
<a id="ingameManual" href="help.php">
    <img class="question" alt="Help" src="img/x.gif">
</a>

<div id="sidebarBeforeContent" class="sidebar beforeContent">
    <?php
        include('Templates/heroSide.tpl');
        include('Templates/Alliance.tpl');
        include('Templates/infomsg.tpl');
        include('Templates/links.tpl');
    ?>
    <div class="clear"></div>
</div>
<div id="contentOuterContainer">
<?php include('Templates/res.tpl'); ?>
<div class="contentTitle">
    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">&nbsp;</a>
    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.ir/" target="_blank"
       title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
</div>
<div class="contentContainer">
<div id="content" class="production">
<h1 class="titleInHeader"><?php echo BD_PRODOVERVIEW;?></h1>

<div class="contentNavi subNavi ">
    <div title="" class="container <?php if ($_GET['t'] == 1) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content">

            <a id="button5280fc114fb2b" href="production.php?t=1" class="tabItem"><?php echo VL_LUMBER;?></a>
        </div>
    </div>

    <script type="text/javascript">
        if ($('button5280fc114fb2b')) {
            $('button5280fc114fb2b').addEvent('click', function () {
                window.fireEvent('tabClicked', [this, {"class": "active", "title": false, "target": false, "id": "button5280fc114fb2b", "href": "production.php?t=1", "onclick": false, "enabled": true, "text": "Lumber", "dialog": false, "plusDialog": false, "goldclubDialog": false, "containerId": "", "buttonIdentifier": "button5280fc114fb2b"}]);

            });
        }
    </script>

    <div title="" class="container <?php if ($_GET['t'] == 2) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content">

            <a id="button5280fc114fb76" href="production.php?t=2" class="tabItem"><?php echo VL_CLAY;?></a>
        </div>
    </div>

    <script type="text/javascript">
        if ($('button5280fc114fb76')) {
            $('button5280fc114fb76').addEvent('click', function () {
                window.fireEvent('tabClicked', [this, {"class": "normal", "title": false, "target": false, "id": "button5280fc114fb76", "href": "production.php?t=2", "onclick": false, "enabled": true, "text": "Clay", "dialog": false, "plusDialog": false, "goldclubDialog": false, "containerId": "", "buttonIdentifier": "button5280fc114fb76"}]);

            });
        }
    </script>

    <div title="" class="container <?php if ($_GET['t'] == 3) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content">

            <a id="button5280fc114fc82" href="production.php?t=3" class="tabItem"><?php echo VL_IRON;?></a>
        </div>
    </div>

    <script type="text/javascript">
        if ($('button5280fc114fc82')) {
            $('button5280fc114fc82').addEvent('click', function () {
                window.fireEvent('tabClicked', [this, {"class": "normal", "title": false, "target": false, "id": "button5280fc114fc82", "href": "production.php?t=3", "onclick": false, "enabled": true, "text": "Iron", "dialog": false, "plusDialog": false, "goldclubDialog": false, "containerId": "", "buttonIdentifier": "button5280fc114fc82"}]);

            });
        }
    </script>

    <div title="" class="container <?php if ($_GET['t'] == 4) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content">
            <a id="button5280fc115017b" href="production.php?t=4" class="tabItem"><?php echo VL_CROP;?></a>
        </div>
    </div>

    <script type="text/javascript">
        if ($('button5280fc115017b')) {
            $('button5280fc115017b').addEvent('click', function () {
                window.fireEvent('tabClicked', [this, {"class": "normal", "title": false, "target": false, "id": "button5280fc115017b", "href": "production.php?t=4", "onclick": false, "enabled": true, "text": "Crop", "dialog": false, "plusDialog": false, "goldclubDialog": false, "containerId": "", "buttonIdentifier": "button5280fc115017b"}]);

            });
        }
    </script>

    <div title="" class="container <?php if ($_GET['t'] == 5) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content">
            <a id="button5280fc1150491" href="production.php?t=5" class="tabItem"><?php echo VL_BALANCE;?></a>
        </div>
    </div>

    <script type="text/javascript">
        if ($('button5280fc1150491')) {
            $('button5280fc1150491').addEvent('click', function () {
                window.fireEvent('tabClicked', [this, {"class": "normal", "title": false, "target": false, "id": "button5280fc1150491", "href": "production.php?t=5", "onclick": false, "enabled": true, "text": "Balance", "dialog": false, "plusDialog": false, "goldclubDialog": false, "containerId": "", "buttonIdentifier": "button5280fc1150491"}]);

            });
        }
    </script>
    <div class='clear'></div>
</div>
<script type="text/javascript">
    window.addEvent('domready', function () {
        $$('.subNavi').each(function (element) {
            new Travian.Game.Menu(element);
        });
    });
</script>
<?php
    $player = $database->getUser($session->username, 0);
    if ($_GET['t'] == 1) {
        $heroData = $database->getHeroField($session->uid);
        $total_hwood = $heroData['r1'] * 10 * SPEED * $heroData['product'];
        $total_hclay = $heroData['r2'] * 10 * SPEED * $heroData['product'];
        $total_hiron = $heroData['r3'] * 10 * SPEED * $heroData['product'];
        $total_hcrop = $heroData['r4'] * 10 * SPEED * $heroData['product'];
        $hproduct = $heroData['r0'] * 3 * SPEED * $heroData['product'];
        $wood = $sawmill = 0;
        $woodholder = array();
        for ($i = 1; $i <= 38; $i++) {
            if ($village->resarray['f' . $i . 't'] == 1) {
                array_push($woodholder, 'f' . $i);
            }
            if ($village->resarray['f' . $i . 't'] == 5) {
                $sawmill = $village->resarray['f' . $i];
                $perc = $bid5[$village->resarray['f' . $i]]['attri'];
            }
        }
        for ($i = 0; $i <= count($woodholder) - 1; $i++) {
            $wood += $bid1[$village->resarray[$woodholder[$i]]]['prod'];
        }
        $total_wood_product = $wood * SPEED;
        if ($sawmill >= 1) {
            $wood += $wood / 100 * $bid5[$sawmill]['attri'];
        }
        if ($village->ocounter2[0] != 0) {
            $wood += $wood * 0.25 * $village->ocounter2[0];
        }
        if ($session->bonus1 == 1) {
            $wood *= 1.25;
        }
        $wood += $wood * $village->ocounter2[0] * 0.25;
        $wood *= SPEED;
        $wood += $hproduct;
        $abadi = $village->ocounter2[0];
        ?>
        <div class="productionContainer">
            <div class="productionPerHour">
                <h4><?php echo VL_PRODPERHR;?>:</h4>
                <table cellspacing="1" cellpadding="1" class="row_table_data">
                    <thead>
                    <tr>
                        <td><?php echo VL_RESFIELD;?></td>
                        <td><?php echo VL_PRODUCTION;?></td>
                        <td><?php echo AL_BONUS;?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>هیزم شکن سطح <?php echo $village->resarray[$woodholder[0]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[0]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>هیزم شکن سطح <?php echo $village->resarray[$woodholder[1]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[1]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>هیزم شکن سطح <?php echo $village->resarray[$woodholder[2]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[2]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>هیزم شکن سطح <?php echo $village->resarray[$woodholder[3]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[3]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr class="productionSum">
                        <td>مجموع</td>
                        <td class="numberCell"><?php echo $total_wood_product; ?></td>
                        <td class="numberCell"><?php echo $total_hwood; ?></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="productionBoostSpeechBubble">
                <div class="fluidSpeechBubble-container">
                    <div class="fluidSpeechBubble">
                        <div class="fluidSpeechBubble-tl"></div>
                        <div class="fluidSpeechBubble-tr"></div>
                        <div class="fluidSpeechBubble-tc"></div>
                        <div class="fluidSpeechBubble-ml"></div>
                        <div class="fluidSpeechBubble-mr"></div>
                        <div class="fluidSpeechBubble-mc"></div>
                        <div class="fluidSpeechBubble-bl"></div>
                        <div class="fluidSpeechBubble-br"></div>
                        <div class="fluidSpeechBubble-bc"></div>
                        <div class="speechArrowBack"></div>
                        <div class="fluidSpeechBubble-contents cf"><h5>جایزه تولیدات:</h5>
                            <table cellspacing="0" cellpadding="0" class="row_table_data">
                                <tbody>
                                <tr class="inactive">
                                    <td>الوار سازی سطح  <?php echo $sawmill; ?> :</td>
                                    <td class="numberCell"><?php if (isset($perc)) {
                                            echo $perc;
                                        } else {
                                            echo '0';
                                        } ?>%
                                    </td>
                                </tr>
                                <tr class="inactive">
                                    <td>آبادی (&times;<?php echo $abadi; ?>)</td>
                                    <td class="numberCell">&#8206;<?php echo $abadi; ?>%</td>
                                </tr>
                                <tr>
                                    <td class="bold">مجموع جایزه</td>
                                    <td class="bold numberCell">&#8206;<?php echo $bonus_total = $abadi + $perc; ?>%</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="total productionContainer">
            <div class="productionPerHourTotal">
                <h4>مجموع <?php echo VL_PRODPERHR;?>:</h4>
                <table cellspacing="0" cellpadding="0" class="row_table_data">
                    <tbody>
                    <tr>
                        <td><?php echo VL_PRODUCTION;?></td>
                        <td class="numberCell"><?php echo $total_wood_product; ?></td>
                    </tr>
                    <tr>
                        <td>جایزه</td>
                        <td class="numberCell"><?php echo $bonus_total; ?>%</td>
                    </tr>
                    <tr>
                        <td>تولیدات قهرمان</td>
                        <td class="numberCell"><?php echo $total_hwood + $hproduct; ?></td>
                    </tr>
                    <tr class="subtotal">
                        <td class="bold">تعادل فعلی =</td>
                        <td class="numberCell bold">~</td>
                    </tr>

                    <tr class="inactive">
                        <td>&#8206;+25% تولیدات <?php if ($player['b1'] < $_SERVER['REQUEST_TIME']) {
                                echo "(inactive)";
                                $plus_pro = 0;
                            } else {
                                $plus_pro = (($total_wood_product) * 25 / 100);
                            }
                            ?></td>
                        <td class="numberCell"><?php echo round($plus_pro); ?></td>
                    </tr>
                    <tr class="total bold">
                        <td class="bold">مجموع</td>
                        <td class="numberCell bold">
                            <?php
                                echo $wood;
                            ?></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <?php if ($player['b1'] < $_SERVER['REQUEST_TIME']) { ?>
                <div class="productionBoostResourceSpeechBubble">
                    <div class="fluidSpeechBubble-container">
                        <div class="fluidSpeechBubble">
                            <div class="fluidSpeechBubble-tl"></div>
                            <div class="fluidSpeechBubble-tr"></div>
                            <div class="fluidSpeechBubble-tc"></div>
                            <div class="fluidSpeechBubble-ml"></div>
                            <div class="fluidSpeechBubble-mr"></div>
                            <div class="fluidSpeechBubble-mc"></div>
                            <div class="fluidSpeechBubble-bl"></div>
                            <div class="fluidSpeechBubble-br"></div>
                            <div class="fluidSpeechBubble-bc"></div>
                            <div class="speechArrowBack"></div>
                            <div class="fluidSpeechBubble-contents cf">
                                <form id="fluidSpeechBubble" method="post" action="">
                                    <p>Hourly production including production bonus: <span class="bold"></span></p>

                                    <div>
                                        <button type="button" value="Activate now" id="button5280fc11512da"
                                                class="gold prosButton productionboostWood"
                                                title="Activate Now||Bonus duration in days: <span class='bold'>7</span>"
                                                coins="5">
                                            <div class="button-container addHoverClick">
                                                <div class="button-background">
                                                    <div class="buttonStart">
                                                        <div class="buttonEnd">
                                                            <div class="buttonMiddle"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="button-content">Activate Now<img src="img/x.gif"
                                                                                             class="goldIcon"
                                                                                             alt=""/><span
                                                        class="goldValue">5</span></div>
                                            </div>
                                        </button>
                                        <script type="text/javascript">
                                            window.addEvent('domready', function () {
                                                if ($('button5280fc11512da')) {
                                                    $('button5280fc11512da').addEvent('click', function () {
                                                        window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Activate now", "name": "", "id": "button5280fc11512da", "class": "gold prosButton productionboostWood", "title": "Activate now\u0026lt;br \/\u0026gt;Bonus duration in days: \u0026lt;span class=\u0026quot;bold\u0026quot;\u0026gt;7\u0026lt;\/span\u0026gt;", "confirm": "", "onclick": "", "coins": 5, "wayOfPayment": {"featureKey": "productionboostWood", "context": "production"}}]);
                                                    });
                                                }
                                            });
                                        </script>
                                    </div>
                                    <div class="productionBoostSpeechBubbleFurtherInfo">
                                        <p>* The production bonus increases the production of the resource in <span
                                                class="underlined"> All </span>your villages.</p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    <?php
    } else if ($_GET['t'] == 2) {
        $heroData = $database->getHeroField($session->uid);
        $total_hwood = $heroData['r1'] * 10 * SPEED * $heroData['product'];
        $total_hclay = $heroData['r2'] * 10 * SPEED * $heroData['product'];
        $total_hiron = $heroData['r3'] * 10 * SPEED * $heroData['product'];
        $total_hcrop = $heroData['r4'] * 10 * SPEED * $heroData['product'];
        $hproduct = $heroData['r0'] * 3 * SPEED * $heroData['product'];
        $wood = $sawmill = 0;
        $woodholder = array();
        for ($i = 1; $i <= 38; $i++) {
            if ($village->resarray['f' . $i . 't'] == 2) {
                array_push($woodholder, 'f' . $i);
            }
            if ($village->resarray['f' . $i . 't'] == 6) {
                $sawmill = $village->resarray['f' . $i];
                $perc = $bid6[$village->resarray['f' . $i]]['attri'];
            }
        }
        for ($i = 0; $i <= count($woodholder) - 1; $i++) {
            $wood += $bid2[$village->resarray[$woodholder[$i]]]['prod'];
        }
        $total_wood_product = $wood * SPEED;
        if ($sawmill >= 1) {
            $wood += $wood / 100 * $bid6[$sawmill]['attri'];
        }
        if ($village->ocounter2[1] != 0) {
            $wood += $wood * 0.25 * $village->ocounter2[1];
        }
        if ($session->bonus1 == 1) {
            $wood *= 1.25;
        }
        $wood += $wood * $village->ocounter2[1] * 0.25;
        $wood *= SPEED;
        $wood += $hproduct;
        $abadi = $village->ocounter2[1];
        ?>
        <div class="productionContainer">
            <div class="productionPerHour">
                <h4><?php echo VL_PRODPERHR;?>:</h4>
                <table cellspacing="1" cellpadding="1" class="row_table_data">
                    <thead>
                    <tr>
                        <td><?php echo VL_RESFIELD;?></td>
                        <td><?php echo VL_PRODUCTION;?></td>
                        <td>جایزه</td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>آجر سازی سطح <?php echo $village->resarray[$woodholder[0]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[0]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>آجر سازی سطح <?php echo $village->resarray[$woodholder[1]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[1]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>آجر سازی سطح<?php echo $village->resarray[$woodholder[2]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[2]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr>
                        <td>آجر سازی سطح <?php echo $village->resarray[$woodholder[3]]; ?></td>
                        <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[3]]]['prod'] * SPEED; ?></td>
                        <td class="numberCell">0</td>
                    </tr>
                    <tr class="productionSum">
                        <td>مجموع</td>
                        <td class="numberCell"><?php echo $total_wood_product; ?></td>
                        <td class="numberCell"><?php echo $total_hwood; ?></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="productionBoostSpeechBubble">
                <div class="fluidSpeechBubble-container">
                    <div class="fluidSpeechBubble">
                        <div class="fluidSpeechBubble-tl"></div>
                        <div class="fluidSpeechBubble-tr"></div>
                        <div class="fluidSpeechBubble-tc"></div>
                        <div class="fluidSpeechBubble-ml"></div>
                        <div class="fluidSpeechBubble-mr"></div>
                        <div class="fluidSpeechBubble-mc"></div>
                        <div class="fluidSpeechBubble-bl"></div>
                        <div class="fluidSpeechBubble-br"></div>
                        <div class="fluidSpeechBubble-bc"></div>
                        <div class="speechArrowBack"></div>
                        <div class="fluidSpeechBubble-contents cf"><h5>جایزه تولیدات:</h5>
                            <table cellspacing="0" cellpadding="0" class="row_table_data">
                                <tbody>
                                <tr class="inactive">
                                    <td>آجر پزی سطح <?php echo $sawmill; ?> :</td>
                                    <td class="numberCell"><?php if (isset($perc)) {
                                            echo $perc;
                                        } else {
                                            echo '0';
                                        } ?>%
                                    </td>
                                </tr>
                                <tr class="inactive">
                                    <td>آبادی (&times;<?php echo $abadi; ?>)</td>
                                    <td class="numberCell">&#8206;<?php echo $abadi; ?>%</td>
                                </tr>
                                <tr>
                                    <td class="bold">مجموع جایزه</td>
                                    <td class="bold numberCell">&#8206;<?php echo $bonus_total = $abadi + $perc; ?>%</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="total productionContainer">
            <div class="productionPerHourTotal">
                <h4><?php echo VL_PRODPERHR;?>:</h4>
                <table cellspacing="0" cellpadding="0" class="row_table_data">
                    <tbody>
                    <tr>
                        <td>تولیدات</td>
                        <td class="numberCell"><?php echo $total_wood_product; ?></td>
                    </tr>
                    <tr>
                        <td>جایزه</td>
                        <td class="numberCell"><?php echo $bonus_total; ?>%</td>
                    </tr>
                    <tr>
                        <td>تولیدات قهرمان</td>
                        <td class="numberCell"><?php echo $total_hwood + $hproduct; ?></td>
                    </tr>
                    <tr class="subtotal">
                        <td class="bold">تعادل فعلی =</td>
                        <td class="numberCell bold">~</td>
                    </tr>

                    <tr class="inactive">
                        <td>&#8206;+25% تولیدات <?php if ($player['b2'] < $_SERVER['REQUEST_TIME']) {
                                echo "(inactive)";
                                $plus_pro = 0;
                            } else {
                                $plus_pro = (($total_wood_product) * 25 / 100);
                            }
                            ?></td>
                        <td class="numberCell"><?php echo round($plus_pro); ?></td>
                    </tr>
                    <tr class="total bold">
                        <td class="bold">مجموع</td>
                        <td class="numberCell bold">
                            <?php
                                echo $wood;
                            ?></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <?php if ($player['b2'] < $_SERVER['REQUEST_TIME']) { ?>
                <div class="productionBoostResourceSpeechBubble">
                    <div class="fluidSpeechBubble-container">
                        <div class="fluidSpeechBubble">
                            <div class="fluidSpeechBubble-tl"></div>
                            <div class="fluidSpeechBubble-tr"></div>
                            <div class="fluidSpeechBubble-tc"></div>
                            <div class="fluidSpeechBubble-ml"></div>
                            <div class="fluidSpeechBubble-mr"></div>
                            <div class="fluidSpeechBubble-mc"></div>
                            <div class="fluidSpeechBubble-bl"></div>
                            <div class="fluidSpeechBubble-br"></div>
                            <div class="fluidSpeechBubble-bc"></div>
                            <div class="speechArrowBack"></div>
                            <div class="fluidSpeechBubble-contents cf">
                                <form id="fluidSpeechBubble" method="post" action="">
                                    <p>Hourly production including production bonus: <span class="bold"></span></p>

                                    <div>
                                        <button type="button" value="Activate now" id="button5280fc11512da"
                                                class="gold prosButton productionboostWood"
                                                title="Activate Now||Bonus Duration in Days : <span class='bold'>7</span>"
                                                coins="5">
                                            <div class="button-container addHoverClick">
                                                <div class="button-background">
                                                    <div class="buttonStart">
                                                        <div class="buttonEnd">
                                                            <div class="buttonMiddle"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="button-content">Activate Now<img src="img/x.gif"
                                                                                             class="goldIcon"
                                                                                             alt=""/><span
                                                        class="goldValue">5</span></div>
                                            </div>
                                        </button>
                                        <script type="text/javascript">
                                            window.addEvent('domready', function () {
                                                if ($('button5280fc11512da')) {
                                                    $('button5280fc11512da').addEvent('click', function () {
                                                        window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Activate now", "name": "", "id": "button5280fc11512da", "class": "gold prosButton productionboostWood", "title": "Activate now\u0026lt;br \/\u0026gt;Bonus duration in days: \u0026lt;span class=\u0026quot;bold\u0026quot;\u0026gt;7\u0026lt;\/span\u0026gt;", "confirm": "", "onclick": "", "coins": 5, "wayOfPayment": {"featureKey": "productionboostWood", "context": "production"}}]);
                                                    });
                                                }
                                            });
                                        </script>
                                    </div>
                                    <div class="productionBoostSpeechBubbleFurtherInfo">
                                        <p>* The production bonus increases the production of the resource in <span
                                                class="underlined"> All </span>your villages.</p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    <?php
    } else
        if ($_GET['t'] == 3) {
            $heroData = $database->getHeroField($session->uid);
            $total_hwood = $heroData['r1'] * 10 * SPEED * $heroData['product'];
            $total_hclay = $heroData['r2'] * 10 * SPEED * $heroData['product'];
            $total_hiron = $heroData['r3'] * 10 * SPEED * $heroData['product'];
            $total_hcrop = $heroData['r4'] * 10 * SPEED * $heroData['product'];
            $hproduct = $heroData['r0'] * 3 * SPEED * $heroData['product'];
            $wood = $sawmill = 0;
            $woodholder = array();
            for ($i = 1; $i <= 38; $i++) {
                if ($village->resarray['f' . $i . 't'] == 3) {
                    array_push($woodholder, 'f' . $i);
                }
                if ($village->resarray['f' . $i . 't'] == 7) {
                    $sawmill = $village->resarray['f' . $i];
                    $perc = $bid7[$village->resarray['f' . $i]]['attri'];
                }
            }
            for ($i = 0; $i <= count($woodholder) - 1; $i++) {
                $wood += $bid3[$village->resarray[$woodholder[$i]]]['prod'];
            }
            $total_wood_product = $wood * SPEED;

            if ($sawmill >= 1) {
                $wood += $wood / 100 * $bid7[$sawmill]['attri'];
            }
            if ($village->ocounter2[2] != 0) {
                $wood += $wood * 0.25 * $village->ocounter2[2];
            }
            if ($session->bonus1 == 1) {
                $wood *= 1.25;
            }
            $wood += $wood * $village->ocounter2[2] * 0.25;
            $wood *= SPEED;
            $wood += $hproduct;
            $abadi = $village->ocounter2[2];
            ?>
            <div class="productionContainer">
                <div class="productionPerHour">
                    <h4><?php echo VL_PRODPERHR;?>:</h4>
                    <table cellspacing="1" cellpadding="1" class="row_table_data">
                        <thead>
                        <tr>
                            <td><?php echo VL_RESFIELD;?></td>
                            <td><?php echo VL_PRODUCTION;?></td>
                            <td>جایزه</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>معدن آهن سطح  <?php echo $village->resarray[$woodholder[0]]; ?></td>
                            <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[0]]]['prod'] * SPEED; ?></td>
                            <td class="numberCell">0</td>
                        </tr>
                        <tr>
                            <td>معدن آهن سطح  <?php echo $village->resarray[$woodholder[1]]; ?></td>
                            <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[1]]]['prod'] * SPEED; ?></td>
                            <td class="numberCell">0</td>
                        </tr>
                        <tr>
                            <td>معدن آهن سطح  <?php echo $village->resarray[$woodholder[2]]; ?></td>
                            <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[2]]]['prod'] * SPEED; ?></td>
                            <td class="numberCell">0</td>
                        </tr>
                        <tr>
                            <td>معدن آهن سطح  <?php echo $village->resarray[$woodholder[3]]; ?></td>
                            <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[3]]]['prod'] * SPEED; ?></td>
                            <td class="numberCell">0</td>
                        </tr>
                        <tr class="productionSum">
                            <td>مجموع</td>
                            <td class="numberCell"><?php echo $total_wood_product; ?></td>
                            <td class="numberCell"><?php echo $total_hwood; ?></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="productionBoostSpeechBubble">
                    <div class="fluidSpeechBubble-container">
                        <div class="fluidSpeechBubble">
                            <div class="fluidSpeechBubble-tl"></div>
                            <div class="fluidSpeechBubble-tr"></div>
                            <div class="fluidSpeechBubble-tc"></div>
                            <div class="fluidSpeechBubble-ml"></div>
                            <div class="fluidSpeechBubble-mr"></div>
                            <div class="fluidSpeechBubble-mc"></div>
                            <div class="fluidSpeechBubble-bl"></div>
                            <div class="fluidSpeechBubble-br"></div>
                            <div class="fluidSpeechBubble-bc"></div>
                            <div class="speechArrowBack"></div>
                            <div class="fluidSpeechBubble-contents cf"><h5>جایزه تولیدات:</h5>
                                <table cellspacing="0" cellpadding="0" class="row_table_data">
                                    <tbody>
                                    <tr class="inactive">
                                        <td>کارخانه فولادسازی سطح<?php echo $sawmill; ?> :</td>
                                        <td class="numberCell"><?php if (isset($perc)) {
                                                echo $perc;
                                            } else {
                                                echo '0';
                                            } ?>%
                                        </td>
                                    </tr>
                                    <tr class="inactive">
                                        <td>آبادی (&times;<?php echo $abadi; ?>)</td>
                                        <td class="numberCell">&#8206;<?php echo $abadi; ?>%</td>
                                    </tr>
                                    <tr>
                                        <td class="bold">مجموع جایزه</td>
                                        <td class="bold numberCell">&#8206;<?php echo $bonus_total = $abadi + $perc; ?>%</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="total productionContainer">
                <div class="productionPerHourTotal">
                    <h4><?php echo VL_PRODPERHR;?>:</h4>
                    <table cellspacing="0" cellpadding="0" class="row_table_data">
                        <tbody>
                        <tr>
                            <td>تولیدات</td>
                            <td class="numberCell"><?php echo $total_wood_product; ?></td>
                        </tr>
                        <tr>
                            <td>جایره</td>
                            <td class="numberCell"><?php echo $bonus_total; ?>%</td>
                        </tr>
                        <tr>
                            <td>تولیدات قعرمان</td>
                            <td class="numberCell"><?php echo $total_hwood + $hproduct; ?></td>
                        </tr>
                        <tr class="subtotal">
                            <td class="bold">تعادل فعلی =</td>
                            <td class="numberCell bold">~</td>
                        </tr>

                        <tr class="inactive">
                            <td>&#8206;+25% تولیدات <?php if ($player['b3'] < $_SERVER['REQUEST_TIME']) {
                                    echo "(inactive)";
                                    $plus_pro = 0;
                                } else {
                                    $plus_pro = (($total_wood_product) * 25 / 100);
                                }
                                ?></td>
                            <td class="numberCell"><?php echo round($plus_pro); ?></td>
                        </tr>
                        <tr class="total bold">
                            <td class="bold">مجموع</td>
                            <td class="numberCell bold">
                                <?php
                                    echo $wood;
                                ?></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <?php if ($player['b3'] < $_SERVER['REQUEST_TIME']) { ?>
                    <div class="productionBoostResourceSpeechBubble">
                        <div class="fluidSpeechBubble-container">
                            <div class="fluidSpeechBubble">
                                <div class="fluidSpeechBubble-tl"></div>
                                <div class="fluidSpeechBubble-tr"></div>
                                <div class="fluidSpeechBubble-tc"></div>
                                <div class="fluidSpeechBubble-ml"></div>
                                <div class="fluidSpeechBubble-mr"></div>
                                <div class="fluidSpeechBubble-mc"></div>
                                <div class="fluidSpeechBubble-bl"></div>
                                <div class="fluidSpeechBubble-br"></div>
                                <div class="fluidSpeechBubble-bc"></div>
                                <div class="speechArrowBack"></div>
                                <div class="fluidSpeechBubble-contents cf">
                                    <form id="fluidSpeechBubble" method="post" action="">
                                        <p>Hourly production including production bonus: <span class="bold"></span></p>

                                        <div>
                                            <button type="button" value="Activate now" id="button5280fc11512da"
                                                    class="gold prosButton productionboostWood"
                                                    title="Activate Now||Bonus Duration in Days : <span class='bold'>7</span>"
                                                    coins="5">
                                                <div class="button-container addHoverClick">
                                                    <div class="button-background">
                                                        <div class="buttonStart">
                                                            <div class="buttonEnd">
                                                                <div class="buttonMiddle"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="button-content">Activate Now<img src="img/x.gif"
                                                                                                 class="goldIcon"
                                                                                                 alt=""/><span
                                                            class="goldValue">5</span></div>
                                                </div>
                                            </button>
                                            <script type="text/javascript">
                                                window.addEvent('domready', function () {
                                                    if ($('button5280fc11512da')) {
                                                        $('button5280fc11512da').addEvent('click', function () {
                                                            window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Activate now", "name": "", "id": "button5280fc11512da", "class": "gold prosButton productionboostWood", "title": "Activate now\u0026lt;br \/\u0026gt;Bonus duration in days: \u0026lt;span class=\u0026quot;bold\u0026quot;\u0026gt;7\u0026lt;\/span\u0026gt;", "confirm": "", "onclick": "", "coins": 5, "wayOfPayment": {"featureKey": "productionboostWood", "context": "production"}}]);
                                                        });
                                                    }
                                                });
                                            </script>
                                        </div>
                                        <div class="productionBoostSpeechBubbleFurtherInfo">
                                            <p>* The production bonus increases the production of the resource in <span
                                                    class="underlined"> All </span>your villages.</p>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        <?php
        } else
            if ($_GET['t'] == 4) {
                $heroData = $database->getHeroField($session->uid);
                $total_hwood = $heroData['r1'] * 10 * SPEED * $heroData['product'];
                $total_hclay = $heroData['r2'] * 10 * SPEED * $heroData['product'];
                $total_hiron = $heroData['r3'] * 10 * SPEED * $heroData['product'];
                $total_hcrop = $heroData['r4'] * 10 * SPEED * $heroData['product'];
                $hproduct = $heroData['r0'] * 3 * SPEED * $heroData['product'];
                $wood = $sawmill = $bakery = 0;
                $woodholder = array();
                for ($i = 1; $i <= 38; $i++) {
                    if ($village->resarray['f' . $i . 't'] == 4) {
                        array_push($woodholder, 'f' . $i);
                    }
                    if ($village->resarray['f' . $i . 't'] == 8) {
                        $sawmill = $village->resarray['f' . $i];
                        $perc = $bid5[$sawmill]['attri'];
                    }
                    if ($village->resarray['f' . $i . 't'] == 9) {
                        $bakery = $village->resarray['f' . $i];
                        $perc2 = $bid9[$bakery]['attri'];
                    }
                }
                for ($i = 0; $i <= count($woodholder) - 1; $i++) {
                    $wood += $bid4[$village->resarray[$woodholder[$i]]]['prod'];
                }
                $total_wood_product = $wood * SPEED;
                if ($sawmill >= 1 || $bakery >= 1) {
                    $wood += $wood / 100 * ($bid8[$sawmill]['attri'] + $bid9[$bakery]['attri']);
                }
                if ($village->ocounter2[3] != 0) {
                    $wood += $wood * 0.25 * $village->ocounter2[3];
                }
                if ($session->bonus4 == 1) {
                    $wood *= 1.25;
                }
                $wood += $wood * $village->ocounter2[3] * 0.25;
                $wood *= SPEED;
                $wood += $hproduct;
                $abadi = $village->ocounter2[3];
                ?>
                <div class="productionContainer">
                    <div class="productionPerHour">
                        <h4><?php echo VL_PRODPERHR;?>:</h4>
                        <table cellspacing="1" cellpadding="1" class="row_table_data">
                            <thead>
                            <tr>
                                <td><?php echo VL_RESFIELD;?></td>
                                <td>تولیدات</td>
                                <td>جایره</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[0]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[0]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[1]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[1]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[2]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[2]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[3]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[3]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[4]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[4]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr>
                                <td>مزرعه گندم سطح  <?php echo $village->resarray[$woodholder[5]]; ?></td>
                                <td class="numberCell"><?php echo $bid1[$village->resarray[$woodholder[5]]]['prod'] * SPEED; ?></td>
                                <td class="numberCell">0</td>
                            </tr>
                            <tr class="productionSum">
                                <td>مجموع</td>
                                <td class="numberCell"><?php echo $total_wood_product; ?></td>
                                <td class="numberCell"><?php echo $total_hwood; ?></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="productionBoostSpeechBubble">
                        <div class="fluidSpeechBubble-container">
                            <div class="fluidSpeechBubble">
                                <div class="fluidSpeechBubble-tl"></div>
                                <div class="fluidSpeechBubble-tr"></div>
                                <div class="fluidSpeechBubble-tc"></div>
                                <div class="fluidSpeechBubble-ml"></div>
                                <div class="fluidSpeechBubble-mr"></div>
                                <div class="fluidSpeechBubble-mc"></div>
                                <div class="fluidSpeechBubble-bl"></div>
                                <div class="fluidSpeechBubble-br"></div>
                                <div class="fluidSpeechBubble-bc"></div>
                                <div class="speechArrowBack"></div>
                                <div class="fluidSpeechBubble-contents cf"><h5>مجموع تولیدات:</h5>
                                    <table cellspacing="0" cellpadding="0" class="row_table_data">
                                        <tbody>
                                        <tr class="inactive">
                                            <td>آسیاب سطح<?php echo $sawmill; ?> :</td>
                                            <td class="numberCell"><?php if (isset($perc)) {
                                                    echo $perc;
                                                } else {
                                                    echo '0';
                                                } ?>%
                                            </td>
                                        </tr>
                                        <tr class="inactive">
                                            <td>نانوایی سطح <?php echo $bakery; ?> :</td>
                                            <td class="numberCell"><?php if (isset($perc2)) {
                                                    echo $perc2;
                                                } else {
                                                    echo '0';
                                                } ?>%
                                            </td>
                                        </tr>
                                        <tr class="inactive">
                                            <td>آبادی (&times;<?php echo $abadi; ?>)</td>
                                            <td class="numberCell">&#8206;<?php echo $abadi; ?>%</td>
                                        </tr>
                                        <tr>
                                            <td class="bold">مجوع جایزه</td>
                                            <td class="bold numberCell">
                                                &#8206;<?php echo $bonus_total = $abadi + $perc + $perc2; ?>%
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="total productionContainer">
                    <div class="productionPerHourTotal">
                        <h4><?php echo VL_PRODPERHR;?>:</h4>
                        <table cellspacing="0" cellpadding="0" class="row_table_data">
                            <tbody>
                            <tr>
                                <td>تولیدات</td>
                                <td class="numberCell"><?php echo $total_wood_product; ?></td>
                            </tr>
                            <tr>
                                <td>جایزه</td>
                                <td class="numberCell"><?php echo $bonus_total; ?>%</td>
                            </tr>
                            <tr>
                                <td>تولیدات قعرمان</td>
                                <td class="numberCell"><?php echo $total_hwood + $hproduct; ?></td>
                            </tr>
                            <tr class="subtotal">
                                <td class="bold">تعادل فعلی =</td>
                                <td class="numberCell bold">~</td>
                            </tr>

                            <tr class="inactive">
                                <td>&#8206;+25% تولیدات <?php if ($player['b3'] < $_SERVER['REQUEST_TIME']) {
                                        echo "(inactive)";
                                        $plus_pro = 0;
                                    } else {
                                        $plus_pro = (($total_wood_product) * 25 / 100);
                                    }
                                    ?></td>
                                <td class="numberCell"><?php echo round($plus_pro); ?></td>
                            </tr>
                            <tr class="total bold">
                                <td class="bold">مجموع</td>
                                <td class="numberCell bold">
                                    <?php
                                        echo round($wood);
                                    ?></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <?php if ($player['b3'] < $_SERVER['REQUEST_TIME']) { ?>
                        <div class="productionBoostResourceSpeechBubble">
                            <div class="fluidSpeechBubble-container">
                                <div class="fluidSpeechBubble">
                                    <div class="fluidSpeechBubble-tl"></div>
                                    <div class="fluidSpeechBubble-tr"></div>
                                    <div class="fluidSpeechBubble-tc"></div>
                                    <div class="fluidSpeechBubble-ml"></div>
                                    <div class="fluidSpeechBubble-mr"></div>
                                    <div class="fluidSpeechBubble-mc"></div>
                                    <div class="fluidSpeechBubble-bl"></div>
                                    <div class="fluidSpeechBubble-br"></div>
                                    <div class="fluidSpeechBubble-bc"></div>
                                    <div class="speechArrowBack"></div>
                                    <div class="fluidSpeechBubble-contents cf">
                                        <form id="fluidSpeechBubble" method="post" action="">
                                            <p>Hourly production including production bonus: <span class="bold"></span>
                                            </p>

                                            <div>
                                                <button type="button" value="Activate now" id="button5280fc11512da"
                                                        class="gold prosButton productionboostWood"
                                                        title="Activate Now||Bonus Duration in Days : <span class='bold'>7</span>"
                                                        coins="5">
                                                    <div class="button-container addHoverClick">
                                                        <div class="button-background">
                                                            <div class="buttonStart">
                                                                <div class="buttonEnd">
                                                                    <div class="buttonMiddle"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="button-content">Activate Now<img src="img/x.gif"
                                                                                                     class="goldIcon"
                                                                                                     alt=""/><span
                                                                class="goldValue">5</span></div>
                                                    </div>
                                                </button>
                                                <script type="text/javascript">
                                                    window.addEvent('domready', function () {
                                                        if ($('button5280fc11512da')) {
                                                            $('button5280fc11512da').addEvent('click', function () {
                                                                window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Activate now", "name": "", "id": "button5280fc11512da", "class": "gold prosButton productionboostWood", "title": "Activate now\u0026lt;br \/\u0026gt;Bonus duration in days: \u0026lt;span class=\u0026quot;bold\u0026quot;\u0026gt;7\u0026lt;\/span\u0026gt;", "confirm": "", "onclick": "", "coins": 5, "wayOfPayment": {"featureKey": "productionboostWood", "context": "production"}}]);
                                                            });
                                                        }
                                                    });
                                                </script>
                                            </div>
                                            <div class="productionBoostSpeechBubbleFurtherInfo">
                                                <p>* The production bonus increases the production of the resource in
                                                    <span class="underlined"> All </span>your villages.</p>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
									            <?php
            } elseif ($_GET['t'] == 5) {
                echo "soon...";
            } elseif ($_GET['t'] == 5123123123123123123) {
                ?>
                <div class="cropBalanceContainer">
                <div class="productionBoostSpeechBubble">
                    <div class="productionBoostResourceSpeechBubble">
                        <div class="fluidSpeechBubble-container">
                            <div class="fluidSpeechBubble">
                                <div class="fluidSpeechBubble-tl"></div>
                                <div class="fluidSpeechBubble-tr"></div>
                                <div class="fluidSpeechBubble-tc"></div>
                                <div class="fluidSpeechBubble-ml"></div>
                                <div class="fluidSpeechBubble-mr"></div>
                                <div class="fluidSpeechBubble-mc"></div>
                                <div class="fluidSpeechBubble-bl"></div>
                                <div class="fluidSpeechBubble-br"></div>
                                <div class="fluidSpeechBubble-bc"></div>
                                <div class="speechArrowBack"></div>
                                <div class="fluidSpeechBubble-contents cf">
                                    <form id="fluidSpeechBubble" method="post" action="">
                                        <p>Hourly production including production bonus: <span class="bold">79</span>
                                        </p>

                                        <div>
                                            <button type="button" value="Activate now" id="button528f7ab6b6a42"
                                                    class="gold prosButton productionboostCrop"
                                                    title="Activate now&lt;br /&gt;Bonus duration in days: &lt;span class=&quot;bold&quot;&gt;3&lt;/span&gt;"
                                                    coins="5">
                                                <div class="button-container addHoverClick">
                                                    <div class="button-background">
                                                        <div class="buttonStart">
                                                            <div class="buttonEnd">
                                                                <div class="buttonMiddle"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="button-content">Activate now<img src="img/x.gif"
                                                                                                 class="goldIcon"
                                                                                                 alt=""/><span
                                                            class="goldValue">5</span></div>
                                                </div>
                                            </button>
                                            <script type="text/javascript">
                                                window.addEvent('domready', function () {
                                                    if ($('button528f7ab6b6a42')) {
                                                        $('button528f7ab6b6a42').addEvent('click', function () {
                                                            window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Activate now", "name": "", "id": "button528f7ab6b6a42", "class": "gold prosButton productionboostCrop", "title": "Activate now\u0026lt;br \/\u0026gt;Bonus duration in days: \u0026lt;span class=\u0026quot;bold\u0026quot;\u0026gt;3\u0026lt;\/span\u0026gt;", "confirm": "", "onclick": "", "coins": 5, "wayOfPayment": {"featureKey": "productionboostCrop", "context": "production"}}]);
                                                        });
                                                    }
                                                });
                                            </script>
                                        </div>
                                        <div class="productionBoostSpeechBubbleFurtherInfo">
                                            <p>The production bonus increases the production of the resource in <span
                                                    class="underlined">all</span> your villages.</p>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="balanceCropBalancePart">
                    <table cellspacing="0" cellpadding="0" class="row_table_data">
                        <tbody>
                        <tr>
                            <td>Production of buildings and oases</td>
                            <td class="numberCell"><?php echo round($village->acrop); ?></td>
                        </tr>
                        <tr>
                            <td>Population and construction orders</td>
                            <td class="numberCell"><?php echo $village->allcrop; ?></td>
                        </tr>
                        <tr class="subtotal">
                            <td class="bold">Free crop</td>
                            <td class="bold numberCell"><?php echo $village->getProd('crop'); ?></td>
                        </tr>
                        <tr>
                            <td>Incomplete construction orders</td>
                            <td class="numberCell">0</td>
                        </tr>
                        <tr>
                            <td>Hero production</td>
                            <td class="numberCell">
                                <?php
                                    $heroData = $database->getHeroField($session->uid);
                                    $hproduct = $heroData['r0'] * 3 * SPEED * $heroData['product'];
                                    $total_hwood = $heroData['r1'] * 10 * SPEED * $heroData['product'];
                                    echo $total_hwood + $hproduct;
                                ?>
                            </td>
                        </tr>
                        <tr class="inactive">
                            <td>&#8206;&#x202d;&#43;&#x202d;25&#x202c;&#37;&#x202c;&#8206; production (inactive)</td>
                            <td class="numberCell"> <?php if ($player['b3'] < $_SERVER['REQUEST_TIME']) {
                                    echo "(0)";
                                    $plus_pro = 0;
                                } else {
                                    $plus_pro = (($total_wood_product) * 25 / 100);
                                }?></td>
                        </tr>
                        <tr class="subtotal">
                            <td class="bold">Interim balance =</td>
                            <td class="bold numberCell">40</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="balanceCropBalancePart balanceTroops">
                    <div class="boxes boxesColor gray">
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
                            <div class="switchDown  " id="ownBalanceTroops">
                                <div class="switchDownCloseStateContainer ">
                                    <div class="switchClosed headline">Consumption of own troops</div>
                                    <div class="switchDownContent">
                                        <span class="bold">&#8206;&#x202d;&#45;&#x202d;6&#x202c;&#x202c;&#8206;</span></div>
                                    <div class="clear"></div>
                                </div>
                                <div class="switchDownOpenStateContainer hide">
                                    <div class="switchOpened headline">Consumption of own troops</div>
                                    <div class="clear"></div>
                                    <div class="switchDownContent">
                                        <table>
                                            <tbody>
                                            <tr>
                                                <td class="troopLabel">- in village</td>
                                                <td class="numberCell">&#8206;&#x202d;&#45;&#x202d;6&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr>
                                                <td class="troopLabel">- in oasis</td>
                                                <td class="numberCell">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr>
                                                <td class="troopLabel">- on the way</td>
                                                <td class="numberCell">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr>
                                                <td class="troopLabel">- imprisoned</td>
                                                <td class="numberCell">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr class=" inactive">
                                                <td class="troopLabel">Artefact bonus</td>
                                                <td class="numberCell">0</td>
                                            </tr>
                                            <tr class=" inactive">
                                                <td class="troopLabel">Horse Drinking Trough</td>
                                                <td class="numberCell">0</td>
                                            </tr>
                                            <tr class="subtotal">
                                                <td class="bold">Sum</td>
                                                <td class="numberCell bold">&#8206;&#x202d;&#45;&#x202d;6&#x202c;&#x202c;&#8206;
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                            <script type="text/javascript">
                                window.addEvent('domready', function () {
                                    $$('#ownBalanceTroops').each(function (element) {
                                        new Travian.Game.SwitchDown(element);
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <div class="balanceCropBalancePart balanceTroops">
                    <div class="boxes boxesColor gray">
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
                            <div class="switchDown  " id="foraignBalanceTroops">
                                <div class="switchDownCloseStateContainer ">
                                    <div class="switchClosed headline">Consumption of foreign troops</div>
                                    <div class="switchDownContent">
                                        <span class="bold">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</span></div>
                                    <div class="clear"></div>
                                </div>
                                <div class="switchDownOpenStateContainer hide">
                                    <div class="switchOpened headline">Consumption of foreign troops</div>
                                    <div class="clear"></div>
                                    <div class="switchDownContent">
                                        <table>
                                            <tbody>
                                            <tr>
                                                <td class="troopLabel">- in village</td>
                                                <td class="numberCell">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr>
                                                <td class="troopLabel">- in oasis</td>
                                                <td class="numberCell">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            <tr class=" inactive">
                                                <td class="troopLabel">Artefact bonus</td>
                                                <td class="numberCell">0</td>
                                            </tr>
                                            <tr class=" inactive">
                                                <td class="troopLabel">Horse Drinking Trough</td>
                                                <td class="numberCell">0</td>
                                            </tr>
                                            <tr class="subtotal">
                                                <td class="bold">Sum</td>
                                                <td class="numberCell bold">&#8206;&#x202d;&#x202d;0&#x202c;&#x202c;&#8206;</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                            <script type="text/javascript">
                                window.addEvent('domready', function () {
                                    $$('#foraignBalanceTroops').each(function (element) {
                                        new Travian.Game.SwitchDown(element);
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <div class="balanceCropBalancePart">
                    <table cellspacing="0" cellpadding="0" class="row_table_data">
                        <tbody>
                        <tr class="total">
                            <td class="bold">Crop balance =</td>
                            <td class="bold numberCell">&#8206;&#x202d;&#x202d;34&#x202c;&#x202c;&#8206;</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                </div>
            <?php } ?>
<div class="clear"></div>
</div>
<div class="clear">&nbsp;</div>
</div>
<div class="contentFooter"></div>
</div>
<div id="sidebarAfterContent" class="sidebar afterContent">
    <div id="sidebarBoxActiveVillage" class="sidebarBox ">
        <div class="sidebarBoxBaseBox">
            <div class="baseBox baseBoxTop">
                <div class="baseBox baseBoxBottom">
                    <div class="baseBox baseBoxCenter"></div>
                </div>
            </div>
        </div>
        <?php include 'Templates/sideinfo.tpl'; ?>
    </div>
    <?php
        include 'Templates/multivillage.tpl';
        include 'Templates/quest.tpl';
    ?>
</div>
<div class="clear"></div>
&#65279;<?php
    include 'Templates/footer.tpl';
?>
</div>
<div id="ce"></div>
</div>
</body>
</html>