<?php
//////////////// made by TTMTT ////////////////
    if ($_GET['fid']) {
        $aid = $database->ForumCatAlliance($_GET['fid']);
    } else if ($_GET['fid2']) {
        $aid = $database->ForumCatAlliance($_GET['fid2']);
    } elseif (!isset($aid)) {
        $aid = $session->alliance;
    }


   // $q = mysql_query("SELECT `ends` FROM ".TB_PREFIX."forum_topic where alliance = '".$session->alliance."'");
    //$q = mysql_fetch_assoc($q);
    //foreach($q as $qu){
       // echo $qu;
        $query =  "UPDATE " . TB_PREFIX . "forum_topic set `close` = '1' where ends <= '" . $_SERVER['REQUEST_TIME'] . "' && ends > 0 && alliance = '" . $session->alliance . "'";
        //echo $query;
        mysql_query($query) or die(mysql_error());
    //}
    $allianceinfo = $database->getAlliance($aid);
    $opt = $database->getAlliPermissions($session->uid, $aid);
    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";

    $ids = $_GET['s'];

    if (isset($_POST['new'])) {
        $forum_name = $_POST['u1'];
        $forum_des = $_POST['u2'];
        $forum_owner = $session->uid;
        $forum_area = $_POST['bid'];
        if ($forum_name != '' && $forum_des != '') {

            $id = $database->CreatForum($forum_owner, $aid, $forum_name, $forum_des, $forum_area);
            if (isset($_POST['users_by_id'])) {
                $users_by_id = $_POST['users_by_id'];
                $users_by_id = implode(",", $users_by_id);
            } else {
                $users_by_id = null;
            }

            if (isset($_POST['users_by_name'])) {
                $users_by_name = $_POST['users_by_name'];
                $users_by_name = implode(",", $users_by_name);
            } else {
                $users_by_name = null;
            }

            if (isset($_POST['allys_by_id'])) {
                $allys_by_id = $_POST['allys_by_id'];
                $allys_by_id = implode(",", $allys_by_id);
            } else {
                $allys_by_id = null;
            }

            if (isset($_POST['allys_by_name'])) {
                $allys_by_name = $_POST['allys_by_name'];
                $allys_by_name = implode(",", $allys_by_name);
            } else {
                $allys_by_name = null;
            }

            $database->CreatForum_rules($aid, $id, $users_by_id, $users_by_name, $allys_by_id, $allys_by_name);

        }
    }
    if (isset($_POST['edittopic'])) {
        $topic_name = $_POST['thema'];
        $topic_cat = $_POST['fid'];
        $topic_id = $_POST['tid'];

        $database->UpdateEditTopic($topic_id, $topic_name, $topic_cat);
    }
    if (isset($_POST['editforum'])) {
        $forum_name = $_POST['u1'];
        $$forum_name = htmlspecialchars($forum_name);
        $forum_des = $_POST['u2'];
        $forum_des = htmlspecialchars($forum_des);
        $forum_id = $_POST['fid'];

        $database->UpdateEditForum($forum_id, $forum_name, $forum_des);
    }
    if (isset($_POST['newtopic'])) {
        $title = $_POST['thema'];
        $text = $_POST['text'];
        $cat = $_POST['fid'];
        $owner = $session->uid;
        $alli = $_POST['pid'];

        if (isset($_POST['umfrage_ende'])) {
            if ($_POST['year'] == 15) {
                $_POST['year'] = 2015;
            }
            if ($_POST['year'] == 16) {
                $_POST['year'] = 2016;
            }

            $ends = strtotime("" . $_POST['year'] . "-" . $_POST['month'] . "-" . $_POST['day'] . " " . $_POST['hour'] . ":" . $_POST['minute'] . ":00");
            //echo $ends." ".time();
            //$ends -= 16200;
            //die;
        } else {
            $ends = '';
        }

        if ($text != "") {
            if (!preg_match('/\[message\]/', $text) && !preg_match('/\[\/message\]/', $text)) {
                $text = "[message]" . $text . "[/message]";
                $alliance = $player = $coor = $report = 0;
                for ($i = 0; $i <= $alliance; $i++) {
                    if (preg_match('/\[alliance' . $i . '\]/', $text) && preg_match('/\[\/alliance' . $i . '\]/', $text)) {
                        $alliance1 = preg_replace('/\[message\](.*?)\[\/alliance' . $i . '\]/is', '', $text);
                        if (preg_match('/\[alliance' . $i . '\]/', $alliance1) && preg_match('/\[\/alliance' . $i . '\]/', $alliance1)) {
                            $j = $i + 1;
                            $alliance2 = preg_replace('/\[\/alliance' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $alliance1 = preg_replace('/\[alliance' . $i . '\]/', '[alliance' . $j . ']', $alliance1);
                            $alliance1 = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance' . $j . ']', $alliance1);
                            $text = $alliance2 . "[/alliance" . $i . "]" . $alliance1;
                            $alliance += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $player; $i++) {
                    if (preg_match('/\[player' . $i . '\]/', $text) && preg_match('/\[\/player' . $i . '\]/', $text)) {
                        $player1 = preg_replace('/\[message\](.*?)\[\/player' . $i . '\]/is', '', $text);
                        if (preg_match('/\[player' . $i . '\]/', $player1) && preg_match('/\[\/player' . $i . '\]/', $player1)) {
                            $j = $i + 1;
                            $player2 = preg_replace('/\[\/player' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $player1 = preg_replace('/\[player' . $i . '\]/', '[player' . $j . ']', $player1);
                            $player1 = preg_replace('/\[\/player' . $i . '\]/', '[/player' . $j . ']', $player1);
                            $text = $player2 . "[/player" . $i . "]" . $player1;
                            $player += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $coor; $i++) {
                    if (preg_match('/\[coor' . $i . '\]/', $text) && preg_match('/\[\/coor' . $i . '\]/', $text)) {
                        $coor1 = preg_replace('/\[message\](.*?)\[\/coor' . $i . '\]/is', '', $text);
                        if (preg_match('/\[coor' . $i . '\]/', $coor1) && preg_match('/\[\/coor' . $i . '\]/', $coor1)) {
                            $j = $i + 1;
                            $coor2 = preg_replace('/\[\/coor' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $coor1 = preg_replace('/\[coor' . $i . '\]/', '[coor' . $j . ']', $coor1);
                            $coor1 = preg_replace('/\[\/coor' . $i . '\]/', '[/coor' . $j . ']', $coor1);
                            $text = $coor2 . "[/coor" . $i . "]" . $coor1;
                            $coor += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $report; $i++) {
                    if (preg_match('/\[report' . $i . '\]/', $text) && preg_match('/\[\/report' . $i . '\]/', $text)) {
                        $report1 = preg_replace('/\[message\](.*?)\[\/report' . $i . '\]/is', '', $text);
                        if (preg_match('/\[report' . $i . '\]/', $report1) && preg_match('/\[\/report' . $i . '\]/', $report1)) {
                            $j = $i + 1;
                            $report2 = preg_replace('/\[\/report' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $report1 = preg_replace('/\[report' . $i . '\]/', '[report' . $j . ']', $report1);
                            $report1 = preg_replace('/\[\/report' . $i . '\]/', '[/report' . $j . ']', $report1);
                            $text = $report2 . "[/report" . $i . "]" . $report1;
                            $report += 1;
                        }
                    }
                }

                $t = $database->CreatTopic($title, $text, $cat, $owner, $alli, $ends, $alliance, $player, $coor, $report);
                if (isset($_POST['umfrage'])) {
                    $database->CreatPoll($t, $_POST['umfrage_thema'], $_POST['option_1'], $_POST['option_2'], $_POST['option_3'], $_POST['option_4']);
                }
            }
        }
    }
    if (isset($_POST['newpost'])) {
        $text = $_POST['text'];
        $tids = $_POST['tid'];
        $owner = $session->uid;
        if ($text != "") {
            if (!preg_match('/\[message\]/', $text) && !preg_match('/\[\/message\]/', $text)) {
                $text = "[message]" . $text . "[/message]";
                $alliance = $player = $coor = $report = 0;
                for ($i = 0; $i <= $alliance; $i++) {
                    if (preg_match('/\[alliance' . $i . '\]/', $text) && preg_match('/\[\/alliance' . $i . '\]/', $text)) {
                        $alliance1 = preg_replace('/\[message\](.*?)\[\/alliance' . $i . '\]/is', '', $text);
                        if (preg_match('/\[alliance' . $i . '\]/', $alliance1) && preg_match('/\[\/alliance' . $i . '\]/', $alliance1)) {
                            $j = $i + 1;
                            $alliance2 = preg_replace('/\[\/alliance' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $alliance1 = preg_replace('/\[alliance' . $i . '\]/', '[alliance' . $j . ']', $alliance1);
                            $alliance1 = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance' . $j . ']', $alliance1);
                            $text = $alliance2 . "[/alliance" . $i . "]" . $alliance1;
                            $alliance += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $player; $i++) {
                    if (preg_match('/\[player' . $i . '\]/', $text) && preg_match('/\[\/player' . $i . '\]/', $text)) {
                        $player1 = preg_replace('/\[message\](.*?)\[\/player' . $i . '\]/is', '', $text);
                        if (preg_match('/\[player' . $i . '\]/', $player1) && preg_match('/\[\/player' . $i . '\]/', $player1)) {
                            $j = $i + 1;
                            $player2 = preg_replace('/\[\/player' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $player1 = preg_replace('/\[player' . $i . '\]/', '[player' . $j . ']', $player1);
                            $player1 = preg_replace('/\[\/player' . $i . '\]/', '[/player' . $j . ']', $player1);
                            $text = $player2 . "[/player" . $i . "]" . $player1;
                            $player += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $coor; $i++) {
                    if (preg_match('/\[coor' . $i . '\]/', $text) && preg_match('/\[\/coor' . $i . '\]/', $text)) {
                        $coor1 = preg_replace('/\[message\](.*?)\[\/coor' . $i . '\]/is', '', $text);
                        if (preg_match('/\[coor' . $i . '\]/', $coor1) && preg_match('/\[\/coor' . $i . '\]/', $coor1)) {
                            $j = $i + 1;
                            $coor2 = preg_replace('/\[\/coor' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $coor1 = preg_replace('/\[coor' . $i . '\]/', '[coor' . $j . ']', $coor1);
                            $coor1 = preg_replace('/\[\/coor' . $i . '\]/', '[/coor' . $j . ']', $coor1);
                            $text = $coor2 . "[/coor" . $i . "]" . $coor1;
                            $coor += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $report; $i++) {
                    if (preg_match('/\[report' . $i . '\]/', $text) && preg_match('/\[\/report' . $i . '\]/', $text)) {
                        $report1 = preg_replace('/\[message\](.*?)\[\/report' . $i . '\]/is', '', $text);
                        if (preg_match('/\[report' . $i . '\]/', $report1) && preg_match('/\[\/report' . $i . '\]/', $report1)) {
                            $j = $i + 1;
                            $report2 = preg_replace('/\[\/report' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $report1 = preg_replace('/\[report' . $i . '\]/', '[report' . $j . ']', $report1);
                            $report1 = preg_replace('/\[\/report' . $i . '\]/', '[/report' . $j . ']', $report1);
                            $text = $report2 . "[/report" . $i . "]" . $report1;
                            $report += 1;
                        }
                    }
                }
                $database->UpdatePostDate($tids);
                $database->CreatPost($text, $tids, $owner, $alliance, $player, $coor, $report);
            }
        }
    }
    if (isset($_POST['editans'])) {
        $text = $_POST['text'];
        $text = preg_replace('/\[message\]/', '', $text);
        $text = preg_replace('/\[\/message\]/', '', $text);
        for ($i = 1; $i <= $_POST['alliance0']; $i++) {
            $text = preg_replace('/\[alliance' . $i . '\]/', '[alliance0]', $text);
            $text = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance0]', $text);
        }
        for ($i = 0; $i <= $_POST['player0']; $i++) {
            $text = preg_replace('/\[player' . $i . '\]/', '[player0]', $text);
            $text = preg_replace('/\[\/player' . $i . '\]/', '[/player0]', $text);
        }
        for ($i = 0; $i <= $_POST['coor0']; $i++) {
            $text = preg_replace('/\[coor' . $i . '\]/', '[coor0]', $text);
            $text = preg_replace('/\[\/coor' . $i . '\]/', '[/coor0]', $text);
        }
        for ($i = 0; $i <= $_POST['report0']; $i++) {
            $text = preg_replace('/\[report' . $i . '\]/', '[report0]', $text);
            $text = preg_replace('/\[\/report' . $i . '\]/', '[/report0]', $text);
        }
        $topic_id = $_POST['tid'];

        if ($text != "") {
            if (!preg_match('/\[message\]/', $text) && !preg_match('/\[\/message\]/', $text)) {
                $text = "[message]" . $text . "[/message]";
                $alliance = $player = $coor = $report = 0;
                for ($i = 0; $i <= $alliance; $i++) {
                    if (preg_match('/\[alliance' . $i . '\]/', $text) && preg_match('/\[\/alliance' . $i . '\]/', $text)) {
                        $alliance1 = preg_replace('/\[message\](.*?)\[\/alliance' . $i . '\]/is', '', $text);
                        if (preg_match('/\[alliance' . $i . '\]/', $alliance1) && preg_match('/\[\/alliance' . $i . '\]/', $alliance1)) {
                            $j = $i + 1;
                            $alliance2 = preg_replace('/\[\/alliance' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $alliance1 = preg_replace('/\[alliance' . $i . '\]/', '[alliance' . $j . ']', $alliance1);
                            $alliance1 = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance' . $j . ']', $alliance1);
                            $text = $alliance2 . "[/alliance" . $i . "]" . $alliance1;
                            $alliance += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $player; $i++) {
                    if (preg_match('/\[player' . $i . '\]/', $text) && preg_match('/\[\/player' . $i . '\]/', $text)) {
                        $player1 = preg_replace('/\[message\](.*?)\[\/player' . $i . '\]/is', '', $text);
                        if (preg_match('/\[player' . $i . '\]/', $player1) && preg_match('/\[\/player' . $i . '\]/', $player1)) {
                            $j = $i + 1;
                            $player2 = preg_replace('/\[\/player' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $player1 = preg_replace('/\[player' . $i . '\]/', '[player' . $j . ']', $player1);
                            $player1 = preg_replace('/\[\/player' . $i . '\]/', '[/player' . $j . ']', $player1);
                            $text = $player2 . "[/player" . $i . "]" . $player1;
                            $player += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $coor; $i++) {
                    if (preg_match('/\[coor' . $i . '\]/', $text) && preg_match('/\[\/coor' . $i . '\]/', $text)) {
                        $coor1 = preg_replace('/\[message\](.*?)\[\/coor' . $i . '\]/is', '', $text);
                        if (preg_match('/\[coor' . $i . '\]/', $coor1) && preg_match('/\[\/coor' . $i . '\]/', $coor1)) {
                            $j = $i + 1;
                            $coor2 = preg_replace('/\[\/coor' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $coor1 = preg_replace('/\[coor' . $i . '\]/', '[coor' . $j . ']', $coor1);
                            $coor1 = preg_replace('/\[\/coor' . $i . '\]/', '[/coor' . $j . ']', $coor1);
                            $text = $coor2 . "[/coor" . $i . "]" . $coor1;
                            $coor += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $report; $i++) {
                    if (preg_match('/\[report' . $i . '\]/', $text) && preg_match('/\[\/report' . $i . '\]/', $text)) {
                        $report1 = preg_replace('/\[message\](.*?)\[\/report' . $i . '\]/is', '', $text);
                        if (preg_match('/\[report' . $i . '\]/', $report1) && preg_match('/\[\/report' . $i . '\]/', $report1)) {
                            $j = $i + 1;
                            $report2 = preg_replace('/\[\/report' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $report1 = preg_replace('/\[report' . $i . '\]/', '[report' . $j . ']', $report1);
                            $report1 = preg_replace('/\[\/report' . $i . '\]/', '[/report' . $j . ']', $report1);
                            $text = $report2 . "[/report" . $i . "]" . $report1;
                            $report += 1;
                        }
                    }
                }

                $database->EditUpdateTopic($topic_id, $text, $alliance, $player, $coor, $report);
                $q = "SELECT `voters` FROM " . TB_PREFIX . "forum_poll where id = '" . $topic_id . "'";
                if (mysql_query($q)) {
                    $q = mysql_query($q);
                    $q = mysql_fetch_assoc($q);
                    if ($q && $q['voters'] == 0) {
                        mysql_query("UPDATE " . TB_PREFIX . "forum_poll set `p1_name` = '" . $_POST['option_1'] . "' , `p2_name` = '" . $_POST['option_2'] . "' ,
			`p3_name` = '" . $_POST['option_3'] . "' , `p4_name` = '" . $_POST['option_4'] . "' ,`name` = '" . $_POST['option_5'] . "'
			where id = '" . $topic_id . "'") or die(mysql_error());
                    }
                }
            }
        }
    }
    if (isset($_POST['editpost'])) {
        $text = $_POST['text'];
        $text = preg_replace('/\[message\]/', '', $text);
        $text = preg_replace('/\[\/message\]/', '', $text);
        for ($i = 1; $i <= $_POST['alliance0']; $i++) {
            $text = preg_replace('/\[alliance' . $i . '\]/', '[alliance0]', $text);
            $text = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance0]', $text);
        }
        for ($i = 0; $i <= $_POST['player0']; $i++) {
            $text = preg_replace('/\[player' . $i . '\]/', '[player0]', $text);
            $text = preg_replace('/\[\/player' . $i . '\]/', '[/player0]', $text);
        }
        for ($i = 0; $i <= $_POST['coor0']; $i++) {
            $text = preg_replace('/\[coor' . $i . '\]/', '[coor0]', $text);
            $text = preg_replace('/\[\/coor' . $i . '\]/', '[/coor0]', $text);
        }
        for ($i = 0; $i <= $text['report0']; $i++) {
            $text = preg_replace('/\[report' . $i . '\]/', '[report0]', $text);
            $text = preg_replace('/\[\/report' . $i . '\]/', '[/report0]', $text);
        }
        $posts_id = $_POST['pod'];
        if ($text != "") {
            if (!preg_match('/\[message\]/', $text) && !preg_match('/\[\/message\]/', $text)) {
                $text = "[message]" . $text . "[/message]";
                $alliance = $player = $coor = $report = 0;
                for ($i = 0; $i <= $alliance; $i++) {
                    if (preg_match('/\[alliance' . $i . '\]/', $text) && preg_match('/\[\/alliance' . $i . '\]/', $text)) {
                        $alliance1 = preg_replace('/\[message\](.*?)\[\/alliance' . $i . '\]/is', '', $text);
                        if (preg_match('/\[alliance' . $i . '\]/', $alliance1) && preg_match('/\[\/alliance' . $i . '\]/', $alliance1)) {
                            $j = $i + 1;
                            $alliance2 = preg_replace('/\[\/alliance' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $alliance1 = preg_replace('/\[alliance' . $i . '\]/', '[alliance' . $j . ']', $alliance1);
                            $alliance1 = preg_replace('/\[\/alliance' . $i . '\]/', '[/alliance' . $j . ']', $alliance1);
                            $text = $alliance2 . "[/alliance" . $i . "]" . $alliance1;
                            $alliance += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $player; $i++) {
                    if (preg_match('/\[player' . $i . '\]/', $text) && preg_match('/\[\/player' . $i . '\]/', $text)) {
                        $player1 = preg_replace('/\[message\](.*?)\[\/player' . $i . '\]/is', '', $text);
                        if (preg_match('/\[player' . $i . '\]/', $player1) && preg_match('/\[\/player' . $i . '\]/', $player1)) {
                            $j = $i + 1;
                            $player2 = preg_replace('/\[\/player' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $player1 = preg_replace('/\[player' . $i . '\]/', '[player' . $j . ']', $player1);
                            $player1 = preg_replace('/\[\/player' . $i . '\]/', '[/player' . $j . ']', $player1);
                            $text = $player2 . "[/player" . $i . "]" . $player1;
                            $player += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $coor; $i++) {
                    if (preg_match('/\[coor' . $i . '\]/', $text) && preg_match('/\[\/coor' . $i . '\]/', $text)) {
                        $coor1 = preg_replace('/\[message\](.*?)\[\/coor' . $i . '\]/is', '', $text);
                        if (preg_match('/\[coor' . $i . '\]/', $coor1) && preg_match('/\[\/coor' . $i . '\]/', $coor1)) {
                            $j = $i + 1;
                            $coor2 = preg_replace('/\[\/coor' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $coor1 = preg_replace('/\[coor' . $i . '\]/', '[coor' . $j . ']', $coor1);
                            $coor1 = preg_replace('/\[\/coor' . $i . '\]/', '[/coor' . $j . ']', $coor1);
                            $text = $coor2 . "[/coor" . $i . "]" . $coor1;
                            $coor += 1;
                        }
                    }
                }
                for ($i = 0; $i <= $report; $i++) {
                    if (preg_match('/\[report' . $i . '\]/', $text) && preg_match('/\[\/report' . $i . '\]/', $text)) {
                        $report1 = preg_replace('/\[message\](.*?)\[\/report' . $i . '\]/is', '', $text);
                        if (preg_match('/\[report' . $i . '\]/', $report1) && preg_match('/\[\/report' . $i . '\]/', $report1)) {
                            $j = $i + 1;
                            $report2 = preg_replace('/\[\/report' . $i . '\](.*?)\[\/message\]/is', '', $text);
                            $report1 = preg_replace('/\[report' . $i . '\]/', '[report' . $j . ']', $report1);
                            $report1 = preg_replace('/\[\/report' . $i . '\]/', '[/report' . $j . ']', $report1);
                            $text = $report2 . "[/report" . $i . "]" . $report1;
                            $report += 1;
                        }
                    }
                }
                $database->EditUpdatePost($posts_id, $text, $alliance, $player, $coor, $report);
            }
        }
    }
    if (!isset($_GET['admin'])) {
        $_GET['admin'] = null;
    }
    if ($_GET['admin'] == "switch_admin") {
        if ($opt['opt5'] == 1) {
            if ($database->CheckResultEdit($aid) != 1) {
                $database->CreatResultEdit($aid, 1);
            } else {
                if ($database->CheckEditRes($aid) == 1) {
                    $database->UpdateResultEdit($aid, '');
                } else {
                    $database->UpdateResultEdit($aid, 1);
                }
            }
        }
    }
    if ($_GET['admin'] == "pin") {
        $database->StickTopic($_GET['idt'], 1); // stick topic
    }
    if ($_GET['admin'] == "pos") {
        $database->ChangePos($_GET['fid'], $_GET['res']);
        header("Location: allianz.php?s=2");
    }
    if ($_GET['admin'] == "unpin") {
        $database->StickTopic($_GET['idt'], ''); // unstick topic
    }
    if ($_GET['admin'] == "delforum") {
        $database->DeleteCat($_GET['idf']); // delete forum
    }
    if ($_GET['admin'] == "deltopic") {
        $database->DeleteTopic($_GET['idt']); // delete topic
    }
    if ($_GET['admin'] == "delpost") {
        $database->DeletePost($_GET['pod']); // stick topic
    }
    if ($_GET['admin'] == "lock") {
        $database->LockTopic($_GET['idt'], 1); // lock topic
    }
    if ($_GET['admin'] == "unlock") {
        $database->LockTopic($_GET['idt'], ''); // unlock topic
    }
    if ($_GET['admin'] == "newforum") {
        include("Forum/forum_1.tpl"); // New forum
    } elseif (isset($_GET['fid'])) {
        if (isset($_GET['ac'])) {
            include("Forum/forum_5.tpl"); // new topic
        } else {
            include("Forum/forum_4.tpl"); // topic cat
        }
    } elseif ($_GET['admin'] == "editforum") {
        include("Forum/forum_8.tpl"); // edit topic
    } elseif ($_GET['admin'] == "editans") {
        include("Forum/forum_9.tpl"); // edit answer
    } elseif ($_GET['admin'] == "editpost") {
        include("Forum/forum_10.tpl"); // edit answer
    } elseif ($_GET['admin'] == "edittopic") {
        include("Forum/forum_3.tpl"); // edit topic
    } elseif (isset($_GET['tid'])) {
        if (isset($_GET['ac'])) {
            include("Forum/forum_7.tpl"); // new post
        } else {
            include("Forum/forum_6.tpl"); // showtopic
        }
    } else {
        if ($database->CheckForum($aid)) {
            include("Forum/forum_2.tpl");
        } else if ($opt['opt5'] == 1) {
            if ($session->access == BANNED) {
                ?>
                <p class="error"><?php echo AL_FORUMNTCREATED;?></p>
                <p>
                    <button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo AL_NEWFORUM;?>"
                            onclick="window.location.href = 'banned.php'; return false;">
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
                            if ($('btn_ok')) {
                                $('btn_ok').addEvent('click', function () {
                                    window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "<?php echo AL_NEWFORUM;?>", "confirm": "", "onclick": ""}]);
                                });
                            }
                        });
                    </script>
                </p>
            <?php
            } else {
                ?>
                <p class="error"><?php echo AL_FORUMNTCREATED;?></p>
                <p>
                    <button type="submit" value="ok" name="s1" id="btn_ok" class="green " title="<?php echo AL_NEWFORUM;?>"
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
                            if ($('btn_ok')) {
                                $('btn_ok').addEvent('click', function () {
                                    window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "<?php echo AL_NEWFORUM;?>", "confirm": "", "onclick": ""}]);
                                });
                            }
                        });
                    </script>
            <?php
            }
        } else {
            echo '<p class="error">'.AL_NEWFORUM.'</p>';
        }
    }
?>