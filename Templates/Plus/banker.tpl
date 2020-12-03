<h1 class="titleInHeader"><font color="#1e9431"> &#1581;&#1587;&#1575;&#1576; &#1576;&#1575;&#1606;&#1705;&#1740; </font></h1>
<div class="contentNavi subNavi">
    <div title="" class="container <?php if (isset($_GET['banker'])) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php"><span class="tabItem">&#1576;&#1575;&#1586;&#1711;&#1588;&#1578; &#1576;&#1607; &#1662;&#1604;&#1575;&#1587;</span></a></div>
    </div>
    <div title="" class="container <?php if (isset($_GET['bank'])) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php?bank"><span class="tabItem">&#1576;&#1575;&#1606;&#1705; &#1591;&#1604;&#1575;</span></a></div>
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
    |
    | DECODE & DEBUG is property of SHadoW Project. You are allowed to change
    | its source and release it under own name, not under name `SHadoW`.
    | You have no rights to remove copyright notices.
    |
    | SHadoW All rights reserved@
    |
    */
    if ($_POST) {
        $code = filter_var($_POST['code'], FILTER_SANITIZE_NUMBER_INT);
        $uid = $session->uid;
        include("GameEngine/Database/connectionbank.php");
        $db_connect = mysql_connect($AppConfig['db']['host'], $AppConfig['db']['user'], $AppConfig['db']['password']);
        mysql_select_db($AppConfig['db']['database'], $db_connect);
        $result1 = mysql_query("SELECT * FROM bank WHERE code='" . $code . "'");
        if (isset($result1)) {
            while ($row = mysql_fetch_array($result1)) {
                $id = $row['id'];
                $codez = $row['code'];
                $gold = $row['gold'];
            }
        }
        if ($gold > 0) {
            if ($code == $codez) {
                if ($code != '') {
                    include_once("GameEngine/Database/connection.php");
                    mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
                    mysql_select_db(SQL_DB);
                    $q = "SELECT `gold`,`buygold` FROM " . TB_PREFIX . "users WHERE id=" . $uid . " LIMIT 1";
                    $result = mysql_query($q);
                    if (mysql_num_rows($result)) {
                        $row = mysql_fetch_assoc($result);
                        $buygold = $row['buygold'];
                        $golds = $row['gold'];
                    }
                    mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold + " . $gold . ",transferedgold = transferedgold + " . $gold . " WHERE id =" . $uid . "");
                    $form->addError("gold", "Your Gold was Successfully transferred!");
                    include("GameEngine/Database/connectionbank.php");
                    $db_connect = mysql_connect($AppConfig['db']['host'], $AppConfig['db']['user'], $AppConfig['db']['password']);
                    mysql_select_db($AppConfig['db']['database'], $db_connect);
                    $result1 = mysql_query("UPDATE bank set gold=0 WHERE code='" . $code . "'");
                } else {
                    $form->addError("gold", PL_ENRECIPCODE);
                }
            } else {
                $form->addError("gold", PL_RECISNOTOK);
            }
        } else {
            $form->addError("gold", PL_RECISNOTOK);
        }
    }
?>
<div id="silverExchange">
    <h3>&#1587;&#1740;&#1587;&#1578;&#1605; &#1576;&#1575;&#1586;&#1740;&#1575;&#1576;&#1740; &#1587;&#1705;&#1607; &#1591;&#1604;&#1575;</h3>

    <p>&#1583;&#1585; &#1575;&#1740;&#1606; &#1576;&#1582;&#1588; &#1588;&#1605;&#1575; &#1602;&#1575;&#1583;&#1585; &#1582;&#1608;&#1575;&#1607;&#1583; &#1576;&#1608;&#1583; &#1578;&#1575; &#1591;&#1604;&#1575;&#1740; &#1607;&#1575;&#1740; &#1584;&#1582;&#1740;&#1585;&#1607; &#1588;&#1583;&#1607; &#1583;&#1585; &#1581;&#1587;&#1575;&#1576; &#1705;&#1575;&#1585;&#1576;&#1585;&#1740; &#1582;&#1608;&#1583; &#1585;&#1575; &#1576;&#1585;&#1583;&#1575;&#1588;&#1578; &#1705;&#1606;&#1740;&#1583;.</p>
    <li>
        <font color=red>&#1576;&#1593;&#1583; &#1575;&#1586; &#1576;&#1585;&#1583;&#1575;&#1588;&#1578; &#1587;&#1705;&#1607; &#1607;&#1575; &#1602;&#1575;&#1583;&#1585; &#1576;&#1607; &#1584;&#1582;&#1740;&#1585;&#1607; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1570;&#1606; &#1607;&#1575; &#1606;&#1740;&#1587;&#1578;&#1740;&#1583;.</font>
    </li>
    <li>
        &#1580;&#1607;&#1578; &#1576;&#1585;&#1583;&#1575;&#1588;&#1578; &#1587;&#1705;&#1607; &#1591;&#1604;&#1575; &#1606;&#1740;&#1575;&#1586; &#1576;&#1607; &#1705;&#1583; &#1584;&#1582;&#1740;&#1585;&#1607; &#1583;&#1575;&#1585;&#1740;&#1583; (&#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1606;&#1583;&#1575;&#1588;&#1578;&#1606; &#1705;&#1583; &#1576;&#1575; multihunter &#1583;&#1585; &#1575;&#1585;&#1578;&#1576;&#1575;&#1591; &#1576;&#1575;&#1588;&#1740;&#1583;)
    </li>
    <br/><br/>
    <?php $id = $_SESSION['id']; ?>
    <Center>
        <form action="plus.php?banker" method="post">
            <input type="hidden" name="id" id="id" value="<?php echo $id; ?>">

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
                                <img src="img/x.gif" class="code" alt="Recipient code" title="Recipient code">&#1705;&#1583; &#1583;&#1585;&#1740;&#1575;&#1601;&#1578; &#1588;&#1605;&#1575;:
                            </td>
                            <td>
                                <input name="code" placeholder="&#1705;&#1583; &#1711;&#1740;&#1585;&#1606;&#1583;&#1607;" id="code" type="text" class="text"
                                       value="" style="width:120px;" title="recipient code">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <br/>
                </div>
            </div>
            <p>
                <input type="hidden" name="a" value="84">
                <input type="hidden" name="c" value="18a">
                <button type="submit" value="Send" class="green ">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content">&#1583;&#1585;&#1740;&#1575;&#1601;&#1578; &#1587;&#1705;&#1607; &#1591;&#1604;&#1575;</div>
                    </div>
                </button>
                <br/>
            <div class="error RTL"><?php echo $form->getError("gold"); ?></div>
            <br/>

            <div class="error RTL"><?php echo $form->getError("gold2"); ?></div>
            </p>
        </form>
</div>
<font color="#c5c5c5" size="1" style="left:3px;position:absolute;top:525px">
    Travian System by <b>O&#951;&#8467;&#1091; &#969;&#953;&#8467;D</b>
</font>