<form method="POST" name="snd" action="build.php">
    <input type="hidden" name="id" value="<?php echo $id; ?>"/>
    <input type="hidden" name="ft" value="t1"/>

    <table cellpadding="1" cellspacing="1" class="build_details">
        <thead>
        <tr>
            <td><?php echo AL_NAME; ?></td>
            <td><?php echo BL_NUM; ?></td>
            <td><?php echo BL_MAXIMUM; ?></td>
        </tr>
        </thead>
        <tbody>
        <?php
            $i = 20;
            echo "<tr><td class=\"desc\">
					<div class=\"tit\">
						<img class=\"unit u" . $i . "\" src=\"img/x.gif\" alt=\"" . $technology->getUnitName($i) . "\" title=\"" . $technology->getUnitName($i) . "\" />
						<a href=\"#\" onClick=\"return Popup(" . $i . ",1);\">" . $technology->getUnitName($i) . "</a>  <span class=\"info\">(" . VL_AVAILABLE . ": " . $village->unitarray['u' . $i] . ")</span>
					</div>
					<div class=\"details\"><img class=\"r1\" src=\"img/x.gif\" alt=\"" . VL_WOOD . "\" title=\"" . VL_WOOD . "\" />" . ${'u' . $i}['wood'] . "|<img class=\"r2\" src=\"img/x.gif\" alt=\"" . VL_CLAY . "\" title=\"" . VL_CLAY . "\" />" . ${'u' . $i}['clay'] . "|<img class=\"r3\" src=\"img/x.gif\" alt=\"" . VL_IRON . "\" title=\"" . VL_IRON . "\" />" . ${'u' . $i}['iron'] . "|<img class=\"r4\" src=\"img/x.gif\" alt=\"" . VL_CROP . "\" title=\"" . VL_CROP . "\" />" . ${'u' . $i}['crop'] . "|<img class=\"clock\" src=\"img/x.gif\" alt=\"" . AT_DURATION . "\" title=\"" . AT_DURATION . "\" />";
            echo $generator->getTimeFormat(round(${'u' . $i}['time'] / SPEED));
            //if($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) > 1) {
            //echo "|<a href=\"build.php?gid=17&t=3&r1=".${'r'.$i}['wood']."&r2=".${'r'.$i}['clay']."&r3=".${'r'.$i}['iron']."&r4=".${'r'.$i}['crop']."\" title=\"NPC trade\"><img class=\"npc\" src=\"img/x.gif\" alt=\"NPC trade\" title=\"NPC trade\" /></a>";
            //}
            echo "
				<td class=\"val\"><input type=\"text\" class=\"text\" name=\"t" . $i . "\" value=\"0\" maxlength=\"4\"></td>
				<td class=\"max\"><a href=\"#\" onClick=\"document.snd.t" . $i . ".value=" . $technology->maxUnit($i) . "; return false;\">(" . $technology->maxUnit($i) . ")</a></td></tr></tbody>
	";
        ?>
        </tbody>
    </table>
    <p>
        <input type="image" id="btn_train" class="dynamic_img" value="ok" name="s1" src="img/x.gif" alt="train"/>
    </p>

    <?php
        $trainlist = $technology->getTrainingList(20);
        if (count($trainlist) > 0) {
            $timer = 2 * count($trainlist);
            echo "
    <table cellpadding=\"1\" cellspacing=\"1\" class=\"under_progress\">
		<thead><tr>
			<td>" . UN_TRAIN . "</td>
			<td>" . BL_TIME . "</td>
			<td>" . AT_FINISH . "</td>
		</tr></thead>
		<tbody>";
            foreach ($trainlist as $train) {
                echo "<tr><td class=\"desc\">";
                echo "<img class=\"unit u" . $train['unit'] . "\" src=\"img/x.gif\" alt=\"" . $train['name'] . "\" title=\"" . $train['name'] . "\" />" . $train['amt'] . " " . $train['name'] . "</td><td class=\"dur\"><span id=timer" . $timer . ">" . $generator->getTimeFormat(($train['commence'] + ($train['eachtime'] * $train['amt'])) - time()) . "</span></td><td class=\"fin\">";
                $timer -= 1;
                $time = $generator->procMTime($train['commence'] + (1 * $train['amt']));
                if ($time[0] != "today") {
                    echo $time[0];
                }
                echo $time[1] . "</span><span> " . AT_HRS . "</td>
		</tr><tr class=\"next\"><td colspan=\"3\">" . sprintf(UN_NEXTUNITREADYIN, '<span id=timer' . $timer . '>' . $generator->getTimeFormat(($train['commence'] + $train['eachtime']) - time()) . '</span>') . '</td></tr>';
            }
            echo "</tbody></table>";
        }
    ?>

</form>