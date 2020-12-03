<form id="settings" action="options.php?s=3" method="POST">
<input type="hidden" name="ft" value="p3">
<input type="hidden" name="get" value="3">
<input type="hidden" name="uid" value="<?php echo $session->uid; ?>"/>
    <?php

    echo "<div class=\"error\"> ".$form->getError('sit')."</div>";

    ?>
<h4 class="round spacer"><?php echo PF_SITTERFORTHISA; ?></h4>
<input type="hidden" name="sitter_flag_posted" value="1">

<div class="text"><?php echo PF_SITTERFORTHISADESC; ?></div>

<script type="text/javascript">
    function cloneName(obj, id) {
        $(id).innerHTML = obj.value.stripTags();
    }
</script>



<table class="sitters transparent">
    <tbody>
    <tr>
        <th>
            <div class="boxes boxesColor lightGreen">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents"><span><?php echo PF_SITTER1; ?></span></div>
            </div>
        </th>
        <td>
            <?php

                if ($session->userinfo['sit1'] == 0) {
                    echo "<input onkeyup=\"cloneName(this, 'sitterName0')\" class=\"text\" type=\"text\" name=\"v1\" maxlength=\"15\">";
                }
                if ($session->userinfo['sit1'] != 0) {
                    echo "<button onkeyup=\"cloneName(this, 'sitterName0')\" type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&e=3&id=" . $session->userinfo['sit1'] . "&a=" . $session->checker . "&type=1'; return false;\"><img src=\"img/x.gif\" class=\"del\" alt=\"helyettes\"></button>";
                    echo "&nbsp;" . $database->getUserField($session->userinfo['sit1'], "username", 0) . "";
                }
            ?></td>
    </tr>
    <tr>
        <th>
            <div class="boxes boxesColor orange">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents"><span><?php echo PF_SITTER2; ?></span></div>
            </div>
        </th>
        <td>
        <?php

        if ($session->userinfo['sit2'] == 0) {
            echo "<input onkeyup=\"cloneName(this, 'sitterName1')\" class=\"text\" type=\"text\" name=\"v2\" maxlength=\"15\">";
        }
        if ($session->userinfo['sit2'] != 0) {
            echo "<button onkeyup=\"cloneName(this, 'sitterName1')\" type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&e=3&id=" . $session->userinfo['sit2'] . "&a=" . $session->checker . "&type=2'; return false;\"><img src=\"img/x.gif\" class=\"del\" alt=\"helyettes\"></button>";
            echo "&nbsp;" . $database->getUserField($session->userinfo['sit2'], "username", 0) . "";
        }
        ?></td>
    </tr>
    </tbody>
</table>
<table cellpadding="1" cellspacing="1" class="sitters2 spacer">
    <tbody>
    <tr class="sitterHead">
        <th><?php echo AL_PLAYER . ' ' . AL_NAME; ?></th>
        <td class="name"
            id="sitterName0"><?php echo $database->getUserField($session->userinfo['sit1'], "username", 0); ?></td>
        <td class="name"
            id="sitterName1"><?php echo $database->getUserField($session->userinfo['sit2'], "username", 0); ?></td>
    </tr>
    <tr>
        <?Php $f11 = $database->getUsersetting($session->uid); ?>
        <th><?php echo PF_SITTEROP1; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag0"
                <?php if ($f11['sitter1_set_1'] == 1 || $session->userinfo['sit1'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag0"
                <?php if ($f11['sitter2_set_1'] == 1 || $session->userinfo['sit2'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    <tr>
        <th><?php echo PF_SITTEROP2; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag1"
                <?php if ($f11['sitter1_set_2'] == 1 || $session->userinfo['sit1'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag1"
                <?php if ($f11['sitter2_set_2'] == 1 || $session->userinfo['sit2'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    <tr>
        <th><?php echo PF_SITTEROP3; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag2"
                <?php if ($f11['sitter1_set_3'] == 1 || $session->userinfo['sit1'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag2"
                <?php if ($f11['sitter2_set_3'] == 1 || $session->userinfo['sit2'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    <tr>
        <th><?php echo PF_SITTEROP4; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag3"
                <?php if ($f11['sitter1_set_4'] == 1) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag3"
                <?php if ($f11['sitter2_set_4'] == 1) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    <tr>
        <th><?php echo PF_SITTEROP5; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag4"
                <?php if ($f11['sitter1_set_5'] == 1 || $session->userinfo['sit1'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag4"
                <?php if ($f11['sitter2_set_5'] == 1 || $session->userinfo['sit2'] == 0) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    <tr>
        <th><?php echo PF_SITTEROP6; ?></th>
        <td><input type="checkbox" value="1"
                   name="sitter1_flag5"
                <?php if ($f11['sitter1_set_6'] == 1) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
        <td><input type="checkbox" value="1"
                   name="sitter2_flag5"
                <?php if ($f11['sitter2_set_6'] == 1) {
                    echo 'checked="checked"';
                } ?> class="check"/></td>
    </tr>
    </tbody>
</table>
<h4 class="round spacer"><?php echo PF_SITFORANOTHER; ?></h4>
<input type="hidden" name="sitter_flag_posted" value="1">

<div class="text"><?php echo PF_SITFORANOTHERDESC; ?>
</div>
<table class="sitters transparent">
    <tbody>
    <tr>
        <th>
            <div class="boxes boxesColor lightGreen">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents"><span><?php echo PF_SITTER1; ?></span></div>
            </div>
        </th>
        <td>
            <?php
                if (!$database->getSitee1($session->uid)) {
                    echo '<span class="none">' . PF_NOSIT . '</span>';
                } else {
                    $getsit1 = $database->getSitee1($session->uid);
                    echo "<button type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&e=3&id=" . $session->uid . "&owner=" . $getsit1['id'] . "&a=" . $session->checker . "&type=1'; return false;\"><img src=\"img/x.gif\" class=\"del\" alt=\"helyettes\"></button>";
                    echo "&nbsp;" . $getsit1['username'];
                }
            ?>
        </td>
    </tr>
    <tr>
        <th>
            <div class="boxes boxesColor orange">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents"><span><?php echo PF_SITTER2; ?></span></div>
            </div>
        </th>
        <td>
            <?php
                if (!$database->getSitee2($session->uid)) {
                    echo '<span class="none">' . PF_NOSIT . '</span>';
                } else {
                    $getsit2 = $database->getSitee2($session->uid);
                    echo "<button type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&e=3&id=" . $session->uid . "&owner=" . $getsit2['id'] . "&a=" . $session->checker . "&type=2'; return false;\"><img src=\"img/x.gif\" class=\"del\" alt=\"helyettes\"></button>";
                    echo "&nbsp;" . $getsit2['username'];
                }
            ?></td>
    </tr>
    <table cellpadding="1" cellspacing="1" class="sitters2 spacer">
        <tbody>
        <tr class="sitterHead">
            <th><?php echo AL_PLAYER . ' ' . AL_NAME; ?></th>
            <td class="name" id="sitterName0"><?php $getsit1 = $database->getSitee1($session->uid);
                    echo $getsit1['username']; ?></td>
            <td class="name" id="sitterName1"><?php $getsit2 = $database->getSitee2($session->uid);
                    echo $getsit2['username']; ?></td>
        </tr>
        <tr>
            <?Php $f11 = $f12 = $database->getSit($session->uid); ?>
            <th><?php echo PF_SITTEROP1; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag00" disabled="disable"
                    <?php if ($f11['sitter1_set_1'] == 1 || $getsit1['sit1'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag00" disabled="disable"
                    <?php if ($f12['sitter2_set_1'] == 1 || $getsit1['sit2'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        <tr>
            <th><?php echo PF_SITTEROP2; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag11" disabled="disable"
                    <?php if ($f11['sitter1_set_2'] == 1 || $getsit1['sit1'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag11" disabled="disable"
                    <?php if ($f12['sitter2_set_2'] == 1 || $getsit1['sit2'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        <tr>
            <th><?php echo PF_SITTEROP3; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag22" disabled="disable"
                    <?php if ($f11['sitter1_set_3'] == 1 || $getsit1['sit1'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag22" disabled="disable"
                    <?php if ($f12['sitter2_set_3'] == 1 || $getsit1['sit2'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        <tr>
            <th><?php echo PF_SITTEROP4; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag33" disabled="disable"
                    <?php if ($f11['sitter1_set_4'] == 1) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag33" disabled="disable"
                    <?php if ($f12['sitter2_set_4'] == 1) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        <tr>
            <th><?php echo PF_SITTEROP5; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag44" disabled="disable"
                    <?php if ($f11['sitter1_set_5'] == 1 || $getsit1['sit1'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag44" disabled="disable"
                    <?php if ($f12['sitter2_set_5'] == 1 || $getsit1['sit2'] == 0) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        <tr>
            <th><?php echo PF_SITTEROP6; ?></th>
            <td><input type="checkbox" value="1"
                       name="sitter1_flag55" disabled="disable"
                    <?php if ($f11['sitter1_set_6'] == 1) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
            <td><input type="checkbox" value="1"
                       name="sitter2_flag55" disabled="disable"
                    <?php if ($f12['sitter2_set_6'] == 1) {
                        echo 'checked="checked"';
                    } ?> class="check"/></td>
        </tr>
        </tbody>
    </table>
    </tbody>
</table>
<div class="submitButtonContainer">
    <button type="submit" value="save" id="button52813724aae71" class="green ">
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
            if ($('button52813724aae71')) {
                $('button52813724aae71').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "save", "name": "", "id": "button52813724aae71", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                });
            }
        });
    </script>
</div>
</form>
<script type="text/javascript">
    window.addEvent('domready', function () {
        Travian.Form.UnloadHelper.watchHtmlForm($('settings'));
    });
</script>