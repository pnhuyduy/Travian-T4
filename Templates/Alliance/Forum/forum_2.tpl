<?php
//////////////// made by TTMTT ////////////////
    if ($session->access != BANNED) {
        $displayarray = $database->getUser($session->uid, 1);
        $forumcat = $database->ForumCat(htmlspecialchars($displayarray['alliance']));
        $forum_cat = $database->ForumCat;
        $ally = $session->alliance;
        $public = mysql_query("SELECT `id` FROM " . TB_PREFIX . "forum_cat WHERE alliance = $ally AND forum_area = 1");
        $public1 = mysql_num_rows($public);
        $cofederation = mysql_query("SELECT `id` FROM " . TB_PREFIX . "forum_cat WHERE alliance = $ally AND forum_area = 2");
        $cofederation1 = mysql_num_rows($cofederation);
        $alliance = mysql_query("SELECT `id` FROM " . TB_PREFIX . "forum_cat WHERE alliance = $ally AND forum_area = 0");
        $alliance1 = mysql_num_rows($alliance);
        $closed = mysql_query("SELECT `id` FROM " . TB_PREFIX . "forum_cat WHERE alliance = $ally AND forum_area = 3");
        $closed1 = mysql_num_rows($closed);
        if ($public1 != 0) {
            ?>
            <table cellpadding="1" cellspacing="1" id="public">
                <thead>
                <tr>
                    <th colspan="4"><?php echo AL_PUBFORUM;?></th>
                </tr>

                <tr>
                    <td></td>
                    <td><?php echo AL_FORUMNAME;?></td>
                    <td>&nbsp;<?php echo AL_THREADS;?>&nbsp;</td>
                    <td>&nbsp;<?php echo AL_LASTPOST;?>&nbsp;</td>
                </tr>
                </thead>
                <tbody>
                <?php
                    foreach ($forumcat as $arr) {
                        if ($arr['forum_area'] == 1) {
                            $countop = $database->CountCat($arr['id']);
                            $ltopic = $database->LastTopic($arr['id']);
                            //foreach ($ltopic as $las) {
                            //}
                            $lpos = $database->LastPost($ltopic['id']);
                            //foreach ($lpos as $pos) {
                            //}
                            if ($database->CheckLastTopic($arr['id'])) {
                                if ($database->CheckLastPost($las['id'])) {
                                    $lpost = date('m/d/y H:i a', $lpos['date']);
                                    $owner = $database->getUser($lpos['owner'], 1);
                                } else {
                                    $lpost = date('m/d/y H:i a', $las[date]);
                                    $owner = $database->getUser($las['owner'], 1);
                                }
                            } else {
                                $lpost = "";
                                $owner = "";
                            }


                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                echo '<a class="up_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=-1" title="'.AL_TOTOP.'"><img src="img/x.gif" alt="To top" /></a><a class="edit" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=editforum" title="'.AL_EDIT.'"><img src="img/x.gif" alt="edit" /></a><br /><a class="down_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=1" title="'.AL_TOBOTT.'"><img src="img/x.gif" alt="To bottom" /></a><a class="fdel" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=delforum" onClick="return confirm(\'confirm delete?\');" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" /></a>';
                            } else {
                                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                            }
                            echo '</td><td class="tit"><a href="allianz.php?s=2&fid=' . $arr['id'] . '&pid=' . $aid . '" title="' . $arr['forum_name'] . '">' . $arr['forum_name'] . '</a><br />' . $arr['forum_des'] . '</td>
			<td class="cou">' . $countop . '</td>
			<td class="last">' . $lpost . '</span><span><br /><a href="spieler.php?uid=' . $owner['id'] . '">' . $owner['username'] . '</a> <img class="latest_reply" src="img/x.gif" alt="Show last post" title="Show last post" /></td>
		</tr>';

                        }
                    }
                ?>
                </tbody>
            </table>
        <?php
        }
        if ($cofederation1 != 0) {
            ?>
            <table cellpadding="1" cellspacing="1" id="confederation">
                <thead>
                <tr>
                    <th colspan="4"><?php echo AL_CONFFORUM;?></th>
                </tr>

                <tr>
                    <td></td>
                    <td><?php echo AL_FORUMNAME;?></td>
                    <td>&nbsp;<?php echo AL_THREADS;?>&nbsp;</td>
                    <td>&nbsp;<?php echo AL_LASTPOST;?>&nbsp;</td>
                </tr>
                </thead>
                <tbody>
                <?php
                    foreach ($forumcat as $arr) {
                        if ($arr['forum_area'] == 2) {
                            $countop = $database->CountCat($arr['id']);
                            $ltopic = $database->LastTopic($arr['id']);
                            //foreach ($ltopic as $las) {
                            //}
                            $lpos = $database->LastPost($ltopic['id']);
                            //foreach ($lpos as $pos) {
                            //}
                            if ($database->CheckLastTopic($arr['id'])) {
                                if ($database->CheckLastPost($las['id'])) {
                                    $lpost = date('m/d/y H:i a', $lpos['date']);
                                    $owner = $database->getUser($pos['owner'], 1);
                                } else {
                                    $lpost = date('m/d/y H:i a', $las['date']);
                                    $owner = $database->getUser($las['owner'], 1);
                                }
                            } else {
                                $lpost = "";
                                $owner = "";
                            }
                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                echo '<a class="up_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=-1" title="To Top"><img src="img/x.gif" alt="To Top" /></a><a class="edit" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=editforum" title="'.AL_EDIT.'"><img src="img/x.gif" alt="Edit" /></a><br /><a class="down_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=1" title="'.AL_TOBOTT.'"><img src="img/x.gif" alt="To bottom" /></a><a class="fdel" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=delforum" onClick="return confirm(\'confirm delete?\');" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" /></a>';
                            } else {
                                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                            }
                            echo '</td><td class="tit"><a href="allianz.php?s=2&fid=' . $arr['id'] . '&pid=' . $aid . '" title="' . $arr['forum_name'] . '">' . $arr['forum_name'] . '</a><br />' . $arr['forum_des'] . '</td>
			<td class="cou">' . $countop . '</td>
			<td class="last">' . $lpost . '</span><span><br /'.AL_BY.' : <a href="spieler.php?uid=' . $owner['id'] . '">' . $owner['username'] . '</a> <img class="latest_reply" src="img/x.gif" alt="Show last post" title="Show last post" /></td>
		</tr>';

                        }
                    }
                ?>
                </tbody>
            </table>
        <?php
        }
        if ($alliance1 != 0) {
            ?>
            <table cellpadding="1" cellspacing="1" id="alliance">
                <thead>
                <tr>
                    <th colspan="4"><?php echo AL_ALLYFORUM?></th>
                </tr>

                <tr>
                    <td></td>
                    <td><?php echo AL_FORUMNAME;?></td>
                    <td>&nbsp;<?php echo AL_THREADS;?>&nbsp;</td>
                    <td>&nbsp;<?php echo AL_LASTPOST;?>&nbsp;</td>
                </tr>
                </thead>
                <tbody>
                <?php
                    foreach ($forumcat as $arr) {
                        if ($arr['forum_area'] == 0) {
                            $countop = $database->CountCat($arr['id']);
                            $ltopic = $database->LastTopic($arr['id']);
                            //foreach ($ltopic as $las) {
                            //}
                            $lpos = $database->LastPost($ltopic['id']);
                            //foreach ($lpos as $pos) {
                            //}
                            if ($database->CheckLastTopic($arr['id'])) {
                                if ($database->CheckLastPost($las['id'])) {
                                    $lpost = date('m/d/y H:i a', $lpos['date']);
                                    $owner = $database->getUser($lpos['owner'], 1);
                                } else {
                                    $lpost = date('m/d/y H:i a', $las['date']);
                                    $owner = $database->getUser($las['owner'], 1);
                                }
                            } else {
                                $lpost = "";
                                $owner = "";
                            }

                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                echo '<a class="up_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=-1" title="'.AL_TOTOP.'"><img src="img/x.gif" alt="To Top" /></a><a class="edit" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=editforum" title="'.AL_EDIT.'"><img src="img/x.gif" alt="Edit" /></a><br /><a class="down_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=1" title="'.AL_TOBOTT.'"><img src="img/x.gif" alt="To bottom" /></a><a class="fdel" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=delforum" onClick="return confirm(\'confirm delete?\');" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" /></a>';
                            } else {
                                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                            }
                            echo '</td><td class="tit"><a href="allianz.php?s=2&fid=' . $arr['id'] . '&pid=' . $aid . '" title="' . $arr['forum_name'] . '">' . $arr['forum_name'] . '</a><br />' . $arr['forum_des'] . '</td>
			<td class="cou">' . $countop . '</td><td class="last">' . $lpost . '</span>';


                            if ($lpost != '') {
                                echo '<span><br />By : <a href="spieler.php?uid=' . $owner['id'] . '">' . $owner['username'] . '</a> <img class="latest_reply" src="img/x.gif" alt="Show last post" title="Show last post" /></td>
		</tr>';
                            }else{
                                echo '<span class="cou">'.AL_BY.'</span>';
                            }

                        }
                    }
                ?>
                </tbody>
            </table>
        <?php
        }
        if ($closed1 != 0) {
            ?>
            <table cellpadding="1" cellspacing="1" id="closed">
                <thead>
                <tr>
                    <th colspan="4"><?php echo AL_CLOSEFORUM;?></th>
                </tr>

                <tr>
                    <td></td>
                    <td><?php echo AL_FORUMNAME;?></td>
                    <td>&nbsp;<?php echo AL_THREADS;?>&nbsp;</td>
                    <td>&nbsp;<?php echo AL_LASTPOST;?>&nbsp;</td>
                </tr>
                </thead>
                <tbody>
                <?php
                    foreach ($forumcat as $arr) {
                        if ($arr['forum_area'] == 3) {
                            $countop = $database->CountCat($arr['id']);
                            $ltopic = $database->LastTopic($arr['id']);
                            //foreach ($ltopic as $las) {
                            //}
                            $pos = $database->LastPost($ltopic['id']);
                            //foreach ($lpos as $pos) {
                            //}
                            if ($database->CheckLastTopic($arr['id'])) {
                                if ($database->CheckLastPost($las['id'])) {
                                    $lpost = date('m/d/y H:i a', $pos['date']);
                                    $owner = $database->getUser($pos['owner'], 1);
                                } else {
                                    $lpost = date('m/d/y H:i a', $las[date]);
                                    $owner = $database->getUser($las['owner'], 1);
                                }
                            } else {
                                $lpost = "";
                                $owner = "";
                            }
                            echo '<tr><td class="ico">';
                            if ($database->CheckEditRes($aid) == "1") {
                                echo '<a class="up_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=-1" title="'.AL_TOTOP.'"><img src="img/x.gif" alt="To Top" /></a><a class="edit" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=editforum" title="'.AL_EDIT.'"><img src="img/x.gif" alt="Edit" /></a><br /><a class="down_arr" href="allianz.php?s=2&fid=' . $arr['id'] . '&bid=0&admin=pos&res=1" title="'.AL_TOBOTT.'"><img src="img/x.gif" alt="To bottom" /></a><a class="fdel" href="allianz.php?s=2&idf=' . $arr['id'] . '&admin=delforum" onClick="return confirm(\'confirm delete?\');" title="'.AL_DELETE.'"><img src="img/x.gif" alt="delete" /></a>';
                            } else {
                                echo '<img class="folder" src="img/x.gif" title="'.AL_THWITHOUTPOST.'" alt="'.AL_THWITHOUTPOST.'">';
                            }
                            echo '</td><td class="tit"><a href="allianz.php?s=2&fid=' . $arr['id'] . '&pid=' . $aid . '" title="' . $arr['forum_name'] . '">' . $arr['forum_name'] . '</a><br />' . $arr['forum_des'] . '</td>
			<td class="cou">' . $countop . '</td>
			<td class="last">' . $lpost . '</span><span><br />'.AL_BY.' : <a href="spieler.php?uid=' . $owner['id'] . '">' . $owner['username'] . '</a> <img class="latest_reply" src="img/x.gif" alt="Show last post" title="Show last post" /></td>
		</tr>';

                        }
                    }
                ?>
                </tbody>
            </table>
        <?php
        }
        ?>
        <p>
        <?php
        $opt = $database->getAlliPermissions($session->uid, $aid);
        if ($opt['opt5'] == 1) {
            ?>
            <div class="buttonBox">
                <button type="button" value="New forum" id="button528a4efc076c0" class="green "
                        onclick="window.location.href = 'allianz.php?s=2&admin=newforum'; return false;">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo AL_NEWFORUM;?></div>
                    </div>
                </button>
                <script type="text/javascript">
                    window.addEvent('domready', function () {
                        if ($('button528a4efc076c0')) {
                            $('button528a4efc076c0').addEvent('click', function () {
                                window.fireEvent('buttonClicked', [this, {"type": "button", "value": "New forum", "name": "", "id": "button528a4efc076c0", "class": "green ", "title": "", "confirm": "", "onclick": "window.location.href = 'allianz.php?s=2&admin=newforum'; return false;"}]);
                            });
                        }
                    });
                </script>

            </div>
            <div class="buttonBox"><a href="allianz.php?s=<?php echo $ids; ?>&admin=switch_admin"
                                      title="Toggle Admin mode"><img class="switch_admin dynamic_img" src="img/x.gif"
                                                                     alt="Toggle Admin mode"/></a></div>
            <div class="clear"></div>
        <?php
        }
        ?>

        </p>
    <?php
    } else {
        header("Location: banned.php");
        die;
    }
?>