<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    $memberlist = $database->getAllMember($aid);

    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
    include('menu.tpl');
?>
<h4 class="round"><?php echo AL_ASSIGNPOS;?></h4>
<form id="SettingsFormular" method="post" action="allianz.php">
    <table cellpadding="1" cellspacing="1" id="position" class="small_option">
        <tbody>
        <tr>
            <th colspan="2"><?php echo AL_ASSIGNPOSDESC;?></th>
        </tr>
        <tr>
            <th><?php echo AL_NAME;?>:</th>
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
        if (!$('selectNewMemberRights')) {
            return;
        }

        Travian.Form.UnloadHelper.watchHtmlForm($('SettingsFormular'));

        $('selectNewMemberRights').down('select').addEvent('change', function (e) {
            var selectRow = $('selectNewMemberRights');
            var select = selectRow.down('select');
            var uid = select.value;
            var name = select[select.selectedIndex].text;

            // Eintrag mit -1 ist der Infotext
            if (uid == -1) {
                return;
            }

            //Sortierung festlegen
            var orderRights = new Array(1, 2, 3, 6, 7, 4, 5, 9);

            // Zeile mit ausgewähltem Spieler clonen
            var newMemberRow = selectRow.clone();

            // Rechte/Rang zurücksetzen
            newMemberRow.down('td.name').set('html', name);
            newMemberRow.select('input[type=checkbox]').each(function (element, index) {
                element.removeProperty('checked').set('name', 'rights[' + uid + '][e' + (orderRights[index]) + ']');
            });
            newMemberRow.down('input[type=text]').set('value', '').set('name', 'rights[' + uid + '][rang]');

            // Neue Zeile einfügen
            selectRow.insert(
                {
                    before: newMemberRow
                }).down('option[value=' + uid + ']').dispose();

            // remove dropdown row if there is no player left
            var remainingPlayerCount = $$('#selectNewMemberRights option').length;

            if (remainingPlayerCount <= 1) {
                selectRow.dispose();
            }
        });
    });
</script>
<p class="error3"><?php echo $form->getError("error"); ?></p>