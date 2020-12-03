<?php
//////////////// made by TTMTT ////////////////
    if ($session->access != BANNED) {
        $tid = $_GET['tid'];
        $opt = $database->getAlliPermissions($session->uid, $tid);
        $topics = $database->ShowTopic($tid);
        $posts = $database->ShowPost($tid);
        foreach ($topics as $arr) {
            $cat_id = $arr['cat'];
            $owner = $database->getUser($arr['owner'], 1);
            $CatName = stripslashes($database->ForumCatName($cat_id));
            $allianceinfo = $database->getAlliance($owner['alliance']);
        }
        $date = date('m/d/y H:i a', $arr['date']);
        $varray = $database->getProfileVillages($arr['owner']);
        $totalpop = 0;
        foreach ($varray as $vil) {
            $totalpop += $vil['pop'];
        }
        $countAu = $database->CountTopic($arr['owner']);
        $displayarray = $database->getUser($arr['owner'], 1);
        $tribe = $displayarray['tribe'];
        switch ($tribe) {
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
        $alliance = $arr['alliance0'];
        $player = $arr['player0'];
        $coor = $arr['coor0'];
        $report = $arr['report0'];
        $bbcoded = $input;
        include("GameEngine/BBCode.php");
        $bbcode_topic = stripslashes(nl2br($bbcoded));
        ?>
        <script type="text/javascript">
            function submitform1() {
                document.forms["Form1"].submit();
            }
        </script>
        <h4><a href="allianz.php?s=2&pid=<?php echo $arr['alliance']; ?>"><?php echo AL_ALLIANCE;?></a> -> <a
                href="allianz.php?s=2&pid=<?php echo $arr['alliance']; ?>&fid=<?php echo $arr['cat']; ?>"><?php echo $CatName; ?></a>
        </h4>
        <table cellpadding="1" cellspacing="1" id="posts">
            <thead>
            <?php
                $q = "SELECT * FROM " . TB_PREFIX . "forum_poll where id = " . $_GET['tid'] . "";
                if (mysql_query($q)) {
                    $q = mysql_query($q);
                    $q = mysql_fetch_assoc($q);

                    $votr = explode(",", $q['voters']);
                    foreach ($votr as $voter) {
                        if ($voter == $session->uid) {
                            $yes = 1;
                        }
                    }
                    ?>
                    <h4 class="round">survey - <?php echo $q['name']; ?></h4>
                    <tr>
                        <td colspan="2" class="poll">
                            <form
                                action="allianz.php?s=2&fid2=<?php echo $_GET['fid2']; ?>&pid=<?php echo $_GET['pid']; ?>&tid=<?php echo $_GET['tid']; ?>"
                                method="post" id="Form1">
                                <input type="hidden" name="s" value="2"/>
                                <input type="hidden" name="aid" value="<?php echo $session->uid; ?>"/>
                                <input type="hidden" name="seite" value="1"/>
                                <input type="hidden" name="tid" value="4"/>

                                <table cellpadding="0" cellspacing="0" id="poll">
                                    <thead>
                                    <tr>
                                        <th colspan="3">
                                            <?php echo AL_SURVEY;?> : <?php echo $q['name']; ?>
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <tr>
                                        <?php if ($q['p1_name'] != ''){ ?>
                                        <td class="sel"><?php echo $q['p1_name']; ?></td>
                                        <td class="stat">
                                            <input class="radio" type="radio" name="vote_option" value="306"/></td>
                                        <!--<td class="count"><?php if (isset($_GET['resolt']) || $yes == 1) {
                                            echo $q['p1'];
                                        } else {
                                            echo '?';
                                        } ?></td>-->
                                        <td style="position:absolute;left:100px">
                                            <img class="poll" src="img/x.gif" width='<?php echo round($q['p1'], 2); ?>'
                                                 height='15'>
                                            <?php echo round($q['p1'], 2); ?>%
                                        </td>
                                    </tr>
                                    <tr>
                                        <?php }if ($q['p2_name'] != ''){ ?>
                                        <td class="sel"><?php echo $q['p2_name']; ?></td>
                                        <td class="stat">
                                            <input class="radio" type="radio" name="vote_option" value="307"/></td>
                                        <!--<td class="count"><?php if (isset($_GET['resolt']) || $yes == 1) {
                                            echo $q['p2'];
                                        } else {
                                            echo '?';
                                        } ?></td>-->
                                        <td style="position:absolute;left:100px">
                                            <img class="poll" src="img/x.gif" width='<?php echo round($q['p2'], 2); ?>'
                                                 height='15'>
                                            <?php echo round($q['p2'], 2); ?>%
                                        </td>
                                    </tr>
                                    <tr>
                                        <?php }if ($q['p3_name'] != ''){ ?>
                                        <td class="sel"><?php echo $q['p3_name']; ?></td>
                                        <td class="stat">
                                            <input class="radio" type="radio" name="vote_option" value="308"/></td>
                                        <!--<td class="count"><?php if (isset($_GET['resolt']) || $yes == 1) {
                                            echo $q['p3'];
                                        } else {
                                            echo '?';
                                        } ?></td>-->
                                        <td style="position:absolute;left:100px">
                                            <img class="poll" src="img/x.gif" width='<?php echo round($q['p3'], 2); ?>'
                                                 height='15'>
                                            <?php echo round($q['p3'], 2); ?>%
                                        </td>
                                    </tr>
                                    <tr>
                                        <?php }if ($q['p4_name'] != ''){ ?>
                                        <td class="sel"><?php echo $q['p4_name']; ?></td>
                                        <td class="stat">
                                            <input class="radio" type="radio" name="vote_option" value="309"/></td>
                                        <!--<td class="count"><?php if (isset($_GET['resolt']) || $yes == 1) {
                                            echo $q['p4'];
                                        } else {
                                            echo '?';
                                        } ?></td>-->
                                        <td style="position:absolute;left:100px">
                                            <img class="poll" src="img/x.gif" width='<?php echo round($q['p4'], 2); ?>'
                                                 height='15'>
                                            <?php echo round($q['p4'], 2); ?>%
                                        </td>
                                    </tr>
                                    <tr>
                                        <?php } ?>
                                        <td colspan="3">
                                            <button type="submit" value="1" name="vote" id="fbtn_vote" class="green ">

                                                <?php
                                                    if ($yes != 1) {
                                                        if (!isset($_GET['resolt'])) {
                                                            if (empty($arr['close'])) {
                                                                ?>
                                                                <button type="button" value="vote" class="build"
                                                                        onclick="submitform1();">
                                                                    <div class="button-container">
                                                                        <div class="button-position">
                                                                            <div class="btl">
                                                                                <div class="btr">
                                                                                    <div class="btc"></div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="bml">
                                                                                <div class="bmr">
                                                                                    <div class="bmc"></div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="bbl">
                                                                                <div class="bbr">
                                                                                    <div class="bbc"></div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="button-contents"><?php echo AL_VOTE;?></div>
                                                                    </div>
                                                                </button>
                                                            <?php }
                                                        } else { ?>
                                                            <button type="button" value="To vote" class="build"
                                                                    onclick="window.location.href = 'allianz.php?s=2&fid2=<?php echo $_GET['fid2']; ?>&pid=<?php echo $_GET['pid']; ?>&tid=<?php echo $_GET['tid']; ?>'">
                                                                <div class="button-container">
                                                                    <div class="button-position">
                                                                        <div class="btl">
                                                                            <div class="btr">
                                                                                <div class="btc"></div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="bml">
                                                                            <div class="bmr">
                                                                                <div class="bmc"></div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="bbl">
                                                                            <div class="bbr">
                                                                                <div class="bbc"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="button-contents"><?php echo AL_TOVOTE;?></div>
                                                                </div>
                                                            </button>
                                                        <?php }
                                                    } ?>
                                                <script type="text/javascript">
                                                    window.addEvent('domready', function () {
                                                        if ($('fbtn_vote')) {
                                                            $('fbtn_vote').addEvent('click', function () {
                                                                window.fireEvent('buttonClicked', [this, {"type": "submit", "value": 1, "name": "vote", "id": "fbtn_vote", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                                            });
                                                        }
                                                    });
                                                </script>
                                                <?php if (!isset($_GET['resolt']) && $yes != 1) { ?>
                                                    <button type="button" value="Result" class="build"
                                                            onclick="window.location.href = 'allianz.php?s=2&fid2=<?php echo $_GET['fid2']; ?>&pid=<?php echo $_GET['pid']; ?>&tid=<?php echo $_GET['tid']; ?>&resolt'">
                                                        <div class="button-container">
                                                            <div class="button-position">
                                                                <div class="btl">
                                                                    <div class="btr">
                                                                        <div class="btc"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="bml">
                                                                    <div class="bmr">
                                                                        <div class="bmc"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="bbl">
                                                                    <div class="bbr">
                                                                        <div class="bbc"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="button-contents"><?php echo AL_RESULT;?></div>
                                                        </div>
                                                    </button>
                                                <?php } ?>
                                                <script type="text/javascript">
                                                    window.addEvent('domready', function () {
                                                        if ($('fbtn_result')) {
                                                            $('fbtn_result').addEvent('click', function () {
                                                                window.fireEvent('buttonClicked', [this, {"type": "submit", "value": 1, "name": "vote_ergebnis", "id": "fbtn_result", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                                            });
                                                        }
                                                    });
                                                </script>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                    </tr>
                <?php } ?>
            <tr>
                <th colspan="2"><?php echo stripslashes($arr['title']); ?></th>

            </tr>
            <tr>
                <td><?php echo AL_AUTHOR;?></td>
                <td><?php echo MS_HEADERMESSAGES;?> ?></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="pinfo"><a class="name"
                                     href="spieler.php?uid=<?php echo $arr['owner']; ?>"><?php echo $owner['username']; ?></a><br/><img
                        class="avatarHead" title="<?php echo $owner['username']; ?>"
                        alt="<?php echo $owner['username']; ?>"
                        src="hero_image.php?uid=<?php echo $arr['owner']; ?>&amp;size=forum" border="0"/><br/><a
                        href="allianz.php?aid=<?php echo $allianceinfo['id']; ?>"><?php echo $allianceinfo['tag']; ?></a><br/>
                    <?php echo AL_POSTS;?>: <?php echo $countAu; ?><br/>
                    <br/>
                    <?php echo POPUALTION;?>: <?php echo $totalpop; ?><br/>
                    <?php echo VILLAGES;?>: <?php echo count($varray); ?><br/>
                    <?php echo $trip; ?>
                </td>
                <td class="pcontent">
                    <div class="posted"><?php echo AL_Created;?> : <?php echo $date; ?></div>
                    <?php
                        if ($database->CheckEditRes($aid) == "1") {
                            echo '<div class="admin"><a class="edit" href="allianz.php?s=2&pid=' . $arr['alliance'] . '&idf=' . $arr['cat'] . '&idt=' . $arr['id'] . '&admin=editans"><img src="img/x.gif" title="Edit" alt="Edit" /></a><a class="fdel" href="?s=2&pid=' . $arr['alliance'] . '&tid=' . $arr['id'] . '&admin=deltopic" onClick="return confirm(\'confirm delete?\');"><img src="img/x.gif" title="delete" alt="delete" /></a></div><br />';
                        }
                    ?>
                    <div class="clear dotted"></div>
                    <div class="text"><?php echo $bbcode_topic; ?></div>
                </td>
            </tr>
            <?php
                foreach ($posts as $po) {
                    $date = date('m/d/y H:i a', $po['date']);
                    $countAu = $database->CountTopic($po['owner']);
                    $varray = $database->getProfileVillages($po['owner']);
                    $totalpop = 0;
                    foreach ($varray as $vil) {
                        $totalpop += $vil['pop'];
                    }
                    $displayarray = $database->getUser($po['owner'], 1);
                    $tribe = $displayarray['tribe'];
                    switch ($tribe) {
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
                    $owner = $database->getUser($po['owner'], 1);
                    $allianceinfo = $database->getAlliance($owner['alliance']);
                    $input = $po['post'];
                    $alliance = $po['alliance0'];
                    $player = $po['player0'];
                    $coor = $po['coor0'];
                    $report = $po['report0'];
                    include("GameEngine/BBCode.php");
                    $bbcode_post = stripslashes(nl2br($bbcoded));

                    echo '<tr><td class="pinfo"><a class="name" href="spieler.php?uid=' . $po['owner'] . '">' . $owner['username'] . '</a><br /><a href="allianz.php?aid=' . $allianceinfo['id'] . '">' . $allianceinfo['tag'] . '</a><br />
		Posts: ' . $countAu . '<br />
		<br />
		Inhbs.: ' . $totalpop . '<br />
		Villages: ' . count($varray) . '<br />
		' . $trip . '
		</td>
		<td class="pcontent"><div class="posted">created:  ' . $date . '</div>';
                    if ($database->CheckEditRes($aid) == "1") {
                        echo '<div class="admin"><a class="edit" href="allianz.php?s=2&pid=' . $arr['alliance'] . '&idt=' . $_GET['tid'] . '&pod=' . $po['id'] . '&admin=editpost"><img src="img/x.gif" title="Edit" alt="Edit" /></a><a class="fdel" href="?s=2&pid=' . $arr['alliance'] . '&tid=' . $arr['id'] . '&admin=deltopic" onClick="return confirm(\'confirm delete?\');"><img src="img/x.gif" title="delete" alt="delete" /></a></div><br />';
                    }
                    echo '<div class="clear dotted"></div><div class="text">' . $bbcode_post . '</div></td>
	</tr>';
                }
            ?>
            </tbody>
        </table>
        <div style="margin-top: 15px;">
        <?php
        if (empty($arr['close'])) {
            ?>
            <div class="buttonBox">
                <button type="button" value="reply" id="fbtn_reply" class="green "
                        onclick="window.location.href = 'allianz.php?s=2&pid=<?php echo $arr['alliance']; ?>&tid=<?php echo $arr['id']; ?>&ac=newpost'; return false;">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content">Reply</div>
                    </div>
                </button>
                <script type="text/javascript">
                    window.addEvent('domready', function () {
                        if ($('fbtn_reply')) {
                            $('fbtn_reply').addEvent('click', function () {
                                window.fireEvent('buttonClicked', [this, {"type": "button", "value": "reply", "name": "", "id": "fbtn_reply", "class": "green ", "title": "", "confirm": "", "onclick": "window.location.href = 'allianz.php?s=2&pid=<?php echo $arr['alliance'];?>&tid=<?php echo $arr['id'];?>&ac=newpost'; return false;"}]);
                            });
                        }
                    });
                </script>
            </div>
        <?php
        }
        if ($opt['opt5'] == 1) {
            ?>
            <div class="buttonBox"><a
                    href="allianz.php?s=2&pid=<?php echo $aid; ?>&tid=<?php echo $arr['id']; ?>&admin=switch_admin"
                    title="Toggle Admin mode"><img class="switch_admin dynamic_img" src="img/x.gif"
                                                   alt="Toggle Admin mode"/></a></div>
        <?php
        }
        echo '<div class="clear"></div></div>';
    } else {
        header("Location: banned.php");
        die;
    }
?>