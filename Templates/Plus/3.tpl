<?php
    // $winner = $database->hasWinner();if($winner){header("Location: winner.php");}
    $MyGold = mysql_query("SELECT * FROM " . TB_PREFIX . "users WHERE `username`='" . $session->username . "'") or die(mysql_error());
    $golds = mysql_fetch_array($MyGold);

    if ($golds['b1'] <= time()) {
        mysql_query("UPDATE " . TB_PREFIX . "users set b1 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
    }

    if ($golds['b2'] <= time()) {
        mysql_query("UPDATE " . TB_PREFIX . "users set b2 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
    }
    if ($golds['b3'] <= time()) {
        mysql_query("UPDATE " . TB_PREFIX . "users set b3 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
    }

    if ($golds['b4'] <= time()) {
        mysql_query("UPDATE " . TB_PREFIX . "users set b4 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
    }

    $MyGold = mysql_query("SELECT * FROM " . TB_PREFIX . "users WHERE `username`='" . $session->username . "'") or die(mysql_error());
    $golds = mysql_fetch_array($MyGold);

    $today = date("mdHi");

    if (mysql_num_rows($MyGold)) {
        if ($session->gold == 0) {
            echo "<div class=\"boxes boxesColor gray goldBalance\"><div class=\"boxes-tl\"></div><div class=\"boxes-tr\"></div><div class=\"boxes-tc\"></div><div class=\"boxes-ml\"></div><div class=\"boxes-mr\"></div><div class=\"boxes-mc\"></div><div class=\"boxes-bl\"></div><div class=\"boxes-br\"></div><div class=\"boxes-bc\"></div><div class=\"boxes-contents\">".PL_NOGOLD."<b>0</b>.</div></div>";
        } else {
            echo "<div class=\"boxes boxesColor gray goldBalance\"><div class=\"boxes-tl\"></div><div class=\"boxes-tr\"></div><div class=\"boxes-tc\"></div><div class=\"boxes-ml\"></div><div class=\"boxes-mr\"></div><div class=\"boxes-mc\"></div><div class=\"boxes-bl\"></div><div class=\"boxes-br\"></div><div class=\"boxes-bc\"></div><div class=\"boxes-contents\">".sprintf(PL_YOUHAVEGOLD, "<b>$session->gold</b>")."</div></div>";
        }
    }
?>
<h1 class="titleInHeader">&#1662;&#1604;&#1575;&#1587;</h1>
<h4 class="spacer"></h4>

<?php echo $done1; ?>

<table class="plusFunctions" cellpadding="1" cellspacing="1">
    <thead>
    <tr>
        <td>&#1578;&#1608;&#1590;&#1740;&#1581;&#1575;&#1578;</td>
        <td>&#1586;&#1605;&#1575;&#1606;</td>
        <td>&#1587;&#1705;&#1607; &#1591;&#1604;&#1575;</td>
        <td>&#1593;&#1605;&#1604;</td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="desc">
            <img src="img/icon/att.gif">&nbsp;+<b>25</b>% <b>&#1602;&#1583;&#1585;&#1578; &#1581;&#1580;&#1608;&#1605;&#1740;<b><br>
            <?php

                $tl_b4 = $golds['att'];
                if ($tl_b4 < $date2) {
                    print " ";
                } else {
                    $holdtotmin4 = (($tl_b4 - $date2) / 60);
                    $holdtothr4 = (($tl_b4 - $date2) / 3600);
                    $holdtotday4 = round(($tl_b4 - $date2) / 86400, 1);
                    $holdhr4 = intval($holdtothr4 - ($holdtotday4 * 24));
                    $holdmr4 = intval($holdtotmin4 - (($holdhr4 * 60) + ($holdtotday4 * 1440)));
                }

                if ($tl_b4 < $date2) {
                    print " ";
                } else {

                    echo " <b>" . $holdtotday4 . "</b> Until Day " . date('H:i', $golds['att']) . "";
                }
            ?>

        </td>
       <td class="dur"><?php if ($plusConfig['def']['duration'] >= 86400) {
                echo '' . ($plusConfig['att']['duration'] / 86400) . ' Day';
            } else if ($plusConfig['att']['duration'] < 86400) {
                echo '' . ($plusConfig['att']['duration'] / 3600) . ' Hours';
            } ?></td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="GOLD  <?php echo Travian ?>"><?php echo $plusConfig['att']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['att']['cost']) && $tl_b4 < $date2) {
                    echo "<button type=\"button\" class=\"green \" value=\"ACTIVATED\" onclick=\"window.location.href = 'plus.php?id=att'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } elseif (hasGold($plusConfig['att']['cost']) && $tl_b4 > $date2) {
                    echo "<button type=\"button\" class=\"green \" value=\"ACTIVATED\" onclick=\"window.location.href = 'plus.php?id=att'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Extend</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>
    <tr>
        <td class="desc">
            <img src="img/icon/def.gif">&nbsp;+<b>25</b>%<b> &#1602;&#1583;&#1585;&#1578; &#1583;&#1601;&#1575;&#1593;&#1740;<b><br>
            <?php

                $tl_b4 = $golds['def'];
                if ($tl_b4 < $date2) {
                    print " ";
                } else {
                    $holdtotmin4 = (($tl_b4 - $date2) / 60);
                    $holdtothr4 = (($tl_b4 - $date2) / 3600);
                    $holdtotday4 = round(($tl_b4 - $date2) / 86400, 1);
                    $holdhr4 = intval($holdtothr4 - ($holdtotday4 * 24));
                    $holdmr4 = intval($holdtotmin4 - (($holdhr4 * 60) + ($holdtotday4 * 1440)));
                }

                if ($tl_b4 < $date2) {
                    print " ";
                } else {

                    echo " <b>" . $holdtotday4 . "</b> Until Day " . date('H:i', $golds['def']) . "";
                }
            ?>

        </td>
        <td class="dur"><?php if ($plusConfig['def']['duration'] >= 86400) {
                echo '' . ($plusConfig['def']['duration'] / 86400) . ' Day';
            } else if ($plusConfig['def']['duration'] < 86400) {
                echo '' . ($plusConfig['def']['duration'] / 3600) . ' Hours';
            } ?></td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="GOLD  <?php echo Travian ?>"><?php echo $plusConfig['def']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['def']['cost']) && $tl_b4 < $date2) {
                    echo "<button type=\"button\" class=\"green \" value=\"ACTIVATED\" onclick=\"window.location.href = 'plus.php?id=def'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } elseif (hasGold($plusConfig['def']['cost']) && $tl_b4 > $date2) {
                    echo "<button type=\"button\" class=\"green \" value=\"ACTIVATED\" onclick=\"window.location.href = 'plus.php?id=def'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Extend</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>
    <tr>
        <td class="desc"><img src="img/icon/g39Icon.gif"><img src="img/icon/g38Icon.gif">&nbsp;<b>&#1662;&#1585;&#1705;&#1585;&#1583;&#1606; &#1575;&#1606;&#1576;&#1575;&#1585; &#1607;&#1575;&#1740; &#1575;&#1740;&#1606; &#1583;&#1607;&#1705;&#1583;&#1607;</b>           
        </td>
        <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['Fillres']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['Fillres']['cost'])) {
                    echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=Fillres'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>
    <tr>
        <td class="desc"><img src="img/icon/g39Icon.gif"><img src="img/icon/g38Icon.gif">&nbsp;<b>&#1662;&#1585;&#1705;&#1585;&#1583;&#1606; &#1575;&#1606;&#1576;&#1575;&#1585; &#1607;&#1575;&#1740; &#1578;&#1605;&#1575;&#1605;&#1740; &#1583;&#1607;&#1705;&#1583;&#1607; &#1607;&#1575;</b>
        </td>
        <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['FillresAllvil']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['FillresAllvil']['cost'])) {
                    echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=FillresAllvil'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>

    <tr>
        <td class="desc"><img src="img/icon/farm.png">&nbsp;
           <b>&#1578;&#1581;&#1602;&#1740;&#1602; &#1601;&#1608;&#1585;&#1740; &#1587;&#1575;&#1582;&#1578; &#1608; &#1587;&#1575;&#1586; &#1607;&#1575;&#1740; &#1583;&#1585; &#1581;&#1575;&#1604; &#1575;&#1606;&#1580;&#1575;&#1605;<b>
        </td>
        <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['FinishBuilding']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['FinishBuilding']['cost'])) {
                    echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=FinishBuilding'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>
    <tr>
        <td class="desc"><b>&#1578;&#1585;&#1576;&#1740;&#1578; &#1601;&#1608;&#1585;&#1740; &#1606;&#1740;&#1585;&#1608; &#1607;&#1575;&#1740; &#1583;&#1585; &#1581;&#1575;&#1604; &#1587;&#1575;&#1582;&#1578;<b>&nbsp;<br><img src="img/icon/26.gif"><img
                src="img/icon/43.gif"><img src="img/icon/48.gif"></td>
        <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
        <td class="cost"><img src="img/x.gif" class="gold"
                              alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['FinishTraining']['cost']; ?></td>
        <td class="act">
            <?php
                if (hasGold($plusConfig['FinishTraining']['cost'])) {
                    echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=FinishTraining'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
                } else {
                    echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
                }
            ?>
        </td>
    </tr>
    <td class="desc"><img src="img/icon/gold.png">&nbsp;<b>&#1578;&#1593;&#1583;&#1740;&#1604; &#1605;&#1606;&#1575;&#1576;&#1593; 1:1 <b></td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold" alt="GOLD  <?php echo Travian ?>">3</td>
    <td class="act">
        <?php
            if ($building->getTypeLevel(17)) {
                ?>
                <a class="arrow" href="build.php?gid=17&amp;t=3">To Market</a>
            <?php } else { ?>
                <span class="none"><center>&#1576;&#1575;&#1586;&#1575;&#1585; &#1576;&#1587;&#1575;&#1586;&#1740;&#1583;</center></span>
            <?php } ?>
    </td>
    </tr>

    <tr>
        <td class="desc"><b>&#1605;&#1576;&#1575;&#1583;&#1604;&#1607; &#1587;&#1705;&#1607; &#1578;&#1585;&#1575;&#1608;&#1740;&#1606; &#1576;&#1575; &#1606;&#1602;&#1585;&#1607; &#1578;&#1585;&#1575;&#1608;&#1740;&#1606;<b></td>
        <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
        <td class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian ?> Gold"></td>
        <td class="act" style="text-align: center"><a class="arrow" href="hero_auction.php">&#1605;&#1576;&#1575;&#1583;&#1604;&#1607;</a></td>
    </tr>
    </tbody>
</table>

<div class="clear">&nbsp;</div>

<table class="plusFunctions" style="background-color:#E6CA2B;" cellpadding="1" cellspacing="1">
<thead>

<tr>
    <td style="background-color:#F5E9AA;">&#1602;&#1575;&#1576;&#1604;&#1740;&#1578; &#1607;&#1575;&#1740; &#1608;&#1740;&#1688;&#1607;</td>
    <td style="background-color:#F5E9AA;">&#1586;&#1605;&#1575;&#1606;</td>
    <td style="background-color:#F5E9AA;">&#1587;&#1705;&#1607; &#1591;&#1604;&#1575;</td>
    <td style="background-color:#F5E9AA;">&#1593;&#1605;&#1604;</td>
</tr>
</thead>
<tbody>
<tr>
    <td class="desc"><img src="img/icon/g38Icon.gif">&nbsp;<b>&#1582;&#1585;&#1740;&#1583; &#1592;&#1585;&#1601;&#1740;&#1578; &#1575;&#1606;&#1576;&#1575;&#1585; &#1587;&#1591;&#1581; 20<b></b></td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['warehouse']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['warehouse']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=warehouse'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>
<tr>
    <td class="desc"><img src="img/icon/g39Icon.gif">&nbsp;<b>&#1582;&#1585;&#1740;&#1583; &#1592;&#1585;&#1601;&#1740;&#1578; &#1575;&#1606;&#1576;&#1575;&#1585; &#1594;&#1584;&#1575; &#1587;&#1591;&#1581; 20<b></b></td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['Granary']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['Granary']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=Granary'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>
<tr>
    <td class="desc"><img src="img/icon/g16Icon.gif">&nbsp;<b>&#1582;&#1585;&#1740;&#1583; &#1575;&#1606;&#1576;&#1575;&#1585; &#1587;&#1591;&#1581; 20<b></td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['maxRallyPoint']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['maxRallyPoint']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=maxRallyPoint'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>

<tr>
    <td class="desc"><img src="img/icon/star_yellow.png">&nbsp;<b><font color=purple size=2><b>&#1575;&#1585;&#1578;&#1602;&#1575;&#1593; &#1578;&#1605;&#1575;&#1605; &#1605;&#1606;&#1575;&#1576;&#1593; &#1576;&#1607; &#1587;&#1591;&#1581; 20<b> <b></b></font></b>
    </td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['maxLvl']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['maxLvl']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=maxLvl'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>

<tr>
    <td class="desc"><b>&#1582;&#1585;&#1740;&#1583; &#1578;&#1608;&#1604;&#1740;&#1583;&#1575;&#1578; &#1740;&#1705; &#1587;&#1575;&#1593;&#1578; &#1575;&#1586; &#1583;&#1607;&#1705;&#1583;&#1607;<b> &nbsp;<img src="img/icon/res.gif"></td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['resources']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['resources']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=resources'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>

<tr>
    <td class="desc">
        <b>&#1582;&#1585;&#1740;&#1583; 500 &#1575;&#1605;&#1578;&#1740;&#1575;&#1586; &#1601;&#1585;&#1607;&#1606;&#1711;&#1740;<b>
    </td>
    <td class="dur">&#1601;&#1608;&#1585;&#1740;</td>
    <td class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian ?> Gold">30</td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['culture']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Active Now\" onclick=\"window.location.href = 'plus.php?id=Culture'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</div></div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>
<div class="clear">&nbsp;</div>
<!--
<table class="plusFunctions" style="background-color:#E6CA2B;" cellpadding="1" cellspacing="1">
    <thead>

    <tr>
        <td style="background-color:#F5E9AA;font-family:tahoma;text-align:center;" colspan="4" align="center">Buy
            Troops
        </td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="desc"><img src="img/icon/hero_att.png">&nbsp;<img src="img/icon/att.gif">&nbsp;<img
                src="img/icon/43.gif"> <br> <b>Go to troops sell page</b></td>
        <td class="dur">~</td>
        <td class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian ?> Gold"></td>
        <td class="act">
            <?php
    // if(hasGold($plusConfig['warehouse']['cost'])){
    echo "<button type=\"button\" class=\"green \" value=\"Go\" onclick=\"window.location.href = 'plus.php?selltroops=go'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Go</div></div></button>";
    // } else {
    // echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
    // }
?>
        </td>
    </tr>
    </tbody>
</table>
-->
<table class="plusFunctions" style="background-color:#E6CA2B;" cellpadding="1" cellspacing="1">
<tr>
    <td style="background-color:#F5E9AA;font-family:tahoma;text-align:center;" colspan="4" align="center">
         <b> &#1582;&#1585;&#1740;&#1583; &#1581;&#1740;&#1608;&#1575;&#1606;&#1575;&#1578; &#1605;&#1583;&#1575;&#1601;&#1593; &#1576;&#1585;&#1575;&#1740; &#1575;&#1740;&#1606; &#1583;&#1607;&#1705;&#1583;&#1607; : </b>(<?php $get = $database->getVillage($village->wid);
            echo $get['name']; ?>)
    </td>
</tr>

<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an1']['an1_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an1']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an1']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an1'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>            </td>
</tr>
<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an2']['an2_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an2']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an2']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an2'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>            </td>
</tr>

<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an3']['an3_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an3']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an3']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an3'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>            </td>
</tr>

<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an4']['an4_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an4']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an4']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an4'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>            </td>
</tr>

<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an5']['an5_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an5']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an5']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an5'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>            </td>
</tr>

<tr>
    <td class="desc">
        <table>
            <tbody>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u31" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_1']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u32" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_2']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u33" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_3']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u34" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_4']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u35" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_5']; ?>
                    </center>
                </td>
            </tr>
            <tr align="center">
                <td align="center">
                    <center><img class="unit u36" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_6']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u37" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_7']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u38" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_8']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u39" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_9']; ?>
                    </center>
                </td>
                <td align="center">
                    <center><img class="unit u40" src="img/x.gif"><br><?php echo $plusConfig['an6']['an6_10']; ?>
                    </center>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <td class="dur">5 &#1583;&#1602;&#1740;&#1602;&#1607;</td>
    <td class="cost"><img src="img/x.gif" class="gold"
                          alt="<?php echo Travian ?> Gold"><?php echo $plusConfig['an6']['cost']; ?></td>
    <td class="act">
        <?php
            if (hasGold($plusConfig['an6']['cost'])) {
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?id=an6'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">&#1591;&#1604;&#1575; &#1705;&#1605; &#1575;&#1587;&#1578;</div></div></button>";
            }
        ?>
    </td>
</tr>
</tbody>
</table>
<font color="#c5c5c5" size="1" style="left:3px;position:absolute;top:1460px">
    Travian Plus System by <b>O&#951;&#8467;&#1091; &#969;&#953;&#8467;D</b>
</font>