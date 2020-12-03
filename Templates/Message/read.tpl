<?php
    $input = $message->reading['message'];
    $alliance = $message->reading['alliance'];
    $player = $message->reading['player'];
    $coor = $message->reading['coor'];
    $report = $message->reading['report'];
    include("GameEngine/BBCode.php");
    if ($session->is_sitter == 1) {
        $setting = $database->getUsersetting($session->uid);
        $who = $database->whoissitter($session->uid);
        if ($who['whosit_sit'] == 1) {
            $settings = $setting['sitter1_set_5'];
        } else if ($who['whosit_sit'] == 2) {
            $settings = $setting['sitter2_set_5'];
        }
    }
?>
<div id="messageNavigation">
    <div id="backToInbox">
        <a href="nachrichten.php"><?php echo MS_RETURNTOINBOX; ?></a>
    </div>
    <div class="clear"></div>
</div>

<div class="paper">
    <div class="layout">
        <div class="paperTop">
            <div class="paperContent">

                <div id="sender">
                    <div class="header label"><?php echo MS_SENDER; ?></div>
                    <div class="header text">
                        <?php echo "<a href=\"spieler.php?uid=" . $database->getUserField($message->reading['owner'], "id", 0) . "\">" . $database->getUserField($message->reading['owner'], "username", 0) . "</a>"; ?>
                    </div>
                    <div class="clear"></div>
                </div>

                <div id="subject">
                    <div class="header label"><?php echo AL_SUBJECT; ?></div>
                    <div class="header text"><?php echo $message->reading['topic']; ?></div>
                    <div class="clear"></div>
                </div>

                <div id="time">
                    <div class="header label"><?php echo MS_SENT; ?></div>
                    <div class="header text"><?php $date = $generator->procMtime($message->reading['time']);
                            echo $date[0];
                            echo $date[1]; ?></div>
                    <div class="toolList">

                        <div id="deleteMessage">
                            <form method="post" action="nachrichten.php">
                                <input name="msg" value="<?php echo $message->reading['id']; ?>" id="msg" type="hidden">
                                <input name="t" value="0" id="t" type="hidden">
                                <input name="n1" value="<?php echo $_GET['id']; ?>" id="n1" type="hidden">
                                <input name="ft" value="m5" id="ft" type="hidden">
                                <?php
                                    if ($database->getUserField($message->reading['owner'], "id", 0) != $session->uid) {
                                        $q = mysql_query("SELECT `reason` FROM " . TB_PREFIX . "msg_reports WHERE msg_id = " . $_GET['id'] . " AND reported_by = '" . $_SESSION['username'] . "'") or die(mysql_error());
                                        $q = mysql_fetch_assoc($q);
                                        if ($q['reason']) {
                                            echo '<font color=darkorange>'.sprintf(MS_REPORTAS, $q['reason']).'</font>';
                                        } else {
                                            ?>
                                            <a href="#" id="reportSpam" class="a arrow"
                                               onclick='Travian.Game.ReportSpamMessagesDialog.reportSpam(
                                                   "<?php echo $_GET['id']; ?>",
                                                   "<?php echo MS_REPORTASSPAM; ?>",
                                                   "<?php echo MS_REPORT;?>",
                                                   "<?php echo MS_REPORTATT;?>",
                                                   "http://t4.answers.travian.com",
                                                   {"not_chosen":"<?php echo MS_CHREASON;?>","advertisement":"<?php echo MS_ADVERTISE; ?>","harassment":"<?php echo MS_HARASSMENT; ?>","gold":"<?php echo MS_GSSEEL; ?>","misc":"<?php echo MS_OTHER; ?>"}
                                                   ); return false;'><?php echo MS_REPORTTHIS;?></a>
                                        <?php
                                        }
                                    }
                                ?>
                                <button type="submit" name="delmsg" title="<?php echo AL_DELETE; ?>" id="delmsg"
                                        class="icon hover" onclick="return (function(){
                                    ('<?php echo MS_REALLYDELETEMSG; ?>').dialog(
                                    {
                                    buttonTextOk:'Yes',
                                    buttonTextCancel:'Cancel',
                                    onOkay: function(dialog, contentElement)
                                    {
                                    $('delmsg').up('form').submit();
                                    },
                                    onShow: function() {
                                    var button = $('delmsg');
                                    button.disabled = true;
                                    button.disabled = false;
                                    }
                                    }
                                    );
                                    return false;
                                    })()"><img src="img/x.gif" class="Delete delete" alt="Delete"></button>
                                <input name="delmsg" value="1" type="hidden">
                            </form>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>

                <div class="separator"></div>
                <div id="message"><?php echo htmlspecialchars_decode(stripslashes(nl2br($bbcoded))); ?></div>

                <div id="answer">
                    <form method="post" action="nachrichten.php">
                        <input type="hidden" name="id" value="<?php echo $message->reading['id']; ?>"/>
                        <input type="hidden" name="ft" value="m1"/>
                        <input type="hidden" name="t" value="1"/>
                        <button type="submit" value="Reply" name="s1" id="s1" class="green ">
                            <div class="button-container addHoverClick">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content"><?php echo MS_REPLY; ?></div>
                            </div>
                        </button>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                if ($('s1')) {
                                    $('s1').addEvent('click', function () {
                                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "answer", "name": "s1", "id": "s1", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                    });
                                }
                            });
                        </script>
                    </form>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="paperBottom"></div>
    </div>
</div>