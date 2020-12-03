<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include('GameEngine/Village.php');
include('Templates/html.tpl');
$start = $generator->pageLoadTimeStart();
if (isset($_GET['ok'])) {
    $database->updateUserField($session->username, 'ok', '0', '0');
    $_SESSION['ok'] = '0';
}
if (isset($_GET['newdid'])) {
    $_SESSION['wid'] = $_GET['newdid'];
    header("Location: " . $_SERVER['PHP_SELF']);
} else {
    $building->procBuild($_GET);
}
include "Templates/html.tpl";
include "Templates/Plus/price.tpl";
// Set Your Setting This Part

$MerchantID = $AppConfig['plus']['payments']['parspal']['MerchantID'];
$Password   = $AppConfig['plus']['payments']['parspal']['password'];
$mehdi      = explode(",", $_GET['back']);
if (isset($_GET['provider']) or $mehdi) {
    if (isset($_GET['provider'])) {
        $pid = $_GET['provider'];
    }
    ;
    if (isset($_GET['back'])) {
        $pid = $mehdi[0];
    }
    ;
}

$Prices = array(
    
    
    array(
        "بسته B",
        $AppConfig['plus']['packages'][0]['gold'],
        $AppConfig['plus']['packages'][0]['cost']
    ),
    array(
        "بسته C",
        $AppConfig['plus']['packages'][1]['gold'],
        $AppConfig['plus']['packages'][1]['cost']
    ),
    array(
        "بسته D",
        $AppConfig['plus']['packages'][2]['gold'],
        $AppConfig['plus']['packages'][2]['cost']
    ),
    array(
        "بسته E",
        $AppConfig['plus']['packages'][3]['gold'],
        $AppConfig['plus']['packages'][3]['cost']
    ),
    array(
        "بسته F",
        $AppConfig['plus']['packages'][4]['gold'],
        $AppConfig['plus']['packages'][4]['cost']
    ),
    array(
        "بسته g",
        $AppConfig['plus']['packages'][5]['gold'],
        $AppConfig['plus']['packages'][5]['cost']
    ),
    array(
        "بسته h",
        $AppConfig['plus']['packages'][6]['gold'],
        $AppConfig['plus']['packages'][6]['cost']
    ),
    array(
        "بسته m",
        $AppConfig['plus']['packages'][7]['gold'],
        $AppConfig['plus']['packages'][7]['cost']
    ),
    array(
        "بسته a",
        $AppConfig['plus']['packages'][5]['gold'],
        $AppConfig['plus']['packages'][5]['cost']
    )
    
    
);



?><body class='v35 gecko universal perspectiveResources'>
<script type="text/javascript">
    window.ajaxToken = '<?php
echo md5($_REQUEST['SERVER_TIME']);
?>';
</script>
<div id="background">
    <div id="headerBar"></div>
    <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>
        <?php
include('Templates/Header.tpl');
?>
        <div id="center">
            <a id="ingameManual" href="help.php">
                <img class="question" alt="Help" src="img/x.gif">
            </a>

            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <?php
include('Templates/heroSide.tpl');
include('Templates/Alliance.tpl');
include('Templates/infomsg.tpl');
include('Templates/links.tpl');
?>
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer">
                <?php
include('Templates/res.tpl');
?>
                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php
echo BL_CLOSE;
?>">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank" title="<?php
echo BL_TRAVIANANS;
?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="universal">
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
				
				
		
				

<?php

if (isset($pid)) {
    
    if ($pid == 1) {
        if (isset($_GET['id'])) {
            $id = "";
        } else {
            $id = "";
        }
        
        if ($id == "") {
            
            $id = $session->username;
            
            $rest      = mysql_query("SELECT * FROM " . TB_PREFIX . "users where `username`='$id' ");
            $row       = mysql_fetch_assoc($rest);
            $Paymenter = $row['username'];
            $Email     = $row['email'];
            
            if (isset($_GET['buy'])) {
                
                $package = intval($_GET['buy']);
                if ($package < 0 || $package >= count($Prices)) {
                    echo 'پکيج مورد نظر شما يافت نشد !';
                } else {
                    $Price       = intval($Prices[$package][2]);
                    $ReturnPath  = $AppConfig['plus']['payments']['parspal']['Link'] . $package;
                    $ResNumber   = $id;
                    $Description = urlencode('خريد ' . $Prices[$package][0]);
                    
                    require_once('Templates/Plus/nusoapp.php');
                    
                    $client = new nusoap_client('http://merchant.parspal.com/WebService.asmx?wsdl', 'wsdl');
                    
                    $parameters = array(
                        "MerchantID" => $MerchantID,
                        "Password" => $Password,
                        "Price" => $Price,
                        "ReturnPath" => $ReturnPath,
                        "ResNumber" => $ResNumber,
                        "Description" => $Description,
                        "Paymenter" => $Paymenter,
                        "Email" => $Email,
                        "Mobile" => '-'
                    );
                    
                    $result  = $client->call('RequestPayment', array(
                        $parameters
                    ));
                    $PayPath = $result['RequestPaymentResult']['PaymentPath'];
                    $Status  = $result['RequestPaymentResult']['ResultStatus'];
                    
                    if ($Status == 'Succeed') {
                        echo '<h1 class="titleInHeader">اتصال به درگاه</h1>
                  <div style="text-align:center; font-family:tahoma" >
                  <img src="loading.gif" />   <br><br>
                  در حال اتصال به درگاه پرداخت ، لطفا منتظر بمانيد ...</div>
                  <script>
                   window.addEvent("load", function()
					{
						window.location = "' . $PayPath . '"
					});
                    </script>

                  ';
                        //echo $PayPath;
                    } else {
                        echo 'در اتصال به درگاه خطایی رخ داده است ! ' . $Status;
                    }
                }
                //echo 'اتصال به درگاه'.$id.'-'.$name.'=='.$email;
            } else if (isset($_GET['verify'])) {
                $package = intval($_GET['verify']);
                if ($package < 0 || $package >= count($Prices)) {
                    echo 'پکيج مورد نظر شما يافت نشد !';
                } else {
                    
                    echo '<h1 class="titleInHeader">نتيجه پرداخت</h1>';
                    
                    
                    if (isset($_POST['status']) && $_POST['status'] == 100) {
                        
                        
                        $Price  = intval($Prices[$package][2]);
                        $Status = $_POST['status'];
                        
                        $Refnumber = $_POST['refnumber'];
                        $Resnumber = $_POST['resnumber']; //Your Order ID
                        
                        require_once('Templates/Plus/nusoapp.php');
                        $client = new nusoap_client('http://merchant.parspal.com/WebService.asmx?wsdl', 'wsdl');
                        
                        if ($id == $Resnumber) {
                            
                            $parameters = array(
                                "MerchantID" => $MerchantID,
                                "Password" => $Password,
                                "Price" => $Price,
                                "RefNum" => $Refnumber
                            );
                            
                            $result = $client->call('verifyPayment', $parameters);
                            
                            $Status   = $result['verifyPaymentResult']['ResultStatus'];
                            $PayPrice = $result['verifyPaymentResult']['PayementedPrice'];
                            
                            if (strtolower($Status) == 'success') // Your Peyment Code Only This Event
                                {
                                
                                $gold  = $Prices[$package][1];
                                $query = mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold + '" . $gold . "' WHERE username = '" . $id . "'");
                                $query2 = mysql_query("UPDATE " . TB_PREFIX . "users SET boughtgold = boughtgold + '" . $gold . "' WHERE username = '" . $id . "'");
                                
                                echo '<div style="color:green; font-family:tahoma; direction:rtl; text-align:center">
                            کاربر گرامی ، پرداخت با موفقیت انجام گردید . جزئیات خرید شما به شرح زیر می باشد : <br><br>
                            بسته خریداری شده :' . $Prices[$package][0] . '<br><br>
                            تعداد سکه : ' . $gold . '<br><br>
                            مبلغ : ' . intval($PayPrice) . '<br><br>
                            شماره رسید پرداخت : ' . $Refnumber . '<br><br>
        				<br /></div>';
                                
                                $subject = "خريد موفقيت آميز";
                                $sendsms = "کاربر گرامی ، خرید  " . $Prices[$package][0] . " با موفقیت به شماره رسید " . $Refnumber . " انجام و تعداد " . $gold . " سکه به حساب کاربری شما افزوده گردید .";
                                $uid     = $row['id'];
                                
                                mysql_query("INSERT INTO `" . TB_PREFIX . "mdata` (`target`, `owner`, `topic`, `message`, `viewed`, `archived`, `send`, `time`  ) VALUES( $uid  , 0       , '$subject', '$sendsms', 0   , 0 , 0,  now())");
                                
                                
                            } else {
                                echo '<br /><br /><br /><br /><br /><div style="color:green; font-family:tahoma; direction:rtl; text-align:center">
	        			خطا در پردازش عملیات پرداخت ، نتیجه پرداخت : ';
                                if ($Status == 'Verifyed')
                                    echo '<br /><br /><br /><br /><br><br><b>شماره رسيد قبلا استفاده شده است !</b>';
                                else if ($Status == 'InvalidRef')
                                    echo '<br /><br /><br /><br /><br><br><b style="color:red">شماره رسيد ارسالي معتبر نمي باشد!</b>';
                                else
                                    echo $Status;
                                echo ' <br /></div>';
                            }
                            
                        } else {
                            echo 'کاربر فعلی ، کاربر درخواست کننده پرداخت نمی باشد ، شماره رسید خود را جهت بررسی به مدیر اعلام نمایید . شماره رسید ' . $Refnumber;
                        }
                        
                    } else {
                        echo '<br /><br /><br /><br /><div style="color:red; font-family:tahoma; direction:rtl; text-align:center">
		            بازگشت از عمليات پرداخت، خطا در انجام عملیات پرداخت ( پرداخت ناموق ) !
            		<br /></div>';
                    }
                    
                }
            }
        }
        
    } else {
        
        
        $id = $session->username;
        
        $rest      = mysql_query("SELECT * FROM " . TB_PREFIX . "users where `username`='$id' ");
        $row       = mysql_fetch_assoc($rest);
        $Paymenter = $row['username'];
        $Email     = $row['email'];
        $package   = intval($_GET['buy']);
        $Price     = intval($Prices[$package][2]);
        
        if (isset($_GET['buy'])) {
            include_once("mehdi.php");
            $url      = 'http://payline.ir/payment/gateway-send';
            $api      = 'd947c-f5dd3-898b6-c106b-001cdc5cd48f38fd5abc865d0a61';
            $amount   = $Price;
            $redirect = $AppConfig['plus']['payments']['payline']['Link'] . $package;
            $result   = send($url, $api, $amount, $redirect);
            
            if ($result > 0 && is_numeric($result)) {
                $go = "http://payline.ir/payment/gateway-$result";
                header("Location: $go");
            }
        }
        if (isset($_GET['back'])) {
            echo '<h1 class="titleInHeader">نتيجه پرداخت</h1>';
            
            
            if (isset($_POST['trans_id']) && isset($_POST['"id_get'])) {
                
                
                $Price = intval($Prices[$package][2]);
                include_once("mehdi.php");
                
                $url      = 'http://payline.ir/payment/gateway-result-second';
                $api      = 'd947c-f5dd3-898b6-c106b-001cdc5cd48f38fd5abc865d0a61';
                $trans_id = $_POST['trans_id'];
                $id_get   = $_POST['id_get'];
                $result   = get($url, $api, $trans_id, $id_get);
                
                
                if ($result) // Your Peyment Code Only This Event
                    {
                    
                    $gold  = $Prices[$package][1];
                    $query = mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold + '" . $gold . "' WHERE username = '" . $id . "'");
                    $query2 = mysql_query("UPDATE " . TB_PREFIX . "users SET boughtgold = boughtgold + '" . $gold . "' WHERE username = '" . $id . "'");
                    echo '<div style="color:green; font-family:tahoma; direction:rtl; text-align:center">
                            کاربر گرامی ، پرداخت با موفقیت انجام گردید . جزئیات خرید شما به شرح زیر می باشد : <br><br>
                            بسته خریداری شده :' . $Prices[$package][0] . '<br><br>
                            تعداد سکه : ' . $gold . '<br><br>
                            مبلغ : <br><br>
                            شماره رسید پرداخت : ' . $trans_id . '<br><br>
        				<br /></div>';
                    
                    $subject = "خريد موفقيت آميز";
                    $sendsms = "کاربر گرامی ، خرید  " . $Prices[$package][0] . " با موفقیت به شماره رسید " . $trans_id . " انجام و تعداد " . $gold . " سکه به حساب کاربری شما افزوده گردید .";
                    $uid     = $row['id'];
                    
                    mysql_query("INSERT INTO `" . TB_PREFIX . "mdata` (`target`, `owner`, `topic`, `message`, `viewed`, `archived`, `send`, `time`  ) VALUES( $uid  , 0       , '$subject', '$sendsms', 0   , 0 , 0,  now())");
                    
                    
                } else {
                    echo '<br /><br /><br /><br /><br /><div style="color:green; font-family:tahoma; direction:rtl; text-align:center">
	        			خطا در پردازش عملیات پرداخت ، نتیجه پرداخت : ';
                    if ($result == '-4') {
                        echo '<br /><br /><br /><br /><br><br><b>شماره رسيد قبلا استفاده شده است !</b>';
                    } else if ($result == '-2') {
                        echo '<br /><br /><br /><br /><br><br><b style="color:red">شماره رسيد ارسالي معتبر نمي باشد!</b>';
                    } else {
                        echo $result;
                    }
                    echo ' <br /></div>';
                }
                
                
                
            } else {
                echo '<br /><br /><br /><br /><div style="color:red; font-family:tahoma; direction:rtl; text-align:center">
		            بازگشت از عمليات پرداخت، خطا در انجام عملیات پرداخت ( پرداخت ناموق ) !
            		<br /></div>';
            }
        }
    }
} else {
    echo 'در انتخاب درگاه به مشکل بر خوردیم !';
}
?>
<font style="left:3px;position:absolute;top:525px" color="#c5c5c5" size="1">
    Travian Payments by <b> Mehdi Zabet</b>
</font>
 </div>
                    <div class="clear"></div>
                </div>
                <div class='contentFooter'>&nbsp;</div>
            </div>
            <div id="sidebarAfterContent" class="sidebar afterContent">
                <div id="sidebarBoxActiveVillage" class="sidebarBox ">
                    <div class="sidebarBoxBaseBox">
                        <div class="baseBox baseBoxTop">
                            <div class="baseBox baseBoxBottom">
                                <div class="baseBox baseBoxCenter"></div>
                            </div>
                        </div>
                    </div>
                    <?php
include 'Templates/sideinfo.tpl';
?>
                </div>
                <?php
include 'Templates/multivillage.tpl';
include 'Templates/quest.tpl';
?>
            </div>
            <div class="clear"></div>
            ﻿<?php
include 'Templates/footer.tpl';
?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>