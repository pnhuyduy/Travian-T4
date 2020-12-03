<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       player.tpl                                                  ##
##  Developed by:  Jok3r                                                       ##
##  License:       TravianX Project                                            ##
##  Copyright:     TravianX (c) 2010-2011. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<?php
$id = $_GET['uid'];
if(isset($id)){        
	$user = $database->getUser($id,1);    
	$varray = $database->getProfileVillages($id);
	if($user){
		$totalpop = 0;
		foreach($varray as $vil) {$totalpop += $vil['pop'];}
		$deletion = false;
		if($deletion){?>  
			<table align="center" cellpadding="1" cellspacing="1" border="1" width="650">
			  <tr>
				<td>The account will be deleted in <span class="c2">79:56:11</span>
				  <a href="?action=StopDel&uid=<?php echo $user['id'];?>" onClick="return del('stopDel','<?php echo $user['username'];?>');"><img src="img/x.gif" class="del"></a>
				</td>
			  </tr>
			</table>
		<?php } ?>
		<table align="center" cellpadding="1" cellspacing="1" border="1" width="650">
			<thead>
				<tr><th colspan="3"><div align="center"><ul class="tabs"><center><li><a href="index.php?p=player&uid=<?php echo $user['id'];?>"><?php echo $user['username'];?></a></li></center></ul></div></th></tr>                                       
				<tr><th colspan="3" style="height:5px;"></th></tr>
				<tr><th>Details</th><th>Description 1 </th><th>Description 2</th></tr>
			</thead>
			<tbody>
				<tr><td colspan="3" style="height:5px;"></td></tr>
				<tr>
					<td class="details" width="30%">
						<table cellpadding="1" cellspacing="1" border="1">
							<tr>
								<th>Rank</th>
								<td><!-- ?php //echo $ranking->searchRank($displayarray['username'],"username"); ? --></td>
							</tr>
							<tr>
								<th>Tribe</th>
								<td>
									<?php                        
									if($user['tribe'] == 1) {echo "Roman";
									}else if($user['tribe'] == 2){echo "Teutons";
									}else if($user['tribe'] == 3) {echo "Gauls";
									}else if($user['tribe'] == 4) {echo "Natars";
									} ?>
								</td>
							</tr>
							<tr>
								<th>Alliance</th>
								<td>
									<?php 
									if($user['alliance'] == 0) {echo "-";
									}else {
										echo "<a href=\"?p=alliance&aid=".$user['alliance']."\">".$database->getAllianceName($user['alliance'])."</a>";
									} ?>
								</td>
							</tr>
							<tr>
								<th>Villages</th>
								<td><?php echo count($varray);?></td>
							</tr>
							<tr>
								<th>Population</th>
								<td><?php echo $totalpop;?> <a href="?action=recountPopUsr&uid=<?php echo $user['id'];?>">Recount</a></td>
							</tr>
							<?php 
							if(isset($user['birthday']) && $user['birthday'] != 0) {
								$age = date("Y")-substr($user['birthday'],0,4);
							}
							?>
							<tr>
								<th>Age</th>
								<td><?php echo $age;?> </td>
							</tr>
							<?php
							if(isset($user['gender']) && $user['gender'] != 0) {
								$gender = ($user['gender']== 1)? "Male" : "Female";
							}
							?>
							<tr>
								<th>Gender</th>
								<td><?php echo $gender;?></td>
							</tr>
							<tr>
								<th>Location</th>
								<td><input disabled class="fm" name="location" value="<?php echo $user['location'];?>"></td>
							</tr>
							<?php
							if(date('d/m/Y H:i',$user['plus']) < time()) {
								$pd = "Not enabled!";
							} else {
								$pd = "".date('d/m/Y H:i',$user['plus']+3600*2)."";
							}
							?>
							<tr>
								<th><b><font color='#71D000'>P</font><font color='#FF6F0F'>l</font><font color='#71D000'>u</font><font color='#FF6F0F'>s</font></b></th>
								<td><?php echo $pd;?> </td>
							</tr>
							<tr>
								<th>Email</th>
								<td><input disabled class="fm" name="email" value="<?php echo $user['email'];?>"/></td>
							</tr>
							<tr>
								<td colspan="2" class="empty"></td>
							</tr>
							<?php
							if($_SESSION['access'] == ADMIN){
								echo '<tr><td colspan="2" style="height:2px;"></td></tr><tr><td colspan="2"><a href="?p=editprofile&uid='.$user['id'].'">&raquo; Edit profile</a></td></tr>';
							} else if($_SESSION['access'] == MULTIHUNTER){
								echo '';
							}
							echo '<tr><td colspan="2" style="height:2px;"></td></tr><tr><td colspan="2"> <a href="?p=newmessage&uid='.$user['id'].'">&raquo; Write message</a></td></tr>';
							if($_SESSION['access'] == ADMIN){
								echo '<tr><td colspan="2" style="height:2px;"></td></tr><tr><td colspan="2"><a class="rn3" href="?action=deleteuser&uid='.$user['id'].'">&raquo; Delete player</a></td></tr>';
							} else if($_SESSION['access'] == MULTIHUNTER){
								echo '';
							}
							?>
							<tr><td colspan="2" style="height:2px;"></td></tr>
							<tr>
								<th>Hero revive</th>
								<td><a href="index.php?action=ihr&uid=<?php echo $user['id'];?>">revive hero now</a></td>
							</tr>
							<tr><td colspan="2" style="height:2px;"></td></tr>
							<tr>
								<?php
								if ($user['goldclub']!=0){?>
								<th>Deactivate Gold Club</th>
								<td><a href="index.php?action=delGoldClub&uid=<?php echo $user['id'];?>">Deactivate</a></td>
								<?php
								} else {
								?>
								<th>Activate Gold Club</th>
								<td><a href="index.php?action=addGoldClub&uid=<?php echo $user['id'];?>">Activate</a></td>
								<?php
								}
								
								?>
							</tr>
							<tr><td colspan="2" style="height:2px;"></td></tr>
							<tr>
								<?php
								if ($user['access']>=2){?>
								<th>Ban Player</th>
								<td>
										<form method="post" action="index.php">
											<input name="action" type="hidden" value="addBan"/>
											<input name="uid" type="hidden" value="<?php echo $user['id'];?>"/>
											<label for="time">time (in seconds):<label><input type="text" name="time" value="0"/><br/>
											<input value="OK" type="submit">
										</form>
								</td>
								<?php
								} else {
								?>
								<th>Unban Player</th>
								<td>
									<a href="index.php?action=delBan&uid=<?php echo $user['id'];?>">Unban</a>
								</td>
								<?php
								}
								
								?>
							</tr>
							<tr><td colspan="2" style="height:2px;"></td></tr>
							<tr>
								<th>Punish Player</th>
								<td>
										<form method="post" action="index.php">
											<input name="action" type="hidden" value="punish"/>
											<input name="uid" type="hidden" value="<?php echo $user['id'];?>"/>
											<select name="punish">
												<option name="punish" value="10" selected="selected">10%
												<option name="punish" value="20">20%
												<option name="punish" value="30">30%
												<option name="punish" value="40">40%
												<option name="punish" value="50">50%
												<option name="punish" value="60" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>>60%
												<option name="punish" value="70" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>>70%
												<option name="punish" value="80" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>>80%
												<option name="punish" value="90" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>>90%
												<option name="punish" value="100" <?php if($_SESSION['access'] == ADMIN){ echo ''; } else if($_SESSION['access'] == MULTIHUNTER){ echo 'disabled="disabled"'; } ?>>100%</option>
											</select><br/>
											<input type="checkbox" name="del_troop" value="1"> Delete troops </input><br/>
											<input type="checkbox" name="clean_ware" value="1"> Empty warehouses </input><br/>
											<input value="OK" type="submit">
										</form>
								</td>
							</tr>
						</table>
					</td>
					<td class="desc1" width="40%">
						<center><?php echo nl2br($user['desc1']); ?></center>
					</td>
					<td class="desc1" width="40%">
						<center><?php echo nl2br($user['desc2']); ?></center>
					</td>
				</tr>
			</tbody>
		</table>
<!-- GOLD -->
		<table align="center" cellpadding="1" cellspacing="1" border="1" width="650"> 
			<thead>
				<tr>
					<th colspan="8">
						<div align="center"><ul class="tabs"><center><li>Gold Balance Table</li></center></ul></div>
					</th>
				</tr>
				<tr><th>Gold Balance</th><th>Gold</th><th>Bought gold</th><th>Gift gold</th><th>Transfered gold</th><th>SEG gold</th><th>Used gold</th><th>Options</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<center>
						<?php
							$pgold = $user['boughtgold']+$user['giftgold']+$user['seggold']+$user['transferedgold']; $ngold = $user['usedgold'];
							$gb = $pgold-$ngold; 
							echo $gb;
						?>
						</center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='Gold' title='This user has: <?php echo $user['gold']; ?> gold'/> <?php echo $user['gold']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='Bought Gold' title='This user bought : <?php echo $user['boughtgold']; ?> gold'/> <?php echo $user['boughtgold']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='Gift Gold' title='This user gained : <?php echo $user['giftgold']; ?> gold'/> <?php echo $user['giftgold']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='Transfered Gold' title='This user transfered : <?php echo $user['transferedgold']; ?> gold to this account'/> <?php echo $user['transferedgold']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='SEG (silver exchanged to gold) Gold' title='This user gained : <?php echo $user['seggold']; ?> gold by exchanging silver'/> <?php echo $user['seggold']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/gold.gif' class='gold' alt='Used Gold' title='This user used : <?php echo $user['usedgold']; ?> gold fro advantages'/> <?php echo $user['usedgold']; ?></center>
					</td>
					<td>
						<?php if($_SESSION['access'] == ADMIN){
							 echo '<center><a href="index.php?p=gold&uid='.$id.'"><img src="../img/admin/edit.gif" title="Edit Gold Balance"></a></center>';
						} ?>
					</td>
				</tr>
			</tbody>
		</table>
<!-- SILVER -->
		<table align="center" cellpadding="1" cellspacing="1" border="1" width="650"> 
			<thead>
				<tr>
					<th colspan="7">
						<div align="center"><ul class="tabs"><center><li>Silver Balance Table</li></center></ul></div>
					</th>
				</tr>
				<tr><th>Silver balance</th><th>Silver</th><th>Gift silver</th><th>GES silver</th><th>sItem silver</th><th>bItem silver</th><th>Options</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<center>
						<?php
							$psilver = $user['giftsilver']+$user['gessilver']+$user['sisilver']; $nsilver = $user['bisilver'];
							$sb = $psilver-$nsilver;
							echo $sb;
						?>
						</center>
					</td>
					<td>
						<center><img src='../img/admin/silver.gif' class='silver' alt='silver' title='This user has: <?php echo $user['silver']; ?> silver'/> <?php echo $user['silver']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/silver.gif' class='silver' alt='gift silver' title='This user gained: <?php echo $user['giftsilver']; ?> gift silver'/> <?php echo $user['giftsilver']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/silver.gif' class='silver' alt='GES (gold exhchanged to silver) silver' title='This user gained: <?php echo $user['gessilver']; ?> silver by exchanging gold'/> <?php echo $user['gessilver']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/silver.gif' class='silver' alt='SI (sold item) silver' title='This user gained: <?php echo $user['sisilver']; ?> silver by selling items'/> <?php echo $user['sisilver']; ?></center>
					</td>
					<td>
						<center><img src='../img/admin/silver.gif' class='silver' alt='BI (bought item) silver' title='This user used: <?php echo $user['bisilver']; ?> silver to by items'/> <?php echo $user['bisilver']; ?></center>
					</td>
					<td>
						<?php if($_SESSION['access'] == ADMIN){
							 echo '<center><a href="index.php?p=silver&uid='.$id.'"><img src="../img/admin/edit.gif" title="Edit Silver Balance"></a></center>';
						} ?>
					</td>
				</tr>
			</tbody>
		</table>
<!-- ADDITIONAL USER INFORMATION -->
		<table align="center" cellpadding="1" cellspacing="1" border="1" width="650"> 
			<thead>
				<tr>
					<th colspan="6">
						<div align="center"><ul class="tabs"><center><li>Additional Information</li></center></ul></div>
					</th>
				</tr>
				<tr><th>Access</th><th>Sitter 1</th><th>Sitter 2</th><th>Beginners Protection</th><th>CP</th><th>Last activity</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<?php 
						if($user['access'] == 0){echo "Banned";
						}else if($user['access'] == 2){echo "Normal user";
						}else if($user['access'] == 8){echo "<b><font color=\"Blue\">Multihunter</font></b>";
						}else if($user['access'] == 9){echo "<b><font color=\"Red\">Administrator</font></b>";
						}?>
					</td>
					<td>
						<?php
						if($user['sit1'] >= 1){
							echo '<a href="index.php?p=player&uid='.$user['sit1'].'">'.$database->getUserField($user['sit1'],"username",0).'</a>';
						} else if($user['sit1'] == 0){
							echo 'No sitter';
						}
						?>
					</td>
					<td>
						<?php
						if($user['sit2'] >= 1){
							echo '<a href="index.php?p=player&uid='.$user['sit2'].'">'.$database->getUserField($user['sit2'],"username",0).'</a>';
						} 
						else if($user['sit2'] == 0){
							echo 'No sitter';
						}
						?>
					</td>
					<td>
						<?php echo ''.date('d/m/Y H:i',$user['protect']+3600*2).'';?>
					</td>
					<td>
						<?php
						echo $user['cp'];
						if($_SESSION['access'] == ADMIN){?>
							<a href='index.php?p=cp&uid=<?php echo $id; ?>'><img src='../img/admin/edit.gif' title='Give CP'></a>
						<?php } ?>
					</td>
					<td>
						<?php echo ''.date('d/m/Y H:i',$user['timestamp']+3600*2).'';?>
					</td>
				</tr>
			</tbody>
		</table>
<?php
		include ('villages.tpl');
	}else{
		echo "Not found...<a href=\"javascript: history.go(-1)\">Back</a>";
	}
}
?>