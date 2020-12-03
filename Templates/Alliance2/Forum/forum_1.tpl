<script language="JavaScript" type="text/javascript">
    function showCheckList() {
        bid = document.getElementById('bid');
        if (bid.value == 2) {
            document.getElementById('conf_list').className = '';
            document.getElementById('ally_list').className = '';
            document.getElementById('user_list').className = 'hide';
        }
        else if (bid.value == 3) {
            document.getElementById('conf_list').className = 'hide';
            document.getElementById('ally_list').className = 'hide';
            document.getElementById('user_list').className = '';
        }
        else {
            document.getElementById('conf_list').className = 'hide';
            document.getElementById('ally_list').className = 'hide';
            document.getElementById('user_list').className = 'hide';
        }
    }
</script>
<script language="JavaScript" type="text/javascript">

    function addRow(element_id) {
        // element_id: user_list, ally_list

        liste = document.getElementById(element_id);
        liste = liste.getElementsByTagName('tbody')[0];

        var anzahl_trs = liste.getElementsByTagName('tr').length;
        var num_fields = anzahl_trs;
        var num_last_tr = anzahl_trs - 1;

        lastTR = liste.getElementsByTagName('tr')[num_last_tr];
        lastTD = lastTR.getElementsByTagName('td')[2];
        lastIMG = lastTD.getElementsByTagName('img')[0];
        lastTD.removeChild(lastIMG);

        newTR = document.createElement('tr');
        newTD1 = document.createElement('td');
        newTD2 = document.createElement('td');
        newTD3 = document.createElement('td');
        newTR.appendChild(newTD1);
        newTR.appendChild(newTD2);
        newTR.appendChild(newTD3);
        liste.appendChild(newTR);

        var html_input_1 = '<input class="text" type="text" ';

        if (element_id == 'ally_list') {
            newTD1.className = 'ally';
            newTD2.className = 'tag';
            newTD3.className = 'ad';
            newTD1.innerHTML = html_input_1 + 'id="allys_by_id_' + num_fields + '" class="text" maxlength="8" name="allys_by_id[' + num_fields + ']" onkeyup="checkInputs(' + num_fields + ',\'allys\')">';
            newTD2.innerHTML = html_input_1 + 'id="allys_by_name_' + num_fields + '" class="text" maxlength="8" name="allys_by_name[' + num_fields + ']" onkeyup="checkInputs(' + num_fields + ',\'allys\')">';
        }

        if (element_id == 'user_list') {
            newTD1.className = 'id';
            newTD2.className = 'pla';
            newTD3.className = 'ad';
            newTD1.innerHTML = html_input_1 + 'id="users_by_id_' + num_fields + '" class="text" maxlength="8" name="users_by_id[' + num_fields + ']" onkeyup="checkInputs(' + num_fields + ',\'users\')">';
            newTD2.innerHTML = html_input_1 + 'id="users_by_name_' + num_fields + '" class="text" maxlength="15" name="users_by_name[' + num_fields + ']" onkeyup="checkInputs(' + num_fields + ',\'users\')">';
        }

        newTD3.innerHTML = '<img class="add" src="img/x.gif" title="<?php echo AL_ADD;?>" alt="<?php echo AL_ADD;?>" onclick="addRow(\'' + element_id + '\')">';
    }

</script>
<script language="JavaScript" type="text/javascript">

    function checkInputs(id, typ) {
        id_field = document.getElementById(typ + '_by_id_' + id);
        name_field = document.getElementById(typ + '_by_name_' + id);

        //alert(id_field.value);
        //alert(name_field.value);

        if (id_field.value != '' && id_field.disabled == false) {
            name_field.disabled = true;
            name_field.style.border = '1px solid #999';
        }
        else {
            name_field.disabled = false;
            name_field.style.border = '1px solid #71D000';
        }

        if (name_field.value != '' && name_field.disabled == false) {
            id_field.disabled = true;
            id_field.style.border = '1px solid #999';
        }
        else {
            id_field.disabled = false;
            id_field.style.border = '1px solid #71D000';
        }
    }

</script>

<form method="post" action="allianz.php?s=2">
    <input type="hidden" name="new" value="1">

    <input type="hidden" name="newforum" value="1">
    <input type="hidden" name="admin" value="1">
    <h4 class="round"><?php echo AL_NEWFORUM;?></h4>
    <table cellpadding="1" cellspacing="1" id="new_forum">
        <tbody>
        <tr>

            <th><?php echo AL_FORUMNAME;?></th>
            <td><input class="text" type="text" name="u1" value="" maxlength="20"></td>
        </tr>

        <tr>
            <th><?php echo AL_DESCRIPTION;?></th>
            <td><input class="text" type="text" name="u2" value="" maxlength="38"></td>
        </tr>

        <th><?php echo AL_FORUMTYPE;?></th>
        <td><select class="dropdown" id="bid" name="bid" onchange="showCheckList();">
                <option value="1"><?php echo AL_PUBFORUM;?></option>
                <option value="2"><?php echo AL_CONFFORUM;?></option>
                <option value="0" selected><?php echo AL_ALLYFORUM;?></option>
                <option value="3"><?php echo AL_CLOSEFORUM;?></option>
            </select></td>
        </tr>
        </tbody>
    </table>
    <Br/>
    <script language="JavaScript" type="text/javascript">
        showCheckList();
    </script>
    <p class="btn" align="center">
        <button type="submit" value="save" class="green build" name="s1" id="btn_save">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo AL_CREATE;?></div>
            </div>
        </button>
    </p>
</form>