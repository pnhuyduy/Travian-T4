<?php
    $eigen = $database->getCoor($village->wid);
    $adventure = $database->CheckAdventure($session->uid, $_GET['id'], 0);
    if (!isset($adventure) || !$adventure) {
        header('Location: hero_adventure.php');
        exit;
    }
    $adventureXY = $database->getMInfo($_GET['id']);
    $from = array('x' => $eigen['x'], 'y' => $eigen['y']);
    $to = array('x' => $adventureXY['x'], 'y' => $adventureXY['y']);
    $herodetail = $database->getHero($session->uid);
    $speed = $herodetail['speed'] + $herodetail['itemspeed'];
    $time = $generator->procDistanceTime($from, $to, $speed, 1, $herodetail);
    //$founder = $database->getVillage($_GET['id']);
?>

<h1><?php echo HS_ADVENTURE; ?></h1>
<form method="POST" action="build.php">
    <input type="hidden" name="a" value="adventure"/>
    <input type="hidden" name="c" value="5"/>
    <input type="hidden" name="h" value="<?php echo $_GET['id']; ?>"/>
    <input type="hidden" name="id" value="39"/>
    <input type="hidden" name="timestamp" value="<?php echo time() + $time ?>"/>
    <table class="troop_details" cellpadding="1" cellspacing="1">
        <thead>
        <tr>
            <td class="role"><a
                    href="karte.php?d=<?php echo $village->wid; ?>&c=<?php echo $generator->getMapCheck($_GET['id']); ?>"><?php echo $village->vname; ?></a>
            </td>
            <td colspan="11"><?php echo HS_ADVENTURE; ?>
                (<?php echo(DIRECTION == 'ltr' ? $adventureXY['x'] . '|' . $adventureXY['y'] : $adventureXY['y'] . '|' . $adventureXY['x']); ?>
                )
            </td>
        </tr>
        </thead>
        <tbody class="units">
        <tr>
            <th></th>
            <?php for ($i = ($session->tribe - 1) * 10 + 1; $i <= $session->tribe * 10; $i++) {
                echo "<td><img src=\"img/x.gif\" class=\"unit u" . $i . "\" title=\"" . $technology->getUnitName($i) . "\" alt=\"" . $technology->getUnitName($i) . "\" /></td>";
            }
                echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"" . $technology->getUnitName(51) . "\" alt=\"" . $technology->getUnitName(51) . "\" /></td>";
            ?>
        </tr>
        <tr>
            <th><?php echo UNITS; ?></th>
            <?php for ($i = 1; $i <= 10; $i++) {
                echo "<td class=\"none\">0</td>";
            } ?>
            <td>1</td>
        </tr>
        </tbody>
        <tbody class="infos">
        <tr>
            <th><?php echo AT_ARRIVAL; ?></th>
            <td colspan="11"><img class="clock" src="img/x.gif" alt="Duration"
                                  title="Duration"/> <?php echo $generator->getTimeFormat($time); ?></td>
        </tr>
        </tbody>
    </table>
    <?php
        if ($village->resarray['f39'] >= 1) {
            if ($herodetail['dead'] == 0) {
                if ($database->getHUnit($village->wid)) {
                    ?>
                    <p class="button">
                        <button type="submit" value="ok" name="s1" id="btn_ok" class="green build">
                            <div class="button-container addHoverClick">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content"><?php echo AT_STARTADV; ?></div>
                            </div>
                        </button>
                    </p>
                <?php } else { ?>
                    <button type="button" title="<?php echo HS_NOTINVIL; ?>" value="<?php echo HS_NOTINVIL; ?>"
                            class="green build disabled">
                        <div class="button-container addHoverClick">
                            <div class="button-background">
                                <div class="buttonStart">
                                    <div class="buttonEnd">
                                        <div class="buttonMiddle"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="button-content"><?php echo HS_NOTINVIL; ?></div>
                        </div>
                    </button>
                <?php } ?>
            <?php } else { ?>
                <button type="button" title="<?php echo HS_HERODEAD; ?>" value="<?php echo HS_HERODEAD; ?>"
                        class="green build disabled">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo HS_HERODEAD; ?></div>
                    </div>
                </button>
            <?php
            }
        } else {
            ?>
            <button type="button" title="<?php echo AT_BUILDRALLYPOINTTORAID; ?>" value="<?php echo AT_BUILDRALLYPOINTTORAID; ?>"
                    class="green build disabled">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content"><?php echo AT_BUILDRALLYPOINTTORAID; ?></div>
                </div>
            </button>
        <?php } ?>
</form>
