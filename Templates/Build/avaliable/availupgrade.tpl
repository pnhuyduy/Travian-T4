<?php
    $bid = $_GET['bid'];

    $bindicator = $building->canBuild($id, $bid);
    $uprequire = $building->resourceRequired($id, $bid);
    $crop = round($village->acrop);

    $bindicate = $building->canBuild($id, $village->resarray['f' . $id . 't']);

    if ($bindicate == 1) {
    echo "<p><span class=\"none\">" . BL_BUILDINGCOMPLETED . "</span></p>";
} else if ($bindicate == 10) {
    echo "<p><span class=\"none\">" . BL_BECOMMINGLASTLVL . "</span></p>";
} else if ($bindicate == 11) {
    echo "<p><span class=\"none\">" . BL_UNDERDEMOLISH . "</span></p>";
} else {
    $loopsame = $building->isCurrent($id) ? 1 : 0;
    if ($loopsame > 0 && $building->isLoop($id)) {
        $doublebuild = 1;
    }

?>
<div id="contract" class="contract contractNew contractWrapper">
    <div class="contractText">Cost:</div>
    <div class="contractCosts">
        <div class="showCosts">
            <span class="resources r1 little_res"><img class="r1" src="img/x.gif"
                                                       title="<?php echo VL_WOOD; ?>"><?php echo $uprequire['wood']; ?></span>
            <span class="resources r2 little_res"><img class="r2" src="img/x.gif"
                                                       title="<?php echo VL_CLAY; ?>"><?php echo $uprequire['clay']; ?></span>
            <span class="resources r3 little_res"><img class="r3" src="img/x.gif"
                                                       title="<?php echo VL_IRON; ?>"><?php echo $uprequire['iron']; ?></span>
            <span class="resources r4"><img class="r4" src="img/x.gif"
                                            title="<?php echo VL_CROP; ?>"><?php echo $uprequire['crop']; ?></span>
            <span class="resources r5"><img class="r5" src="img/x.gif"
                                            title="<?php echo VL_UPKEEP; ?>"><?php echo $uprequire['pop']; ?></span>

            <div class="clear"></div>
    <span class="clocks"><img class="clock" src="img/x.gif" title="<?php echo AT_DURATION; ?>">
        <?php
            echo $generator->getTimeFormat($uprequire['time']);
            echo "</span>";
            $totalres = $uprequire['wood'] + $uprequire['clay'] + $uprequire['iron'] + $uprequire['crop'];
            $wood = round($village->awood);
            $clay = round($village->aclay);
            $iron = round($village->airon);
            $crop = round($village->acrop);
            $availres = $wood + $clay + $iron + $crop;
            $disable = '';
            if ($session->userinfo['gold'] >= 3 && $availres >= $totalres) {
                $style = "npc";
            } else {
                $style = "npc_inactive";
                $disable = "disabled=\"disabled\"";
            }
            if ($session->plus) {
                if ($building->getTypeLevel(17) >= 1) {
                    echo "<button " . $disable . " type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?gid=17&t=3&r1=" . $uprequire['wood'] . "&r2=" . $uprequire['clay'] . "&r3=" . $uprequire['iron'] . "&r4=" . $uprequire['crop'] . "'; return false;\"><img src=\"img/x.gif\" class=\"" . $style . "\" alt=\"npc\"></button>";
                }
            } ?>
        <div class="clear"></div>
        </div>
    </div>
    <div class="contractLink">
        <?php
            if ($bindicator == 20) {
                echo "<span class=\"none\">" . BL_WW_LACK . "</span>";
            } else if ($bindicator == 21) {
                echo "<span class=\"none\">" . BL_OWNERWWB_LACK . "</span>";
            } else if ($bindicator == 22) {
                echo "<span class=\"none\">" . BL_ALLYWWB_LACK . "</span>";
            } elseif ($bindicator == 2 || $bindicator == 3) {
                echo "<span class=\"none\">" . BL_WORKERSATWORK . "</span>";
            } else if ($bindicator == 4) {
                echo "<span class=\"none\">" . BL_FOODSHORTAGE . "</span>";
            } else if ($bindicator == 5) {
                echo "<span class=\"none\">" . BL_UPGRADEWAREHOUSE . "</span>";
            } else if ($bindicator == 6) {
                echo "<span class=\"none\">" . BL_UPGRADEGRANARY . "</span>";
            } else if ($bindicator == 7) {
                $neededtime = $building->calculateAvaliable($id, $bid);
                echo "<span class=\"none\">Enough resources at " . $neededtime[1] . "</span>";
            } else if ($bindicator == 8) {
                echo "<button type=\"button\" value=\"" . BL_CONSTBUILD . "\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf2.php?a=$bid&id=$id&c=" . $session->checker . "'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_CONSTBUILD . "</div></div></button>";
            } else if ($bindicator == 9) {
                echo "<button type=\"button\" value=\"" . BL_CONSTBUILD . "\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf2.php?a=$bid&id=$id&c=" . $session->checker . "'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_CONSTBUILD . "</div></div></button> <span class=\"none\">" . BL_CONSTWITHMS . "</span>";
            } else {
                echo $bindicator;
            }
        }
        ?>
    </div>
    <div class="clear"></div>
</div>
