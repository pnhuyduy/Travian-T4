<html slick-uniqueid="3"><head>
<title>Admin ir</title>
<link rel="stylesheet" type="text/css" href="m_un.css">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="content-language" content="ir&quot;">
<meta http-equiv="imagetoolbar" content="no">
</head>
<body>
<div class="div1" align="right"></div>
<img src="img/x.gif" width="1" height="90" border="0">
  <table cellspacing="0" cellpadding="0">
			<tbody><tr valign="top">
				<td width="130">
					<a href="index.php" id="logo"><img src="img/x.gif" border="0" class="adminLogo"></a>
					﻿<table width="116" cellspacing="0" cellpadding="0">
	<tbody>
    		<tr>
			<td class="menu" id="menu_trav">
				<a href="admin.php">Login</a>
			</td>
		</tr>
    	</tbody>
</table>		  		</td>
		  		<td class="s1"><img src="img/x.gif" width="1" height="10" border="0"></td>
		  		<td class="s2">
<p><br>
﻿<p>Welcome to the Admin Control Panel. Please enter name and password:</p>
<form method="post" name="snd" action="admin.php">
<input type="hidden" name="action" value="login" />
	<br>
	<div class="p1">
		<table width="100%" cellspacing="1" cellpadding="0">
			<tbody><tr>
				<td>
					<label>Name:</label>
					<input class="fm fm110" type="text" name="username" value="" maxlength="15"> <span class="e f7"></span>
				</td>
			</tr>
			<tr>
				<td>
					<label>Password:</label>
					<input class="fm fm110" type="password" name="password" value="" maxlength="20">
					<span class="e f7"></span>
				</td>
			</tr>
		</tbody></table>
	</div>
		<p align="center">
			<input type="Submit" name="" value="&nbsp; Login &nbsp;">
		</p>
	<p align="center"><?php if(isset($_POST) && $_POST != null){echo "unknown user";}?></p>
</form>				</td>
			</tr>
		</tbody></table>
		
			
</body></html>