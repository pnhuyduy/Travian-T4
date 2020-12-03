<div class="clear"></div>
<?php

    if (isset($_REQUEST["cancel"]) && $_REQUEST["cancel"] == "1") {
        $database->delDemolition($village->wid);
    }

    if (isset($_REQUEST["demolish"]) && !empty($_REQUEST["demolish"]) && $_REQUEST["c"] == $session->mchecker) {
        if ($_REQUEST["type"] != null) {
            $type = $_REQUEST['type'];
            $database->addDemolition($village->wid, $type);
            $session->changeChecker();
        }
    }

    if ($village->resarray['f' . $id] >= DEMOLISH_LEVEL_REQ) {
        echo "<h4>" . BL_DEMOLISHBUILDING . ":</h4><p>" . BL_DEMOLISHBUILDINGDESC . ":</p>";
        $VillageResourceLevels = $database->getResourceLevel($village->wid);
        $DemolitionProgress = $database->getDemolition($village->wid);
        if (!empty($DemolitionProgress)) {
            $Demolition = $DemolitionProgress[0];
            echo " <table cellpadding='1' cellspacing='1' id='demolish'><tbody><tr>
		<td><a href='build.php?id=26&cancel=1'><img class='del' src='img/x.gif' title='cancel' alt='cancel'></a></td><td>
		<b>" . constant('B' . $VillageResourceLevels['f' . $Demolition['buildnumber'] . 't']) . "</b></td><td><span id='timer$timer'>" . $generator->getTimeFormat($Demolition['timetofinish'] - time()) . "</span></td>
		</tr></tbody></table>";
            $timer++;
        } else {
            echo "
		<form action=\"build.php?gid=15&amp;demolish=1&amp;cancel=0&amp;c=" . $session->mchecker . "\" method=\"POST\" style=\"display:inline\">
		<select name=\"type\" class=\"dropdown\">";
            for ($i = 19; $i <= 41; $i++) {
                if ($VillageResourceLevels['f' . $i . 't'] >= 1) {
                    echo "<option value=" . $i . ">" . $i . ". " . $building->procResType($VillageResourceLevels['f' . $i . 't']) . " " . $VillageResourceLevels['f' . $i] . "</option>";
                }
            }
            echo "</select>
        <button type=\"submit\" value=\"button\" class=\"green build\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">".BL_DEMOLISH."</div></div></button></form>";
        }
    }
?>
