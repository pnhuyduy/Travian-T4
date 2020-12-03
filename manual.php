<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Session.php");
?>
<html>
<head>
    <title><?php echo SERVER_NAME; ?></title>
    <link REL="shortcut icon" HREF="favicon.ico"/>
    <meta name="content-language" content="<?php echo $_SESSION['lang']; ?>"/>
    <meta http-equiv="cache-control" content="max-age=0"/>
    <meta http-equiv="imagetoolbar" content="no"/>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link href="<?php echo GP_LOCATE; ?>lang/<?php echo $_SESSION['lang']; ?>/compact.css?f4b7c" rel="stylesheet"
          type="text/css"/>
    <link href="<?php echo GP_LOCATE; ?>lang/<?php echo $_SESSION['lang']; ?>/lang.css?f4b7c" rel="stylesheet"
          type="text/css"/>
</head>
<body class="manual">
<?php
    $S = filter_var($_GET['s'], FILTER_SANITIZE_NUMBER_INT);
    $TYPE = filter_var($_GET['typ'], FILTER_SANITIZE_NUMBER_INT);
    if (!ctype_digit($S)) {
        $S = '0';
    }
    if (!ctype_digit($TYPE)) {
        $TYPE = null;
    }
    if (!isset($TYPE) && !isset($S)) {
        include('Templates/Manual/0.tpl');
    } else if (!isset($TYPE) && $S == 1) {
        include('Templates/Manual/00.tpl');
    } elseif (!isset($TYPE) && $S == 2) {
        include('Templates/Manual/0.tpl');
    } elseif (isset($TYPE) && $TYPE == 5 && $S == 3) {
        include('Templates/Manual/0.tpl');
    } else {
        if (isset($_GET['gid'])) {
            //echo 'Templates/Manual/' . $TYPE . (preg_replace("/[^a-zA-Z0-9_-]/", '', $_GET['gid'])) . '.tpl';
            include('Templates/Manual/' . $TYPE . (preg_replace("/[^a-zA-Z0-9_-]/", '', $_GET['gid'])) . '.tpl');
        } else {
            if ($TYPE == 4 && $S == 0) {
                $S = 1;
            }
            include('Templates/Manual/' . $TYPE . preg_replace("/[^a-zA-Z0-9_-]/", '', $S) . '.tpl');
        }
    }
?>
</body>
</html>