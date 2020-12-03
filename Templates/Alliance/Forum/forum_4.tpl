<?php
//////////////// made by TTMTT ////////////////
    if ($session->access != BANNED) {
        $cat_id = $_GET['fid'];
        $aid = $session->alliance;
        $q = "SELECT `leader` FROM " . TB_PREFIX . "alidata WHERE id = $aid";
        $z = mysql_query($q) or die(mysql_error());
        $rows = mysql_fetch_assoc($z);


        if ($rows['leader'] != $session->uid && $database->check_forumRules($cat_id, $session->uid)) {
            echo "<table cellpadding='1' cellspacing='1' id='topics'><thead>
	<tr>
       <th colspan='4'>".AL_ACCESSDENIED."</th>
	</tr>
	<tr>
		<td><br>
		".AL_ACCESSDENIEDDESC."
		<br><br><br><br></td>
	</tr>
	</tbody></table>";
        } else {
            $CatName = stripslashes($database->ForumCatName($cat_id));
            $ChckTopic = $database->CheckCatTopic($cat_id);
            $Topics = $database->ForumCatTopic($cat_id);
            $TopicsStick = $database->ForumCatTopicStick($cat_id);
            ?>
            <h4><a href="allianz.php?s=2"><?php echo AL_ALLIANCE;?></a> -> <a
                    href="allianz.php?s=2&pid=<?php echo $_GET['pid']; ?>&fid=<?php echo $cat_id; ?>"><?php echo $CatName; ?></a>
            </h4>
            <table cellpadding="1" cellspacing="1" id="topics">
                <thead>
                <tr>
                    <th colspan="4"><?php echo $CatName; ?></th>
                </tr>
                <tr>
                    <td></td>
                    <td><?php echo AL_THREADS;?></td>
                    <td><?php echo AL_REPLIES;?></td>
                    <td><?php echo AL_LASTPOST;?></td>
                </tr>
                </thead>
                <tbody>
                <?php
                    if ($ChckTopic) {
                        foreach ($TopicsStick as $arrs) {
                            $CountPosts = $database->CountPost($arrs['id']);
                            $lposts = $database->LastPost($arrs['id']);
                            foreach ($lposts as $post) {
                            }
                            if ($database->CheckLastPost($arrs['id'])) {
                                $post_dates = date('m/d/y, H:i a', $post['date']);
                                $owner_topics = $database->getUser($post['owner'], 1);
                            } else {
                                $post_dates = date('m/d/y, H:i a', $arrs['date']);
                                $owner_topics = $database->getUser($arrs['owner'], 1);
                            }

                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                if ($database->CheckCloseTopic($arrs['id']) == 1) {
                                    $locks = '<a class="unlock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=unlock" title="'.AL_OPENTOPIC.'"><img src="img/x.gif" alt="open topic" /></a>';
                                } else {
                                    $locks = '<a class="lock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=lock" title="'.AL_CLOSETOPIC.'"><img src="img/x.gif" alt="close topic" /></a>';
                                }
                                echo '' . $locks . '<a class="edit" href="?s=2&idf=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=edittopic" title="'.AL_EDIT.'"><img src="img/x.gif" alt="edit" /></a><br /><a class="unpin" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=unpin" title="stick topic"><img src="img/x.gif" alt="stick topic" /></a><a class="fdel" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=deltopic" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" onClick="return confirm(\'confirm delete?\');" /></a>';
                            } elseif ($arrs['close'] == "1") {
                                echo '<img class="folder_sticky_lock" src="img/x.gif" alt="Closed Thread without new posts" title="'.AL_CTHWITHOUTPOST.'" />';
                            } else {
                                echo '<img class="folder_sticky" src="img/x.gif" alt="Important Thread without new posts" title="'.AL_ITHWITHOUTPOST.'" />';
                            }
                            echo '</td>
		<td class="tit"><a href="allianz.php?s=2&fid2=' . $arrs['cat'] . '&pid=' . $aid . '&tid=' . $arrs['id'] . '">' . stripslashes($arrs['title']) . '</a><br></td>
		<td class="cou">' . $CountPosts . '</td>
		<td class="last">' . $post_dates . '<br /><a href="spieler.php?uid=' . $arrs['owner'] . '">' . $owner_topics['username'] . '</a> <a href="allianz.php?s=2&fid2=' . $arrs['cat'] . '&pid=' . $aid . '&tid=' . $arrs['id'] . '&seite=max"><img class="latest_reply" src="img/x.gif" alt="Show last post" title="'.AL_SHOWLASTPOST.'" /></a>
		</td></tr>';

                        }

                        foreach ($Topics as $arr) {
                            $CountPost = $database->CountPost($arr['id']);
                            $lpost = $database->LastPost($arr['id']);
                            //foreach ($lpost as $pos) {
                           // }
                            if ($database->CheckLastPost($arr['id'])) {
                                $post_date = date('m/d/y, H:i a', $lpost['date']);
                                $owner_topic = $database->getUser($pos['owner'], 1);
                            } else {
                                $post_date = date('m/d/y, H:i a', $arr['date']);
                                $owner_topic = $database->getUser($arr['owner'], 1);
                            }

                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                if ($database->CheckCloseTopic($arr['id']) == 1) {
                                    $lock = '<a class="unlock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=unlock" title="'.AL_OPENTOPIC.'"><img src="img/x.gif" alt="open topic" /></a>';
                                } else {
                                    $lock = '<a class="lock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=lock" title="'.AL_CLOSETOPIC.'"><img src="img/x.gif" alt="close topic" /></a>';
                                }
                                echo '' . $lock . '<a class="edit" href="?s=2&idf=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=edittopic" title="'.AL_EDIT.'"><img src="img/x.gif" alt="edit" /></a><br /><a class="pin" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=pin" title="stick topic"><img src="img/x.gif" alt="stick topic" /></a><a class="fdel" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=deltopic" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" onClick="return confirm(\'confirm delete?\');" /></a>';
                            } elseif ($arr['close'] == "1") {
                                echo '<img class="folder_lock" src="img/x.gif" alt="Closed Thread without new posts" title="'.AL_CTHWITHOUTPOST.'" />';
                            } else {
                                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                            }
                            echo '</td>
		<td class="tit"><a href="allianz.php?s=2&fid2=' . $arr['cat'] . '&pid=' . $aid . '&tid=' . $arr['id'] . '">' . stripslashes($arr['title']) . '</a><br></td>
		<td class="cou">' . $CountPost . '</td>
		<td class="last">' . $post_date . '<br /><a href="spieler.php?uid=' . $arr['owner'] . '">' . $owner_topic['username'] . '</a> <a href="allianz.php?s=2&aid=' . $aid . '&tid=' . $arr['id'] . '&seite=max"><img class="latest_reply" src="img/x.gif" alt="Show last post" title="Show last post" /></a>
		</td></tr>';

                        }
                    } else {
                        echo '<tr>
		<td class="none" colspan="4">'.AL_NOTOPIC.'</td>
	</tr>';
                    }
                ?>
                </tbody>
            </table><p>
            <div class="buttonBox">
                <button type="button" value="Post new thread" id="button528a506e61994" class="green "
                        onclick="window.location.href = 'allianz.php?s=2&pid=<?php echo $aid; ?>&fid=<?php echo $cat_id; ?>&ac=newtopic'; return false;">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo AL_NEWTOPIC;?></div>
                    </div>
                </button>
                <script type="text/javascript">
                    window.addEvent('domready', function () {
                        if ($('button528a506e61994')) {
                            $('button528a506e61994').addEvent('click', function () {
                                window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Post new thread", "name": "", "id": "button528a506e61994", "class": "green ", "title": "", "confirm": "", "onclick": "window.location.href = 'allianz.php?s=2&pid=<?php echo $aid; ?>&fid=<?php echo $cat_id; ?>&ac=newtopic'; return false;"}]);
                            });
                        }
                    });
                </script>
            </div>
            <?php
            $opt = $database->getAlliPermissions($session->uid, $aid);
            if ($opt[opt5] == 1) {
                ?>
                <div class="buttonBox"><a href="allianz.php?s=2&fid=<?php echo $cat_id; ?>&seite=1&admin=switch_admin"
                                          title="Toggle Admin mode"><img class="switch_admin dynamic_img"
                                                                         src="img/x.gif" alt="Toggle Admin mode"/></a>
                </div>
                <div class="clear"></div>
                <div class="clear"></div>
            <?php
            }
            ?>
            </p>
        <?php
        }
    } else {
        header("Location: banned.php");
        die;
    }
?>