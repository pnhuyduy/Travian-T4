<?php
    $cat_id = $_GET['fid'];
    $CatName = $database->ForumCatName($cat_id);
    $ChckTopic = $database->CheckCatTopic($cat_id);
    $Topics = $database->ForumCatTopic($cat_id);
    $TopicsStick = $database->ForumCatTopicStick($cat_id);
?>

<h4><a href="allianz.php?s=2"><?php echo AL_ALLIANCE;?></a>
    <a class="arrowForum" href="allianz.php?s=2&pid=<?php echo $_GET['pid']; ?>&fid=<?php echo $cat_id; ?>"><?php echo $CatName; ?></a>
</h4>
<h4 class="round"><?php echo $CatName; ?></h4>
<table cellpadding="1" cellspacing="1" id="topics">
    <thead>
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
                $post = $database->LastPost($arrs['id']);
                //foreach ($lposts as $post) {
                //}
                if ($database->CheckLastPost($arrs['id'])) {
                    $post_dates = date('y/m/d, H:i '.MV_HOUR, $post['date']);
                    $owner_topics = $database->getUser($post['owner'], 1);
                } else {
                    $post_dates = date('y/m/d, H:i '.MV_HOUR, $arrs['date']);
                    $owner_topics = $database->getUser($arrs['owner'], 1);
                }

                echo '<tr><td class="ico">';
                if ($database->CheckEditRes($aid) == "1") {
                    if ($database->CheckCloseTopic($arrs['id']) == 1) {
                        $locks = '<a class="unlock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=unlock" title="'.AL_OPENTOPIC.'"><img src="img/x.gif" alt="'.AL_OPENTOPIC.'" /></a>';
                    } else {
                        $locks = '<a class="lock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=lock" title="'.AL_CLOSETOPIC.'"><img src="img/x.gif" alt="'.AL_CLOSETOPIC.'" /></a>';
                    }
                    echo '' . $locks . '<a class="edit" href="?s=2&idf=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=edittopic" title="'.AL_EDIT.'"><img src="img/x.gif" alt="'.AL_EDIT.'" /></a><br />
                    <a class="unpin" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=unpin" title="'.AL_STICKTOPIC.'"><img src="img/x.gif" alt="'.AL_STICKTOPIC.'" /></a><a class="fdel" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arrs['id'] . '&admin=deltopic" title="'.AL_DELETE.'"><img src="img/x.gif" alt="'.AL_DELETE.'" onClick="return confirm(\''.AL_AREYOUSURE.'\');" /></a>';
                } elseif ($arrs['close'] == "1") {
                    echo '<img class="folder_sticky_lock" src="img/x.gif" alt="'.AL_CTHWITHOUTPOST.'" title="'.AL_CTHWITHOUTPOST.'" />';
                } else {
                    echo '<img class="folder_sticky" src="img/x.gif" alt="'.AL_ITHWITHOUTPOST.'" title="'.AL_ITHWITHOUTPOST.'" />';
                }
                echo '</td>
		<td class="tit"><a href="allianz.php?s=2&pid=' . $aid . '&tid=' . $arrs['id'] . '">' . $arrs['title'] . '</a><br></td>
		<td class="cou">' . $CountPosts . '</td>
		<td class="last">' . $post_dates . '<br /><a href="spieler.php?uid=' . $arrs['owner'] . '">' . $owner_topics['username'] . '</a> <a href="allianz.php?s=2&pid=' . $aid . '&tid=' . $arrs['id'] . '&seite=max">
		<img class="latest_reply" src="img/x.gif" alt="'.AL_SHOWLASTPOST.'" title="'.AL_SHOWLASTPOST.'"/></a>
		</td></tr>';

            }

            foreach ($Topics as $arr) {
                $CountPost = $database->CountPost($arr['id']);
                $pos = $database->LastPost($arr['id']);
                //foreach ($lpost as $pos) {
                //}
                if ($database->CheckLastPost($arr['id'])) {
                    $post_date = date('y/m/d, H:i '.MV_HOUR, $pos['date']);
                    $owner_topic = $database->getUser($pos['owner'], 1);
                } else {
                    $post_date = date('y/m/d, H:i '.MV_HOUR, $arr['date']);
                    $owner_topic = $database->getUser($arr['owner'], 1);
                }

                echo '<tr><td class="ico">';
                if ($database->CheckEditRes($aid) == "1") {
                    if ($database->CheckCloseTopic($arr['id']) == 1) {
                        $lock = '<a class="unlock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=unlock" title="'.AL_OPENTOPIC.'"><img src="img/x.gif" alt="'.AL_OPENTOPIC.'" /></a>';
                    } else {
                        $lock = '<a class="lock" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=lock" title="'.AL_CLOSETOPIC.'"><img src="img/x.gif" alt="'.AL_CLOSETOPIC.'" /></a>';
                    }
                    echo '' . $lock . '<a class="edit" href="?s=2&idf=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=edittopic" title="'.AL_EDIT.'"><img src="img/x.gif" alt="'.AL_EDIT.'" /></a><br /><a class="pin" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=pin" title="'.AL_STICKTOPIC.'"><img src="img/x.gif" alt="'.AL_STICKTOPIC.'" /></a><a class="fdel" href="?s=2&fid=' . $_GET['fid'] . '&idt=' . $arr['id'] . '&admin=deltopic" title="'.AL_DELETE.'"><img src="img/x.gif" onClick="return confirm(\''.AL_AREYOUSURE.'\');" /></a>';
                } elseif ($arr['close'] == "1") {
                    echo '<img class="folder_lock" src="img/x.gif" alt="'.AL_CTHWITHOUTPOST.'" title="'.AL_CTHWITHOUTPOST.'" />';
                } else {
                    echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                }
                echo '</td>
		<td class="tit"><a href="allianz.php?s=2&pid=' . $aid . '&tid=' . $arr['id'] . '">' . $arr['title'] . '</a><br></td>
		<td class="cou">' . $CountPost . '</td>
		<td class="last">' . $post_date . '<br /><a href="spieler.php?uid=' . $arr['owner'] . '">' . $owner_topic['username'] . '</a> <a href="allianz.php?s=2&aid=' . $aid . '&tid=' . $arr['id'] . '&seite=max"><img class="latest_reply" src="img/x.gif" alt="'.AL_SHOWLASTPOST.'" title="'.AL_SHOWLASTPOST.'" /></a>
		</td></tr>';

            }
        } else {
            echo '<tr>
		<td class="none" colspan="4">'.AL_NOTOPIC.'</td>
	</tr>';
        }
    ?>
    </tbody>
</table>
<p>
    <button type="button" value="<?php echo AL_POSTNEWTH;?>" class="green build"
            onclick="window.location.href = 'allianz.php?s=2&pid=<?php echo $aid; ?>&fid=<?php echo $cat_id; ?>&ac=newtopic'; return false;">
        <div class="button-container addHoverClick">
            <div class="button-background">
                <div class="buttonStart">
                    <div class="buttonEnd">
                        <div class="buttonMiddle"></div>
                    </div>
                </div>
            </div>
            <div class="button-content"><?php echo AL_POSTNEWTH;?></div>
        </div>
    </button>
    <?php
        $opt = $database->getAlliPermissions($session->uid, $aid);
        if ($opt['opt5'] == 1) {
            echo "<button type=\"button\" value=\"".HDR_OPTION2."\" class=\"green build\" onclick=\"window.location.href = 'allianz.php?s=2&fid=" . $cat_id . "&seite=1&admin=switch_admin'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">".HDR_OPTION2."</div></div></button>";
        }
    ?>
</p>