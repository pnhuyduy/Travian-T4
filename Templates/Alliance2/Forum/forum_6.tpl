<?php
    $tid = $_GET['tid'];
    $opt = $database->getAlliPermissions($session->uid, $aid);
    $topics = $database->ShowTopic($tid);
    $posts = $database->ShowPost($tid);
    foreach ($topics as $arr) {
        $cat_id = $arr['cat'];
        $owner = $database->getUser($arr['owner'], 1);
        $CatName = $database->ForumCatName($cat_id);
        $allianceinfo = $database->getAlliance($owner['alliance']);
    }
    $date = date('y/m/d H:i', $arr['date']);
    $varray = $database->getProfileVillages($arr['owner']);
    $totalpop = 0;
    foreach ($varray as $vil) {
        $totalpop += $vil['pop'];
    }
    $countAu = $database->CountTopic($arr['owner']);
    $displayarray = $database->getUser($arr['owner'], 1);

    switch($displayarray['tribe']){
        case 1:
            $trip = TRIBE1;
            break;
        case 2:
            $trip = TRIBE2;
            break;
        case 3:
            $trip = TRIBE3;
            break;
    }

    $input = $arr['post'];
    include("GameEngine/bbcode.php");
    $bbcode_topic = nl2br($bbcoded);
?>
    <h4><a href="allianz.php?s=2&pid=<?php echo $arr['alliance']; ?>"><?php AL_ALLIANCE;?></a> <a class="arrowForum"
                                                                                   href="allianz.php?s=2&pid=<?php echo $arr['alliance']; ?>&fid=<?php echo $arr['cat']; ?>"><?php echo $CatName; ?></a>
    </h4>
    <h4 class="round"><?php echo $arr['title']; ?></h4>
    <table cellpadding="1" cellspacing="1" id="posts">
        <thead>
        <tr>
            <td>نویسنده</td>
            <td>پیام ها</td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="pinfo"><a class="name"
                                 href="spieler.php?uid=<?php echo $arr['owner']; ?>"><?php echo $owner['username']; ?></a><br/><a
                    href="allianz.php?aid=<?php echo $allianceinfo['id']; ?>"><?php echo $allianceinfo['tag']; ?></a><br/>
                پست ها: <?php echo $countAu; ?><br/>
                <br/>
                جمعیت: <?php echo $totalpop; ?><br/>
                دهکده ها: <?php echo count($varray); ?><br/>
                <?php echo $trip; ?>
            </td>
            <td class="pcontent">
                <div class="posted">ایجاد شده در: <?php echo $date; ?></div>
                <?php
                    if ($database->CheckEditRes($aid) == "1") {
                        echo '<div class="admin"><a class="edit" href="allianz.php?s=2&pid=' . $arr['alliance'] . '&idf=' . $arr['cat'] . '&idt=' . $arr['id'] . '&admin=editans"><img src="img/x.gif" title="ویرایش" alt="ویرایش" /></a><a class="fdel" href="?s=2&pid=' . $arr['alliance'] . '&tid=' . $arr['id'] . '&admin=deltopic" onClick="return confirm(\'آیا مطمئن هستی؟\');"><img src="img/x.gif" title="حذف" alt="حذف" /></a></div><br />';
                    }
                ?>
                <div class="clear dotted"></div>
                <div class="text"><?php echo $bbcode_topic; ?></div>
            </td>
        </tr>
        <?php
            foreach ($posts as $po) {

                $date = date('y/m/d H:i', $po['date']);
                $countAu = $database->CountTopic($po['owner']);
                $varray = $database->getProfileVillages($po['owner']);
                $totalpop = 0;
                foreach ($varray as $vil) {
                    $totalpop += $vil['pop'];
                }
                $displayarray = $database->getUser($po['owner'], 1);
                if ($displayarray['tribe'] == 1) {
                    $trip = "رومی ها";
                } else if ($displayarray['tribe'] == 2) {
                    $trip = "توتن ها";
                } else if ($displayarray['tribe'] == 3) {
                    $trip = "گول ها";
                }
                $owner = $database->getUser($po['owner'], 1);
                $allianceinfo = $database->getAlliance($owner['alliance']);
                $input = $po['post'];
                include("GameEngine/BBCode.php");
                $bbcode_post = nl2br($bbcoded);

                echo '<tr><td class="pinfo"><a class="name" href="spieler.php?uid=' . $po['owner'] . '">' . $owner['username'] . '</a><br /><a href="allianz.php?aid=' . $allianceinfo['id'] . '">' . $allianceinfo['tag'] . '</a><br />
		پست ها: ' . $countAu . '<br />
		<br />
		جمعیت: ' . $totalpop . '<br />
		دهکده ها: ' . count($varray) . '<br />
		' . $trip . '
		</td>
		<td class="pcontent"><div class="posted">ساخته شده در: ' . $date . '</div>';
                if ($database->CheckEditRes($aid) == "1") {
                    echo '<div class="admin"><a class="edit" href="allianz.php?s=2&pid=' . $arr['alliance'] . '&idt=' . $_GET['tid'] . '&pod=' . $po['id'] . '&admin=editpost"><img src="img/x.gif" title="ویرایش" alt="ویرایش" /></a><a class="fdel" href="?s=2&pid=' . $arr['alliance'] . '&pod=' . $po['id'] . '&tid=' . $_GET['tid'] . '&admin=delpost" onClick="return confirm(\'آیا مطمئن هستی؟\');"><img src="img/x.gif" title="حذف" alt="حذف" /></a></div><br />';
                }
                echo '<div class="clear dotted"></div><div class="text">' . $bbcode_post . '</div></td>
	</tr>';
            }
        ?>
        </tbody>
    </table>
    <div style="margin-top: 15px;">
	<?php
	if (empty($arr[close])) {
        echo "<button type=\"button\" value=\"پاسخ\" class=\"green build\" onclick=\"window.location.href = 'allianz.php?s=2&pid=" . $arr['alliance'] . "&tid=" . $arr['id'] . "&ac=newpost'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">پاسخ</div></div></button>";
    }
	if ($opt[opt5] == 1) {
        echo "<button type=\"button\" value=\"تنظیمات\" class=\"green build\" onclick=\"window.location.href = 'allianz.php?s=2&pid=" . $aid . "&tid=" . $arr['id'] . "&admin=switch_admin'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">تنظیمات</div></div></button>";
    }
	 
	 echo '</div>';
	 ?>