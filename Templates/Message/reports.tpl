<?php
    if ($session->uid == 4) {
        if (!isset($_GET['report'])) {
            $prefix = TB_PREFIX . "msg_reports";
            $sql = mysql_query("SELECT `id` FROM $prefix WHERE delet = 0 ORDER BY time DESC");
            $query = mysql_num_rows($sql);

            if (isset($_GET['page'])) {
                $page = preg_replace('#[^0-9]#i', '', $_GET['page']);
            } else {
                $page = 1;
            }

            $itemsPerPage = 10;
            $lastPage = ceil($query / $itemsPerPage);

            if ($page < 1) {
                $page = 1;
            } else if ($page > $lastPage) {
                $page = $lastPage;
            }

            include('Templates/pagination.tpl');

            $limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;
            $sql2 = mysql_query("SELECT * FROM $prefix WHERE delet = 0 ORDER BY time DESC $limit");
            $paginationDisplay = "";
            $nextPage = $_GET['page'] + 1;
            $previous = $_GET['page'] - 1;

            include('Templates/pagination2.tpl');

            $outputList = '';
            $name = 1;
            if ($query == 0) {
                $outputList .= "<td colspan=\"4\" class=\"none\">".MS_NOMSGINBOX."</td>";
            } else {
                while ($row = mysql_fetch_array($sql2)) {
                    $id = $row["id"];
                    $msg_id = $row["msg_id"];
                    $reported_by = $row["reported_by"];
                    $reason = $row["reason"];
                    $viewed = $row["viewed"];
                    $time = $row["time"];


                    if ($reason == MS_ADVERTISE) {
                        $color = "background-color:#FF0066";
                    } else if ($reason == MS_HARASSMENT) {
                        $color = "background-color:#71D000";
                    } else if ($reason == MS_GSSEEL) {
                        $color = "background-color:orange";
                    } else if ($reason == MS_OTHER) {
                        $color = "background-color:blue";
                    }

                    $outputList .= "<tr><td class=\"sel\" style=\"$color\"><input class=\"check\" type=\"checkbox\" name=\"n" . $name . "\" value=\"" . $id . "\" /></td><td class=\"subject\"><div class=\"subjectWrapper\">";

                    if ($viewed == 0) {
                        $viewed = "Unread";
                    } else {
                        $viewed = "Read";
                    }
                    $outputList .= "<img src=\"img/x.gif\" class=\"messageStatus messageStatus" . $viewed . "\" alt=\"".MS_READ."\">
	<a href=\"nachrichten.php?t=6&report=" . $id . "\"> " . $reason . "</a></div></td>";
                    $date = $generator->procMtime($time);
                    $outputList .= "<td class=\"send\"><a href=\"spieler.php?uid=" . $database->getUserField($reported_by, 'id', 1) . "\">" . $reported_by . "</a></td>";
                    $outputList .= "<td class=\"dat\">" . $date[0] . " " . date('H:i', $time) . "</td>";
                    $name++;
                }
            }
            ?>
            <form method="post" action="nachrichten.php" name="report">
                <input name="ft" value="m8" type="hidden"/>
                <table cellpadding="1" cellspacing="1" id="overview" class="inbox">
                    <thead>
                    <tr>
                        <th style="background-color:#edeceb;" colspan="2">نوع گزارش</th>
                        <th style="background-color:#edeceb;" class="dat">گزارش دهنده</th>
                        <th style="background-color:#edeceb;" class="dat"><b>ارسال شده&nbsp;</b><img src="img/x.gif"
                                                                                                     alt="sort"/></a>
                        </th>
                    </tr>
                    </thead>

                    <tbody>
                    <?php echo "$outputList"; ?>
                    </tbody>
                </table>
                <div class="administration">
                    <div class="checkAll">
                        <input class="check" type="checkbox" id="sAll" onclick="
				$(this).up('form').getElements('input[type=checkbox]').each(function(element)
				{
					element.checked = this.checked;
				}, this);
			">
                        <span><label for="sAll">انتخواب همه</label></span>
                    </div>
                    <div class="paginator">
                        <?php echo $paginationDisplay; ?>
                    </div>
                    <div class="clear"></div>
                </div>
                <button type="submit" value="حذف" name="delmsg" id="del" class="green ">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content">حذف</div>
                    </div>
                </button>
            </form>
        <?php
        } else {

            mysql_query("UPDATE " . TB_PREFIX . "msg_reports SET viewed = 1 WHERE id=" . $_GET['report']) or die(mysql_error());
            $query = mysql_query("SELECT * FROM " . TB_PREFIX . "msg_reports WHERE `delet` = 0 AND id=" . $_GET['report']) or die(mysql_error());
            $row = mysql_fetch_assoc($query);
            $id = $row["id"];
            $msg_id = $row["msg_id"];
            $reported_by = $row["reported_by"];
            $reason = $row["reason"];
            $time = $row["time"];

            $query2 = mysql_query("SELECT * FROM " . TB_PREFIX . "mdata WHERE id=" . $msg_id) or die(mysql_error());
            $row2 = mysql_fetch_assoc($query2);


            ?>
            <div id="messageNavigation">
                <div id="backToInbox">
                    <a href="nachrichten.php">بازگشت به صندوق ورودی</a>
                </div>
                <div class="clear"></div>
            </div>

            <div class="paper">
                <div class="layout">
                    <div class="paperTop">
                        <div class="paperContent">
                            <div id="sender">
                                <div class="header label">ارسال کننده</div>
                                <div class="header text">
                                    <?php echo "<a href=\"spieler.php?uid=" . $database->getUserField($reported_by, 'id', 1) . "\">" . $reported_by . "</a>"; ?>
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div id="subject">
                                <div class="header label">دلیل</div>
                                <div class="header text"><?php echo $reason; ?></div>
                                <div class="clear"></div>
                            </div>

                            <div id="time">
                                <div class="header label">تاریخ ارسال</div>
                                <div class="header text"><?php $date = $generator->procMtime($time);
                                        echo $date[0]; ?> <?php echo $date[1]; ?></div>
                                <div class="clear"></div>
                            </div>

                            <div class="separator"></div>

                            <?php $msg = "<b> فرستاده شده توسط : </b> <a href=\"spieler.php?uid=" . $row2['owner'] . "\"> " . $database->getUserField($row2['owner'], 'username', 0) . "</a>

		<b> متن پیام : </b> ' " . $row2['message'] . " '
		
		
		";?>
                            <div id="message"><?php
                                    $msg = preg_replace('/\[message\]/', '', $msg);
                                    $msg = preg_replace('/\[\/message\]/', '', $msg);
                                    echo stripslashes(nl2br($msg)); ?></div>

                            <div id="answer">

                                <button type="submit" value="پاسخ" name="s1" id="button5225ee283b15922" class="green ">
                                    <div class="button-container addHoverClick">
                                        <div class="button-background">
                                            <div class="buttonStart">
                                                <div class="buttonEnd">
                                                    <div class="buttonMiddle"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-content">پاسخ به گزارش دهنده</div>
                                    </div>
                                </button>
                                <script type="text/javascript">
                                    if ($('button5225ee283b15922')) {
                                        $('button5225ee283b15922').addEvent('click', function () {
                                            window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": true, "boxId": "hero", "disabled": false, "speechBubble": "", "class": "", "id": "button5225ee283b15922", "redirectUrl": "nachrichten.php?t=1&id=<?php echo $database->getUserField($reported_by,'id',1);?>", "redirectUrlExternal": ""}]);
                                        });
                                    }
                                </script>

                                <button type="submit" value="پاسخ" name="s1" id="button5225ee283b1592" class="green ">
                                    <div class="button-container addHoverClick">
                                        <div class="button-background">
                                            <div class="buttonStart">
                                                <div class="buttonEnd">
                                                    <div class="buttonMiddle"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-content">پاسخ به ارسال کننده پیام</div>
                                    </div>
                                </button>
                                <script type="text/javascript">
                                    if ($('button5225ee283b1592')) {
                                        $('button5225ee283b1592').addEvent('click', function () {
                                            window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": true, "boxId": "hero", "disabled": false, "speechBubble": "", "class": "", "id": "button5225ee283b1592", "redirectUrl": "nachrichten.php?t=1&id=<?php echo $row2['owner'];?>", "redirectUrlExternal": ""}]);
                                        });
                                    }
                                </script>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                    <div class="paperBottom"></div>
                </div>
            </div>

        <?php }
    } else {
        header("Location: nachrichten.php");
    } ?>