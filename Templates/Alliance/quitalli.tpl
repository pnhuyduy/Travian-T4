<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
?>
<h4 class="round"><?php echo AL_LEFTALLY;?></h4>
<p class="option"><?php echo US_PASSTOCONFIRM;?></p>
<form method="post" action="allianz.php">
    <input type="hidden" name="a" value="11">
    <input type="hidden" name="o" value="11">
    <input type="hidden" name="s" value="5">
    <table cellpadding="1" cellspacing="1" class="option quit transparent">
        <tbody>
        <tr>
            <th>
                <?php echo US_PASSWORD;?>:
            </th>
            <td>
                <input class="pass text" type="password" name="pw" maxlength="20">
            </td>
        </tr>
        </tbody>
    </table>
    <p class="option">
        <button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo OK;?>">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo OK;?></div>
            </div>
        </button>
        <script type="text/javascript">
            window.addEvent('domready', function () {
                if ($('btn_ok')) {
                    $('btn_ok').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "<?php echo OK;?>", "confirm": "", "onclick": ""}]);
                    });
                }
            });
        </script>
    </p>
</form>
<p class="error"><?php echo $form->getError("error"); ?></p>