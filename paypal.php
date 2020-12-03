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
include("Templates/Plus/price.tpl");
require_once( "GameEngine/paypal.class.php" );
$p = new paypal_class( );
if ( !isset( $_GET['action'] ) || empty( $_GET['action'] ) )
{
	$_GET['action'] = "process";
}
switch ( $_GET['action'] )
{
case "process" :
	return;
case "success" :
	if ( isset($_POST['payment_status']) && $_POST['payment_status']=='Completed' )
	{
		echo "<html><head><title>Success</title></head><body><h3>Thank you for your order.</h3>";
		echo "</body></html>";
		
		if ( !$p->validate_ipn( ) )
		{
			echo "Your Payment Faild And Was Not Accepted....";
			break;
		}
		$subject = "Instant Payment Notification - Recieved Payment";
		$data = base64_decode(base64_decode( $p->ipn_data['custom'] ));
		$dat = explode("-",$data);		
		$from = $dat[1];
		$payment = $database->query("SELECT * FROM `". TB_PREFIX ."payment` WHERE `uid` = '". $dat[0] ."' AND `code` = '". $dat[2] ."'");
		$pay = mysql_fetch_array($payment);
		if(mysql_num_rows($payment) > 0 && $pay['status']==0){
			$database->query("UPDATE `". TB_PREFIX ."payment` SET `status`='1' WHERE `uid` = '". $dat[0] ."' AND `code` = '". $dat[2] ."'");
			$database->query("UPDATE `". TB_PREFIX ."payment` SET `pemail`='". $_POST['payer_email'] ."' WHERE `uid` = '". $dat[0] ."' AND `code` = '". $dat[2] ."'");
			$to = ADMIN_EMAIL;
			$plyer = mysql_fetch_array($database->query("SELECT * FROM `". TB_PREFIX ."users` WHERE `id` = '". $dat[0] ."'"));
			$body = "An instant payment notification was successfully recieved\n 
			Payer Player Was ". $plyer['username'] ."\n";
			$body .= "from ".$p->ipn_data['payer_email']." on ".date( "m/d/Y" );
			$body .= " at ".date( "g:i A" )."\n\nDetails:\n";
			foreach ( $p->ipn_data as $key => $value )
			{
				$body .= "\n{$key}: {$value}";
			}
			$subject = sprintf( "=?utf-8?B?".base64_encode( $subject )."?=" );
			$headers = sprintf( "To: %s <%s>\nFrom: %s\nMIME-Version: 1.0\nContent-type: text/html; charset=utf-8", $to, $to, $from );		
			mail( $to, $subject, $body, $headers );
			$message = "Hello Dear ". $plyer['username'] ." \n 
			Thank you for supporting us by buying gold on our servers.\n 
			we use the money to improve the game, so in a way, you are backing our project.\n 
			
			Thanks for that! ;) \n\n 
			
			Regards \n 
			T4DL Team";
			$subject = "Thanks For Shopping";
			$subject = sprintf( "=?utf-8?B?".base64_encode( $subject )."?=" );
			$headers = sprintf( "To: %s <%s>\nFrom: %s\nMIME-Version: 1.0\nContent-type: text/html; charset=utf-8", $from, $from, $to );		
			mail( $from, $subject, $message, $headers );
			$usedPackage = NULL;
			foreach ( $AppConfig['plus']['packages'] as $package )
			{
				if ( $package['cost'] == $p->ipn_data['payment_gross'] )
				{
					$usedPackage = $package;
				}
			}
			$Player = $dat[0];
			echo "Gold Added Successful.";
			$gold = $usedPackage['gold'];
			if($Player == $session->uid){
				$database->query("UPDATE `". TB_PREFIX ."users` SET gold = gold + $gold WHERE `id` = '" . $Player . "'");
				$database->query("UPDATE `". TB_PREFIX ."users` SET boughtgold = boughtgold + $gold WHERE `id` = '" . $Player . "'");
			}			
		}
		elseif($pay['status']==1){
			echo "Your gold just added to your account. <br>please DO NOT refresh this page to get more golds! otherwise you will be reported to multi hunter as a cheatter!<br> Our payments Is empty of any bugs.";
		}
		else{
			echo "Sorry We did not found any record of your purchase! <br> please be careful if you repeat this you will report to multihunter as a cheatter.";
		}
	}
	break;
case "cancel" :
	echo "<html><head><title>Canceled</title></head><body><h3>The order was canceled.</h3>";
	echo "</body></html>";
	break;
case "ipn" :
	if ( $p->validate_ipn( ) )
	{
		break;
	}
}
?>
