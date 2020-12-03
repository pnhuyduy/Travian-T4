<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . AL_ALLIANCE . " - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");
?>

<h4 class="round"><?php echo AL_LEAVEALLI; ?></h4>
<p class="option"><?php echo AL_QUITALLIPASSDESC; ?></p>
<form method="post" action="allianz.php">
    <input type="hidden" name="a" value="11">
    <input type="hidden" name="o" value="11">
    <input type="hidden" name="s" value="5">
    <table cellpadding="1" cellspacing="1" class="option quit transparent">
        <tbody>
        <tr>
            <th>
                <?php echo LG_LOGIN_USERNAME; ?>:
            </th>
            <td>
                <input class="pass text" type="password" name="pw" maxlength="20">
            </td>
        </tr>
        </tbody>
    </table>

    <p class="option">
        <button type="submit" value="save" class="green build" name="s1" id="btn_save">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo AL_LEAVEALLI; ?></div>
            </div>
        </button>
    </p>
</form>
<p class="error"><?php echo $form->getError("error"); ?></p>