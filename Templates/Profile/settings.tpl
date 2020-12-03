<form id="settings" action="options.php?s=1" method="post">
    <input type="hidden" name="f" value="1">
    <input type="hidden" name="t" value="1">
    <h4 class="round"><?php echo PF_FILTERS;?></h4>
    <table class="transparent set" cellpadding="1" cellspacing="1" id="report_filter">
        <tbody>
        <tr>
            <td class="sel">
                <input class="check" <?php

                    $query = mysql_query("SELECT `nopicn` FROM " . TB_PREFIX . "users_setting WHERE id = " . $session->uid . " LIMIT 1");
                    $res = mysql_fetch_assoc($query);

                    if ($res['nopicn'] == 1) {
                        echo 'checked';
                    }

                ?> type="checkbox" name="v4" value="1">
            </td>
            <td>
                <?php echo PF_NOPICINREP;?>
            </td>
        </tr>
        </tbody>
    </table>
    <h4 class="round spacer"><?php echo PF_TIMZEZONEPREF;?></h4>
    <table class="transparent set" cellpadding="1" cellspacing="1" id="timeSettings">
        <tbody>
        <tr>
            <td colspan="2">
                <?php echo PF_TIMZEZONEPREFDESC;?>
            </td>
        </tr>
        <tr>
            <th>
                <?php echo PF_TIMZEZONE;?>:
            </th>
            <td>
                <?php $q = mysql_query("SELECT `timezone` FROM " . TB_PREFIX . "users WHERE id = $session->uid");
                    $q = mysql_fetch_array($q);
                ?>
                <select name="timezone">
                    <optgroup label="local time zones">
                        <option value="30" <?php if ($q['timezone'] == 30) {
                            echo "selected=\"selected\"";
                        } ?> >Asia/Tehran
                        </option>
                        <option value="31" <?php if ($q['timezone'] == 31) {
                            echo "selected=\"selected\"";
                        } ?> >Canada/Central
                        </option>
                        <option value="32" <?php if ($q['timezone'] == 32) {
                            echo "selected=\"selected\"";
                        } ?> >Europe/Berlin
                        </option>
                        <option value="33" <?php if ($q['timezone'] == 33) {
                            echo "selected=\"selected\"";
                        } ?> >Australia/North
                        </option>
                        <option value="34" <?php if ($q['timezone'] == 34) {
                            echo "selected=\"selected\"";
                        } ?> >America/New_York
                        </option>
                        <option value="35" <?php if ($q['timezone'] == 35) {
                            echo "selected=\"selected\"";
                        } ?> >Australia/ACT
                        </option>
                    </optgroup>
                    <optgroup label="general time zones">
                        <option value="12" <?php if ($q['timezone'] == 12) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-11
                        </option>
                        <option value="13" <?php if ($q['timezone'] == 13) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-10
                        </option>
                        <option value="14" <?php if ($q['timezone'] == 14) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-9
                        </option>
                        <option value="15" <?php if ($q['timezone'] == 15) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-8
                        </option>
                        <option value="16" <?php if ($q['timezone'] == 16) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-7
                        </option>
                        <option value="17" <?php if ($q['timezone'] == 17) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-6
                        </option>
                        <option value="18" <?php if ($q['timezone'] == 18) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-5
                        </option>
                        <option value="19" <?php if ($q['timezone'] == 19) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-4
                        </option>
                        <option value="20" <?php if ($q['timezone'] == 20) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-3
                        </option>
                        <option value="21" <?php if ($q['timezone'] == 21) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-2
                        </option>
                        <option value="22" <?php if ($q['timezone'] == 22) {
                            echo "selected=\"selected\"";
                        } ?> >UTC-1
                        </option>
                        <option value="23" <?php if ($q['timezone'] == 23) {
                            echo "selected=\"selected\"";
                        } ?> >UTC
                        </option>
                        <option value="0" <?php if ($q['timezone'] == 0) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+1
                        </option>
                        <option value="1" <?php if ($q['timezone'] == 1) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+2
                        </option>
                        <option value="2" <?php if ($q['timezone'] == 2) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+3
                        </option>
                        <option value="3" <?php if ($q['timezone'] == 3) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+4
                        </option>
                        <option value="4" <?php if ($q['timezone'] == 4) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+5
                        </option>
                        <option value="5" <?php if ($q['timezone'] == 5) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+6
                        </option>
                        <option value="6" <?php if ($q['timezone'] == 6) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+7
                        </option>
                        <option value="7" <?php if ($q['timezone'] == 7) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+8
                        </option>
                        <option value="8" <?php if ($q['timezone'] == 8) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+9
                        </option>
                        <option value="9" <?php if ($q['timezone'] == 9) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+10
                        </option>
                        <option value="10" <?php if ($q['timezone'] == 10) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+11
                        </option>
                        <option value="11" <?php if ($q['timezone'] == 11) {
                            echo "selected=\"selected\"";
                        } ?> >UTC+12
                        </option>
                    </optgroup>
                </select>
            </td>
        </tr>
        <tr>
            <th class="timeFormat">
                <?php echo PF_DATEFORMAT;?>:
            </th>
            <td>
                <label>
                    <input class="radio" type="radio" name="tformat" value="0" disabled="disable"> UE - dd.mm.yy
                    24h</label>
                <label>
                    <input class="radio" type="radio" name="tformat" value="1" disabled="disable"> US - mm/dd/yy
                    12h</label>
                <label>
                    <input class="radio" type="radio" name="tformat" value="2" disabled="disable"> UK - dd/mm/yy
                    12h</label>
                <label>
                    <input class="radio" checked="checked" type="radio" name="tformat" value="3"> ISO - yy/mm/dd 24h
                </label>
            </td>
        </tr>
        </tbody>
    </table>

    <div class="submitButtonContainer">
        <button type="submit" value="save" name="s1" id="btn_ok" class="green ">
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
                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "save", "name": "s1", "id": "btn_ok", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
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