<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include('GameEngine/Village.php');
    if ($session->plus) {
        $start = $generator->pageLoadTimeStart();
        if (isset($_GET['rank'])) {
            $_POST['rank'] == $_GET['rank'];
        }
        if (isset($_GET['newdid'])) {
            $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
            $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
            $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "'");
            $row = mysql_fetch_assoc($t);
            if ($row['owner'] == $session->uid) {
                $_SESSION['wid'] = $_GET['newdid'];
            }
            if (isset($_GET['tid'])) {
                if (preg_match('/[^0-9]/', $_GET['tid'])) {
                    $tid = filter_var($_GET['tid'], FILTER_SANITIZE_STRING, FILTER_SANITIZE_NUMBER_INT);
                } else {
                    $tid = 1;
                }
                header('Location: statistiken.php?tid=' . $tid . '');
                exit;
            } else {
                header('Location: statistiken.php');
                exit;
            }
        }
        include('Templates/html.tpl');
        ?>
        <body class="v35 gecko linklist perspectiveResources">
        <script type="text/javascript">
            window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
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
            <?php include('Templates/res.tpl'); ?>
            <div class="contentTitle">
                <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE; ?>">
                    &nbsp;</a>
                <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.ir/" target="_blank"
                   title="<?php echo BL_TRAVIANANS; ?>">&nbsp;</a>
            </div>
            <div class="contentContainer">
                <div id="content" class="linklist">
                    <h1 class='titleInHeader'><?php echo PL_DIRECTLINK; ?></h1>
                    <?php
                        if (isset($_GET['del']) && is_numeric($_GET['del'])) {
                            $database->removeLinks($_GET['del'], $session->uid);
                            header("Location: spieler.php?s=4");
                        }
                        // Save new link or just edit a link
                        if ($_POST) {
                            $links = array();
// let's do some complicated code x'D
                            foreach ($_POST as $key => $value) {
// echo $value;
                                $i = 0;
                                if (substr($key, 0, 2) == 'nr') {
                                    // $i = substr($key, 2);
                                    $links[$i]['nr'] = $value;
                                }
                                if (substr($key, 0, 2) == 'id') {
                                    // $i = substr($key, 2);
                                    $links[$i]['id'] = $value;
                                }

                                if (substr($key, 0, 8) == 'linkname') {
                                    // $i = substr($key, 8);
                                    $links[$i]['linkname'][] = $value;
                                }
                                // echo substr($key, 0, 8).' ';
                                if (substr($key, 0, 8) == 'linkziel') {
                                    // $i = substr($key, 8);
                                    $links[$i]['linkziel'][] = $value;
                                }
                            }
                            foreach ($links as $link => $value) {

                                settype($link['nr'], 'int');
                                $userid = $session->uid;
                                $query2 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'links` WHERE `userid` = ' . $session->uid . ' ORDER BY `pos` ASC') or die(mysql_error());

                                // $row
                                $max = mysql_num_rows($query2);

                                $i = 0;
                                while ($row = mysql_fetch_assoc($query2)) {
                                    if ($value['linkname'][$i] == '' || $value['linkziel'][$i] == '') {
                                        mysql_query('DELETE FROM `' . TB_PREFIX . 'links` WHERE `id` = ' . $row['id']);
                                    } else
                                        if ($row['name'] != $value['linkname'][$i] || $row['url'] != $value['linkziel'][$i]) {
                                            mysql_query('UPDATE `' . TB_PREFIX . 'links` SET `name` = \'' . $value['linkname'][$i] . '\', `url` = \'' . $value['linkziel'][$i] . '\', `pos` = ' . $i . ' WHERE `id` = ' . $row['id']);
                                        }
                                    $i++;
                                }
                                $counter = 0;
                                foreach ($value['linkname'][$i] as $newname) {
                                    if ($value['linkziel'][$i][$counter] != '') {
                                        $query = mysql_query('INSERT INTO `' . TB_PREFIX . 'links` (`userid`, `name`, `url`, `pos`) VALUES (' . $userid . ', \'' . $newname . '\', \'' . $value['linkziel'][$i][$counter] . '\', ' . $max . ')') or die(mysql_error());
                                    }
                                    $counter++;
                                }
                            }
                        }

                        // Fetch all links
                        $query = mysql_query('SELECT * FROM `' . TB_PREFIX . 'links` WHERE `userid` = ' . $session->uid . ' ORDER BY `pos` ASC') or die(mysql_error());
                        $links = array();
                        while ($data = mysql_fetch_assoc($query)) {
                            $links[] = $data;
                        }
                    ?>
                    <form name="linklist" action="linklist.php" method="POST">
                        <input type="hidden" name="ft" value="p2">
                        <input type="hidden" name="uid" value="<?php echo $session->uid; ?>"/>
                        <table class="transparent" cellpadding="1" cellspacing="1" id="links">
                            <thead>
                            <tr>
                                <td><?php echo PL_DIRECTLINKNUMBER; ?></td>
                                <td><?php echo PL_DIRECTLINKNAME; ?></td>
                                <td><?php echo PL_DIRECTLINKURL; ?></td>
                                <td></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($query) {
                                $number = 0;
                                foreach ($links as $link) {

                                    ?>
                                    <tr>
                                        <td class="nr">
                                            <input class="text" type="text" name="nr<?php print $link['pos']; ?>"
                                                   value="<?php print $link['pos']; ?>" size="1" maxlength="3"/>
                                        </td>
                                        <td class="nam">
                                            <input class="text" type="text" name="linkname<?php print $link['name']; ?>"
                                                   value="<?php print $link['name']; ?>" maxlength="30"/>
                                        </td>
                                        <td class="link">
                                            <input class="text" type="text" name="linkziel<?php print $link['url']; ?>"
                                                   value="<?php print $link['url']; ?>" maxlength="255"/>
                                        </td>
                                        <td class="remove">
                                            <button type="button" class="removeLine removeElement"
                                                    onclick="this.up('tr').hide().down('.link input').value = '';"
                                                    title="delete"></button>
                                        </td>
                                    </tr>
                                    <?php
                                    $number++;
                                }
                            }                ?>
                            <tr class="addLine templateElement insertElement">
                                <td class="nr">
                                    <input class="text" type="text" name="nr[]" value="<?php echo $number; ?>" size="1"
                                           maxlength="3"/>
                                </td>
                                <td class="nam">
                                    <input class="text" type="text" name="linkname[]" value="" maxlength="30"/>
                                </td>
                                <td class="link">
                                    <input class="text" type="text" name="linkziel[]" value="" maxlength="255"/>
                                </td>
                                <td class="add">
                                    <button type="button" class="removeLine removeElement hide" title="delete"
                                            onclick="this.up('tr').hide().down('.link input').value = '';"></button>
                                    <button type="button" class="addLine addElement" title="Add"></button>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                var lastNumber = <?php echo $number;?>;
                                new Travian.Game.AddLine(
                                    {
                                        entryCount: 1,
                                        elements: {
                                            table: $('links')
                                        },
                                        onInsertInputBefore: function (addLine, newInsertElement, newInputElement) {
                                            if (newInputElement.name.indexOf('nr[]') == 0) {
                                                newInputElement.value = ++lastNumber;
                                            }
                                        },
                                        onInsertAfter: function (addLine, newInsertElement) {
                                            var button = newInsertElement.prev('tr').down('button.removeElement').removeClass('hide');
                                            button.setTitle('delete');

                                            // Jetzt die ganzen Events an das Element hängen
                                            Travian.addMouseEvents(button, button);
                                        }
                                    });
                            });
                        </script>

                        <div class="submitButtonContainer">
                            <button type="submit" value="save" name="s1" id="btn_ok" class="green ">
                                <div class="button-container addHoverClick">
                                    <div class="button-background">
                                        <div class="buttonStart">
                                            <div class="buttonEnd">
                                                <div class="buttonMiddle"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-content"><?php echo SI_SAVE;?></div>
                                </div>
                            </button>
                            <script type="text/javascript">
                                window.addEvent('domready', function () {
                                    if ($('btn_ok')) {
                                        $('btn_ok').addEvent('click', function () {
                                            window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "save", "name": "s1", "id": "btn_ok", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                        });
                                    }
                                });
                            </script>
                        </div>

                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                            });
                        </script>
                    </form>
                </div>
            </div>
            <div class="contentFooter">&nbsp;</div>
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
                <?php include 'templates/sideinfo.tpl'; ?>
            </div>
            <?php
                include 'templates/multivillage.tpl';
                include 'Templates/quest.tpl';
            ?>
        </div>
        <div class="clear"></div>
        ﻿<?php
            include 'templates/footer.tpl';
        ?>
        </div>
        <div id="ce"></div>
        </div>
        </body>
        </html>
    <?php
    } else {
        Header('Location: dorf1.php');
        die;
    }