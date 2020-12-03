<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       Gold.php                                                    ##
##  Developed by:  Jok3r                                                       ##
##  License:       TravianX Project                                            ##
##  Copyright:     TravianX (c) 2010-2011. All rights reserved.                ##
##                                                                             ##
#################################################################################

if($_SESSION['access'] < ADMIN) die("Access Denied: You are not Admin!");
$uid = $_GET['uid'];
if(isset($uid)){        
	$user = $database->getUser($uid,1);?>
	<form action="index.php" method="POST">
		<input type="hidden" name="action" id="action" value="savesilver">
		<input type="hidden" name="uid" id="uid" value="<?php echo $uid; ?>">
		<center>
			<table align="center" cellpadding="1" cellspacing="1" border="1" width="650"> 
				<thead>
					<tr>
						<th colspan="7">
							<div align="center"><ul class="tabs"><center><li>Edit user <a style="color:#00aa00; "href="index.php?p=player&uid=<?php echo $uid;?>"><?php echo $user['username'];?></a> silver</li></center></ul></div>
						</th>
					</tr>
					<tr><th>/</th><th>Silver balance</th><th>Silver</th><th>Gift silver</th><th>GES silver</th><th>sItem silver</th><th>bItem silver</th></tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<center>Current State</center>
						</td>
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
					</tr>
					<tr>
						<td><center>New State</center></td>
						<td><center>-</center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['silver']; ?>" name="silver"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['giftsilver']; ?>" name="giftsilver"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['gessilver']; ?>" name="gessilver"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['sisilver']; ?>" name="sisilver"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['bisilver']; ?>" name="bisilver"/></center></td>
					</tr>
					<tr>
						<td colspan="7">
							<center>
								<br/><br/>
								<input type="submit" value="submit"/><br/><br/>
								<a style="color:#aa0000; "href="index.php?p=player&uid=<?php echo $uid;?>">Cancel</a><br/><br/>
							</center>
						</td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>
<?php
}