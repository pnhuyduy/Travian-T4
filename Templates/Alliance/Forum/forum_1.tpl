<!-- //////////////// made by TTMTT //////////////// -->
<script language="JavaScript" type="text/javascript">
function showCheckList() {
	bid = document.getElementById('bid');
	if(bid.value == 2) {
		if ($('conf_list'))
		{
			$('conf_list').className = '';
			$('conf_list_headline').removeClass('hide');
		}
		if ($('ally_list'))
		{
			$('ally_list').className = '';
			$('ally_list_headline').removeClass('hide');
		}
		if ($('user_list'))
		{
			$('user_list').className = 'hide';
			$('user_list_headline').addClass('hide');
		}
	}
	else if (bid.value == 3) {
		if ($('conf_list')){
			$('conf_list').className = 'hide';
			$('conf_list_headline').addClass('hide');
		}
		if ($('ally_list')){
			$('ally_list').className = 'hide';
			$('ally_list_headline').addClass('hide');
		}
		if ($('user_list')){
			$('user_list').className = '';
			$('user_list_headline').removeClass('hide');
		}
	}
	else {
		if ($('conf_list'))
		{
			$('conf_list').className = 'hide';
			$('conf_list_headline').addClass('hide');
		}
		if ($('ally_list'))
		{
			$('ally_list').className = 'hide';
			$('ally_list_headline').addClass('hide');
		}
		if ($('user_list'))
		{
			$('user_list').className = 'hide';
			$('user_list_headline').addClass('hide');
		}
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
    	var num_last_tr = anzahl_trs -1;

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

		if(element_id == 'ally_list') {
			newTD1.className = 'ally';
			newTD2.className = 'tag';
			newTD3.className = 'ad';
			newTD1.innerHTML = html_input_1 + 'id="allys_by_id_'+num_fields+'" class="text" maxlength="8" name="allys_by_id['+num_fields+']" onkeyup="checkInputs('+num_fields+',\'allys\')">';
			newTD2.innerHTML = html_input_1 + 'id="allys_by_name_'+num_fields+'" class="text" maxlength="8" name="allys_by_name['+num_fields+']" onkeyup="checkInputs('+num_fields+',\'allys\')">';
		}

		if(element_id == 'user_list') {
			newTD1.className = 'id';
			newTD2.className = 'pla';
			newTD3.className = 'ad';
			newTD1.innerHTML = html_input_1 + 'id="users_by_id_'+num_fields+'" class="text" maxlength="8" name="users_by_id['+num_fields+']" onkeyup="checkInputs('+num_fields+',\'users\')">';
			newTD2.innerHTML = html_input_1 + 'id="users_by_name_'+num_fields+'" class="text" maxlength="15" name="users_by_name['+num_fields+']" onkeyup="checkInputs('+num_fields+',\'users\')">';
		}

		newTD3.innerHTML = '<img class="add" src="img/x.gif" title="add" alt="add" onclick="addRow(\''+element_id+'\')">';
    }

</script>
<script language="JavaScript" type="text/javascript">
	
    function checkInputs(id, typ) {
		id_field = document.getElementById(typ+'_by_id_'+id);
		name_field = document.getElementById(typ+'_by_name_'+id);
		
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
    
	</script><form method="post" action="allianz.php?s=2">
	<input type="hidden" name="new" value="1">

	<input type="hidden" name="newforum" value="1">
	<input type="hidden" name="admin" value="1">

	<table cellpadding="1" cellspacing="1" id="new_forum"><thead>
	<tr>
    	<th colspan="2"><?php echo AL_NEWFORUM;?></th>
	</tr>
	</thead><tbody>
	<tr>

		<th><?php echo AL_FORUMNAME;?> </th>
		<td><input class="text" type="text" name="u1" value="" maxlength="20"></td>
	</tr>

	<tr>
		<th><?php echo AL_DESCRIPTION;?> </th>
		<td><input class="text" type="text" name="u2" value="" maxlength="38"></td>
	</tr>

	<tr>
		<th><?php echo AL_FORUMTYPE;?> </th>
		<td><select class="dropdown" id="bid" name="bid" onchange="showCheckList();"><option value="1"><?php echo AL_PUBFORUM;?></option><option value="2"><?php echo AL_CONFFORUM;?></option><option value="0"selected><?php echo AL_ALLYFORUM;?></option><option value="3"><?php echo AL_CLOSEFORUM;?></option></select></td>
	</tr>
	</tbody></table><h4 id="ally_list_headline" class="tableHeadline hide"><?php echo AL_OPENFORMOREALLY;?></h4>
	<table cellpadding="1" cellspacing="1" id="ally_list" class="hide"><thead>
	<tr>
		<td><?php echo AL_ALLYID;?>:</td>
		<td><?php echo AL_TAG;?>:</td>
		<td><?php echo AL_ADD;?></td>
	</tr>

	</thead><tbody>
	<tr>
		<td class="ally">
			<input class="text" type="text" id="allys_by_id_0" maxlength="8" name="allys_by_id[0]" onkeyup="checkInputs(0,'allys');" />
		</td>
		<td class="tag">
			<input class="text" type="text" id="allys_by_name_0" maxlength="8" name="allys_by_name[0]" onkeyup="checkInputs(0,'allys');" />
		</td>
		<td class="ad">

			<img class="add" src="img/x.gif" title="add" alt="add" onclick="addRow('ally_list')" />
		</td>
	</tr>
</table><h4 id="user_list_headline" class="tableHeadline hide"><?php echo AL_OPENFORMOREPLAYERS;?></h4>
	<table cellpadding="1" cellspacing="1" id="user_list" class="hide"><thead>
	<tr>
		<td><?php echo AL_USERID;?>:</td>
		<td><?php echo AL_NAME;?>:</td>
		<td><?php echo AL_ADD;?></td>
	</tr>
	</thead><tbody>
	<tr>
		<td class="id">
			<input class="text" type="text" id="users_by_id_0" maxlength="8" name="users_by_id[0]" onkeyup="checkInputs(0,'users');" />
		</td>

		<td class="pla">
			<input class="text" type="text" id="users_by_name_0" maxlength="15" name="users_by_name[0]" onkeyup="checkInputs(0,'users');" />
		</td>
		<td class="ad">
			<img class="add" src="img/x.gif" title="add" alt="add" onclick="addRow('user_list')" />
		</td>
	</tr>
</tbody></table>

<script language="JavaScript" type="text/javascript">
	showCheckList();
</script>

<p class="btn"><button  type="submit" value="ok" name="s1" id="s1" class="green ">
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
	window.addEvent('domready', function()
	{
	if($('s1'))
	{
		$('s1').addEvent('click', function ()
		{
			window.fireEvent('buttonClicked', [this, {"type":"submit","value":"ok","name":"s1","id":"s1","class":"green ","title":"","confirm":"","onclick":""}]);
		});
	}
	});
</script></p></form>