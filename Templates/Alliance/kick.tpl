<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $memberlist = $database->getAllMember($aid);
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
?>
<h4 class="round"><?php echo AL_KICK;?></h4>
<form method="post" action="allianz.php">
    <table cellpadding="1" cellspacing="1" id="position" class="small_option">
        <tbody>
        <tr>
            <th colspan="2"><?php echo AL_SELECTTOKICK;?></th>
        </tr>
        <tr>
            <th>Name:</th>
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
        <input type="hidden" name="o" value="2">
        <input type="hidden" name="s" value="5">
        <input type="hidden" name="a" value="2">
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