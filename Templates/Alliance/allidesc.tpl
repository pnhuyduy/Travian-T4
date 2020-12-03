<?php
    if (!isset($aid)){
        $aid = $session->alliance;
    }
    $varmedal = $database->getProfileMedalAlly($aid);
    $allianceinfo = $database->getAlliance($aid);
    $memberlist = $database->getAllMember($aid);
    $totalpop = 0;
    foreach ($memberlist as $member) {
        $totalpop += $database->getVSumField($member['id'], "pop");
    }
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
    include('menu.tpl');
?>
<h4 class="round"><?php echo AL_DESCRIPTION;?></h4>
<form id="SettingsFormular" method="post" action="allianz.php">
    <input type="hidden" name="a" value="3">
    <input type="hidden" name="o" value="3">
    <input type="hidden" name="s" value="5">
    <textarea class="editDescription editDescription1" tabindex="1"
              name="be1"><?php echo $allianceinfo['desc']; ?></textarea>
    <textarea class="editDescription editDescription2" tabindex="2"
              name="be2"><?php echo $allianceinfo['notice']; ?></textarea>

    <div class="clear"></div>
    <script type="text/javascript">
        window.addEvent('domready', function () {
            if ($('switchMedals')) {
                $('switchMedals').addEvent('click', function (e) {
                    Travian.toggleSwitch($('medals'), $('switchMedals'));
                });
            }
        });
    </script>
    <div class="switchWrap">
        <div class="openedClosedSwitch switchClosed" id="switchMedals">medals</div>
        <div class="clear"></div>
    </div>
    <br/>
    <table cellpadding="1" cellspacing="1" id="medals" class="hide">
        <tr>
            <td><?php echo AL_CATEGORY;?></td>
            <td><?php echo AL_RANK;?></td>
            <td><?php echo AL_WEEK;?></td>
            <td><?php echo AL_BBCODE;?></td>
        </tr>
        <?php
            foreach ($varmedal as $medal) {
                $titel = "Bonus";
                switch ($medal['categorie']) {
                    case "1":
                        $titel = PF_MD1;
                        break;
                    case "2":
                        $titel = PF_MD2;
                        break;
                    case "3":
                        $titel = PF_MD3;
                        break;
                    case "4":
                        $titel = PF_MD4;
                        break;
                    case "5":
                        $titel = PF_TOP10BOTH;
                        break;
                    case "6":
                        $titel = sprintf(PF_MD5,$medal['points']);
                        break;
                    case "7":
                        $titel = sprintf(PF_MD6,$medal['points']);
                        break;
                    case "8":
                        $titel = sprintf(PF_MD7,$medal['points']);
                        break;
                    case "9":
                        $titel = sprintf(PF_MD8,$medal['points']);
                        break;
                    case "10":
                        $titel = PF_MD11;
                        break;
                    case "11":
                        $titel = sprintf(PF_MD9,$medal['points']);
                        break;
                    case "12":
                        $titel = sprintf(PF_MD10,$medal['points']);
                        break;
                }
                echo "<tr>
		<td> " . $titel . "</td>
		<td>" . $medal['plaats'] . "</td>
		<td>" . $medal['week'] . "</td>
		<td>[#" . $medal['id'] . "]</td>
		</tr>";
            } ?>
    </table>
    </p>
    <p class="btn">
        <button type="submit" value="save" name="s1" id="btn_save" class="green " title="<?php echo SI_SAVE;?>" tabindex="3">
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
                if ($('btn_save')) {
                    $('btn_save').addEvent('click', function () {
                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "save", "name": "s1", "id": "btn_save", "class": "green ", "title": "<?php echo SI_SAVE;?>", "confirm": "", "onclick": "", "tabindex": 3}]);
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
</form>
<p class="error"><?php echo $form->getError("error"); ?></p>