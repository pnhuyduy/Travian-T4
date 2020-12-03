<table cellpadding="1" cellspacing="1" class="build_details">
    <thead>
    <tr>
        <td><?php echo UN_DEVELOPMENT;?></td>
        <td><?php echo MK_ACTION;?></td>
    </tr>
    </thead>
    <tbody>

    <?php
        $fail = $success = 0;
        $acares = $technology->grabAcademyRes();
        for ($i = 32; $i <= 39; $i++) {
            if ($technology->meetRRequirement($i) && !$technology->getTech($i) && !$technology->isResearch($i, 1)) {
                echo "<tr><td class=\"desc\">
					<div class=\"tit\">
						<img class=\"unit u" . $i . "\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($i) . "\" title=\"" . $technology->getUnitName($i) . "\" />
						<a href=\"#\" onClick=\"return Popup(" . $i . ",1);\">" . $technology->getUnitName($i) . "</a>
					</div>
					<div class=\"details\"><img class=\"r1\" src=\"img/x.gif\" alt=\"Fa\" title=\"".VL_WOOD."\" />" . ${'r' . $i}['wood'] . "|<img class=\"r2\" src=\"img/x.gif\" alt=\"Agyag\" title=\"".VL_CROP."\" />" . ${'r' . $i}['clay'] . "|<img class=\"r3\" src=\"img/x.gif\" alt=\"Vasérc\" title=\"".VL_IRON."\" />" . ${'r' . $i}['iron'] . "|<img class=\"r4\" src=\"img/x.gif\" alt=\"Búza\" title=\"".VL_CROP."\" />" . ${'r' . $i}['crop'] . "|<img class=\"clock\" src=\"img/x.gif\" alt=\"Időtartam\" title=\"\" />";
                echo $generator->getTimeFormat(round(${'r' . $i}['time'] * ($bid22[$village->resarray['f' . $id]]['attri'] / 100) / SPEED));
                if ($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) > 1) {
                    echo "|<a href=\"build.php?gid=17&t=3&r1=" . ${'r' . $i}['wood'] . "&r2=" . ${'r' . $i}['clay'] . "&r3=" . ${'r' . $i}['iron'] . "&r4=" . ${'r' . $i}['crop'] . "\" title=\"".MK_NPCMERCHANT."\"><img class=\"npc\" src=\"img/x.gif\" alt=\"".MK_NPCMERCHANT."\" title=\"".MK_NPCMERCHANT."\" /></a>";
                }
                if (${'r' . $i}['wood'] > $village->maxstore || ${'r' . $i}['clay'] > $village->maxstore || ${'r' . $i}['iron'] > $village->maxstore) {
                    echo "<br><span class=\"none\">".BL_UPGRADEWAREHOUSE."</span></div></td>";
                    echo "<td class=\"none\">
					<div class=\"none\">".BL_UPGRADEWAREHOUSE."</div>
				</td></tr>";
                } else if (${'r' . $i}['crop'] > $village->maxcrop) {
                    echo "<br><span class=\"none\">".BL_UPGRADEGRANARY."</span></div></td>";
                    echo "<td class=\"none\">
					<div class=\"none\">".BL_UPGRADEGRANARY."</div>
				</td></tr>";
                } else if (${'r' . $i}['wood'] > $village->awood || ${'r' . $i}['clay'] > $village->aclay || ${'r' . $i}['iron'] > $village->airon || ${'r' . $i}['crop'] > $village->acrop) {
                    $time = $technology->calculateAvaliable($i);
                    echo "<br><span class=\"none\">" . sprintf(BL_NORESAV_AVON, '' . $time[1] . '') . "</span></div></td>";
                    echo "<td class=\"none\">
					<div class=\"none\">" . sprintf(BL_NORESAV_AVON, '' . $time[1] . '') . "</div>
				</td></tr>";
                } else if (count($acares) > 0) {
                    echo "</td>";
                    echo "<td class=\"none\">".UN_DEVPROC."</td></tr>";
                } else {
                    echo "</td>";
                    echo "<td class=\"act\">
					<a class=\"research\" href=\"build.php?id=$id&amp;a=$i&amp;c=" . $session->mchecker . "\">".UN_DEVELOPMENT."</a></td></tr>";
                }
                $success += 1;
            } else {
                $fail += 1;
            }
        }
        if ($success == 0) {
            echo "<td colspan=\"2\"><div class=\"none\" align=\"center\">".MK_TRADEROUTEDESC."</div></td>";
        }
    ?>
    </tbody>
</table>
<?php if ($fail > 0) {
    echo "<p class=\"switch\"><a id=\"researchFutureLink\" href=\"#\" onclick=\"return $('researchFuture').toggle();\">Továbbiak</a></p>
		<table id=\"researchFuture\" class=\"build_details hide\" cellspacing=\"1\" cellpadding=\"1\">
			<thead><tr><td colspan=\"2\">Kritériumok</td></tr><tbody>";
    for ($uc = 33; $uc <= 39; $uc++) {
        if (!$technology->meetRRequirement($uc) && !$technology->getTech($uc)) {
            echo "<div class=\"research\"><div class=\"bigUnitSection\"><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\"><img class=\"unitSection u" . $uc . "Section\" src=\"img/x.gif\" alt=\"Testőrség\"></a><a href=\"#\" class=\"zoom\" onclick=\"return Travian.Game.unitZoom(" . $uc . ");\"><img class=\"zoom\" src=\"img/x.gif\" alt=\"zoom in\"></a></div><div class=\"information\"><div class=\"title\"><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\"><img class=\"unit u" . $uc . "\" src=\"img/x.gif\" alt=\"" . constant('U' . $uc) . "\"></a><a href=\"#\" onclick=\"return Travian.Game.iPopup(" . $uc . ",1);\">" . constant('U' . $uc) . "</a></div><div class=\"costs\"><div class=\"showCosts\"><span class=\"resources r1 little_res\"><img class=\"r1\" src=\"img/x.gif\" alt=\"" . VL_WOOD . "\">" . ${'r' . $uc}['wood'] . "</span><span class=\"resources r2 little_res\"><img class=\"r2\" src=\"img/x.gif\" alt=\"".VL_CLAY."\">" . ${'r' . $uc}['clay'] . "</span><span class=\"resources r3 little_res\"><img class=\"r3\" src=\"img/x.gif\" alt=\"".VL_IRON."\">" . ${'r' . $uc}['iron'] . "</span><span class=\"resources r4 little_res\"><img class=\"r4\" src=\"img/x.gif\" alt=\"".VL_CROP."\">" . ${'r' . $uc}['crop'] . "</span><div class=\"clear\"></div><span class=\"clocks\"><img class=\"clock\" src=\"img/x.gif\" alt=\"" . AT_HRS . "\">";
            echo $generator->getTimeFormat(round(${'r' . $uc}['time'] * ($bid22[$village->resarray['f' . $id]]['attri'] / 100) / SPEED));
            switch ($uc) {
                case 33:
                    break;
                case 34:
                    break;
                case 35:
                    break;
                case 36:
                    break;
                case 37:
                    break;
                case 38:
                    break;
                case 39:
                    break;
            }
        }
    }
    echo " <script type=\"text/javascript\">
		//<![CDATA[
			$(\"researchFuture\").toggle = (function()
			{
				this.toggleClass(\"hide\");

				$(\"researchFutureLink\").set(\"text\",
					this.hasClass(\"hide\")
					?	\"Továbbiak\"
					:	\"Elrejtés\"
				);

				return false;
			}).bind($(\"researchFuture\"));
		//]]>
		</script>";
    echo "</tbody></table>";
}
    //$acares = $technology->grabAcademyRes();
    if (count($acares) > 0) {
        echo "<table cellpadding=\"1\" cellspacing=\"1\" class=\"under_progress\"><thead><tr><td>Fejlesztés alatt</td><td>Időtartam</td><td>Complete</td></tr>
	</thead><tbody>";
       // $timer = 1;
        foreach ($acares as $aca) {
            $unit = substr($aca['tech'], 1, 2);
            echo "<tr><td class=\"desc\"><img class=\"unit u$unit\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($unit) . "\" title=\"" . $technology->getUnitName($unit) . "\" />" . $technology->getUnitName($unit) . "</td>";
            echo "<td class=\"dur\"><span id=\"timer$timer\">" . $generator->getTimeFormat($aca['timestamp'] - time()) . "</span></td>";
            $date = $generator->procMtime($aca['timestamp']);
            echo "<td class=\"fin\"><span>" . $date[1] . "</span><span> ".MV_HOUR."</span></td>";
            echo "</tr>";
            $timer += 1;
        }
        echo "</tbody></table></div>";
    }
?>
