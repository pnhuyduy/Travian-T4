<?php
    if ($village->resarray['f' . $id] > 20 && $id != 99) {
        $ids = 'f' . $id;
        mysql_query("UPDATE " . TB_PREFIX . "fdata SET $ids = 20 WHERE vref=" . $village->wid);
    }
    $bindicate = $building->canBuild($id, $village->resarray['f' . $id . 't']);
    if ($bindicate == 1) {
        echo "<p><span class=\"none\"><b>" . constant('B' . $village->resarray['f' . $id . 't']) . " " . BL_COMPLETELYUPGRADED . "</b></span></p>";
    } else if ($bindicate == 10) {
        echo "<p><span class=\"none\"><b>" . constant('B' . $village->resarray['f' . $id . 't']) . ' ' . BL_GONNAFULLUPGRADED . " </b></span></p>";
    } else if ($bindicate == 11) {
        echo "<p><span class=\"none\"><b>" . constant('B' . $village->resarray['f' . $id . 't']) . " " . BL_UNDERDEMOLISH . " </b></span></p>";
    } else {
        $loopsame = $building->isCurrent($id) ? 1 : 0;
        $doublebuild = 0;
        if ($loopsame > 0 && $building->isLoop($id)) {
            $doublebuild = 1;
        }
        $uprequire = $building->resourceRequired($id, $village->resarray['f' . $id . 't'], ($loopsame > 0 ? 2 : 1) + $doublebuild);
        ?>
        <div id="contract" class="contractWrapper">
        <div
            class="contractText"><?php echo sprintf(BL_UPGRADECOST, ($village->resarray['f' . $id] + ($loopsame > 0 ? 2 : 1) + $doublebuild)); ?>
            :
        </div>
        <div class="contractCosts">
            <div class="showCosts">
                <span class="resources r1"><img class="r1" src="img/x.gif"
                                                title="<?php echo VL_WOOD; ?>"><?php echo $uprequire['wood']; ?></span>
                <span class="resources r2"><img class="r2" src="img/x.gif"
                                                title="<?php echo VL_CLAY; ?>"><?php echo $uprequire['clay']; ?></span>
                <span class="resources r3"><img class="r3" src="img/x.gif"
                                                title="<?php echo VL_IRON; ?>"><?php echo $uprequire['iron']; ?></span>
                <span class="resources r4"><img class="r4" src="img/x.gif"
                                                title="<?php echo VL_CROP; ?>"><?php echo $uprequire['crop']; ?></span>
                <span class="resources r5"><img class="r5" src="img/x.gif"
                                                title="<?php echo VL_UPKEEP; ?>"><?php echo $uprequire['pop']; ?></span>

                <div class="clear"></div>
<span class="clocks">
<img class="clock" src="img/x.gif" title="<?php echo AT_DURATION; ?>">
    <?php
        echo $generator->getTimeFormat($uprequire['time']);

        $wood = round($village->awood);
        $clay = round($village->aclay);
        $iron = round($village->airon);
        $crop = round($village->acrop);

        $totalres = $uprequire['wood'] + $uprequire['clay'] + $uprequire['iron'] + $uprequire['crop'];
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
                echo "&nbsp;&nbsp;<button " . $disable . " type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?gid=17&t=3&r1=" . $uprequire['wood'] . "&r2=" . $uprequire['clay'] . "&r3=" . $uprequire['iron'] . "&r4=" . $uprequire['crop'] . "'; return false;\"><img src=\"img/x.gif\" class=\"" . $style . "\" alt=\"NPC\"></button>";
            }

        }
    ?></span>

                <div class="clear"></div>
            </div>
        </div>
        <?php
        if ($bindicate == 20) {
            echo "<span class=\"none\">" . BL_WW_LACK . "</span>";
        } else if ($bindicate == 21) {
            echo "<span class=\"none\">" . BL_OWNERWWB_LACK . "</span>";
        } else if ($bindicate == 22) {
            echo "<span class=\"none\">" . BL_ALLYWWB_LACK . "</span>";
        } elseif ($bindicate == 2 || $bindicate == 3) {
            echo "<span class=\"none\">" . BL_FULLQUE . "</span>";
        } else if ($bindicate == 4) {
            echo "<span class=\"none\">" . BL_FOODSHORTAGE . "</span>";
        } else if ($bindicate == 5) {
            echo "<span class=\"none\">" . BL_UPGRADEWAREHOUSE . "</span>";
        } else if ($bindicate == 6) {
            echo "<span class=\"none\">" . BL_UPGRADEGRANARY . "</span>";
        } else if ($bindicate == 7) {
            $neededtime = $building->calculateAvaliable($id, $village->resarray['f' . $id . 't'], ($loopsame > 0 ? 2 : 1));
            echo "<span class=\"none\">" . BL_ENOUGHRESOURCEAT . ": " . $neededtime[1] . "</span>";
        } else if ($bindicate == 8) {
            if ($id <= 18) {
                echo "<button type=\"button\" value=\"Upgrade level\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf1.php?a=$id&c=$session->checker'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_UPGRADETO . ' ';
            } else {
                echo "<button type=\"button\" value=\"Upgrade level\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf2.php?a=$id&c=$session->checker'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_UPGRADETO . ' ';
            }
            echo $village->resarray['f' . $id] + 1;
            echo " </div></div></button>";
        } else if ($bindicate == 9) {
            if ($id <= 18) {
                echo "<button type=\"button\" value=\"Upgrade level\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf1.php?a=$id&c=$session->checker'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_UPGRADETO . ' ';
            } else {
                echo "<button type=\"button\" value=\"Upgrade level\" name=\"archive\" id=\"archive\" class=\"green \" onclick=\"window.location.href = 'dorf2.php?a=$id&c=$session->checker'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_UPGRADETO . ' ';
            }
            echo $village->resarray['f' . $id] + ($loopsame > 0 ? 2 : 1);
            echo "</div></div></button> <span class=\"none\">(" . BL_LOOP . ")</span></div>";
        }

        if ($session->userinfo['gold'] < g_level20) {
            $style = "";
            $disable = "disabled=\"disabled\"";
            $class = "gold ";
            $title = "You Dont Have Enough Gold";
        } else {
            $style = "onclick=\"window.location.href = 'dorf1.php?a=$id&c=$session->checker&ins'; return false;\"";
            $class = "green ";
            $title = "( Cost: " . g_level20 . " Travian Gold )";
            $disable = "";
        }

        echo "<button " . $disable . " type=\"button\" value=\"Upgrade level2\" name=\"archive2\" id=\"archive2\" title=\"Attention||".$title."\" class=\"".$class." build\" " . $style . ">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . BL_UPGRADETO . ' 20 ';
        echo "</div></div></button><br /><br />";
        echo "</div>";
    }

?>