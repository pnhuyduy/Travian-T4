<h1 class="titleInHeader"><font color=\"#1e9431\"> &#1576;&#1575;&#1606;&#1705; &#1578;&#1585;&#1575;&#1608;&#1740;&#1606;</font></font></h1>
<div class="contentNavi subNavi">
    <div title="" class="container <?php if (isset($_GET['bank'])) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php"><span class="tabItem">&#1576;&#1575;&#1586;&#1711;&#1588;&#1578; &#1576;&#1607; &#1662;&#1604;&#1575;&#1587;</span></a></div>
    </div>
    <div title="" class="container <?php if (isset($_GET['banker'])) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php?banker"><span class="tabItem">&#1583;&#1585;&#1740;&#1575;&#1601;&#1578; &#1591;&#1604;&#1575;</span></a></div>
    </div>
    <div class="clear"></div>
</div>
<?php
    /*
    |--------------------------------------------------------------------------
    | PLEASE DO NOT REMOVE THIS COPYRIGHT NOTICE!
    |--------------------------------------------------------------------------
    |
    | Project owner: SHadoW < Arctic_X2@yahoo.com >
    | Edit By: Mehdi < Shannal@rogers.com >
    | DECODE & DEBUG is property of SHadoW Project. You are allowed to change
    | its source and release it under own name, not under name `SHadoW`.
    | You have no rights to remove copyright notices.
    |
    | SHadoW All rights reserved@
    |
    */

    if ($_POST) {
        $gold = filter_var($_POST['gold'], FILTER_SANITIZE_NUMBER_INT);
        $password = filter_var($_POST['password'], FILTER_SANITIZE_MAGIC_QUOTES);
        $player = filter_var($_POST['player'], FILTER_SANITIZE_MAGIC_QUOTES);
        $uid = $session->uid;
        include_once("GameEngine/Database/connection.php");
        mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
        mysql_select_db(SQL_DB);
        $q = "SELECT `username`,`password`,`boughtgold`,`email` FROM " . TB_PREFIX . "users WHERE id=" . $uid . " LIMIT 1";
        $result = mysql_query($q);
        if (mysql_num_rows($result)) {
            $row = mysql_fetch_assoc($result);
            $boughtgold = $row['boughtgold'];
            $password2 = $row['password'];
            $username = $row['username'];
            $email = $row['email'];
        }
        if ($gold <= $boughtgold) {
            if ($gold != '' || $gold != 0) {
                if ($gold > 0) {

                    include("GameEngine/Database/connectionbank.php");
                    $db_connect = mysql_connect($AppConfig['db']['host'], $AppConfig['db']['user'], $AppConfig['db']['password']);
                    mysql_select_db($AppConfig['db']['database'], $db_connect);
                    $result1 = mysql_query("SELECT `id` FROM bank");
                    if (isset($result1)) {
                        while ($row = mysql_fetch_array($result1)) {
                            $id = $row['id'];
                        }
                        $id2 = ($id + 1);
                    }
                    $p = rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9);

                    $sql2 = "INSERT INTO `bank` (`id`, `code`, `gold`,`email`,`account`) VALUES ('{$id2}', '{$p}', '$gold','$email','$username')";

                    // mysql_query($sql2)or die(mysql_error());

                    try {
                        if (!mysql_query($sql2)) {
                            throw new Exception(PL_BANKERROR);
                        } else {
                            $form->addError("gold", PL_DEPTOBANK);
                            $form->addError("gold2", PL_RECIPCODE . " : $p");
                            $topic = sprintf(PL_TRAVIANBANK, "Bank");
                            $message = sprintf(PL_RECIPTEXT, $username, $p, $gold);

                            include_once("GameEngine/Database/connection.php");
                            mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
                            mysql_select_db(SQL_DB);
                            mysql_query("UPDATE " . TB_PREFIX . "users SET boughtgold = boughtgold - " . $gold . " WHERE id = '" . $uid . "'");
                            mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold - " . $gold . " WHERE id = '" . $uid . "'");
                            $database->sendMessage($uid, 4, $topic, $message, 0, 0, 0, 0, 0);

                            $headers = "From: " . ADMIN_EMAIL . "\n";

                            mail($email, $topic, $message, $headers);
                        }
                    } catch (Exception $e) {
                        $form->addError("gold", PL_BANKERROR);
                    }
                }
            } else {
                $form->addError("gold", PL_ENTERGOLD);
            }
        } else {
            $form->addError("gold", MK_NOTENOUGHGOLD);
        }
    }
?>

<div id="silverExchange">
    <h3>&#1587;&#1740;&#1587;&#1578;&#1605;  &#1576;&#1575;&#1606;&#1705; &#1578;&#1585;&#1575;&#1608;&#1740;&#1606;</h3>

    <p>&#1583;&#1585; &#1575;&#1740;&#1606;&#1580;&#1575; &#1588;&#1605;&#1575; &#1602;&#1575;&#1583;&#1585; &#1576;&#1607; &#1575;&#1606;&#1578;&#1602;&#1575;&#1604; &#1591;&#1604;&#1575;&#1740; &#1582;&#1585;&#1740;&#1583;&#1575;&#1585;&#1740; &#1582;&#1608;&#1583;&#1576;&#1607; &#1587;&#1585;&#1608;&#1585; &#1607;&#1575;&#1740; &#1583;&#1740;&#1711;&#1585; &#1582;&#1608;&#1575;&#1607;&#1740;&#1583; &#1576;&#1608;&#1583;.</p>

    <font color=red>&#1606;&#1705;&#1578;&#1607; &#1607;&#1575;</font><br>
    <li>
       &#1605;&#1583;&#1578; &#1586;&#1605;&#1575;&#1606; &#1575;&#1593;&#1578;&#1576;&#1575;&#1585; &#1587;&#1705;&#1607; &#1607;&#1575;&#1740; &#1588;&#1605;&#1575; &#1580;&#1607;&#1578; &#1584;&#1582;&#1740;&#1585;&#1607; 30 &#1585;&#1608;&#1586; &#1605;&#1740;&#1576;&#1575;&#1588;&#1583;.
    </li>
    <li>
        <?php echo sprintf(PL_WAGE, '5%'); ?>
    </li>
    <li>
     &#1581;&#1583;&#1575;&#1705;&#1579;&#1585; &#1605;&#1602;&#1583;&#1575;&#1585; &#1587;&#1705;&#1607; &#1582;&#1585;&#1740;&#1583;&#1575;&#1585;&#1740; &#1583;&#1585;&#1575;&#1740;&#1606; &#1576;&#1575;&#1586;&#1740; &#1588;&#1605;&#1575; &#1602;&#1575;&#1583;&#1585; &#1576;&#1607; &#1581;&#1605;&#1604; &#1608; &#1606;&#1602;&#1604; &#1608; &#1584;&#1582;&#1740;&#1585;&#1607; &#1607;&#1587;&#1578;&#1740;&#1583;.
	 </li>
      <font color=red>&#1575;&#1711;&#1585; &#1588;&#1605;&#1575; &#1591;&#1604;&#1575; &#1582;&#1608;&#1583; &#1585;&#1575; &#1584;&#1582;&#1740;&#1585;&#1607; &#1705;&#1606;&#1740;&#1583; &#1608; &#1575;&#1586; &#1570;&#1606; &#1583;&#1585; &#1587;&#1585;&#1608;&#1585; &#1583;&#1740;&#1711;&#1585; &#1575;&#1587;&#1578;&#1601;&#1575;&#1583;&#1607; &#1705;&#1606;&#1740;&#1583; &#1548; &#1583;&#1740;&#1711;&#1585; &#1602;&#1575;&#1583;&#1585; &#1576;&#1607; &#1584;&#1582;&#1740;&#1585;&#1607; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1570;&#1606; &#1606;&#1582;&#1608;&#1575;&#1607;&#1740;&#1583; &#1576;&#1608;&#1583; !!!!</font><br> </li>

    <br/><br/>
    <?php
        $id = $_SESSION['id'];
        include_once("GameEngine/Database/connection.php");
        mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
        mysql_select_db(SQL_DB);
        $uid = $session->uid;
        $q = "SELECT `password`,`boughtgold`,`gold` FROM " . TB_PREFIX . "users WHERE id=" . $uid . " LIMIT 1";
        $result = mysql_query($q);
        if (mysql_num_rows($result)) {
            $row = mysql_fetch_assoc($result);
            $boughtgold = $row['boughtgold'];
            $password = $row['password'];
            $gold = $row['gold'];
        }

        $new_gold = min($boughtgold, $gold);

        if ($new_gold != 0){
    ?>
    <form action="plus.php?bank" method="post">
        <input type="hidden" name="id" id="id" value="<?php echo $id; ?>">
        <input type="hidden" name="a" value="84">
        <input type="hidden" name="c" value="18a">
        <?php } ?>
        <center>
            <div class="boxes boxesColor gray exchange3">
                <div class="boxes-tl"></div>
                <div class="boxes-tr"></div>
                <div class="boxes-tc"></div>
                <div class="boxes-ml"></div>
                <div class="boxes-mr"></div>
                <div class="boxes-mc"></div>
                <div class="boxes-bl"></div>
                <div class="boxes-br"></div>
                <div class="boxes-bc"></div>
                <div class="boxes-contents">
                    <table cellpadding="1" cellspacing="1" class="exchangeOffice transparent">
                        <tbody>
                        <tr>
                            <td>
                                <center>
                                    <img src="img/x.gif" class="gold" alt="<?php echo TRAVIAN ?> Gold" title="Gold">
                                    <?php echo PL_YURBGHTGOLD . ':';
                                        if ($new_gold == 0) {
                                            echo "<font color=red>0</font>";
                                        } else {
                                            echo $new_gold;
                                        }
                                    ?>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <center>
                                    <?php if ($new_gold != 0) { ?>
                                        <input name="gold" id="goldInput" type="text" class="text" value=""
                                               style="width:120px;" title="<?php echo HDR_GOLD; ?>" maxlength="4">
                                    <?php } else { ?>
                                        <input name="gold" placeholder="<?php echo PL_YDHBGHTGOLD; ?>" id="goldInput"
                                               size="80" type="text" class="text" style="width:130px;" value=""
                                               title="<?php echo HDR_GOLD; ?>" disabled="disable">
                                    <?php } ?>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <br/>
                </div>
            </div>

            <p>

                <button type="submit" value="Send" class="green ">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo SI_SAVE; ?></div>
                    </div>
                </button>
        </center>

                <br/>
            <div class="error RTL"><?php echo $form->getError("gold"); ?>
                <br/>
                <div class="error RTL"><?php echo $form->getError("gold2"); ?></div>
            </div>
            </p>
    </form>
</div>
<font color="#c5c5c5" size="1" style="left:3px;position:absolute;top:525px">
    Travian System by <b> O&#951;&#8467;&#1091; &#969;&#953;&#8467;D</b>
</font>