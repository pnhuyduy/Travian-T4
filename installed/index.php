<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Travian Installation by gorz1872@yahoo.com</title>
		<meta http-equiv="cache-control" content="max-age=0" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="imagetoolbar" content="no" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="content-language" content="en" />
		<link href="../<?php echo GP_LOCATE;?>/lang/en/compact.css" rel="stylesheet" type="text/css" />
        <link href="../<?php echo GP_LOCATE;?>/lang/en/lang.css" rel="stylesheet" type="text/css" />
        <link href="../img/travian_basics.css" rel="stylesheet" type="text/css" />
		<script src="../mt-core.js?0faaa" type="text/javascript"></script>
		<script src="../mt-more.js?0faaa" type="text/javascript"></script>
		<script src="../unx.js?0faaa" type="text/javascript"></script>
		<script src="../new.js?0faaa" type="text/javascript"></script>

</head>
<body class="v35 webkit chrome logout">
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
<img id="staticElements" src="img/x.gif" alt="">

<div id="bodyWrapper">
<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="">

<div id="header">
    <div id="mtop">
        <a id="logo" href="<?php echo HOMEPAGE; ?>" target="_blank" title="<?php echo SERVER_NAME; ?>"></a>

        <div class="clear"></div>
    </div>
</div>
<div id="center">
    <div id="sidebarBeforeContent" class="sidebar beforeContent">
        <div id="sidebarBoxMenu" class="sidebarBox   ">
            <div class="sidebarBoxBaseBox">
                <div class="baseBox baseBoxTop">
                    <div class="baseBox baseBoxBottom">
                        <div class="baseBox baseBoxCenter"></div>
                    </div>
                </div>
            </div>
            <div class="sidebarBoxInnerBox">
                <div class="innerBox header noHeader">
                </div>
                <div class="innerBox content">
					<ul>
						<?php include("templates/menu.tpl"); ?>
					</ul>
                </div>
                <div class="innerBox footer">
                </div>
            </div>
        </div>
    </div>
    <div id="contentOuterContainer">
        <div class="contentTitle">&nbsp;</div>
        <div class="contentContainer">
								<div id="content" class="statistics">
<h1 class="titleInHeader">debug by gorz1872@yahoo.com</h1>
<?php 
if(!isset($_GET['s'])) {
include("templates/greet.tpl");
}
else {
	switch($_GET['s']){
		case 1:
		include("templates/config.tpl");
		break;
		case 2:
		include("templates/dataform.tpl");
		break;
		case 3:
		include("templates/field.tpl");
		break;
		case 4:
		include("templates/multihunter.tpl");
		break;
		case 5:
		include("templates/oasis.tpl");
		break;
		case 6:
		include("templates/end.tpl");
		break;
	}
}
?>
<div class="clear">&nbsp;</div></div>
<div class="clear"></div></div>
<div class="contentFooter">&nbsp;</div></div>
	<div id="side_info"></div>
	<div class="clear"></div>
			</div>
	</div>
<div id="ce"></div>
</div>
</body>
</html>