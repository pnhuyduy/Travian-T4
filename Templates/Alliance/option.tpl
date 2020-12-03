<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";

    if ($alliance->userPermArray['opt1'] == 1 || $alliance->userPermArray['opt2'] == 1 || $alliance->userPermArray['opt3'] == 1
        || $alliance->userPermArray['opt4'] == 1
        || $alliance->userPermArray['opt5'] == 1 || $alliance->userPermArray['opt6'] == 1
    ) {
        ?>
        <h4 class="round"><?php echo AL_MANAGEMENTS; ?></h4>
    <?php } ?>
<ul class="options">
    <?php
        if ($alliance->userPermArray['opt3'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=100">  ' . AL_CHANGENAME . '</a></li>';
        }
        if ($alliance->userPermArray['opt3'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=3">  ' . AL_CHANGEDESCRIPTION . '</a></li>';
        }
        if ($alliance->userPermArray['opt1'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=1">  ' . AL_PLAYERSPERM . '</a></li>';
        }
        echo "</ul><h4 class=\"round\">Operations</h4><ul class=\"options\">";
        if ($alliance->userPermArray['opt4'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=4">  ' . AL_INVTOALLY . '</a></li>';
        }
        if ($alliance->userPermArray['opt6'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=6">  ' . AL_ALLIDIPLO . '</a></li>';
        }
        if ($alliance->userPermArray['opt2'] == 1) {
            echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=2"> ' . AL_KICKPLAYER . '</a></li>';
        }
        echo '<li><a class="a arrow" href="allianz.php?s=5&amp;o=11">  ' . AL_LEFTALLY . '</a></li>';
    ?>
</ul>
