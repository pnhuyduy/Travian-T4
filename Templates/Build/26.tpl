<?php
    if (time() - $_SESSION['time_p'] > 5) {
        $_SESSION['time_p'] = '';
        $_SESSION['error_p'] = '';
    }

    if ($_POST AND $_GET['action'] == 'change_capital') {
        $pass = mysql_real_escape_string($_POST['pass']);
        $query = mysql_query('SELECT * FROM `' . TB_PREFIX . 'users` WHERE `id` = ' . $session->uid);
        $data = mysql_fetch_assoc($query);
        function generateHash($plainText, $salt = 1)
        {
            $salt = substr($salt, 0, 9);

            return $salt . md5($salt . $plainText);
        }

        if ($data['password'] == generateHash($pass)) {
            $query1 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'vdata` WHERE `owner` = ' . $session->uid . ' AND `capital` = 1');
            $data1 = mysql_fetch_assoc($query1);
            $query2 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'fdata` WHERE `vref` = ' . $data1['wref']);
            if ($query2) $data2 = mysql_fetch_assoc($query2);
            if (empty($data2) || $data2['vref'] != $village->wid) {
                for ($i = 1; $i <= 18; ++$i) {
                    if ($data2['f' . $i] > 10) {
                        $query2 = mysql_query('UPDATE `' . TB_PREFIX . 'fdata` SET `f' . $i . '` = 10 WHERE `vref` = ' . $data2['vref']) or die(mysql_error());
                    }
                }

                for ($i = 19; $i <= 40; ++$i) {
                    if ($data2['f' . $i . 't'] == 34) {
                        $query3 = mysql_query('UPDATE `' . TB_PREFIX . 'fdata` SET `f' . $i . 't` = 0, `f' . $i . '` = 0 WHERE `vref` = ' . $data2['vref']) or die(mysql_error());
                    }
                }

                $query3 = mysql_query('UPDATE `' . TB_PREFIX . 'vdata` SET `capital` = 0 WHERE `wref` = ' . $data1['wref']);
                $query4 = mysql_query('UPDATE `' . TB_PREFIX . 'vdata` SET `capital` = 1 WHERE `wref` = ' . $village->wid);
            }
            #print '<script language="javascript">location.href="build.php?id=' . $building->getTypeField(26) . '";</script>';
        } else {
            $error = '<b><font class="error">' . BL_ERROR . '</font></b><br />';
            $_SESSION['error_p'] = $error;
            $_SESSION['time_p'] = time();
            print '<script language="javascript">location.href="build.php?id=' . $building->getTypeField(26) . '&confirm=yes";</script>';
        }
    }
?>
<h1 class="titleInHeader"><?php echo B26; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid26">
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(26,4, 'gid');" class="build_logo">
            <img class="building big white g26" src="img/x.gif" alt="<?php echo B26; ?>" title="<?php echo B26; ?>"/>
        </a>
        <?php echo B26_DESC; ?></div>
    <?php
        if ($building->getTypeLevel(26) > 0) {
            include("upgrade.tpl");
            include("26_menu.tpl");

            $test = $database->getAvailableExpansionTraining();

            if ($village->resarray['f' . $id] >= 10) {
                include("26_train.tpl");
            } else {
                echo '<div class="c">' . BL_TOFINDNEWVILPAL . '</div>';
            }

            $query = mysql_query('SELECT * FROM `' . TB_PREFIX . 'vdata` WHERE `owner` = ' . $session->uid . ' AND `capital` = 1');
            $data = mysql_fetch_assoc($query);
            if ($data['wref'] == $village->wid) {
                ?>
                <p class="none"><?php echo BL_CAPITAL; ?></p>
            <?php
            } else {
                if ($_GET['confirm'] == '') {
                    print '<p><a class="arrow" href="?id=' . $building->getTypeField(26) . '&confirm=yes">' . BL_MAKEITCAP . '</a></p>';
                } else {
                    print '<p>' . US_PASSTOCONFIRM . '<br />
    <form method="post" action="build.php?id=' . $building->getTypeField(26) . '&action=change_capital">
     
     ' . US_PASSWORD . ': <input type="password" name="pass" />' . $_SESSION['error_p'] . '<br />
     <button type="submit" value="button" class="green build">
		<div class="button-container addHoverClick">
			<div class="button-background">
				<div class="buttonStart">
					<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">' . OK . '</div></div>
                    </button>
    </form>
    </p>';
                }
            }
        } else {
            echo "<b>" . B26 . " " . BL_ISBEINGUP . ".</b>";
        }

    ?>
</div>
<div class="clear">&nbsp;</div>
<div class="clear"></div>