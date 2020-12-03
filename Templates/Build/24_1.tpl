<div class="clear"></div>
<?php
    $level = $village->resarray['f' . $id];
    $inuse = $database->getVillageField($village->wid, 'celebration');
    $time = Time();
    $i = 1;
    echo "
<div class=\"build_details researches\">
	<div class=\"research\">
		<div class=\"information\">
			<div class=\"title\">
                <a href=\"#\" onclick=\"return Travian.Game.iPopup(24,4);\">
                <img class=\"celebration celebrationSmall\" src=\"img/x.gif\" alt=\"" . BL_SMALLCELEBRATION . "\">
                </a>
                <a href=\"#\" onclick=\"return Travian.Game.iPopup(24,4);\">" . BL_SMALLCELEBRATION . "</a>
                <span class=\"points\">(500 " . BL_CULTUREPOINTS . ")</span>
            </div>
            <div class=\"costs\">
				<div class=\"showCosts\">
                    <span class=\"resources r1 little_res\"><img class=\"r1\" src=\"img/x.gif\" alt=\"" . VL_WOOD . "\">" . $cel[$i]['wood'] . "</span>
                    <span class=\"resources r2 little_res\"><img class=\"r2\" src=\"img/x.gif\" alt=\"" . VL_CLAY . "\">" . $cel[$i]['clay'] . "</span>
                    <span class=\"resources r3 little_res\"><img class=\"r3\" src=\"img/x.gif\" alt=\"" . VL_IRON . "\">" . $cel[$i]['iron'] . "</span>
                    <span class=\"resources r4 little_res\"><img class=\"r4\" src=\"img/x.gif\" alt=\"" . VL_CROP . "\">" . $cel[$i]['crop'] . "</span>
                    <div class=\"clear\"></div>
                    <span class=\"clocks\"><img class=\"clock\" src=\"img/x.gif\" alt=\"" . AT_HRS . "\">";
    echo $generator->getTimeFormat(round($cel[$i]['time'] * ($bid24[$building->getTypeLevel(24)]['attri'] / 100) / SPEED));
    echo "</span>";
    if ($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) >= 1) {
        echo "<button type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?gid=17&t=3&r1=" . $cel[$i]['wood'] . "&r2=" . $cel[$i]['clay'] . "&r3=" . $cel[$i]['iron'] . "&r4=" . $cel[$i]['crop'] . "'; return false;\"><img src=\"img/x.gif\" class=\"npc\" alt=\"npc\"></button>";
    }
    echo "<div class=\"clear\"></div>
                </div>
			</div>";
    if ($inuse > $time) {
        echo "<div class=\"contractLink\"><span class=\"none\">" . BL_PARTYON . "</span></div>";
    } else if ($cel[$i]['wood'] > $village->awood || $cel[$i]['clay'] > $village->aclay || $cel[$i]['iron'] > $village->airon || $cel[$i]['crop'] > $village->acrop) {
        if ($village->getProd("crop") > 0) {
            $time = $technology->calculateAvaliable(24, $cel[$i]);
            echo "<div class=\"contractLink\"><span class=\"none\">" . sprintf(BL_NORESAV_AVON, "" . $time[1] . "") . "</span></div>";
        } else {
            echo "<div class=\"contractLink\"><span class=\"none\">" . BL_NOWHEAT . "</span></div>";
        }
    } else {
        echo "<button type=\"submit\" value=\"button\" class=\"green build\" onclick=\"window.location.href = 'celebration.php?id=$id&type=$i'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">
                	" . BL_CELEBRATE . "</div>
						</div>
					</button>";
    }
    echo "</div><div class=\"clear\"></div></div></div>";
    if ($level >= 10) {
        $level = $village->resarray['f' . $id];
        $i = 2;
        echo "
<div class=\"build_details researches\">
<div class=\"research\">
<div class=\"information\">
<div class=\"title\">
<a href=\"#\" onclick=\"return Travian.Game.iPopup(24,4);\">
<img class=\"celebration celebrationSmall\" src=\"img/x.gif\" alt=\"" . BL_BIGCELEBRATION . "\">
</a>
<a href=\"#\" onclick=\"return Travian.Game.iPopup(24,4);\">" . BL_BIGCELEBRATION . "</a>
<span class=\"points\">(2000 " . BL_CULTUREPOINTS . ")</span>
</div>
<div class=\"costs\">
				<div class=\"showCosts\">
                <span class=\"resources r1 little_res\"><img class=\"r1\" src=\"img/x.gif\" alt=\"Fa\">" . $cel[$i]['wood'] . "</span>
                <span class=\"resources r2 little_res\"><img class=\"r2\" src=\"img/x.gif\" alt=\"Agyag\">" . $cel[$i]['clay'] . "</span>
                <span class=\"resources r3 little_res\"><img class=\"r3\" src=\"img/x.gif\" alt=\"Vasérc\">" . $cel[$i]['iron'] . "</span>
                <span class=\"resources r4 little_res\"><img class=\"r4\" src=\"img/x.gif\" alt=\"Búza\">" . $cel[$i]['crop'] . "</span>
                <div class=\"clear\"></div>
                <span class=\"clocks\"><img class=\"clock\" src=\"img/x.gif\" alt=\"Időtartam\">";
        echo $generator->getTimeFormat(round($cel[$i]['time'] * ($bid24[$building->getTypeLevel(24)]['attri'] / 100) / SPEED));
        echo "</span>";
        if ($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) >= 1) {
            echo "<button type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?gid=17&t=3&r1=" . $cel[$i]['wood'] . "&r2=" . $cel[$i]['clay'] . "&r3=" . $cel[$i]['iron'] . "&r4=" . $cel[$i]['crop'] . "'; return false;\"><img src=\"img/x.gif\" class=\"npc\" alt=\"npc\"></button>";
        }
        echo "<div class=\"clear\"></div>
                </div>
                </div>";
        if ($inuse > $time) {
            echo "<div class=\"contractLink\"><span class=\"none\">" . BL_PARTYON . "</span></div>";
        } else if ($cel[$i]['wood'] > $village->awood || $cel[$i]['clay'] > $village->aclay || $cel[$i]['iron'] > $village->airon || $cel[$i]['crop'] > $village->acrop) {
            if ($village->getProd("crop") > 0) {
                $time = $technology->calculateAvaliable(24, $cel[$i]);
                echo "<div class=\"contractLink\"><span class=\"none\">" . sprintf(BL_NORESAV_AVON, "" . $time[1] . "") . "</span></div>";
            } else {
                echo "<div class=\"contractLink\"><span class=\"none\">" . BL_NOWHEAT . "</span></div>";
            }
        } else {
            echo "<button type=\"submit\" value=\"button\" class=\"green build\" onclick=\"window.location.href = 'celebration.php?id=$id&type=$i'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_CELEBRATE . "</div></div></button>";
        }
        echo "</div><div class=\"clear\"></div></div></div>";
    }
?>