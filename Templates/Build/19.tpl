<h1 class="titleInHeader"><?php echo B19; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid19">
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(19,4);" class="build_logo">
            <img class="building big white g19" src="img/x.gif" alt="<?php echo B19; ?>" title="<?php echo B19; ?>"/>
        </a>
        <?php echo B19_DESC; ?>
    </div>
    <?php
        include("upgrade.tpl");
    ?>
    <div class="clear"></div>
    <?php if ($building->getTypeLevel(19) > 0) { ?>
        <form method="POST" name="snd" action="build.php">
            <input type="hidden" name="id" value="<?php echo $id; ?>"/>
            <input type="hidden" name="ft" value="t1"/>

            <div class="buildActionOverview trainUnits">
                <?php include("19_train.tpl"); ?>
                <div class="clear"></div>
            </div>
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
        echo "<b>" . UN_TRAINSTARTDESC . "</b><br>\n";
    }
        $trainlist = $technology->getTrainingList(1);
        if (count($trainlist) > 0) {
            //$timer = count($trainlist);
            echo "
        <h4 class=\"round spacer\"><?php echo TRAINING;?></h4>
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
                echo "</td><td class=\"fin\">";
                $time = $generator->procMTime($train['endat']);
                echo " " . $time[1] . " " . AT_HRS;
                if ($train['eachtime'] < 2000) {
                    $NextFinished = $generator->getMilisecFormat($train['eachtime']);
                } else {
                    $NextFinished = $generator->getTimeFormat(round($train['eachtime'] / 1000));
                }
                echo '</tr><tr class="next"><td colspan="3">' . sprintf(UN_EUWTI, ('' . $NextFinished . '')) . '</td></tr>';
            } ?>
            </tbody>
        </table>
        <?php } ?>
    </p></div>
<div class="clear">&nbsp;</div>
<div class="clear"></div>