<?php
    if (isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . AL_ALLIANCE . " - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");
    echo $form->getError('allinv');
?>
<h4 class="round"><?php echo HDR_OPTION2; ?></h4>
<form method="POST" action="allianz.php">
    <input type="hidden" name="s" value="5">
    <ul class="options">

        <?php
            if ($alliance->userPermArray['opt3'] == 1) {
                ?>
                <label>
                    <li><input class="radio" type="radio" name="o" value="100"><?php echo AL_CHANGENAME; ?></li>
                </label>
            <?php
            }
            if ($alliance->userPermArray['opt3'] == 1) {
                ?>

                <label>
                    <li><input class="radio" type="radio" name="o" value="3"><?php echo AL_CHANGEDESCRIPTION; ?></li>
                </label>
            <?php
            }
            if ($alliance->userPermArray['opt1'] == 1) {
                ?>
                <label>
                    <li><input class="radio" type="radio" name="o" value="1"><?php echo AL_ASSIGNPOSITION; ?></li>
                </label>
            <?php
            }
            if ($alliance->userPermArray['opt4'] == 1) {
                ?>
                <label>
                    <li><input class="radio" type="radio" name="o" value="4"><?php echo AL_ALLIINV; ?></li>
                </label>
            <?php
            }
            if ($alliance->userPermArray['opt6'] == 1) {
                ?>
                <label>
                    <li><input class="radio" type="radio" name="o" value="6"><?php echo AL_ALLIDIPLO; ?></li>
                </label>
            <?php
            }
            if ($alliance->userPermArray['opt2'] == 1) {
                ?>
                <label>
                    <li><input class="radio" type="radio" name="o" value="2"><?php echo AL_KICK; ?></li>
                </label>

            <?php
            }
        ?>
        <label>
            <li><input class="radio" type="radio" name="o" value="11"><?php echo AL_LEAVEALLI; ?></li>
        </label>

    </ul>

    <p>
        <button type="submit" value="save" class="green build" name="s1" id="btn_save">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo AL_GO; ?></div>
            </div>
        </button>
    </p>
</form>