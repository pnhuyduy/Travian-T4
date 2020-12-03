<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include("Templates/Plus/price.tpl");
include("GameEngine/Village.php");
$start = $generator->pageLoadTimeStart();
include "Templates/html.tpl";
?>
<body class="v35 webkit chrome statistics">
<script type="text/javascript">
			window.ajaxToken = 'de3768730d5610742b5245daa67b12cd';
		</script>
	<div id="background"> 
			<div id="headerBar"></div>	
		<div id="bodyWrapper"> 
			<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="" /> 
			<div id="header"> 
			<div id="mtop">
<?php 
	include("Templates/topheader.tpl"); // mehdi jan injaro man edit kardam bordam tu hamin file ke berim baghie ja ha ham include konim!
	include("Templates/toolbar.tpl"); // mehdi jan injaro man edit kardam bordam tu hamin file ke berim baghie ja ha ham include konim!

?>

</div> 
</div>
					<div id="center">
		<?php include("Templates/sideinfo.tpl"); ?>

<div id="contentOuterContainer">
		<?php include("Templates/res.tpl"); ?>
							<div class="contentTitle">&nbsp;</div> 
							<div class="contentContainer"> 
						<div id="content" class="plus">
                        <script type="text/javascript">
					window.addEvent('domready', function()
					{
						$$('.subNavi').each(function(element)
						{
							new Travian.Game.Menu(element);
						});
					});
				</script>
				<center>
				<h2> &#1583;&#1585; &#1581;&#1575;&#1604; &#1575;&#1578;&#1589;&#1575;&#1604; &#1576;&#1607; &#1583;&#1585;&#1711;&#1575;&#1607; &#1589;&#1576;&#1585; &#1705;&#1606;&#1740;&#1583; <h2>
					<center>
<?php
if(!isset($_GET['c'])){
	header('Location: plus.php');
}
else if(isset($_GET['c'])){
if(($_GET['c'] == 1) || ($_GET['c'] == 2) || ($_GET['c'] == 3) || ($_GET['c'] == 4) || ($_GET['c'] == 5) || ($_GET['c'] == 6) || ($_GET['c'] == 7) || ($_GET['c'] == 8)){
$id = $session->uid;
$name = $session->username;
$email = $session->email;
$_GET['c'] = $_GET['c'] - 1;
$Esi=explode('pay.php',$_SERVER['REQUEST_URI']);
$ReturnPath="http://".$_SERVER['HTTP_HOST'].$Esi[0]."parspal.php";
$Codemaker=rand(10000,200000000);
$goldenb=$AppConfig['plus']['packages'][$_GET['c']]['gold'];

    $price = $AppConfig['plus']['packages'][$_GET['c']]['cost'];
    $token = md5( sprintf( "%s:%s:%s:%s", $AppConfig['plus']['payments']['paypal']['merchant_id'], $price, strtolower( $AppConfig['plus']['payments']['paypal']['currency'] ), $AppConfig['plus']['payments']['paypal']['testMode'] ? $AppConfig['plus']['payments']['paypal']['testKey'] : $AppConfig['plus']['payments']['paypal']['key'] ) );
    $dtest = sprintf( "%s ".text_gold_lang, $AppConfig['plus']['packages'][$_GET['c']]['gold']) ;

	echo '<form action="http://merchant.parspal.com/postservice/" method="post" name="payment"/>
	<input type="hidden" id="MerchantID" value="'.$AppConfig['plus']['payments']['paypal']['merchant_id'].'" name="MerchantID"/>
	<input type="hidden" id="Password" value="'.$AppConfig['plus']['payments']['paypal']['key'].'" name="Password"/>
	<input type="hidden" id="Paymenter" value="'.$name.'" name="Paymenter"/>
	<input type="hidden" id="Email" value="'.$email.'" name="Email"/>
	<input type="hidden" id="Price" value="'.$price.'" name="Price"/>
	<input type="hidden" id="Mobile" value="'.$id.'" name="Mobile"/>
	<input type="hidden" id="ResNumber" value="'.$session->uid.'_'.$_GET['c'].'" name="ResNumber"/>
	<input type="hidden" id="Description" value="'.$Codemaker.'" name="Description"/>
	<input type="hidden" id="ReturnPath" value="'.$ReturnPath.'" name="ReturnPath"/>
	<script language="Javascript">document.payment.submit();</script></form>';

}
else{
	echo '<p align="center">
	<fieldset style="padding: 0">
	<legend>تقلب</legend>
      شما سعی دارید در خرید طلا تقلب کنید. لطفا از کار خود دست بردارید. در غیر این صورت اکانت شما به مولتی هانتر گزارش خواهد شد.<br />
      ایپی شما در سرور ثبت شد
	</fieldset></p>';
	
	
	}
}
?>

</div>
</div>
                        <div class="contentFooter">&nbsp;</div>
</div>
<?php  
include("Templates/rightsideinfor.tpl");		

?>
				<div class="clear"></div>
</div>
<?php

include("Templates/footer.tpl");

?>			
<?php
include("Templates/time.tpl");
?>
<div id="ce"></div>
</div>
</body>
</html>