<?php
    ob_start("ob_gzhandler");
?>
    <html>
    <head>
        <title><?php echo PL_LOADINGPAY; ?></title>
        <meta http-equiv='content-type' content='text/html; charset=UTF-8'>
        <meta http-equiv='imagetoolbar' content='no'>
        <style type='text/css'>html, body {
                margin: 0;
                padding: 0;
                background-color: #e9e9e9;
                font-size: 14px;
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #333;
                direction: ltr
            }

            .small {
                font-size: 12px;
                font-weight: normal
            }

            a {
                text-decoration: none
            }

            a:link {
                color: #7da519
            }

            a:visited {
                color: #7da519
            }

            a:hover {
                color: #557d1e
            }

            a:active {
                color: #557d1e
            }

            table.containertable {
                margin: 35px auto 35px auto;
                text-align: center
            }

            td.container, div.messagebox {
                background-color: #fff;
                border: 2px solid #d6d6d6
            }

            td.container {
                padding: 4px;
                text-align: center
            }

            #buttonSealDiv {
                padding: 4px;
                text-align: center
            }

            table.messagetable {
                text-align: left
            }

            td.subtitle {
                text-align: center;
                padding-bottom: 4px;
                font-size: 14px;
                font-weight: bold;
                border-bottom: 2px solid #d6d6d6
            }

            td.logo {
                padding-top: 5px;
                width: 130px;
                vertical-align: top
            }

            td.message {
                width: 470px;
                padding: 6px 6px 6px 12px;
                vertical-align: middle;
                text-align: left
            }

            td.closewindow {
                padding: 2px;
                text-align: left;
                font-size: 12px;
                font-weight: bold
            }

            div.messagebox {
                position: relative;
                margin: 75px auto 75px auto;
                padding: 20px;
                width: 300px;
                text-align: center;
                font-size: 16px;
                font-weight: bold;
                white-space: nowrap
            }

            div.messageboxButton {
                margin: 25px auto 5px auto;
                padding: 20px 20px 10px 20px
            }

            div.buttonTop {
                position: relative;
                border-radius: 5px 5px 0 0;
                background-color: #ccc;
                padding: 2px;
                width: 100%
            }

            div.buttonBottom {
                font-weight: normal;
                border-radius: 0 0 5px 5px;
                background-color: #eaeaea;
                margin: 0 0 20px 0
            }

            .button {
                color: #FFF;
                width: 100%;
                border: 1px solid #36780f;
                -webkit-border-radius: 5px;
                -moz-border-radius: 5px;
                border-radius: 5px;
                font-family: arial, helvetica, sans-serif;
                padding: 5px;
                text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
                font-weight: bold;
                text-align: center;
                color: #fff;
                background-color: #62ae2a;
                background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #62ae2a), color-stop(100%, #a5da6e));
                background-image: -webkit-linear-gradient(top, #a5da6e, #62ae2a);
                background-image: -moz-linear-gradient(top, #a5da6e, #62ae2a);
                background-image: -ms-linear-gradient(top, #a5da6e, #62ae2a);
                background-image: -o-linear-gradient(top, #a5da6e, #62ae2a);
                background-image: linear-gradient(top, #a5da6e, #62ae2a);
                filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr=#62AE2A, endColorstr=#A5DA6E)
            }

            span.defect_message {
                color: #C00
            }

            .units {
                font-size: smaller
            }</style>
    </head>
    <?php

        include_once "GameEngine/Protection.php";
        include_once "GameEngine/Village.php";

        include 'Payments/packages.php';

        $PageTitle = SERVER_NAME;
        $this_script = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];

        $this_site = 'http://' . $_SERVER['HTTP_HOST'].'/';
        $t = explode ('/', $_SERVER['SCRIPT_NAME']);
        $this_site =  $this_site.$t[1];


        function generateRandomString($length = 20)
        {
            $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
            $randomString = '';
            for ($i = 0; $i < $length; $i++) {
                $randomString .= $characters[rand(0, strlen($characters) - 1)];
            }
            return $randomString;
        }

        switch ($_GET['pid']) {
            case 1:
                require_once('Payments/paypal/paypal.class.php');
                $p = new paypal_class;
                $p->paypal_url = 'https://www.paypal.com/cgi-bin/webscr';
                //$p->paypal_url = 'https://www.sandbox.paypal.com/cgi-bin/webscr';

                $paypalEmailAddress = $paypal_config['email'];
                $playerId = $_SESSION['username'];

                if (empty($_GET['action'])) $_GET['action'] = 'process';

                switch ($_GET['action']) {
                    case 'process':
                        if (isset($_GET['id']) and intval($_GET['id']) >= 0) {
                            $_GET['id'] = intval($_GET['id']);
                            $id = $_GET['id'];
                            $pk = $packages[$id];
                            $gold = $pk['gold'];
                            $Price = $pk['price'];
                            $Desc = $gold.'-Gold/'.$_SESSION['username'];
                            $PageTitle = 'Buy ' . $gold . ' gold';

                            $_SESSION['userOrderId'] = $orderid = generateRandomString();
                            //get user id
                            $q = mysql_query('SELECT id as userid from s1_users where username = \'' . $_SESSION['username'] . '\' ');
                            $q = (mysql_fetch_assoc($q));
                            $playerId = $q['userid'];
                            $query = mysql_query("INSERT INTO transactions (`orderid`,`playerId`, `amunt`, `gold`, `time`) VALUES ('" . $orderid . "','" . $playerId . "', '" . $Price . "', '" . $gold . "', '" . time() . "')");
                            //backup
                            $ourFileHandle = fopen('Payments/paypal/' . sv_ . '_paypal_process.txt', 'a+');
                            $str = '{ order id: ' . $orderid . ' - ';
                            $str .= 'UserName: ' . $_SESSION['username'] . ' - ';
                            $str .= 'player Id: ' . $playerId . ' - ';
                            $str .= 'amount: ' . $Price . ' - ';
                            $str .= 'gold: ' . $gold . ' - ';
                            $str .= 'Desk: ' . $Desc . ' - ';
                            $str .= 'title: ' . $PageTitle . ' - ';
                            $str .= 'time: ' . time() . ' }';
                            $str .= "\n";
                            fwrite($ourFileHandle, $str);
                            fclose($ourFileHandle);
                        } else {
                            die(PL_ERROR);
                        }
                        $p->add_field('business', $paypalEmailAddress);
                        $p->add_field('lc', "MY");
                        $p->add_field('return', $this_script . '?pid=1&action=PL_SUCCESS');
                        $p->add_field('cancel_return', $this_script . '?pid=1&action=cancel');
                        $p->add_field('notify_url', $this_site.'/paypal_ipn.php');
                        $p->add_field('username', 'multihunter');
                        $p->add_field('item_name', $Desc);
                        $p->add_field('item_number', $gold);
                        $p->add_field('amount', $Price);
                        $p->add_field('button_subtype', 'services');
                        //$p->add_field('hosted_button_id', $packages[$id]['hosted_button_id']);
                        $p->add_field('cmd', '_xclick');
                        $p->submit_paypal_post();
                        break;
                    case 'PL_SUCCESS':
                        echo "<html><head><title>" . PL_SUCCESS . "</title></head><body><h3>" . BUY_COMPLETED . "</h3>";
                        $PL_ERROR = $p->last_PL_ERROR;
                        echo "<script>setTimeout('location.href=\"dorf1.php\"', 3000)</script></body></html>";
                        break;

                    case 'cancel':
                        $orderid = $_GET['orderid'];
                        //$query = mysql_query("Delete FROM transactions WHERE `orderid`='" . $orderid . "' AND status='0'");
                        $PL_ERROR = ORDER_CANCELED;
                        break;
                }
                break;
            case 2:
                if (empty($_GET['action'])) $_GET['action'] = 'process';

                switch ($_GET['action']) {
                    case 'process':
                        if (isset($_GET['id']) and intval($_GET['id']) >= 0) {

                            $_GET['id'] = intval($_GET['id']);
                            $id = $_GET['id'];
                            $pk = $packages[$id];
                            $gold = $pk['gold'];
                            $Price = $pk['price'];
                            $Desc = '' . $gold . ' Gold';
                            $PageTitle = 'Buy ' . $gold . ' gold';
                            $_SESSION['userOrderId'] = $orderid = generateRandomString();
                            //get user id
                            $q = mysql_query('SELECT id as userid from s1_users where username = \'' . $_SESSION['username'] . '\' ');
                            $q = (mysql_fetch_assoc($q));
                            $playerId = $q['userid'];
                            $query = mysql_query("INSERT INTO transactions (`orderid`,`playerId`, `amunt`, `gold`, `time`) VALUES ('" . $orderid . "','" . $playerId . "', '" . $Price . "', '" . $gold . "', '" . time() . "')");
                            //backup
                            $ourFileHandle = fopen('Payments/paygol/' . sv_ . '_paygol_process.txt', 'a+');
                            $str = '{ order id: ' . $orderid . ' - ';
                            $str .= 'UserName: ' . $_SESSION['username'] . ' - ';
                            $str .= 'player Id: ' . $playerId . ' - ';
                            $str .= 'amount: ' . $Price . ' - ';
                            $str .= 'gold: ' . $gold . ' - ';
                            $str .= 'Desk: ' . $Desc . ' - ';
                            $str .= 'title: ' . $PageTitle . ' - ';
                            $str .= 'time: ' . time() . ' }';
                            $str .= "\n";
                            fwrite($ourFileHandle, $str);
                            fclose($ourFileHandle);

                        } else {
                            die(PL_ERROR);
                        }
                        ?>
                        <script type='text/javascript'>setTimeout('submitform()', 2000)</script>
                        <form name="pg_frm" method="post" action="https://www.paygol.com/pay" id="TransactionForm2">
                            <input type="hidden" name="pg_serviceid" value="104675">
                            <input type="hidden" name="pg_currency" value="USD">
                            <input type="hidden" name="pg_name" value="<?php echo $pk['gold'] . ' Gold for ' . $pk['price'] . ' USD '; ?>">
                            <input type="hidden" name="pg_custom" value="<?php echo $orderid; ?>">
                            <input type="hidden" name="pg_price" value="<?php echo $pk['price']; ?>">
                            <input type="hidden" name="pg_return_url" value="<?php echo $this_script . '?pid=2&action=PL_SUCCESS';?>">
                            <input type="hidden" name="pg_cancel_url" value="<?php echo $this_script . '?pid=2&action=cancel';?>">
                        </form>
                        <script type='text/javascript'>
                            function submitform() {
                                document.forms['TransactionForm2'].submit();
                            }
                        </script>
                        <?php
                        break;

                    case 'PL_SUCCESS':
                        // er($_SESSION['userOrderId']);
                        if ($_GET['pg_custom']) {

                            // check that the request comes from PayGol server

                            if (!in_array($_SERVER['REMOTE_ADDR'],
                                array('109.70.3.48', '109.70.3.146', '109.70.3.210'))
                            ) {
                                header("HTTP/1.0 403 Forbidden");
                                die("PL_ERROR: Unknown IP");
                            }


                            // get the variables from PayGol system
                            $message_id = $_GET['message_id'];
                            $service_id = $_GET['service_id'];
                            $shortcode = $_GET['shortcode'];
                            $keyword = $_GET['keyword'];
                            $message = $_GET['message'];
                            $sender = $_GET['sender'];
                            $operator = $_GET['operator'];
                            $country = $_GET['country'];
                            $custom = $_GET['custom'];
                            $points = $_GET['points'];
                            $price = $_GET['price'];
                            $currency = $_GET['currency'];
                            if ($service_id == '104675') {
                                //$orderid = mysql_real_escape_string($_GET['orderid']);
                                $query = mysql_query("SELECT * FROM transactions WHERE `orderid`='" . $custom . "' AND status='0'");
                                // er($query);
                                $row = mysql_fetch_array($query);
                                if ($row) {
                                    if ($price == $row['amunt']) {
                                        $gold = $row['gold'];

                                        $query = mysql_query("UPDATE s1_users SET gold = gold + '" . $gold . "' , boughtgold = boughtgold + '" . $gold . "'  WHERE id = '" . $row['playerId'] . "'");
                                        // er($query);
                                        $query = mysql_query("UPDATE transactions SET `status` = '1' WHERE `orderid`='" . $custom . "'");
                                        // er($query);
                                        //backup
                                        $ourFileHandle = fopen('Payments/paygol/' . sv_ . '_paygol_PL_SUCCESS.txt', 'a+');
                                        $str = '{ order id: ' . $custom . ' - ';
                                        $str .= 'message_id: ' . $message_id . ' - ';
                                        $str .= 'service_id: ' . $service_id . ' - ';
                                        $str .= 'shortcode: ' . $shortcode . ' - ';
                                        $str .= 'message: ' . $message . ' - ';
                                        $str .= 'sender: ' . $sender . ' - ';
                                        $str .= 'operator: ' . $operator . ' - ';
                                        $str .= 'country: ' . $country . ' - ';
                                        $str .= 'custom: ' . $custom . ' - ';
                                        $str .= 'price: ' . $price . ' - ';
                                        $str .= 'currency: ' . $currency . ' - ';
                                        $str .= 'UserName: ' . $_SESSION['username'] . ' - ';
                                        $str .= 'player Id: ' . $row['playerId'] . ' - ';
                                        $str .= 'amount: ' . $row['amunt'] . ' - ';
                                        $str .= 'gold: ' . $gold . ' - ';
                                        $str .= 'Desk: ' . $Desc . ' - ';
                                        $str .= 'title: ' . $PageTitle . ' - ';
                                        $str .= 'time: ' . time() . ' }';
                                        $str .= "\n";
                                    }
                                }
                            } else {
                                $PL_ERROR = PL_ERROR;
                            }
                            echo "<html><head><title>" . PL_SUCCESS . "</title></head><body><h3>" . BUY_COMPLETED . "</h3>";
                        }

                        //foreach ($_POST as $key => $value) { echo "$key: $value<br>"; }
                        echo "<script>setTimeout('location.href=\"dorf1.php\"', 3000)</script></body></html>";
                        break;

                    case 'cancel':
                        $orderid = $_GET['orderid'];
                        $query = mysql_query("Delete FROM transactions WHERE `orderid`='" . $orderid . "' AND status='0'")or die(mysql_PL_ERROR());
                        $PL_ERROR = ORDER_CANCELED;
                        break;
                    case 'ipn':

                        break;

                }
                break;
        }

    ?>
    <div class='messagebox'>
        <img src='img/logo-big.png' alt='' height='96' width='190'><br><br>
        <?php if (!isset($PL_ERROR)) { ?>
            <img src='img/loadingshetab.gif' alt='loading' height='48' width='48'><br><br>
            <?php
            switch ($_GET['pid']) {
                case 1:
                    echo LOADING_PAYPAL;
                    break;

                case 2:
                    echo LOADING_PAYGOL;
                    break;
                case 3:
                    //echo LOADING_PERFECTMONEY;
                    //break;
            }
        } else {
            echo $PL_ERROR;
        } ?>
    </div>
    <div id='container'></div>
    </html>
<?php
    ob_end_flush();
?>