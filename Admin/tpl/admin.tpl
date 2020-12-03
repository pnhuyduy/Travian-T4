<?php include('../GameEngine/Lang/'.$_SESSION['lang'].'.php'); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="<?php echo $_SESSION['lang']; ?>">
<link rel="stylesheet" type="text/css" href="../img/admin/main.css">
<title>ACP :: <?php echo SERVER_NAME; ?></title>

<script language="javascript" src="../crypt.js" type="text/javascript"></script>
<script language="javascript" src="ajax.js" type="text/javascript"></script>
<script>
var editing = false;
var CurrentStep = 1;
function SetCurrent(val){
	if(CurrentStep!=val){
		$('div_'+CurrentStep).style.display = 'none';
		$('a_title_'+CurrentStep).className = '';
		$('div_'+val).style.display = 'block';
		$('a_title_'+val).className = 'current';
	}
	CurrentStep = val;
}
</script>
</head>
<body>
<div align="center">
<div class="main">
	<table align="center" cellpadding="0" cellspacing="3" width="850">
		<tbody>
			<tr>
				<td width="170" valign="top">
					<div class="list">
						<center> <?php echo MAINMENU; ?></center><br>
						<div class="point">
							<a href="index.php" <?php if(!isset($_GET['p'])){ echo 'class="bold"'; } ?>><?php echo ACPMAINPAGE; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=news" <?php if($_GET['p']=='news'){ echo 'class="bold"'; } ?>><?php echo EDITNEWS; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=managenews" <?php if($_GET['p']=='ManageNews'){ echo 'class="bold"'; } ?>><?php echo MANAGENEWS; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=onlines" <?php if($_GET['p']=='onlines'){ echo 'class="bold"'; } ?>><?php echo ONLINEUSERS; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=players" <?php if($_GET['p']=='players'){ echo 'class="bold"'; } ?>><?php echo PLAYERS; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=bills" <?php if($_GET['p']=='bills'){ echo 'class="bold"'; } ?>><?php echo 'Bills'; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=inbox" <?php if($_GET['p']=='inbox'){ echo 'class="bold"'; } ?>><?php echo INBOX; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=messages" <?php if($_GET['p']=='messages'){ echo 'class="bold"'; } ?>><?php echo MANAGEMESSAGES; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=search" <?php if($_GET['p']=='search'){ echo 'class="bold"'; } ?>><?php echo SEARCH; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=banned" <?php if($_GET['p']=='banned'){ echo 'class="bold"'; } ?>><?php echo BLACKLIST; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=gold" <?php if($_GET['p']=='gold'){ echo 'class="bold"'; } ?>><?php echo GIVEGOLDSILVER; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=newsletter" <?php if($_GET['p']=='newsletter'){ echo 'class="bold"'; } ?>><?php echo NEWSLETTER; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=backup" <?php if($_GET['p']=='backup'){ echo 'class="bold"'; } ?>><?php echo BACKUP; ?></a>
						</div>
						<div class="point">
							<a href="index.php?p=config" <?php if($_GET['p']=='config'){ echo 'class="bold"'; } ?>><?php echo SETTINGS; ?></a>
						</div>
						<br />
						<div class="point">
							<a target="_blank" href="<?php echo HOMEPAGE; ?>" ><?php echo HOME; ?></a></div>
						<div class="point">
							<a href="?action=logout" ><?php echo LOGOUT; ?></a>
						</div>
					</div>
				</td>
				<td width="670" valign="top">
					<?php include "top.tpl"; ?>
					<div class="page">
						<?php
						if($_POST or $_GET){
							if($_GET['p']){
								$filename = 'tpl/'.$_GET['p'].'.tpl';
								if(file_exists($filename)){
									include($filename);
								}else{
									include('tpl/404.tpl');
								}
							}
							if($_POST['p'] and $_POST['s']){
								$filename = 'tpl/results_'.$_POST['p'].'.tpl';
								if(file_exists($filename)){
									include($filename);
								}else{
									include('tpl/404.tpl');
								}
							}
						}else{
							include('tpl/home.tpl');
						}
						?>
					</div>
					<div style="clear:both;"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div id="ce"></div>
</div>
</body>
</html>