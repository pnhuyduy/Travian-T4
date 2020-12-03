<?php
    $fail = $success = 0;
    $acares = $technology->grabAcademyRes();
    $r2 = array('wood' => 700, 'clay' => 620, 'iron' => 1480, 'crop' => 580, 'time' => 7080);
    $r3 = array('wood' => 1000, 'clay' => 740, 'iron' => 1880, 'crop' => 640, 'time' => 7560);
    $r4 = array('wood' => 940, 'clay' => 740, 'iron' => 360, 'crop' => 400, 'time' => 5880);
    for ($i = 2; $i <= 9; $i++) {
        if ($technology->meetRRequirement($i) && !$technology->getTech($i) && !$technology->isResearch($i, 1)) {
            echo "<div class=\"build_details researches\">
        <div class=\"research\">
			<div class=\"bigUnitSection\">
				<a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $i . ",1);\">
					<img class=\"unitSection u" . $i . "Section\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($i) . "\">
				</a>
				<a href=\"#\" class=\"zoom\" onclick=\"return Travian.Game.unitZoom(" . $i . ");\">
					<img class=\"zoom\" src=\"img/x.gif\" alt=\"zoom in\">
				</a>
			</div>
			<div class=\"information\">
<div class=\"title\">
<a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $i . ",1);\">
<img class=\"unit u" . $i . "\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($i) . "\"></a>
<a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $i . ",1);\">" . $technology->getUnitName($i) . "</a>
</div>
<div class=\"costs\">
<div class=\"showCosts\">
                    <span class=\"resources r1 little_res\"><img class=\"r1\" src=\"img/x.gif\" alt=\"" . VL_WOOD . "\">" . ${'r' . $i}['wood'] . "</span>
                    <span class=\"resources r2 little_res\"><img class=\"r2\" src=\"img/x.gif\" alt=\"" . VL_CLAY . "\">" . ${'r' . $i}['clay'] . "</span>
                    <span class=\"resources r3 little_res\"><img class=\"r3\" src=\"img/x.gif\" alt=\"" . VL_IRON . "\">" . ${'r' . $i}['iron'] . "</span>
                    <span class=\"resources r4 little_res\"><img class=\"r4\" src=\"img/x.gif\" alt=\"" . VL_CROP . "\">" . ${'r' . $i}['crop'] . "</span>
                    <div class=\"clear\"></div>
                    <span class=\"clocks\"><img class=\"clock\" src=\"img/x.gif\" alt=\"" . AT_HRS . "\">";
            echo $generator->getTimeFormat(round(${'r' . $i}['time'] * ($bid22[$village->resarray['f' . $id]]['attri'] / 100) / SPEED));
            echo "</span>";
            if ($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) > 1) {
                echo "<button type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?gid=17&t=3&r1=" . ${'r' . $i}['wood'] . "&r2=" . ${'r' . $i}['clay'] . "&r3=" . ${'r' . $i}['iron'] . "&r4=" . ${'r' . $i}['crop'] . "'; return false;\"><img src=\"img/x.gif\" class=\"npc\" alt=\"npc\"></button>
                    <div class=\"clear\"></div>";
            }
            if (${'r' . $i}['wood'] > $village->maxstore || ${'r' . $i}['clay'] > $village->maxstore || ${'r' . $i}['iron'] > $village->maxstore) {
                echo "<br><div class=\"contractLink\"><span class=\"none\">" . BL_UPGRADEWAREHOUSE . "</span></div>
</div>
<div class=\"clear\">&nbsp;</div>
</div></div>";
                echo "<div class=\"clear\">&nbsp;</div></div></div>";
            } else if (${'r' . $i}['crop'] > $village->maxcrop) {
                echo "<br><div class=\"contractLink\"><span class=\"none\">" . BL_UPGRADEGRANARY . "</span></div>
</div>
<div class=\"clear\">&nbsp;</div>
</div></div>";
                echo "<div class=\"clear\">&nbsp;</div></div></div>";
            } else if (${'r' . $i}['wood'] > $village->awood || ${'r' . $i}['clay'] > $village->aclay || ${'r' . $i}['iron'] > $village->airon || ${'r' . $i}['crop'] > $village->acrop) {
                $time = $technology->calculateAvaliable(22, ${'r' . $i});
                echo "<br><div class=\"contractLink\"><span class=\"none\">" . sprintf(BL_NORESAV_AVON, '' . $time[1] . '') . "</span></div>
</div>
<div class=\"clear\"></div>
</div></div>";
                echo "<div class=\"clear\">&nbsp;</div></div></div>";
            } else if (count($acares) > 0) {
                echo "<br><div class=\"contractLink\"><span class=\"none\">
					" . UN_RESINPROC . "</span></div></div></div></div>
                    <div class=\"clear\">&nbsp;</div>
                    </div></div>";
            } else {
                echo "<button type=\"submit\" value=\"button\" class=\"green build\" onclick=\"window.location.href = 'build.php?id=$id&amp;a=$i&amp;c=" . $session->mchecker . "'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . UN_RESEARCH . "</div></div></button></div>
</div>
<div class=\"clear\">&nbsp;</div>
</div></div><div class=\"clear\">&nbsp;</div></div>";
            }
            $success += 1;
        } else {
            $fail += 1;
        }
    }
    if ($success == 0) {
        echo "<div class=\"buildActionOverview trainUnits\"><td colspan=\"2\"><div class=\"none\" align=\"center\">" . UN_NORESEARCHAVAILABLE . "</div></td></div>";
    }

    if ($fail > 0) {
        echo "<p class=\"switch\"><a class=\"openedClosedSwitch switchOpened\" id=\"researchFutureLink\" href=\"#\" onclick=\"return $('researchFuture').toggle();\">" . UN_MORE . "</a></p>
    <div id=\"researchFuture\" class=\"researches hide \">";
        for ($uc = 2; $uc <= 9; $uc++) {
            if (!$technology->meetRRequirement($uc) && !$technology->getTech($uc)) {
                echo "<div class=\"research\"><div class=\"bigUnitSection\"><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\"><img class=\"unitSection u" . $uc . "Section\" src=\"img/x.gif\" alt=\"" . constant('U' . $uc) . "\"></a><a href=\"#\" class=\"zoom\" onclick=\"return Travian.Game.unitZoom(" . $uc . ");\"><img class=\"zoom\" src=\"img/x.gif\" alt=\"zoom in\"></a></div><div class=\"information\"><div class=\"title\"><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\"><img class=\"unit u" . $uc . "\" src=\"img/x.gif\" alt=\"" . constant('U' . $uc) . "\"></a><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\">" . constant('U' . $uc) . "</a></div><div class=\"costs\"><div class=\"showCosts\"><span class=\"resources r1 little_res\"><img class=\"r1\" src=\"img/x.gif\" alt=\"" . VL_WOOD . "\">" . ${'r' . $uc}['wood'] . "</span><span class=\"resources r2 little_res\"><img class=\"r2\" src=\"img/x.gif\" alt=\"" . VL_CLAY . "\">" . ${'r' . $uc}['clay'] . "</span><span class=\"resources r3 little_res\"><img class=\"r3\" src=\"img/x.gif\" alt=\"" . VL_IRON . "\">" . ${'r' . $uc}['iron'] . "</span><span class=\"resources r4 little_res\"><img class=\"r4\" src=\"img/x.gif\" alt=\"" . VL_CROP . "\">" . ${'r' . $uc}['crop'] . "</span><div class=\"clear\"></div><span class=\"clocks\"><img class=\"clock\" src=\"img/x.gif\" alt=\"" . AT_HRS . "\">";
                echo $generator->getTimeFormat(round(${'r' . $uc}['time'] * ($bid22[$village->resarray['f' . $id]]['attri'] / 100) / SPEED));
                switch ($uc) {
                    case 2:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 1</span>, <a href=\"#\"> " . B13 . " </a><span class=\"level\"> " . BL_LVL . " 1</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 3:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 5</span>, <a href=\"#\"> " . B13 . " </a><span class=\"level\"> " . BL_LVL . " 1</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 4:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 5</span>, <a href=\"#\"> " . B20 . " </a><span class=\"level\"> " . BL_LVL . " 1</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 5:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 5</span>, <a href=\"#\"> " . B20 . " </a><span class=\"level\"> " . BL_LVL . " 5</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 6:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 5</span>, <a href=\"#\"> " . B20 . " </a><span class=\"level\"> " . BL_LVL . " 10</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 7:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 10</span>, <a href=\"#\"> " . B21 . " </a><span class=\"level\"> " . BL_LVL . " 1</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 8:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 15</span>, <a href=\"#\"> " . B21 . " </a><span class=\"level\"> " . BL_LVL . " 10</span></div></div><div class=\"clear\"></div></div><hr>";
                        break;
                    case 9:
                        echo "</span><div class=\"clear\"></div></div></div><div class=\"contractLink\"><a href=\"#\">" . B22 . "</a><span class=\"level\"> " . BL_LVL . " 20</span>, <a href=\"#\"> " . B16 . " </a><span class=\"level\"> " . BL_LVL . " 10</span></div></div><div class=\"clear\"></div></div>";
                        break;
                }
            }
        }
        ?>
        <script type="text/javascript">
            //<![CDATA[
            $("researchFuture").toggle = (function () {
                this.toggleClass("hide");

                $("researchFutureLink").set("text",
                    this.hasClass("hide")
                        ? "Továbbiak"
                        : "Close More"
                );

                return false;
            }).bind($("researchFuture"));
            //]]>
        </script>
        <?php
        echo "<div class=\"clear\"></div></div>";
    }

    if (count($acares) > 0) {
        echo "<table cellpadding=\"1\" cellspacing=\"1\" class=\"under_progress\"><thead><tr><td>" . UN_TRAIN . "</td><td>" . AT_DURATION . "</td><td>" . AT_FINISH . "</td></tr>
	</thead><tbody>";
        //$timer = 1;
        foreach ($acares as $aca) {
            $unit = substr($aca['tech'], 1, 2);
            echo "<tr><td class=\"desc\"><img class=\"unit u$unit\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($unit) . "\" title=\"" . $technology->getUnitName($unit) . "\" />" . $technology->getUnitName($unit) . "</td>";
            echo "<td class=\"dur\"><span id=\"timer$timer\">" . $generator->getTimeFormat($aca['timestamp'] - time()) . "</span></td>";
            $date = $generator->procMtime($aca['timestamp']);
            echo "<td class=\"fin\"><span>" . $date[1] . "</span><span>" . AT_HRS . "</span></td>";
            echo "</tr>";
            $timer += 1;
        }
        echo "</tbody></table>";
    }
?>