<?php
    $displayarray = $database->getUser($session->uid, 1);
    $forumcat = $database->ForumCat(htmlspecialchars($displayarray['alliance']));
?>
<h4 class="round"><?php echo AL_ALLYFORUM;?></h4>
<table cellpadding="1" cellspacing="1" id="alliance">
    <thead>
    <tr>
        <td></td>
        <td><?php echo AL_FORUMNAME;?></td>
        <td>&nbsp;<?php echo AL_THREAD;?>&nbsp;</td>
        <td>&nbsp;<?php echo AL_POSTS;?>&nbsp;</td>
    </tr>
    </thead>
    <tbody>
    <?php
        foreach ($forumcat as $arr) {
            $countop = $database->CountCat($arr['id']);
            $las = $database->LastTopic($arr['id']);
            //foreach ($ltopic as $las) {
            //}
            $pos = $database->LastPost($las['id']);
            //foreach ($lpos as $pos) {
            //}
            if ($database->CheckLastTopic($arr['id'])) {
                if ($database->CheckLastPost($las['id'])) {
                    $lpost = date('y/m/d H:i '.MV_HOUR, $pos['date']);
                    $owner = $database->getUser($pos['owner'], 1);
                } else {
                    $lpost = date('y/m/d H:i '.MV_HOUR, $las['date']);
                    $owner = $database->getUser($las['owner'], 1);
                }
            } else {
                $lpost = "";
                $owner = "";
            }
            echo '<tr><td class="ico">';
            if ($database->CheckEditRes($aid) == "1") {
                echo '<a class="up_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=-1" title="'.AL_TOTOP.'"><img src="img/x.gif" /></a>
    <a class="edit" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=editforum" title="'.AL_EDIT.'"><img src="img/x.gif" /></a>
    <br />
    <a class="down_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=1" title="'.AL_TOBOTT.'"><img src="img/x.gif" /></a>
    <a class="fdel" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=delforum" onClick="return confirm(\''.AL_AREYOUSURE.'\');" title="'.AL_DELETE.'"><img src="img/x.gif" /></a>';
            } else {
                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
            }
            echo '</td><td class="tit"><a href="allianz.php?s=2&fid=' . $arr['id'] . '&pid=' . $aid . '" title="' . $arr['forum_name'] . '">' . $arr['forum_name'] . '</a><br />' . $arr['forum_des'] . '</td>
			<td class="cou">' . $countop . '</td>
			<td class="last">' . $lpost . '</span><span><br /><a href="spieler.php?uid=' . $owner['id'] . '">' . $owner['username'] . '</a> <img class="latest_reply" src="img/x.gif" alt="'.AL_SHOWLASTPOST.'" title="'.AL_SHOWLASTPOST.'" /></td>
		</tr>';

        }
    ?>
    </tbody>
</table><p>
    <?php
        $opt = $database->getAlliPermissions($session->uid, $aid);
        if ($opt['opt5'] == 1) {
            echo "<button type=\"button\" value=\"".AL_NEWFORUM."\" class=\"green build\" onclick=\"window.location.href = 'allianz.php?s=2&admin=newforum'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">".AL_NEWFORUM."</div></div></button>

<button type=\"button\" value=\"".HDR_OPTION2."\" class=\"green build\" onclick=\"window.location.href = 'allianz.php?s=" . $ids . "&admin=switch_admin'; return false;\">
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