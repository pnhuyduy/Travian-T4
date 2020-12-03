<h1 class="titleInHeader"><?php echo B20; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid20">
    <p class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(20,4);" class="build_logo">
            <img class="building big white g20" src="img/x.gif" alt="<?php echo B20; ?>" title="<?php echo B20; ?>"/>
        </a>
        <?php echo B20_DESC; ?><br/></p>
    <?php
        include("upgrade.tpl");
    ?>
    <?php if ($building->getTypeLevel(20) > 0) { ?>
        <div class="clear"></div>
        <form method="POST" name="snd" action="build.php">
            <input type="hidden" name="id" value="<?php echo $id; ?>"/>
            <input type="hidden" name="ft" value="t1"/>

            <div class="buildActionOverview trainUnits">
                <?php
                    include("20_" . $session->tribe . ".tpl");
                ?>
            </div>
            <div class="clear"></div>
            <button type="submit" value="button" class="green build">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content"><?php echo UN_TRAIN; ?></div>
                </div>
            </button>

        </form>
    <?php
    } else {
        echo "<b>" . UN_NOUNITRESEARCHED . "</b><br>\n";
    }
        $trainlist = $technology->getTrainingList(2);
        if (count($trainlist) > 0) {
            //$timer = 2*count($trainlist);
            echo "
        <h4 class=\"round spacer\">Training</h4>
    <table cellpadding=\"1\" cellspacing=\"1\" class=\"under_progress\">
		<thead><tr>
			<td>" . UNIT . "</td>
			<td>" . AT_DURATION . "</td>
			<td>" . AT_FINISH . "</td>
		</tr></thead>
		<tbody>";
            $TrainCount = 0;
            foreach ($trainlist as $train) {
                $TrainCount++;
                echo "<tr><td class=\"desc\">";
                echo "<img class=\"unit u" . $train['unit'] . "\" src=\"img/x.gif\" alt=\"" . $train['name'] . "\" title=\"" . $train['name'] . "\" />";
                echo $train['amt'] . " " . $train['name'] . "</td><td class=\"dur\">";
                if ($TrainCount == 1) {
                    echo "<span id=timer" . $timer . ">" . $generator->getTimeFormat($train['endat'] - time()) . "</span>";
                    $timer++;
                } else {
                    echo $generator->getTimeFormat($train['endat'] - $train['commence']);
                }
                echo "</span></td><td class=\"fin\">";
                $time = $generator->procMTime($train['endat']);
                echo " " . $time[1] . " " . AT_HRS;
                if ($train['eachtime'] < 2000) {
                    $NextFinished = $generator->getMilisecFormat($train['eachtime']);
                } else {
                    $NextFinished = $generator->getTimeFormat(round($train['eachtime'] / 1000));
                }
                echo '</tr><tr class="next"><td colspan="3">' . sprintf(UN_EUWTI, '' . $NextFinished . '') . '</td></tr>';
            } ?>
            </tbody></table>
        <?php
        }
    ?> </p></div>
<div class="clear"></div>