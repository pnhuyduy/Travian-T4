<?php
    if (isset($aid)) {
        $aid = $aid;
    } else {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
    include('menu.tpl');
?>
<h4 class="round"><?php echo AL_ALLIDIPLO;?></h4>
<form method="post" action="allianz.php">
    <input type="hidden" name="a" value="6">
    <input type="hidden" name="o" value="6">
    <input type="hidden" name="s" value="5">

    <div class="option diplomacy">
        <table cellpadding="1" cellspacing="1" class="option transparent">
            <tbody>
            <tr>
                <th>
                    <?php echo AL_ALLIANCE;?>:
                </th>
                <td>
                    <input class="ally text" type="text" name="a_name" maxlength="8">
                </td>
            </tr>

            <tr>
                <td>
                </td>
                <td>
                    <input class="radio" type="radio" id="dipl1" name="dipl" value="1">
                    <label for="dipl1"><?php echo AL_OFFERCONF;?></label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input class="radio" type="radio" id="dipl2" name="dipl" value="2">
                    <label for="dipl2"><?php echo AL_OFFERNAP;?></label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input class="radio" type="radio" id="dipl3" name="dipl" value="3">
                    <label for="dipl3"><?php echo AL_DECLAREWAR;?></label>
                </td>
            </tr>
            </tbody>
        </table>

        <p class="option">
            <input type="hidden" name="a" value="6">
            <button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo SI_SAVE;?>">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content"><?php echo SI_SAVE;?></div>
                </div>
            </button>
            <script type="text/javascript">
                window.addEvent('domready', function () {
                    if ($('btn_ok')) {
                        $('btn_ok').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "<?php echo SI_SAVE;?>", "confirm": "", "onclick": ""}]);
                        });
                    }
                });
            </script>
        <p class="error"><?php echo $form->getError("error");?></p>
        </p>
    </div>
</form>
<div class="boxes boxesColor gray infos">
    <div class="boxes-tl"></div>
    <div class="boxes-tr"></div>
    <div class="boxes-tc"></div>
    <div class="boxes-ml"></div>
    <div class="boxes-mr"></div>
    <div class="boxes-mc"></div>
    <div class="boxes-bl"></div>
    <div class="boxes-br"></div>
    <div class="boxes-bc"></div>
    <div class="boxes-contents">
        <div class="title">
            <?php echo AL_HINT;?>
        </div>
        <div class="text">
            <?php echo AL_HINT_DESC2;?>
        </div>
    </div>
</div>
<div class="clear"></div>


<h4 class="round"><?php echo AL_OWNOFFERS;?></h4>
<table cellpadding="1" cellspacing="1" class="option own transparent">
    <tbody>
    <tbody>
    <?php
        $alliance = $session->alliance;

        if (count($database->diplomacyOwnOffers($alliance))) {
            foreach ($database->diplomacyOwnOffers($alliance) as $key => $value) {
                $type = $value['type'];
                switch ($type) {
                    case 1:
                        $type = "Conf.";
                        break;
                    case 2:
                        $type = "Nap";
                        break;
                    case 3:
                        $type = "War";
                        break;
                }
                echo "<tr><td class=\"abo\"><form method=\"post\" action=\"allianz.php\"><input type=\"hidden\" name=\"o\" value=\"101\"><input type=\"hidden\" name=\"id\" value=\"" . $value['id'] . "\"><button type=\"submit\" value=\"del\" class=\"icon\"><img src=\"img/x.gif\" class=\"del\" alt=\"cancel\"></button></form></td>";
                echo '<td><a href="allianz.php?aid=' . $value['alli2'] . '">' . $type . ' ' . $database->getAllianceName($value['alli2']) . '</a></td></tr>';
            }
        } else {
            echo '<tr><td class="noData">'.AL_NONE.'.</td></tr>';
        }
    ?>
    </tbody>
</table>

<h4 class="round"><?php echo AL_FOROFFERS;?></h4>
<table width="100px" border="0" class="option foreign transparent">
    <tbody>
    <?php
        unset($type);
        $alliance = $session->alliance;

        if (count($database->diplomacyInviteCheck($alliance))) {
            foreach ($database->diplomacyInviteCheck($alliance) as $key => $row) {
                $type = $value['type'];
                switch ($type) {
                    case 1:
                        $type = "Conf.";
                        break;
                    case 2:
                        $type = "Nap";
                        break;
                    case 3:
                        $type = "War";
                        break;
                }
                echo '<td><form method="post" action="allianz.php"><input type="hidden" name="o" value="102"><input type="hidden" name="id" value="' . $row['id'] . '"><input type="hidden" name="alli1" value="' . $row['alli1'] . '"><button type="submit" value="del" class="icon"><img src="img/x.gif" class="del" alt="cancel"></button></form></td>';
                echo '<td><a href="allianz.php?aid=' . $row['alli1'] . '">' . $type . ' ' . $database->getAllianceName($row['alli1']) . '</a></td>';

                echo '<td><form method="post" action="allianz.php"><input type="hidden" name="o" value="103"><input type="hidden" name="id" value="' . $row['id'] . '"><input type="hidden" name="alli2" value="' . $row['alli2'] . '"><button type="submit" value="ok" name="s1" id="btn_ok"><div class="button-container"><div class="button-position"><div class="btl"><div class="btr"><div class="btc"></div></div></div><div class="bml"><div class="bmr"><div class="bmc"></div></div></div><div class="bbl"><div class="bbr"><div class="bbc"></div></div></div></div><div class="button-contents">'.AL_ACCEPT.'</div></div></button></form></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';

            }
        } else {
            echo '<tr><td class="noData">'.AL_NONE.'.</td></tr>';
        }
    ?>
    </tbody>
</table>

<h4 class="round"><?php echo AL_EXRELATIONSHIP;?></h4>
<table cellpadding="1" cellspacing="1" class="option existing transparent">
    <tbody>

    <?php
        unset($type);
        unset($row);
        $alliance = $session->alliance;

        if (count($database->diplomacyExistingRelationships($alliance))) {
            foreach ($database->diplomacyExistingRelationships($alliance) as $key => $row) {
                $type = $value['type'];
                switch ($type) {
                    case 1:
                        $type = "Conf.";
                        break;
                    case 2:
                        $type = "Nap";
                        break;
                    case 3:
                        $type = "War";
                        break;
                }
                echo '<tr><td class="abo"><form method="post" action="allianz.php"><input type="hidden" name="o" value="104"><input type="hidden" name="id" value="' . $row['id'] . '"><input type="hidden" name="alli2" value="' . $row['alli2'] . '"><button type="submit" value="del" class="icon"><img src="img/x.gif" class="del" alt="cancel"></button></form></td>';
                echo '<td>' . $type . ' <a href="allianz.php?aid=' . $row['alli1'] . '">' . $database->getAllianceName($row['alli1']) . '</a></td></tr>';
            }
        } elseif (count($database->diplomacyExistingRelationships2($alliance))) {
            foreach ($database->diplomacyExistingRelationships2($alliance) as $key => $row) {
                $type = $value['type'];
                switch ($type) {
                    case 1:
                        $type = "Conf.";
                        break;
                    case 2:
                        $type = "Nap";
                        break;
                    case 3:
                        $type = "War";
                        break;
                }
                echo '<tr><td class="abo"><form method="post" action="allianz.php"><input type="hidden" name="o" value="104"><input type="hidden" name="id" value="' . $row['id'] . '"><input type="hidden" name="alli2" value="' . $row['alli1'] . '"><button type="submit" value="del" class="icon"><img src="img/x.gif" class="del" alt="cancel"></button></form></td>';
                echo '<td>' . $type . ' <a href="allianz.php?aid=' . $row['alli2'] . '">' . $database->getAllianceName($row['alli2']) . '</a></td></tr>';
            }
        } else {
            echo '<tr><td class="noData">'.AL_NONE.'</td></tr>';
        }

    ?>


    </tbody>
</table>

<div class="boxes boxesColor gray infos">
    <div class="boxes-tl"></div>
    <div class="boxes-tr"></div>
    <div class="boxes-tc"></div>
    <div class="boxes-ml"></div>
    <div class="boxes-mr"></div>
    <div class="boxes-mc"></div>
    <div class="boxes-bl"></div>
    <div class="boxes-br"></div>
    <div class="boxes-bc"></div>
    <div class="boxes-contents">
        <div class="title">
            <?php echo AL_HINT;?>
        </div>
        <div class="text"><?php echo AL_HINT_DESC;?>
        </div>
    </div>
</div>
<div class="clear"></div>