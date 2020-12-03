<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include("GameEngine/Protection.php");
include("GameEngine/Village.php");
$start = $generator->pageLoadTimeStart();
if(isset($_GET['newdid'])) {
    $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
    $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
    $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = " . $_GET['newdid'] . "");
    $row = mysql_fetch_assoc($t);
    if ($row['owner'] == $session->uid) {
        $_SESSION['wid'] = $_GET['newdid'];
    }
    header('Location: ' . $_SERVER['PHP_SELF']);
    die();
}
else {
	$building->procBuild($_GET);
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><?php echo SERVER_NAME ?></title> 
    <link REL="shortcut icon" HREF="favicon.ico"/>
	<meta http-equiv="cache-control" content="max-age=0" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link href="<?php echo GP_LOCATE; ?>lang/<?php echo $_SESSION['lang']; ?>/compact.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo GP_LOCATE; ?>lang/<?php echo $_SESSION['lang']; ?>/lang.css" rel="stylesheet" type="text/css" />
        <script src="crypt.js" type="text/javascript"></script>
        
<script type="text/javascript">

		window.addEvent('domready', start);
	</script>
</head>
 
 
<body class="v35 webkit chrome map qualificationServerMap" onload="start()">
<?php include_once("analyticstracking.php") ?>
<?php
if(isset($_GET['d']) && isset($_GET['c'])) {
	if($generator->getMapCheck($_GET['d']) == $_GET['c']) {
	include("Templates/Map/vilview.tpl");
	}
	else {
		header("Location: dorf1.php");
	}
} 
else {
	include("Templates/Map/mapviewlarge.tpl");
}
?> 
</div>
<div id="ce"></div>
</div>
</body>
</html>
