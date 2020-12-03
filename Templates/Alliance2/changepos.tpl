<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $playerData = $database->getAlliPermissions($_POST['a_user'], $session->alliance);
    $playername = $database->getUserField($_POST['a_user'], 'username', 0);

    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">Alliance - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");
?>
<h4 class="round"><?php echo AL_ASSIGNPOS; ?></h4>
<p><?php echo AL_ASSIGNPOSDESC; ?></p>
<form method="post" action="allianz.php">
    <table cellpadding="1" cellspacing="1" id="memberAdministration">
        <thead>
        <tr>
            <th><?php echo AL_NAME; ?></th>
            <th><img src="img/x.gif" class="allyRight allyRightPosition" alt="<?php echo AL_ASSIGNPOS; ?>"
                     title="<?php echo AL_ASSIGNPOS; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDisband" alt="<?php echo AL_KICK; ?>"
                     title="<?php echo AL_KICK; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDescription" alt="<?php echo AL_CHANGEDESC; ?>"
                     title="<?php echo AL_CHANGEDESC; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightDiplomacy" alt="<?php echo AL_ALLIDIPLO; ?>"
                     title="<?php echo AL_ALLIDIPLO; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightMessage" alt="<?php echo AL_ALLIIGMS; ?>"
                     title="<?php echo AL_ALLIIGMS; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightInvite" alt="<?php echo AL_ALLIINV; ?>"
                     title="<?php echo AL_ALLIINV; ?>"></th>
            <th><img src="img/x.gif" class="allyRight allyRightForum" alt="<?php echo FT_FORUM; ?>"
                     title="<?php echo FT_FORUM; ?>"></th>
            <th>Position Name</th>
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
            <td class="right"><input class="check" type="checkbox" name="e6" value="1" <?php if ($playerData['opt6']) {
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
        <button type="submit" value="save" class="green build" name="s1" id="btn_save">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo SI_SAVE; ?></div>
            </div>
        </button>
    </p>
</form>
<p class="error3"><?php echo $form->getError("error"); ?></p>
