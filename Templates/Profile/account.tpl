<form action="spieler.php" method="POST">
    <input type="hidden" name="ft" value="p3">
    <input type="hidden" name="uid" value="<?php echo $session->uid; ?>"/>

    <h4 class="round"><?php echo PF_CHANGEPASSWORD; ?></h4>

    <table cellpadding="1" cellspacing="1" id="change_pass" class="account transparent">
        <tbody>
        <tr>
            <th class="col1"><?php echo PF_OLDPASSWORD; ?></th>
            <td><input class="text" type="password" name="pw1" maxlength="20"></td>
        </tr>
        <tr>
            <th><?php echo PF_NEWPASSWORD; ?></th>
            <td><input class="text" type="password" name="pw2" maxlength="20"></td>
        </tr>
        <tr>
            <th><?php echo PF_NEWPASSWORDAGAIN; ?></th>
            <td><input class="text" type="password" name="pw3" maxlength="20"></td>
        </tr>

        </tbody>
    </table>
    <?php
        if ($form->getError("pw") != "") {
            echo "<span class=\"error\">" . $form->getError('pw') . "</span>";
        }
    ?>
    <h4 class="round spacer"><?php echo PF_CHNAGEEMAILADDRESS; ?></h4>
    <table id="change_mail" cellpadding="1" cellspacing="1" class="transparent">
        <tbody>
        <tr>
            <td colspan="2">
                <?php echo PF_CHNAGEEMAILADDRESSDESC; ?>
            </td>
        </tr>
        <tr>
            <th><?php echo PF_OLDEMAIL; ?>:</th>
            <td><input class="text" type="text" name="email_alt" maxlength="50" size="40"></td>
        </tr>
        <tr>
            <th><?php echo PF_NEWEMAIL; ?>:</th>
            <td><input class="text" type="text" name="email_neu" maxlength="50" size="40"></td>
        </tr>
        </tbody>
    </table>
    <?php
        if ($form->getError("email") != "") {
            echo "<span class=\"error\">" . $form->getError('email') . "</span>";
        }
    ?>

    <h4 class="round spacer"><?php echo PF_DELETEACCOUNT; ?></h4>
    <table cellpadding="1" cellspacing="1" id="del_acc" class="account transparent">
        <tbody>
        <tr>
            <td colspan="2"><?php echo PF_DELETEACCOUNTDESC; ?></td>
        </tr>


        <?php
            $timestamp = $database->isDeleting($session->uid);
            if ($timestamp) {
                echo "<tr><td colspan=\"2\" class=\"count\">";
                $delduration = round(max(round(259200 / sqrt(SPEED)), 3600));
                $cancelduration = $delduration * 2 / 3;
                if ($timestamp > time() + $cancelduration) {
                    echo "<button type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&id=" . $session->uid . "&a=1&e=4'; return false;\">
			<img src=\"img/x.gif\" class=\"del\" alt=\"del\"></button>";
                }
                $time = $generator->getTimeFormat(($timestamp - time()));
                echo PF_DELETEIN . " <span id=\"timer1\">" . $time . "</span></td></tr>";
            } else {
                $delduration = round(max(round(259200 / sqrt(SPEED)), 3600));
                $cancelduration = $delduration * 2 / 3;

                ?>
                <tr>
                    <td colspan="2"><font color=red><?php echo sprintf(PF_NOTEDELETE, round($cancelduration / 60));?></font></td>
                </tr>
                <tr>
                    <th><?php echo PF_CONFIRMDELETEACC; ?></th>
                    <td class="del_selection">
                        <label><input class="radio" type="radio" name="del" value="1"><?php echo YES; ?></label>
                        <label><input class="radio" type="radio" name="del" value="0"
                                      checked="checked"><?php echo NO; ?></label>
                    </td>
                </tr>
                <tr>
                    <th><?php echo US_PASSTOCONFIRM; ?></th>
                    <td><input class="text" type="password" name="del_pw" maxlength="20"></td>
                </tr>
            <?php
            }
            if ($form->getError("del") != "") {
                echo "<tr><td><span class=\"error\">" . $form->getError("del") . "</span></td></tr>";
            }
        ?>
        </tbody>
    </table>

    <h4 class="round spacer"><?php echo HDR_GOLD; ?></h4>
    <table cellpadding="1" cellspacing="1" class="newsletter transparent">
        <tbody>
        <tr>
            <td colspan="2">
                <?php
                    $udata = $database->getUser($session->uid, 1);
                    echo sprintf(PF_YOURGOLDAMOUNT
                        , '<img src="img/x.gif" class="gold" alt="' . HDR_GOLD . '">' . ($udata['gold'])
                        , '<img src="img/x.gif" class="gold" alt="' . HDR_GOLD . '">' . min($udata['boughtgold'], $udata['gold']));
                ?>
            </td>
        </tr>
        </tbody>
    </table>
    <br/>

    <div class="save_button">
        <button type="submit" value="save" id="button52813724aae71" class="green ">
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
    </div>
</form>