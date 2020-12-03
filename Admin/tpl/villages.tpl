<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       villages.tpl                                                ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianX Project                                            ##
##  Copyright:     TravianX (c) 2010-2011. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<style>
.del {width:12px; height:12px; background-image: url(images/icon/deleteitems-icon.png);} 
</style>  
<table align="center" cellpadding="1" cellspacing="1" border="1" width="650">
	<thead>
		<tr><th colspan="4"><div align="center"><ul class="tabs"><center><li>Villages</li></center></ul></div></th></tr>
		<tr><th>Name</th><th>Population</th><th>Coordinates</th><th>Options</th></tr>
	</thead> 
	<?php
	$delLink = '';
	for ($i = 0; $i <= count($varray)-1; $i++) {
		$coorproc = $database->getCoor($varray[$i]['wref']);
		if($varray[$i]['capital']){
			$capital = ' - Capital';
			//$delLink = '<a href="#"><img src="../img/Admin/del_g.gif" class="del"></a>'; 
		}else{
			$capital = '';
			if($_SESSION['access'] == ADMIN){
				//$delLink = '<a href="?action=delVil&did='.$varray[$i]['wref'].'" onClick="return del(\'did\','.$varray[$i]['wref'].');"><img src="../img/Admin/del.gif" class="del"></a>';
			}else if($_SESSION['access'] == MULTIHUNTER){
				//$delLink = '<a href="#"><img src="../img/Admin/del_g.gif" class="del"></a>';
			}
		}
		echo '<tr>
				<td><a href="?p=village&did='.$varray[$i]['wref'].'">'.$varray[$i]['name'].'</a> '.$capital.'</td>
				<td>'.$varray[$i]['pop'].' <a href="?action=recountPop&did='.$varray[$i]['wref'].'">Recount</a></td>
				<td>('.$coorproc['x'].'|'.$coorproc['y'].')</td>
				<td>'.$delLink.' </td>
			</tr>'; 
	} 
	?>
	<tr>
		<td colspan="4">
			<form method="post" action="admin.php">
				<input name="action" type="hidden" value="addVillage"/>
				<input name="uid" type="hidden" value="<?php echo $user['id'];?>"/>
				<table id="member" style="width: 225px;" align="center"> 
					<thead><tr><th colspan="2">Add Village</th></tr></thead>
					<tr>
						<td colspan="2"><center>Coordinates (<b>X</b>|<b>Y</b>)</center></td>
					</tr>
					<tr>
						<td>X:</td>
						<td><input name="x" class="fm" value="" type="input" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>/></td>
					</tr>
					<tr>
						<td>Y:</td>
						<td><input name="y" class="fm" value="" type="input" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>/></td>
					</tr>
					<tr>
						<td colspan="2"><center><input value="Add Village" type="submit" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>/></center></td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>
