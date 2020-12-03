<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    $allianceInvitations = $database->getAliInvitations($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
?>
<h4 class="round"><?php echo AL_INVTOALLY;?></h4>
<form method="post" action="allianz.php">
    <input type="hidden" name="a" value="4">
    <input type="hidden" name="o" value="4">
    <input type="hidden" name="s" value="5">
    <table cellpadding="1" cellspacing="1" class="option invite transparent">
        <tbody>
        <tr>
            <th>
                <?php echo AL_NAME;?>:
            </th>
            <td>
                <input class="name text" type="text" name="a_name" maxlength="20">
            </td>
        </tr>
        </tbody>
    </table>

    <p class="option">
        <button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo AL_INVITE;?>">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo AL_INVITE;?></div>
            </div>
        </button>
        <script type="text/javascript">
            window.addEvent('domready', function () {
                if ($('btn_ok')) {
                    $('btn_ok').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "<?php echo AL_INVITE;?>", "confirm": "", "onclick": ""}]);
                    });
                }
            });
        </script>
    </p>
</form>
<p class="error"><?php echo $form->getError("error"); ?></p>
<h4 class="round"><?php echo AL_INVITATIONS;?>:</h4>

<table cellpadding="1" cellspacing="1" class="option invitations transparent">
    <tbody>
    <div>
        <?php
            if (count($allianceInvitations) == 0) {
                echo "<tr><td class=noData>".AL_NOINVT."</td></tr>";
            } else {
                foreach ($allianceInvitations as $invit) {
                    $invited = $database->getUserField($invit['uid'], 'username', 0);
                    echo "<tr><td class=\"abo\">";
                    echo "<button type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = '?o=4&s=5&d=" . $invit['id'] . "'; return false;\"><img class=\"del\" src=\"img/x.gif\" alt=\"Cancel\" title=\"Cancel\" /></button></td><td>";
                    echo "<a class=\"a arrow\" href=spieler.php?uid=" . $invit['uid'] . ">Invitation For " . $invited . "";
                    echo "</td></tr>";
                }
            }
        ?>
    </tbody>
</table>
