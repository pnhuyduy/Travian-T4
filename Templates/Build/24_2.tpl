<div class=\"clear\"></div><BR/>
<?php
    if (!isset($timer)) {
        $timer = 1;
    }
    $timeleft = $database->getVillageField($village->wid, 'celebration');
    if ($timeleft > Time()) {

        echo '<table cellpadding="1" cellspacing="1" class="under_progress">
			<thead><tr><td>' . BL_CELEBRATE . '</td><td>' . AT_DURATION . '</td><td>' . AT_FINISH . '</td></tr></thead>';
        echo '<tbody><tr>';
        echo "<td class=\"desc\">" . BL_CELEBRATE . " </td>";
        echo "<td class=\"dur\"><span id=\"timer" . $timer . "\">";
        echo $generator->getTimeFormat($timeleft - time());
        echo "</span></td>";
        echo "<td class=\"fin\">" . date('H:i', $timeleft) . "<span> " . AT_HRS . "</span></td>";
        echo "</tr></tbody></table>";
        $timer += 1;
    }
?>
