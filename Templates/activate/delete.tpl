<?php
$_GET['id'] = filter_var($_GET['id'], FILTER_SANITIZE_NUMBER_INT);
$_GET['id'] = abs($_GET['id']);
?>
<h4>No email received?</h4>
<div class="activation">
			In order to play Travian you need a valid email address to which the activation code can be send. There are exceptional cases when this email might not arrive.
			<br>
			<br>
			Following causes are possible:
			<ul>
				<li>Typos in the email address</li>
				<li>The email account`s storage limit is reached.</li>
				<li>Wrong domain: There is e.g. no @aol.de, only @aol.com</li>
				<li>The email has been moved to the spam/junk folder</li>
			</ul>
			You can undo the registration and re-register with a <u>different email address</u>. 
Then the activation code will be send again
		</div>
        <hr>
        <h4>Delete Account</h4>
        <form action="activate.php" method="post">
        <input type="hidden" name="id" value="<?php echo $_GET['id']; ?>" />
		<input type="hidden" name="ft" value="a3" />
			<div class="boxes activation boxesColor gray"><div class="boxes-tl"></div><div class="boxes-tr"></div><div class="boxes-tc"></div><div class="boxes-ml"></div><div class="boxes-mr"></div><div class="boxes-mc"></div><div class="boxes-bl"></div><div class="boxes-br"></div><div class="boxes-bc"></div><div class="boxes-contents">
				<table cellpadding="1" cellspacing="1" class="transparent">
					<tbody><tr class="top">
						<th>Nickname:</th>
						<td class="name"><?php echo $database->getActivateField($_GET['id'],"username",0); ?></td>
					</tr>
					<tr class="btm">
						<th>Password:</th>
						<td><input class="text" type="password" name="pw" maxlength="20"></td>
					</tr>
				</tbody></table>
				</div>
				</div>
			<div class="clear"></div><button type="submit" value="delete" name="delreports" id="btn_delete" onclick="document.snd.w.value=screen.width+':'+screen.height;"><div class="button-container"><div class="button-position"><div class="btl"><div class="btr"><div class="btc"></div></div></div><div class="bml"><div class="bmr"><div class="bmc"></div></div></div><div class="bbl"><div class="bbr"><div class="bbc"></div></div></div></div><div class="button-contents">delete</div></div></button>
		</form>