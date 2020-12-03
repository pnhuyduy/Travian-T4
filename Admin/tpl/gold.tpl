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
		<input type="hidden" name="action" id="action" value="savegold">
		<input type="hidden" name="uid" id="uid" value="<?php echo $uid; ?>">
		<center>
			<table align="center" cellpadding="1" cellspacing="1" border="1" width="650"> 
				<thead>
					<tr>
						<th colspan="8">
							<div align="center"><ul class="tabs"><center><li>Edit user <a style="color:#00aa00; "href="index.php?p=player&uid=<?php echo $uid;?>"><?php echo $user['username'];?></a> gold</li></center></ul></div>
						</th>
					</tr>
					<tr><th>/</th><th>Gold Balance</th><th>Gold</th><th>Bought gold</th><th>Gift gold</th><th>Transfered gold</th><th>SEG gold</th><th>Used gold</th></tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<center>Current State</center>
						</td>
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
					</tr>
					<tr>
						<td><center>New State</center></td>
						<td><center>-</center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['gold']; ?>" name="gold"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['boughtgold']; ?>" name="boughtgold"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['giftgold']; ?>" name="giftgold"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['transferedgold']; ?>" name="transferedgold"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['seggold']; ?>" name="seggold"/></center></td>
						<td><center><input style="width:80px;height:15px;" value="<?php echo $user['usedgold']; ?>" name="usedgold"/></center></td>
					</tr>
					<tr>
						<td colspan="8">
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