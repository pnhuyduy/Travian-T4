<?php

    //$founder = $database->getVillage($village->wid);
    $newvillage = $database->getMInfo($_GET['id']);
    $eigen = $database->getCoor($village->wid);
    $from = array('x' => $eigen['x'], 'y' => $eigen['y']);
    $to = array('x' => $newvillage['x'], 'y' => $newvillage['y']);
    $time = $generator->procDistanceTime($from, $to, 3, 0);

?>

<h1><?php echo AT_FINDNEWVILLE; ?></h1>
<form method="POST" action="build.php">
    <input type="hidden" name="a" value="new"/>
    <input type="hidden" name="c" value="5"/>
    <input type="hidden" name="s" value="<?php echo $_GET['id']; ?>"/>
    <input type="hidden" name="id" value="39"/>
    <input type="hidden" name="timestamp" value="<?php echo time() + $time ?>"/>
    <table class="troop_details" cellpadding="1" cellspacing="1">
        <thead>
        <tr>
            <td class="role"><a
                    href="karte.php?d=<?php echo $village->wid; ?>&c=<?php echo $generator->getMapCheck($village->wid); ?>"><?php echo $database->getUserField($session->uid, 'username', 0); ?></a>
            </td>
            <td colspan="10"><a
                    href="karte.php?d=<?php echo $newvillage['id']; ?>&c=<?php echo $generator->getMapCheck($newvillage['0']) ?>"> <?php echo AT_NEWVILLAGE; ?>
                    (<?php echo $newvillage['x']; ?>|<?php echo $newvillage['y']; ?>)</a></td>
        </tr>
        </thead>
        <tbody class="units">
        <tr>
            <th>&nbsp;</th>
            <?php for ($i = ($session->tribe - 1) * 10 + 1; $i <= $session->tribe * 10; $i++) {
                echo "<td><img src=\"img/x.gif\" class=\"unit u" . $i . "\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
            } ?>
        </tr>
        <tr>
            <th><?php echo TROOPS; ?></th>
            <?php for ($i = 1; $i <= 9; $i++) {
                echo "<td class=\"none\">0</td>";
            } ?>
            <td>3</td>
        </tr>
        </tbody>
        <tbody class="infos">
        <tr>
            <th><?php echo AT_DURATION; ?></th>
            <td colspan="10"><img class="clock" src="img/x.gif" alt="<?php echo AT_DURATION; ?>"
                                  title="<?php echo AT_DURATION; ?>"/> <?php echo $generator->getTimeFormat($time); ?></td>
        </tr>
        </tbody>
        <tbody class="infos">
        <tr>
            <th><?php echo HDR_RES; ?></th>
            <td colspan="10">
                <img class="r1" src="img/x.gif" alt="<?php echo VL_WOOD; ?>" title="<?php echo VL_WOOD; ?>"/> 750 |
                <img class="r2" src="img/x.gif" alt="<?php echo VL_CLAY; ?>" title="<?php echo VL_CLAY; ?>"/> 750 |
                <img class="r3" src="img/x.gif" alt="<?php echo VL_IRON; ?>" title="<?php echo VL_IRON; ?>"/> 750 |
                <img class="r4" src="img/x.gif" alt="<?php echo VL_CROP; ?>" title="<?php echo VL_CROP; ?>"/> 750
            </td>
        </tr>
        </tbody>
    </table>

    <p class="button">
        <?php
            $mode = CP;
            $total = count($database->getProfileVillages($session->uid));
            $need_cps = ${'cp' . $mode}[$total];
            $cps = $database->getUserField($session->uid, 'cp', 0);
            $wood = round($village->awood);
            $clay = round($village->aclay);
            $iron = round($village->airon);
            $crop = round($village->acrop);
            if ($cps >= $need_cps) {
                if ($wood >= 750 && $clay >= 750 && $iron >= 750 && $crop >= 750) {
                    ?>

                    <button type="submit" value="ok" name="s1" id="btn_ok" class="green ">
                        <div class="button-container addHoverClick">
                            <div class="button-background">
                                <div class="buttonStart">
                                    <div class="buttonEnd">
                                        <div class="buttonMiddle"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="button-content"><?php echo AT_NEWVILLAGE; ?></div>
                        </div>
                    </button>
                <?php
                } else {
                    echo "<span class=\"none\">" . AT_LOWRESTOEXPAND . "</span>";
                }
            } else {
                print "<span class=\"none\">$cps/$need_cps " . VL_CULTUREPOINTS . "</span>";
            }
        ?>
</form>
</p>