<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $playerData = $database->getAlliPermissions($_POST['a_user'], $session->alliance);
    $playername = $database->getUserField($_POST['a_user'], 'username', 0);

    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";

?>
<h4 class="round"><?php echo AL_ASSIGNPOSITION;?></h4>
<p><?php echo AL_ASSIGNPOSDESC;?></p>
<form method="post" action="allianz.php">
    <table cellpadding="1" cellspacing="1" id="memberAdministration">
        <thead>
        <tr>
            <th><?php echo AL_NAME;?></th>
            <th><img src="img/x.gif" class="allyRight allyRightPosition" alt="Assign" title="Assign"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDisband" alt="Kick" title="Kick"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDescription" alt="Change Description"
                     title="Change Description"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDiplomacy" alt="Alliance Diplomacy"
                     title="Alliance Diplomacy"></th>
            <th><img src="img/x.gif" class="allyRight allyRightMessage" alt="IGMs to the whole alliance"
                     title="IGMs to the whole alliance"></th>
            <th><img src="img/x.gif" class="allyRight allyRightInvite" alt="Invite" title="Invite"></th>
            <th><img src="img/x.gif" class="allyRight allyRightForum" alt="Forum" title="Forum"></th>
            <th><?php AL_POSITION;?></th>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td class="name"><?php echo $playername; ?></td>
            <td class="right"><input class="check" type="checkbox" name="e1" value="1" <?php if ($playerData['opt1']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e2" value="1" <?php if ($playerData['opt2']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e3" value="1" <?php if ($playerData['opt3']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e6" value="1" <?php if ($playerData['opt4']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e7" value="1" <?php if ($playerData['opt7']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e4" value="1" <?php if ($playerData['opt4']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="right"><input class="check" type="checkbox" name="e5" value="1" <?php if ($playerData['opt5']) {
                    echo "checked=checked";
                } ?> ></td>
            <td class="title"><input class="text" type="text" name="a_titel" value="<?php echo $playerData['rank']; ?>"
                                     maxlength="20"/></td>
        </tr>

        </tbody>
    </table>
    <p>
        <input type="hidden" name="a" value="1">
        <input type="hidden" name="o" value="1">
        <input type="hidden" name="s" value="5">
        <input type="hidden" name="a_user" value="<?php echo $_POST['a_user']; ?>">
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
    </p>
</form>
<p class="error3"><?php echo $form->getError("error"); ?></p>