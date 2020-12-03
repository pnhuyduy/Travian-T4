<script>

function validateChar(evt) {
    var e = evt || window.event;
    var key = e.keyCode || e.which;

    if (

    // numbers   
    key >= 48 && key <= 57 ||

    // english keypad
    key >= 97 && key <= 122 ||
    key >= 65 && key <= 90 ||    

    // farsi keypad    
key == 1570 || key == 1575 || key == 1576 || key == 1662 || key == 1578 || key == 1579 || key == 1688 || key == 1670 ||  key == 1705 || key == 1711 || key == 1740 || key == 1574 ||  ( key >= 1580 && key <= 1594 ) ||  ( key >= 1601 && key <= 1608 ) || (key >= 1632 && key <= 1641) ||    

    // symbol keypad	
   key == 95 || key == 38 || key == 35 || key == 36 || key == 64 || key == 37 || key == 39 || key == 46 || key == 45 || key == 8 || key == 9 || key == 13 || key == 42 )
 {
    
    

        // input is VALID
    }
    else {
        // input is INVALID
        

    
        e.returnValue = false;
        if (e.preventDefault) e.preventDefault();
    }
}


function validateCtrl(evt) {
    var e = evt || window.event;
    var key = e.keyCode || e.which;

    if (!e.altKey && !e.ctrlKey &&
    // numbers   
    key >= 0 && key <= 2000 )
 {
    
    

        // input is VALID
    }
    else {
        // input is INVALID
        

    
        e.returnValue = false;
        if (e.preventDefault) e.preventDefault();
    }
}

</script>
<script>

function validateNumber(evt) {
    var e = evt || window.event;
    var key = e.keyCode || e.which;

    if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
    // numbers   
    key >= 48 && key <= 57 ||
    // Numeric keypad
    key >= 96 && key <= 105 ||
    // Backspace and Tab and Enter
    key == 8 || key == 9 || key == 13 ||
    // Home and End
    key == 35 || key == 36 ||
    // left and right arrows
    key == 37 ||key == 39 ||
    // Del and Ins
    key == 46 || key == 45) {
    
    

        // input is VALID
    }
    else {
        // input is INVALID
        

    
        e.returnValue = false;
        if (e.preventDefault) e.preventDefault();
    }
}
</script>

<?php 
$varmedal = $database->getProfileMedal($session->uid);  ?>
<form action="spieler.php" method="POST">
    <input type="hidden" name="ft" value="p1" />
    <input type="hidden" name="uid" value="<?php echo $session->uid; ?>" />
    <input type="hidden" name="id" value="<?php echo $id; ?>" />
		<h4 class="round">&#1608;&#1740;&#1585;&#1575;&#1740;&#1588; &#1662;&#1585;&#1608;&#1601;&#1575;&#1740;&#1604;</h4>
	<table cellpadding="1" cellspacing="1" id="editDetails" class="transparent">
		<tbody>
			<tr>
                <?php 
    if($session->userinfo['birthday'] != 0) {
   $bday = explode("-",$session->userinfo['birthday']);
   }
   else {
   $bday = array('','','');
   }
   ?>

				<th class="birth">&#1578;&#1608;&#1604;&#1583;</th>
				<td class="birth">
					
					<input tabindex="3" type="text" name="jahr" value="<?php echo $bday[0]; ?>" maxlength="4" class="text year">
                    <select tabindex="2" name="monat" class="dropdown">
<option value="0"></option><option value="1" <?php if($bday[1] == 1) { echo "selected"; } ?>>January</option><option value="2"<?php if($bday[1] == 2) { echo "selected"; } ?>>Febuary</option><option value="3"<?php if($bday[1] == 3) { echo "selected"; } ?>>March</option><option value="4"<?php if($bday[1] == 4) { echo "selected"; } ?>>April</option><option value="5"<?php if($bday[1] == 5) { echo "selected"; } ?>>May</option><option value="6"<?php if($bday[1] == 6) { echo "selected"; } ?>>June</option><option value="7"<?php if($bday[1] == 7) { echo "selected"; } ?>>July</option><option value="8"<?php if($bday[1] == 8) { echo "selected"; } ?>>August</option><option value="9"<?php if($bday[1] == 9) { echo "selected"; } ?>>September</option><option value="10"<?php if($bday[1] == 10) { echo "selected"; } ?>>October</option><option value="11"<?php if($bday[1] == 11) { echo "selected"; } ?>>November</option><option value="12"<?php if($bday[1] == 12) { echo "selected"; } ?>>December</option>                	</select>
                    <input tabindex="1" class="text day" type="text" name="tag" value="<?php echo $bday[2]; ?>" maxlength="2">
                    </td>
				<th class="gender" rowspan="2">&#1580;&#1606;&#1587;&#1740;&#1578;</th>
				<td class="gender" rowspan="2">
					<label>
						<input class="radio" type="radio" name="mw" value="0" <?php if($session->userinfo['gender'] == 0) { echo "checked"; } ?>> &#1605;&#1588;&#1582;&#1589; &#1606;&#1588;&#1583;&#1607;</label><br>
					<label>
						<input class="radio" type="radio" name="mw" value="1" tabindex="5" <?php if($session->userinfo['gender'] == 1) { echo "checked"; } ?>> &#1662;&#1587;&#1585; </label><br>
					<label>
						<input class="radio" type="radio" name="mw" value="2" <?php if($session->userinfo['gender'] == 2) { echo "checked"; } ?>>&#1583;&#1582;&#1578;&#1585;</label>
				</td>
			</tr>
			<tr>
				<th>&#1605;&#1581;&#1604;</th>
				<td><input tabindex="4" type="text" name="ort" value="<?php echo $session->userinfo['location']; ?>" maxlength="30" class="text">
				</td>
			</tr>
		</tbody>
	</table>

		<h4 class="round spacer">&#1578;&#1608;&#1590;&#1740;&#1581;&#1575;&#1578;</h4>
	<textarea tabindex="6" style="text-align:center;" class="editDescription editDescription1" name="be1"><?php echo $session->userinfo['desc2']; ?></textarea>
	<textarea tabindex="7" style="text-align:center;" class="editDescription editDescription2" name="be2"><?php echo $session->userinfo['desc1']; ?></textarea>
	<div class="clear"></div>

				<div class="switchWrap">
			<div class="openedClosedSwitch switchClosed" id="switchMedals">&#1605;&#1583;&#1575;&#1604; &#1607;&#1575;</div>
			<div class="clear"></div>
		</div>

		<table cellpadding="1" cellspacing="1" id="medals" class="hide">
			<thead>
				<tr>
					<td>&#1711;&#1585;&#1608;&#1607;</td>
					<td>&#1585;&#1578;&#1576;&#1607;</td>
					<td>&#1607;&#1601;&#1578;&#1607;</td>
					<td>&#1705;&#1583; BB</td>
				</tr>
			</thead>
			<tbody>
									<tr>
													<td class="typ"><?php echo BEGINNERPROTECTION;?></td>
													<td class="ra"></td>
													<td class="we"></td>
													<td class="bb">[#0]</td>
											</tr>
            <?php
/******************************
INDELING CATEGORIEEN:
===============================
== 1. Aanvallers top 10      ==
== 2. Defence top 10         ==
== 3. Klimmers top 10        ==
== 4. Overvallers top 10     ==
== 5. In att en def tegelijk ==
== 6. in top 3 - aanval      ==
== 7. in top 3 - verdediging ==
== 8. in top 3 - klimmers    ==
== 9. in top 3 - overval     ==
******************************/				
				
				
	foreach($varmedal as $medal) {
	$titel=MEDALS;
	switch ($medal['categorie']) {
    case "1":
        $titel=AOFW;
        break;
    case "2":
        $titel=DOFW;
        break;
    case "3":
        $titel=COFW;
        break;
    case "4":
        $titel=ROFW;
        break;
    case "5":
        $titel=ADOFW;
        break;
    case "6":
        $titel=sprintf(TOP3AOFW,$medal['points']);
        break;
    case "7":
        $titel=sprintf(TOP3DOFW,$medal['points']);
        break;
    case "8":
        $titel=sprintf(TOP3COFW,$medal['points']);
        break;
    case "9":
        $titel=sprintf(TOP3COFW,$medal['points']);
        break;
    case "10":
        $titel=COFW;
        break;
    case "11":
        $titel=sprintf(TOP3COFW,$medal['points']);
        break;
    case "12":
        $titel=sprintf(TOP10AOFW,$medal['points']);
        break;
	}			
				 echo"<tr>
				   <td class=\"typ\"> ".$titel."</td>
				   <td class=\"ra\">".$medal['plaats']."</td>
				   <td class=\"we\">".$medal['week']."</td>
				   <td class=\"bb\">[#".$medal['id']."]</td>
			 	 </tr>";
				 } ?>				
				

			</tbody>
		</table>
	
		<h4 class="round spacer"><?php echo VILLAGES;?></h4>

	<table cellpadding="1" cellspacing="1" id="villages">
		<thead>
			<tr>
				<th class="name">&#1606;&#1575;&#1605;</th>
                <th>&#1570;&#1576;&#1575;&#1583;&#1740;</th>
				<th>&#1580;&#1605;&#1593;&#1740;&#1578;</th>
                <th>&#1605;&#1582;&#1578;&#1589;&#1575;&#1578;</th>
			</tr>
		</thead>
		<tbody>
<?php
$prefix = "".TB_PREFIX."vdata";
	$sql = mysql_query("SELECT * FROM $prefix WHERE owner = $session->uid ORDER BY pop DESC");
    $name = 0;

	while($row = mysql_fetch_array($sql)){ 
	$vname = $row['name'];
	if($row['owner']==2){$cVName = defined($vname);($cVName?constant($vname):$vname);}
    echo "<tr>";
    echo "<td class=\"name\"><input tabindex=\"6\" type=\"text\" name=\"dname$name\" oncontextmenu=\"return false;\" AUTOCOMPLETE=\"off\" onkeypress=\"validateChar(event);\" onkeydown=\"validateCtrl(event);\" value=\"".$vname."\" maxlength=\"14\" class=\"text\"> ";
    if($row['capital'] == 1) {
        echo "<span class=\"mainVillage\">(<?php echo CAPITAL;?>)</span>";
    }
    echo "</td>";
    echo "<td class=\"oases\">";
$prefix = "".TB_PREFIX."odata";
$sql2 = mysql_query("SELECT * FROM $prefix WHERE owner = ".$session->uid." AND conqured = ".$row['wref']."");
while($row2 = mysql_fetch_array($sql2)){
$type = $row2["type"];
switch($type) {
case 1:
case 2:
echo  "<img class='r1' src='img/x.gif' title='".WOOD."'>";
break;
case 3:
echo  "<img class='r1' src='img/x.gif' title='".WOOD."'> <img class='r4' src='img/x.gif' title='".CROP."'>";
break;
case 4:
case 5:
echo  "<img class='r2' src='img/x.gif' title='".CLAY."'>";
break;
case 6:
echo  "<img class='r2' src='img/x.gif' title='".CLAY."'> <img class='r4' src='img/x.gif' title='".CROP."'>";
case 7:
case 8:
echo  "<img class='r3' src='img/x.gif' title='".IRON."'>";
break;
case 9:
echo  "<img class='r3' src='img/x.gif' title='".IRON."'> <img class='r4' src='img/x.gif' title='".CROP."'>";
break;
case 10:
case 11:
case 12:
echo  "<img class='r4' src='img/x.gif' title='".CROP."'>";
break;
}
}
    echo "</td>";
    echo "<td class=\"inhabitants\"> ".$row['pop']." </td>";
    $prefix = "".TB_PREFIX."wdata";
    $sql2 = mysql_query("SELECT * FROM $prefix WHERE id = ".$row['wref']."");
    $coords = mysql_fetch_array($sql2);
    echo "<td class=\"coords\"><a href=\"karte.php?x=".$coords['y']."&y=".$coords['x']."\"><span class=\"coordinates coordinatesAligned\"><span class=\"coordinatesWrapper\">";
    if (DIRECTION == 'ltr'){
		echo "<span class=\"coordinateX\">(".$coords['x']."</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateY\">".$coords['y'].")</span>";
	}elseif (DIRECTION == 'rtl'){
		echo "<span class=\"coordinateY\">".$coords['y'].")</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateX\">(".$coords['x']."</span>";
	}
    echo "</span></span></td>";
    echo "</tr>";
    $name++;
    }
    ?>
					</tbody>
	</table>

	<div class="submitButtonContainer">
		<button type="submit" value="submit" name="s1" id="btn_ok"><div class="button-container"><div class="button-position"><div class="btl"><div class="btr"><div class="btc"></div></div></div><div class="bml"><div class="bmr"><div class="bmc"></div></div></div><div class="bbl"><div class="bbr"><div class="bbc"></div></div></div></div><div class="button-contents">&#1584;&#1582;&#1740;&#1585;&#1607;</div></div></button></div>
</form><script type="text/javascript">
	window.addEvent('domready', function()
	{
		if ($('switchMedals'))
		{
			$('switchMedals').addEvent('click', function(e)
			{
				Travian.toggleSwitch($('medals'), $('switchMedals'));
			});
		}
	});


</script>
