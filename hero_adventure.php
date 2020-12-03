<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Village.php");

    $winner = $database->hasWinner();
    if ($winner) {
        header("Location: winner.php");
        die;
    }
    if ($session->access < 2) {
        header("Location: banned.php");
        die;
    }
    $start = $generator->pageLoadTimeStart();
    $herodetail = $database->getHero($session->uid);
    include "Templates/html.tpl";
?>
<body class="v35 gecko hero hero_adventure perspectiveBuildings">
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
            <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="Close">&nbsp;</a>
            <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/" target="_blank"
               title="Travian Answe4rs">&nbsp;</a>
        </div>
        <div class="contentContainer">
            <div id="content" class="hero_adventure">
                <h1 class="titleInHeader"><h1 class="titleInHeader"><?php echo U0; ?></h1>

                    <div class="contentNavi subNavi">
                        <div class="container normal">
                            <div class="background-start">&nbsp;</div>
                            <div class="background-end">&nbsp;</div>
                            <div class="content"><a href="hero_inventory.php"><span
                                        class="tabItem"><?php echo HERO_HEROATTRIBUTES; ?></span></a></div>
                        </div>
                        <div class="container normal">
                            <div class="background-start">&nbsp;</div>
                            <div class="background-end">&nbsp;</div>
                            <div class="content"><a href="hero.php"><span
                                        class="tabItem"><?php echo HERO_HEROAPPEARANCE; ?></span></a></div>
                        </div>
                        <div class="container active">
                            <div class="background-start">&nbsp;</div>
                            <div class="background-end">&nbsp;</div>
                            <div class="content"><a href="hero_adventure.php"><span
                                        class="tabItem"><?php echo HERO_HEROADVENTURE; ?></span></a></div>
                        </div>
                        <div class="container normal">
                            <div class="background-start">&nbsp;</div>
                            <div class="background-end">&nbsp;</div>
                            <div class="content"><a href="hero_auction.php"><span
                                        class="tabItem"><?php echo HERO_HEROAUCTION; ?></span></a></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <script type="text/javascript">
                        window.addEvent('domready', function () {
                            $$('.subNavi').each(function (element) {
                                new Travian.Game.Menu(element);
                            });
                        });
                    </script>
                    <table cellspacing="1" cellpadding="1">
                        <thead>
                        <tr>

                            <th colspan="6"> &#1606;&#1740;&#1575;&#1586; &#1576;&#1607; &#1605;&#1575;&#1580;&#1585;&#1575;&#1580;&#1608;&#1740;&#1740; &#1576;&#1740;&#1588;&#1578;&#1585; &#1583;&#1575;&#1585;&#1740;&#1583;&#1567; &#1607;&#1605;&#1740;&#1606; &#1575;&#1604;&#1575;&#1606; &#1582;&#1585;&#1740;&#1583;&#1575;&#1585;&#1740; &#1605;&#1740;&#1705;&#1606;&#1740;&#1583;&#1567;
                                <button type="button" value="activate" id="button459713248zSadvpw"
                                        class="gold prosButton buyAdventure">
                                    <div class="button-container addHoverClick ">
                                        <div class="button-background">
                                            <div class="buttonStart">
                                                <div class="buttonEnd">
                                                    <div class="buttonMiddle"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-content">&#1607;&#1586;&#1740;&#1606;&#1607; &#1582;&#1585;&#1740;&#1583;<img src="img/x.gif" class="goldIcon" alt=""><span
                                                class="goldValue">1</span></div>
                                    </div>
                                </button>
                                <script type="text/javascript">
                                    window.addEvent('domready', function () {
                                        if ($('button459713248zSadvpw')) {
                                            $('button459713248zSadvpw').addEvent('click', function () {
                                                window.fireEvent('buttonClicked', [this, {"type": "button", "value": "<?php echo HR_BUYNOW;?>", "name": "", "id": "button459713248zSadvpw", "class": "gold productionBoostButton", "title": "<?php echo HR_BUYNOW;?>", "confirm": "", "onclick": "", "adventureBuyDialog": {"infoIcon": "http:\/\/t4.answers.travian.com.sa\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}}]);
                                            });
                                        }
                                    });
                                </script>
                            </th>
                        </tr>
                        <tr>
                            <th class="location" colspan="2"><?php echo AT_LOCATION; ?></th>
                            <th class="moveTime"><?php echo BL_TIME; ?></th>
                            <th class="difficulty">&#1587;&#1582;&#1578;&#1740;</th>
                            <th class="timeLeft">&#1586;&#1605;&#1575;&#1606; &#1576;&#1575;&#1602;&#1740;&#1605;&#1575;&#1606;&#1583;&#1607;</th>
                            <th class="goTo">&#1604;&#1740;&#1606;&#1705;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                            $sql = mysql_query("SELECT `wref`,`dif`,`time` FROM " . TB_PREFIX . "adventure WHERE end = 0 and uid = " . $session->uid . " ORDER BY time ASC");
                            $query = mysql_num_rows($sql);

                            $outputList = '';

                            if ($query == 0) {
                                $outputList .= "<td colspan=\"6\" class=\"none\"><center>".HR_NOADVFOUND."</center></td>";
                            } else {
                                while ($row = mysql_fetch_array($sql)) {
                                    include "Templates/Auction/alt.tpl";

                                    //find slowest unit.
                                    $eigen = $database->getCoor($herodetail['wref']);
                                    $coor = $database->getCoor($row['wref']);
                                    $from = array('x' => $eigen['x'], 'y' => $eigen['y']);
                                    $to = array('x' => $coor['x'], 'y' => $coor['y']);
                                    $speed = $herodetail['speed'] + $herodetail['itemspeed'];
                                    $time = $generator->procDistanceTime($from, $to, $speed, 1);

                                    $isoasis = $database->isVillageOases($row['wref']);
                                    if ($isoasis) {
                                        $get = $database->getOMInfo($row['wref']);
                                        $type = $get['type'];
                                    } else {
                                        $get = $database->getMInfo($row['wref']);
                                        $type = $get['fieldtype'];
                                    }
                                    switch ($type) {
                                        case 1:
                                        case 2:
                                        case 3:
                                            $tname = MP_FOREST;
                                            break;
                                        case 4:
                                        case 5:
                                        case 6:
                                            $tname = MP_FIELD;
                                            break;
                                        case 7:
                                        case 8:
                                        case 9:
                                            $tname = MP_MOUNTAIN;
                                            break;
                                        case 10:
                                        case 11:
                                        case 12:
                                            $tname = MP_SEA;
                                            break;
                                    }

                                    $outputList .= "<tr><td class=\"location\">" . $tname . "</td>";

                                    $outputList .= '<td class="coords"><a href="karte.php?x=' . $coor['x'] . '&amp;y=' . $coor['y'] . '">';
                                    if (DIRECTION == 'ltr') {
                                        $outputList .= '<span class="coordinates coordinatesAligned"><span class="coordinateX">(' . $coor['x'] . '</span><span class="coordinatePipe">|</span><span class="coordinateY">' . $coor['y'] . ')</span>';
                                    } elseif (DIRECTION == 'rtl') {
                                        $outputList .= '<span class="coordinates coordinatesAligned"><span class="coordinateY">' . $coor['y'] . ')</span><span class="coordinatePipe">|</span><span class="coordinateX">(' . $coor['x'] . '</span>';
                                    }
                                    $outputList .= '</span><span class="clear"></span></a></td>';
                                    $outputList .= "<td class=\"moveTime\"> " . $generator->getTimeFormat($time) . " </td>";
                                    if (!$row['dif']) {
                                        $outputList .= "<td class='difficulty'><img src='img/x.gif' class='adventureDifficulty2' title='".HR_NORMAL."' /></td>";
                                    } else {
                                        $outputList .= "<td class='difficulty'><img src='img/x.gif' class='adventureDifficulty0' title='".HR_HARD."' /></td>";
                                    }
                                    $outputList .= "<td class=\"timeLeft\"><span id=\"timer" . $timer . "\">" . $generator->getTimeFormat($row['time'] - $_SERVER['REQUEST_TIME']) . "</span></td>";
                                    $outputList .= "<td class=\"goTo\"><a class=\"gotoAdventure arrow\" href=\"a2b.php?id=" . $row['wref'] . "&h=1\">" . AT_STARTADV . "</a></td></tr>";
                                    $timer++;
                                }
                            }
                            echo $outputList;
                        ?>
                        </tbody>
                    </table>
                    <div class="clear">&nbsp;</div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="contentFooter">&nbsp;</div>
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