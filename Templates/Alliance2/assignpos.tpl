<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    $memberlist = $database->getAllMember($aid);

    echo "<h1 class=\"titleInHeader\">" . AL_ALLIANCE . " - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");
?>
<h4 class="round"><?php echo AL_ASSIGNPOS; ?></h4>
<form method="post" action="allianz.php">
    <table cellpadding="1" cellspacing="1" id="position" class="small_option">
        <tbody>
        <tr>
            <th colspan="2"><?php echo AL_ASSIGNPOSDESC; ?></th>
        </tr>
        <tr>
            <th><?php echo AL_NAME; ?>:</th>
            <td>
                <select name="a_user" class="name dropdown">
                    <?php
                        foreach ($memberlist as $member) {
                            echo "<option value=" . $member['id'] . ">" . $member['username'] . "</option>";
                        }
                    ?>
                </select>
            </td>
        </tr>
        </tbody>
    </table>
    <p>
        <input type="hidden" name="o" value="1">
        <input type="hidden" name="s" value="5">
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
<p class="error"></p>