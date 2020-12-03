<?php

    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $varmedal = $database->getProfileMedalAlly($aid);
    $allianceinfo = $database->getAlliance($aid);
    $memberlist = $database->getAllMember($aid);
    $totalpop = 0;
    foreach ($memberlist as $member) {
        $totalpop += $database->getVSumField($member['id'], "pop");
    }

    echo "<h1 class=\"titleInHeader\">" . AL_ALLIANCE . " - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");

?>
<h4 class="round"><?php echo AL_DESCRIPTION; ?></h4>
<form method="post" action="allianz.php">
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
        <div class="openedClosedSwitch switchClosed" id="switchMedals"><?php echo AL_MEDALS; ?></div>
        <div class="clear"></div>
    </div>
    <br/>
    <table cellpadding="1" cellspacing="1" id="medals" class="hide">
        <tr>
            <td><?php echo AL_CATEGORY; ?></td>
            <td><?php echo AL_RANK; ?></td>
            <td><?php echo AL_WEEK; ?></td>
            <td><?php echo AL_BBCODE; ?></td>
        </tr>
        <?php
            foreach ($varmedal as $medal) {
                $titel = AL_BONUS;
                switch ($medal['categorie']) {
                    case "1":
                        $titel = AL_AOFW;
                        break;
                    case "2":
                        $titel = AL_DOFW;
                        break;
                    case "3":
                        $titel = AL_COFW;
                        break;
                    case "4":
                        $titel = AL_ROFW;
                        break;
                    case "5":
                        $titel = AL_ADOFW;
                        break;
                    case "6":
                        $titel = sprintf(AL_TOP3AOFW, $medal['points']);
                        break;
                    case "7":
                        $titel = sprintf(AL_TOP3DOFW, $medal['points']);
                        break;
                    case "8":
                        $titel = sprintf(AL_TOP3COFW, $medal['points']);
                        break;
                    case "9":
                        $titel = sprintf(AL_TOP3ROFW, $medal['points']);
                        break;
                    case "10":
                        $titel = AL_COFW;
                        break;
                    case "11":
                        $titel = sprintf(AL_TOP3COFW, $medal['points']);
                        break;
                    case "12":
                        $titel = sprintf(AL_TOP3AOFW, $medal['points']);
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

<p class="error"><?php echo $form->getError("error"); ?></p>