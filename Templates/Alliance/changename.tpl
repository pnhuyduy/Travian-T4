<?php
    if (isset($aid)) {
        $aid = $aid;
    } else {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
    include("alli_menu.tpl");
?>
<h4 class="round">Rename</h4>
<form id="SettingsFormular" method="post" action="allianz.php">
    <input type="hidden" name="a" value="100">
    <input type="hidden" name="o" value="100">
    <input type="hidden" name="s" value="5">
    <table cellpadding="1" cellspacing="1" class="option name transparent">
        <tbody>
        <tr>
            <th>
                <?php echo AL_TAG;?>:
            </th>
            <td>
                <input class="tag text" name="ally1" value="<?php echo $allianceinfo['tag']; ?>" maxlength="8">
            </td>
        </tr>
        <tr>
            <th>
                <?php echo AL_NAME;?>:
            </th>
            <td>
                <input class="name text" name="ally2" value="<?php echo $allianceinfo['name']; ?>" maxlength="25">
            </td>
        </tr>
        </tbody>
    </table>

    <p>
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
<script type="text/javascript">
    window.addEvent('domready', function () {
        Travian.Form.UnloadHelper.watchHtmlForm($('SettingsFormular'));
    });
</script>
<p class="error3"><?php echo $form->getError("error"); ?></p>