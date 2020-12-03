<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">Alliance - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");
?>
<h4 class="round"><?php echo AL_RENAME; ?></h4>
<form method="post" action="allianz.php">
    <input type="hidden" name="a" value="100">
    <input type="hidden" name="o" value="100">
    <input type="hidden" name="s" value="5">
    <table cellpadding="1" cellspacing="1" class="option name transparent">
        <tbody>
        <tr>
            <th>
                <?php echo AL_TAG; ?>:
            </th>
            <td>
                <input class="tag text" name="ally1" value="<?php echo $allianceinfo['tag']; ?>" maxlength="8">
            </td>
        </tr>
        <tr>
            <th>
                <?php echo AL_NAME; ?>:
            </th>
            <td>
                <input class="name text" name="ally2" value="<?php echo $allianceinfo['name']; ?>" maxlength="25">
            </td>
        </tr>
        </tbody>
    </table>

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
                <div class="button-content"><?php echo SI_SAVE; ?></div>
            </div>
        </button>
    </p>
</form>
<p class="error3"><?php echo $form->getError("error"); ?></p>