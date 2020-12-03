<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include "GameEngine/Protection.php";
// include 'Payments/packages.php';
if (isset($_GET)) {
    if ($_GET['cmd'] != 'News') {
        include('GameEngine/Village.php');
        // mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
        // mysql_select_db(SQL_DB);
        $P_GOLD = $session->gold;
        $golds = $database->getUser($session->username, 0);
        $g_club = g_club;
        $g_finish = g_finish;
        $g_plus = g_plus;
        $g_wood = g_wood;
        $g_clay = g_clay;
        $g_iron = g_iron;
        $g_crop = g_crop;
        $PLUS_TIME = (PLUS_TIME / 86400);
        $PLUS_PRODUCTION = (PLUS_PRODUCTION / 86400);
    }
    if (isset($_GET['cmd'])) {
        switch ($_GET['cmd']) {
            case 'getFieldStatus':
                $data = $_POST['data'];
                $data_id = $data['id'];

                $i = $data_id;
                $loopsame = $building->isCurrent($i) ? 1 : 0;
                if ($loopsame > 0 && $building->isLoop($i)) {
                    $doublebuild = 1;
                }
                $lev = $village->resarray['f' . $i] + ($loopsame > 0 ? 2 : 1) + $doublebuild;
                $uprequire = $building->resourceRequired($i, $village->resarray['f' . $i . 't'], ($loopsame > 0 ? 2 : 1) + $doublebuild);
                $t = $_SESSION['wid'];
                $lvl = $lev - 1;

                $bindicate = $building->canBuild($i, $village->resarray['f' . $i . 't']);

                $str_mid = "&lt;div style=color:#FFF&gt;&lt;b&gt;" . $building->procResType($village->resarray['f' . $i . 't']) . "&lt;/b&gt; سطح " . $village->resarray['f' . $i] . "&lt;/div&gt;" . (($database->getBuildingByField($t, $i)) ? '&lt;br /&gt;&lt;font color=#ff8700&gt; ارتقا به سطح ' . $lvl . '&lt;/font&gt;' : "");

                $str_mid .= ($bindicate != 1) ? "&lt;br /&gt; &#1607;&#1586;&#1740;&#1606;&#1607; &#1575;&#1585;&#1578;&#1602;&#1575; &#1576;&#1607; &#1587;&#1591;&#1581; " . $lev . ":&lt;br /&gt;&nbsp;&nbsp;&nbsp;&lt;span class=resources r1&gt;&lt;img class=r1 src=img/x.gif title=Lumber&gt;" . $uprequire['wood'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r2&gt;&lt;img class=r2 src=img/x.gif title=Clay&gt;" . $uprequire['clay'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r3&gt;&lt;img class=r3 src=img/x.gif title=Iron&gt;" . $uprequire['iron'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r4&gt;&lt;img class=r4 src=img/x.gif title=Crop&gt;" . $uprequire['crop'] . "&nbsp;&nbsp;" : "";

                $str = '{response:{"error":false,"errorMsg":null,"data":{"getFieldStatus" : "' . $str_mid . '"}}}';

                echo $str;
                break;
            case 'getFieldStatus2':
                $data = $_POST['data'];
                $data_id = $data['id'];

                $i = $data_id;
                $loopsame = $building->isCurrent($i) ? 1 : 0;
                if ($loopsame > 0 && $building->isLoop($i)) {
                    $doublebuild = 1;
                }
                $lev = $village->resarray['f' . $i] + ($loopsame > 0 ? 2 : 1) + $doublebuild;
                $uprequire = $building->resourceRequired($i, $village->resarray['f' . $i . 't'], ($loopsame > 0 ? 2 : 1) + $doublebuild);
                $t = $_SESSION['wid'];
                $lvl = $lev - 1;

                $bindicate = $building->canBuild($i, $village->resarray['f' . $i . 't']);

                $str_mid = "&lt;div style=color:#FFF&gt;&lt;b&gt;" . $building->procResType($village->resarray['f' . $i . 't']) . "&lt;/b&gt; &#1587;&#1591;&#1581; " . $village->resarray['f' . $i] . "&lt;/div&gt;" . (($database->getBuildingByField($t, $i)) ? '&lt;br /&gt;&lt;font color=#ff8700&gt; ارتقا به سطح ' . $lvl . '&lt;/font&gt;' : "");

                $str_mid .= ($bindicate != 1) ? "&lt;br /&gt; &#1607;&#1586;&#1740;&#1606;&#1607; &#1575;&#1585;&#1578;&#1602;&#1575;&#1593; &#1576;&#1607; &#1587;&#1591;&#1581; " . $lev . ":&lt;br /&gt;&nbsp;&nbsp;&nbsp;&lt;span class=resources r1&gt;&lt;img class=r1 src=img/x.gif title=Lumber&gt;" . $uprequire['wood'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r2&gt;&lt;img class=r2 src=img/x.gif title=Clay&gt;" . $uprequire['clay'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r3&gt;&lt;img class=r3 src=img/x.gif title=Iron&gt;" . $uprequire['iron'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r4&gt;&lt;img class=r4 src=img/x.gif title=Crop&gt;" . $uprequire['crop'] . "&nbsp;&nbsp;" : "";


                if ($village->resarray['f' . $i . 't'] != 0) {
                    $title = "&lt;div style=color:#FFF&gt;&lt;b&gt;" . $building->procResType($village->resarray['f' . $i . 't']) . "&lt;/b&gt; &#1587;&#1591;&#1581; " . $village->resarray['f' . $i] . "&lt;/div&gt;" . (($database->getBuildingByField($t, $i)) ? '&lt;font color=#ff8700&gt;در حال حاضر ارتقاء به سطح ' . $lvl . '&lt;/font&gt;&lt;br /&gt;' : "");

                    $title .= ($bindicate != 1) ? " &#1607;&#1586;&#1740;&#1606;&#1607; &#1575;&#1585;&#1578;&#1602;&#1575;&#1593; &#1576;&#1607; &#1587;&#1591;&#1581; " . $lev . ":&lt;br /&gt;&nbsp;&nbsp;&nbsp;&lt;span class=resources r1&gt;&lt;img class=r1 src=img/x.gif title=&#1670;&#1608;&#1576;&gt;" . $uprequire['wood'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r2&gt;&lt;img class=r2 src=img/x.gif title=&#1670;&#1608;&#1576;&gt;" . $uprequire['clay'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r3&gt;&lt;img class=r3 src=img/x.gif title=&#1670;&#1608;&#1576;&gt;" . $uprequire['iron'] . "&nbsp;&nbsp;&nbsp;&lt;span class=resources r4&gt;&lt;img class=r4 src=img/x.gif title=&#1670;&#1608;&#1576;&gt;" . $uprequire['crop'] . "&nbsp;&nbsp;&nbsp; " : "";

                    $title2 = "&lt;div style=color:#FFF&gt;&lt;b&gt;" . $building->procResType($village->resarray['f' . $i . 't']) . "&lt;/b&gt;&lt;/div&gt; &#1587;&#1591;&#1581; " . $village->resarray['f' . $i];
                } else {
                    $title = '&#1605;&#1581;&#1589;&#1604; &#1575;&#1581;&#1583;&#1575;&#1579; &#1587;&#1575;&#1582;&#1578;&#1605;&#1575;&#1606;';
                    // if(($t == 39) && ($village->resarray['f'.$t] == 0)) {$title = '&#1605;&#1581;&#1604; &#1575;&#1581;&#1583;&#1575;&#1579; &#1575;&#1585;&#1583;&#1608;&#1711;&#1575;&#1607;';}
                }
                if ($village->resarray['f' . $i] <= 19) {
                    $str_mid = $title;
                } else {
                    $str_mid = $title2;
                }

                $str = '{response:{"error":false,"errorMsg":null,"data":{"getFieldStatus" : "' . $str_mid . '"}}}';

                echo $str;

                break;
            case
            'chat':
                if ($session->logged_in) {
                    //decode
                $_POST['m'] = urldecode($_POST['m']);

                $res = mysql_query('SELECT `id` FROM cchat Where `To` = ' . $session->uid . ' AND viewed = 0');
                $nms = Mysql_fetch_assoc($res);
                if ($nms['id'] > 0) {
                    $newmsg = $nms['id'];
                } else {
                    $newmsg = '0';
                }
                if ($_POST['a'] == 'fl') {
                    if ($session->access >= MULTIHUNTER) {
                        $res = mysql_query('SELECT * FROM cchat Where `To` = 4 GROUP BY `uid`');
                        $htlp = '';
                        while ($row = mysql_fetch_assoc($res)) {
                            $res2 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                            $user = mysql_fetch_assoc($res2);
                            $username = $user['username'];

                            $ress = mysql_query('SELECT `id` FROM cchat Where `To` = 4 AND viewed = 0');
                            $nms = Mysql_fetch_assoc($ress);
                            if ($nms['id'] > 0) {
                                $newmsg = $nms['id'];
                            } else {
                                $newmsg = '0';
                            }
                            $ress = mysql_query("SELECT id FROM " . TB_PREFIX . "users WHERE id= " . $row['uid'] . " AND " . time() . "-timestamp < " . 60);
                            $onl = Mysql_fetch_assoc($ress);

                            if ($onl['id'] > 0) {
                                $online = '1';
                            } else {
                                $online = '0';
                            }
                            $htlp .= '{"u":"'.$row['uid'].'","n":"' . $username . '","a":"0","o":' . $online . ',"m":' . $newmsg . '},';
                        }
                        $str = '{response:{"error":false,"errorMsg":null,"data":
							{
								"username": "' . $session->username . '","friends": [' . $htlp . ']
							}
						}}';
                    } else {

                        $ress = mysql_query("SELECT id FROM " . TB_PREFIX . "users WHERE id= 4 AND " . time() . "-timestamp < " . 60);
                        $onl = Mysql_fetch_assoc($ress);

                        if ($onl['id'] > 0) {
                            $online = '1';
                        } else {
                            $online = '0';
                        }

                        $str = '{response:{"error":false,"errorMsg":null,"data":{"username": "' . $session->username . '","friends": [{"u":"1","n":"Support","a":"0","o":0,"m":0},{"u":"4","n":"Multihunter","a":"0","o":' . $online . ',"m":' . $newmsg . '}]}}}';
                    }
                    echo $str;
                    exit;
                }
                if ($_POST['a'] == 'sc') {
                    mysql_query("insert into cchat (`id`,`uid`,`To`,`msg`,`time`) VALUES (''," . $session->uid . "," . $_POST['t'] . ",'" . $_POST['m'] . "', '".time()."')") or die(mysql_error());
                    $str = '{response:{"error":false,"errorMsg":null,"data":"' . $_POST['m'] . '"}}';
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'asc') {
                    mysql_query("insert into cchat (`id`,`uid`,`alliance`,`msg`) VALUES (''," . $session->uid . "," . $session->alliance . ",'" . $_POST['m'] . "')") or die(mysql_error());
                    $str = '{response:{"error":false,"errorMsg":null,"data":"' . $_POST['m'] . '"}}';
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'agch') {
                    $res = mysql_query('SELECT * FROM cchat Where `alliance` = ' . $session->alliance . ' AND viewed = 1');
                    $htm = '';
                    while ($row = mysql_fetch_assoc($res)) {
                        $res2 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                        $user = mysql_fetch_assoc($res2);
                        $username = $user['username'];
                        $htm .= '{"id":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $username . '","m":"' . $row['msg'] . '"},';
                    }
                    $str = '{response:{"error":false,"errorMsg":null,"data":[' . $htm . ']}}';
                    //$str = '{response:{"error":false,"errorMsg":null,"data":[]}}';
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'agnm') {
                    $res = mysql_query('SELECT * FROM cchat Where `alliance` = ' . $session->alliance . ' AND `uid` != ' . $session->uid . ' AND viewed = 0');
                    $htm = '';
                    while ($row = mysql_fetch_assoc($res)) {
                        $res2 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                        $user = mysql_fetch_assoc($res2);
                        $username = $user['username'];
                        $htm .= '{"id":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $username . '","m":"' . $row['msg'] . '"},';
                        mysql_query("UPDATE cchat set viewed = 1 WHERE id = " . $row['id']);
                    }
                    $str = '{response:{"error":false,"errorMsg":null,"data":[' . $htm . ']}}';
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'gfrq') {
                    $str = '{response:{"error":false,"errorMsg":null,"data":[]}}';
                    echo $str;
                    exit;
                }
                if ($_POST['a'] == 'gch') {

                    $res = mysql_query('SELECT * FROM cchat Where (`uid` = ' . $session->uid . ' AND `To` = '.$_POST['t'].') OR (`To` = ' . $session->uid . ' AND `uid` = '.$_POST['t'].') ORDER BY time');

                    while ($row = mysql_fetch_assoc($res)) {
                        $res2 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                        $user = mysql_fetch_assoc($res2);
                        $username = $user['username'];
						                    $html = str_replace('\t', '', $row['msg']);
                    $html = str_replace('\n', '', $html);
                    $html = str_replace('"', '\"', $html);
                    $html = str_replace('
', '', $html);
                        $htm .= '{"id":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $username . '","m":"' . $html . '"},';
                    }

                    $str = '{response:{"error":false,"errorMsg":null,"data":[' . $htm . ']}}';
                    //$str = '{response:{"error":false,"errorMsg":null,"data":[]}}';

                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;


                    $res = mysql_query('SELECT * FROM cchat Where `uid` = ' . $session->uid . '');
                    $res3 = mysql_query('SELECT * FROM cchat Where `To` = ' . $session->uid . ' AND `uid` = '.$_POST['t']);
                    $htm = '';
                    while ($row = mysql_fetch_assoc($res)) {
                        $res2 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                        $user = mysql_fetch_assoc($res2);
                        $username = $user['username'];
                        $htm .= '{"id":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $username . '","m":"' . $row['msg'] . '"},';
                    }
                    while ($row = mysql_fetch_assoc($res3)) {
                        $res4 = mysql_query("SELECT username FROM " . TB_PREFIX . "users WHERE id = " . $row['uid']);
                        $user = mysql_fetch_assoc($res4);
                        $username = $user['username'];
                        $htm .= '{"id":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $username . '","m":"' . $row['msg'] . '"},';
                    }
                    $str = '{response:{"error":false,"errorMsg":null,"data":[' . $htm . ']}}';
                    //$str = '{response:{"error":false,"errorMsg":null,"data":[]}}';
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'gnm') {
                    if ($session->access == MULTIHUNTER) {
                        $res = mysql_query('SELECT * FROM cchat Where `uid` = ' . $_POST['t'] . ' AND viewed = 0');
                    } else {
                        $res = mysql_query('SELECT * FROM cchat Where `To` = ' . $session->uid . ' AND viewed = 0');
                    }
                    $htm = '';
                    while ($row = mysql_fetch_assoc($res)) {
                        $htm .= '{"html":"' . $row['id'] . '","u":"' . $row['uid'] . '","n":"' . $session->username . '","m":"' . $row['msg'] . '"}';
                        mysql_query("UPDATE cchat set viewed = 1 WHERE id = " . $row['id']);
                    }
                    $str = '{response:{"error":false,"errorMsg":null,"data":[' . $htm . ']}}';
                    $str = str_replace('\t', '', $str);
                    $str = str_replace('\n', '', $str);
                    $str = str_replace('
', '', $str);
                    $input = $str;
                    require 'GameEngine/BBCode.php';
                    echo $bbcoded;
                    exit;
                }
                if ($_POST['a'] == 'scfg') {
                    $data = $_POST['data'];
                    $online = $data['onlinestate'];
                    $sound = $data['sound'];
                    $popup = $data['popup'];

                    switch ($online) {
                        case 0: //offline
                            if (isset($sound) AND isset($popup)) {
                                $cfg = 56;
                            } elseif (isset($sound) AND !isset($popup)) {
                                $cfg = 24;
                            } elseif (!isset($sound) AND isset($popup)) {
                                $cfg = 40;
                            } else {
                                $cfg = 0;
                            }
                            break;
                        //visible
                        case 1:
                            if (isset($sound) AND isset($popup)) {
                                $array = array(49, 51, 53, 55, 57, 59);
                                $cfg = $array[rand(0, 5)];
                            } elseif (isset($sound) AND !isset($popup)) {
                                $array = array(17, 19, 21, 23, 25, 27, 29, 31);
                                $cfg = $array[rand(0, 7)];
                            } elseif (!isset($sound) AND isset($popup)) {
                                $array = array(33, 35, 37, 39, 41, 43, 45, 47);
                                $cfg = $array[rand(0, 7)];
                            } else {
                                $cfg = 1;
                            }
                            break;
                        //invisible
                        case 2:
                            if (isset($sound) AND isset($popup)) {
                                $array = array(50, 52, 54);
                                $cfg = $array[rand(0, 2)];
                            } elseif (isset($sound) AND !isset($popup)) {
                                $cfg = 18;
                            } elseif (!isset($sound) AND isset($popup)) {
                                $cfg = 34;
                            } else {
                                $cfg = 2;
                            }
                            break;
                        //invisible to non ally member
                        case 4:
                            if (isset($sound) AND isset($popup)) {
                                $cfg = 52;
                            } elseif (isset($sound) AND !isset($popup)) {
                                $array = array(20, 22);
                                $cfg = $array[rand(0, 1)];
                            } elseif (!isset($sound) AND isset($popup)) {
                                $array = array(36, 38);
                                $cfg = $array[rand(0, 1)];
                            } else {
                                $cfg = 4;
                            }
                            break;
                        //invisible to my alliance member
                        case 8:
                            if (isset($sound) AND isset($popup)) {
                                $array = array(56, 58, 60);
                                $cfg = $array[rand(0, 2)];
                            } elseif (isset($sound) AND !isset($popup)) {
                                $array = array(24, 26, 28, 30);
                                $cfg = $array[rand(0, 3)];
                            } elseif (!isset($sound) AND isset($popup)) {
                                $array = array(40, 42, 44, 46);
                                $cfg = $array[rand(0, 3)];
                            } else {
                                $cfg = 8;
                            }
                            break;
                    }
                    $_SESSION['chat_config'] = $cfg;
                    mysql_query("UPDATE ".TB_PREFIX."users SET chat_config = ".$cfg." WHERE id = ".$session->uid);
                    echo '{response: {"error":false,"errorMsg":null,"data":' . $cfg . '}}';
                    /*
                    1 3 5 7 9 11 13 15 visible
                    17 19 21 23 25 27 29 31 visible + sound
                    33 35 37 39 41 43 45 47 vis + pop
                    49 51 53 55 57 59 vis + pop + snd


                    2 invisible
                    18 invis + snd
                    34 invis + pop
                    50 52 54  invis + pop + snd


                    4 6 invisbile to non ally
                    20 22 invis to non ally + snd
                    36 38 invis to n + pop
                    52 invis + ppop + snd

                    8 10 12 14 invisible to my ally
                    24 26 28 30 invis to my all + snd
                    40 42 44 46 +pop
                    56 58 60 invis to my all + snd + pop

                    0 offline
                    16 offline + snd nt
                    32 off + pop
                    48 off + snd + pop
                    */

                }
                echo $str;
                }
                break;

            case 'autoComplete':
                if($_POST['type'] == "villagename"){
                    $q = 'SELECT `name` FROM ' . TB_PREFIX . 'vdata WHERE owner > 4 AND name like "' . mysql_real_escape_string($_POST['search']) . '%" order by name asc limit 0,10';
                    $rs = mysql_query($q) or die(mysql_error());
                    while ($row = mysql_fetch_array($rs, MYSQL_ASSOC)) {
                        $t .= '"' . $row['name'] . '",';
                    }
                    echo '{
                        response: [' . $t . ']
                    }';
                    break;
                }elseif($_POST['type'] == "username") {
                    $q = 'SELECT `username` FROM ' . TB_PREFIX . 'users WHERE id > 4 AND username like "' . mysql_real_escape_string($_POST['search']) . '%" order by id asc limit 0,10';
                    $rs = mysql_query($q) or die(mysql_error());
                    while ($row = mysql_fetch_array($rs, MYSQL_ASSOC)) {
                        $t .= '"' . $row['username'] . '",';
                    }
                    echo '{
                        response: [' . $t . ']
                    }';
                }
                break;
            case 'heroEditor':
			    $herol = $database->getHeroFace($session->uid);
                if ($herol['gender'] == 0) {
                    $gen = 'male';
                } else {
                    $gen = 'female';
                }
                if ($_POST['action'] == "save") {
                    // $database->editTableField('heroface', 'face', $_SESSION['face'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'color', $_SESSION['getcolor'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'hair', $_SESSION['gethair'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'ear', $_SESSION['getear'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'eyebrow', $_SESSION['geteyebrow'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'eye', $_SESSION['geteye'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'nose', $_SESSION['getnose'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'mouth', $_SESSION['getmouth'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'beard', $_SESSION['getbeard'], 'uid', $session->uid);
                    // $database->editTableField('heroface', 'gender', $_POST['HeroGender'], 'uid', $_POST['uid']);
                    // $database->editTableField('hero', 'hash', md5($_SERVER['REQUEST_TIME']), 'uid', $session->uid);

                    $database->modifyWholeHeroFace($session->uid, $_SESSION['face'], $_SESSION['getcolor'], $_SESSION['gethair'], $_SESSION['getear'], $_SESSION['geteyebrow'], $_SESSION['geteye'], $_SESSION['getnose'], $_SESSION['getmouth'], $_SESSION['getbeard']);

                    $str = '{
						response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
					}';
                    echo $str;
                    exit;
                }
                if ($_POST['action'] == "random") {
					if ($herol['gender'] == 0) {
						$face = $_SESSION['face'] = rand(0, 4);
					} else {
						$face = $_SESSION['face'] = rand(0, 5);
					}
                    $headp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"<?php echo GP_LOCATE."img/hero/".$gstr; ?>/'.$gen.'/head/254x330/face0.png\" alt=\"\">';
                    $headp .= '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"<?php echo GP_LOCATE."img/hero/".$gstr; ?>/'.$gen.'/head/254x330/face/face' . $face . '.png\" alt=\"\">';
                    $color = $_SESSION['getcolor'] = rand(0, 4);
                    switch ($color) {
                        case 0:
                            $color = 'black';
                            break;
                        case 1:
                            $color = 'brown';
                            break;
                        case 2:
                            $color = 'darkbrown';
                            break;
                        case 3:
                            $color = 'yellow';
                            break;
                        case 4:
                            $color = 'red';
                            break;
                    }
                    $gethair = $_SESSION['gethair'] = rand(0, 5);
                    $hearp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '/img/hero/'.$gen.'/head/254x330/hair/hair' . $gethair . '-' . $color . '.png\" alt=\"\" >';
                    
					if ($herol['gender'] == 0) {
						$getear = $_SESSION['getear'] = rand(0, 4);
					} else {
						$getear = $_SESSION['getear'] = rand(0, 7);
					}
					
                    $earp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/ear\/ear' . $getear . '.png\" alt=\"\">';
                    
					if ($herol['gender'] == 0) {
						$geteyebrow = $_SESSION['geteyebrow'] = rand(0, 4);
					} else {
						$geteyebrow = $_SESSION['geteyebrow'] = rand(0, 9);
					}
					
					if ($herol['gender'] == 0) {
                        $eyebrow = $geteyebrow . '-' . $color;
                    } else {
                        $eyebrow = $geteyebrow;
                    }
					
					$eyebp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/eyebrow\/eyebrow' . $eyebrow . '.png\" alt=\"\">';
                    if ($herol['gender'] == 0) {
                        $geteye = $_SESSION['geteye'] = rand(0, 4);
                    } else {
                        $geteye = $_SESSION['geteye'] = rand(0, 9);
                    }
					$eyep = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/eye\/eye' . $geteye . '.png\" alt=\"\">';
                    if ($herol['gender'] == 0) {
                        $getnose = $_SESSION['getnose'] = rand(0, 4);
                    } else {
                        $getnose = $_SESSION['getnose'] = rand(0, 7);
                    }
					$nosep = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/nose\/nose' . $getnose . '.png\" alt=\"\">';
                    if ($herol['gender'] == 0) {
                        $getmouth = $_SESSION['getmouth'] = rand(0, 3);
                    } else {
                        $getmouth = $_SESSION['getmouth'] = rand(0, 8);
                    }
					
                    $mop = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/mouth\/mouth' . $getmouth . '.png\" alt=\"\">';
                    
					if ($herol['gender'] == 0) {
                        $getbeard = $_SESSION['getbeard'] = rand(0, 5);
						$beardp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/beard\/beard' . $getbeard . '-' . $color . '.png\" alt=\"\">';
                    } else {
                        $beardp = '';
                    }
					$str = '{
						response: {"error":false,"errorMsg":null,"data":{"attributes":{},"html":"' . $headp . $hearp . $earp . $eyebp . $eyep . $nosep . $mop . $beardp . '"}}
					}';
                    echo $str;
                }elseif ($_POST['action'] == 'gender') {
                    $att = $_POST['attribs'];
                    $gender = $att['gender'];

                    if ($gender == 'male') {
                        $gn = 0;
                    } else {
                        $gn = 1;
                    }

                    $database->modifyHeroFace($session->uid, 'gender', $gn);

                    $str = '{
						response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
					}';
                    echo $str;

                } else {
                    $att = $_POST['attribs'];
                    if (isset($att['headProfile'])) {
                        $face = $att['headProfile'];
                        $_SESSION['face'] = $face;
                    } else {
                        $face = $_SESSION['face'];
                    }

                    $headp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '/img/hero/'.$gen.'/head/254x330/face0.png\" alt=\"\">';
                    $headp .= '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '/img/hero/'.$gen.'/head/254x330/face/face' . $face . '.png\" alt=\"\">';
                    if (isset($att['hairColor'])) {
                        $_SESSION['getcolor'] = $att['hairColor'];
                        switch ($att['hairColor']) {
                            case 0:
                                $color = 'black';
                                break;
                            case 1:
                                $color = 'brown';
                                break;
                            case 2:
                                $color = 'darkbrown';
                                break;
                            case 3:
                                $color = 'yellow';
                                break;
                            case 4:
                                $color = 'red';
                                break;
                        }
                        $_SESSION['color'] = $color;
                    } else {
                        $color = $_SESSION['color'];
                    }
                    if (isset($att['hairStyle'])) {
                        $gethair = $_SESSION['gethair'] = $att['hairStyle'];
                    } else {
                        $gethair = $_SESSION['gethair'];
                    }
                    $hearp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '/img/hero/'.$gen.'/head/254x330/hair/hair' . $gethair . '-' . $color . '.png\" alt=\"\" >';
                    if (isset($att['ears'])) {
                        $getear = $_SESSION['getear'] = $att['ears'];
                    } else {
                        $getear = $_SESSION['getear'];
                    }
                    $earp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/ear\/ear' . $getear . '.png\" alt=\"\">';
                    if (isset($att['eyebrow'])) {
                        $geteyebrow = $_SESSION['geteyebrow'] = $att['eyebrow'];
                    } else {
                        $geteyebrow = $_SESSION['geteyebrow'];
                    }
                    $eyebp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/eyebrow\/eyebrow' . $geteyebrow . '-' . $color . '.png\" alt=\"\">';
                    if (isset($att['eyes'])) {
                        $geteye = $_SESSION['geteye'] = $att['eyes'];
                    } else {
                        $geteye = $_SESSION['geteye'];
                    }
                    $eyep = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/eye\/eye' . $geteye . '.png\" alt=\"\">';

                    if (isset($att['nose'])) {
                        $getnose = $_SESSION['getnose'] = $att['nose'];
                    } else {
                        $getnose = $_SESSION['getnose'];
                    }
                    $nosep = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/nose\/nose' . $getnose . '.png\" alt=\"\">';

                    if (isset($att['mouth'])) {
                        $getmouth = $_SESSION['getmouth'] = $att['mouth'];
                    } else {
                        $getmouth = $_SESSION['getmouth'];
                    }

                    $mop = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/mouth\/mouth' . $getmouth . '.png\" alt=\"\">';

                    if (isset($att['beard'])) {
                        $getbeard = $_SESSION['getbeard'] = $att['beard'];
                    } else {
                        $getbeard = $_SESSION['getbeard'];
                    }
                    $beardp = '<img style=\"width:254px; height:330px; position:absolute;left:0px;top:0px;\" src=\"' . GP_LOCATE . '\/img\/hero\/'.$gen.'\/head\/254x330\/beard\/beard' . $getbeard . '-' . $color . '.png\" alt=\"\">';
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"attributes":{},"html":"' . $headp . $hearp . $earp . $eyebp . $eyep . $nosep . $mop . $beardp . '"}}
					}';
                    echo $str;
                }
                break;
            case 'goldclubPopup':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"title":"&#1705;&#1604;&#1608;&#1662; &#1591;&#1604;&#1575;&#1740;&#1740;","gold":"&#1587;&#1705;&#1607; &#1591;&#1604;&#1575;: <img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\"\/> <span class=\"bold\">' . $P_GOLD . '<\/span>","subHeadLine":"&#1576;&#1607; &#1605;&#1606;&#1592;&#1608;&#1585; &#1575;&#1587;&#1578;&#1601;&#1575;&#1583;&#1607; &#1575;&#1586; &#1575;&#1740;&#1606; &#1608;&#1740;&#1688;&#1711;&#1740; &#1607;&#1575; &#1548; &#1588;&#1605;&#1575; &#1606;&#1740;&#1575;&#1586; &#1576;&#1607; &#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; &#1705;&#1604;&#1608;&#1662; &#1591;&#1604;&#1575;&#1740;&#1740; &#1583;&#1575;&#1585;&#1740;&#1583; !","goldButton":"<button  type=\"button\" value=\"Purchase the Gold club.\" id=\"button529084cb4f226\" class=\"gold \" title=\"&#1607;&#1605; &#1575;&#1705;&#1606;&#1608;&#1606; &#1601;&#1593;&#1575;&#1604; &#1705;&#1606; <br>&#1605;&#1583;&#1578; &#1586;&#1605;&#1575;&#1606;: <b>&#1578;&#1575; &#1570;&#1582;&#1585; &#1576;&#1575;&#1586;&#1740;<\/br>\" coins=\"' . $g_club . '\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; &#1705;&#1604;&#1608;&#1662; &#1591;&#1604;&#1575;&#1740;&#1740;.<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">' . $g_club . '<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button529084cb4f226\'))\n\t{\n\t\t$(\'button529084cb4f226\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Purchase the Gold club.\",\"name\":\"\",\"id\":\"button529084cb4f226\",\"class\":\"gold \",\"title\":\"&#1601;&#1593;&#1575;&#1604; &#1705;&#1606; \\u003Cbr\\u003EBonus duration: \\u003Cb\\u003Ewhole game round\\u003C\\\/br\\u003E\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":' . $g_club . '}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1605;&#1583;&#1578; &#1586;&#1605;&#1575;&#1606;: <b>&#1578;&#1575; &#1575;&#1578;&#1605;&#1575;&#1605; &#1576;&#1575;&#1586;&#1740;<\/br>","goldclubPopupButtonExtraFeatures":"&#1593;&#1604;&#1575;&#1608;&#1607; &#1576;&#1585; &#1575;&#1740;&#1606;&#1548; &#1588;&#1605;&#1575; &#1575;&#1605;&#1705;&#1575;&#1606; &#1583;&#1587;&#1578;&#1585;&#1587;&#1740; &#1576;&#1607; &#1608;&#1740;&#1688;&#1711;&#1740; &#1607;&#1575;&#1740; &#1586;&#1740;&#1585; &#1585;&#1575; &#1583;&#1575;&#1585;&#1740;&#1583; :","features":{"troopEscape":{"title":"&#1711;&#1585;&#1740;&#1586; &#1583;&#1585; &#1662;&#1575;&#1740;&#1578;&#1582;&#1578;","text":"&#1587;&#1585;&#1576;&#1575;&#1586;&#1575;&#1606; &#1582;&#1608;&#1583; &#1585;&#1575; &#1583;&#1585; &#1662;&#1575;&#1740;&#1578;&#1582;&#1578;  &#1585;&#1575; &#1605;&#1740; &#1578;&#1608;&#1575;&#1606; &#1583;&#1587;&#1578;&#1608;&#1585; &#1583;&#1575;&#1583; &#1578;&#1575; &#1576;&#1607; &#1589;&#1608;&#1585;&#1578; &#1582;&#1608;&#1583;&#1705;&#1575;&#1585; &#1583;&#1585; &#1576;&#1585;&#1575;&#1576;&#1585; &#1581;&#1605;&#1604;&#1575;&#1578; &#1576;&#1607;&#1583;&#1607;&#1705;&#1583;&#1607; &#1601;&#1585;&#1575;&#1585; &#1608; &#1711;&#1585;&#1740;&#1586; &#1705;&#1606;&#1606;&#1583; &#1608; &#1587;&#1575;&#1604;&#1605; &#1576;&#1605;&#1575;&#1606;&#1606;&#1583;."},"raidList":{"title":"&#1601;&#1575;&#1585;&#1605; &#1604;&#1740;&#1587;&#1578;","text":"&#1583;&#1585; &#1575;&#1585;&#1583;&#1608;&#1711;&#1575;&#1607; &#1548; &#1588;&#1605;&#1575; &#1605;&#1740; &#1578;&#1608;&#1575;&#1606;&#1740;&#1583; &#1604;&#1740;&#1587;&#1578; &#1583;&#1607;&#1705;&#1583;&#1607; &#1608; &#1570;&#1576;&#1575;&#1583;&#1740; &#1607;&#1575; &#1576;&#1585;&#1575;&#1740; &#1605;&#1583;&#1740;&#1585;&#1740;&#1578; &#1581;&#1605;&#1604;&#1607; &#1576;&#1607; &#1575;&#1607;&#1583;&#1575;&#1601; &#1587;&#1608;&#1583;&#1570;&#1608;&#1585; &#1575;&#1587;&#1578;&#1601;&#1575;&#1583;&#1607; &#1705;&#1606;&#1740;&#1583;."},"tradeThreeTimes":{"title":"&#1602;&#1575;&#1576;&#1604;&#1740;&#1578; &#1587;&#1607; &#1586;&#1605;&#1575;&#1606;&#1607; &#1588;&#1583;&#1606; &#1578;&#1575;&#1580;&#1585;&#1740;&#1606;","text":"&#1578;&#1575;&#1580;&#1585;&#1575;&#1606; &#1602;&#1575;&#1583;&#1585; &#1576;&#1607; &#1575;&#1606;&#1580;&#1575;&#1605; &#1576;&#1607; &#1591;&#1608;&#1585; &#1582;&#1608;&#1583;&#1705;&#1575;&#1585; &#1605;&#1581;&#1605;&#1608;&#1604;&#1607; &#1605;&#1606;&#1575;&#1576;&#1593; &#1578;&#1575; &#1587;&#1607; &#1576;&#1575;&#1585; &#1583;&#1585; &#1740;&#1705; &#1585;&#1583;&#1740;&#1601;."},"tradeRoute":{"title":"&#1605;&#1587;&#1740;&#1585;&#1607;&#1575;&#1740; &#1578;&#1580;&#1575;&#1585;&#1740; &#1576;&#1607; &#1589;&#1608;&#1585;&#1578; &#1582;&#1608;&#1583;&#1705;&#1575;&#1585;","text":"&#1588;&#1605;&#1575; &#1605;&#1740; &#1578;&#1608;&#1575;&#1606;&#1740;&#1583; &#1585;&#1575;&#1607; &#1575;&#1606;&#1583;&#1575;&#1586;&#1740; &#1605;&#1581;&#1605;&#1608;&#1604;&#1607; &#1605;&#1606;&#1575;&#1576;&#1593; &#1576;&#1607;&#1606;&#1711;&#1575;&#1605; &#1608; &#1576;&#1607; &#1591;&#1608;&#1585; &#1605;&#1606;&#1592;&#1605; &#1576;&#1740;&#1606; &#1585;&#1608;&#1587;&#1578;&#1575;&#1607;&#1575;&#1740; &#1582;&#1608;&#1583; &#1588;&#1605;&#1575;."},"cropFinder":{"title":"&#1580;&#1587;&#1578;&#1580;&#1608; &#1711;&#1585; (9-15) &#1711;&#1606;&#1583;&#1605;&#1740;","text":"&#1602;&#1575;&#1576;&#1604;&#1740;&#1578; &#1580;&#1587;&#1578;&#1580;&#1608; &#1583;&#1585; &#1576;&#1740;&#1606; &#1570;&#1576;&#1575;&#1583;&#1740; &#1607;&#1575; &#1576;&#1585;&#1575;&#1740;  &#1662;&#1740;&#1583;&#1575; &#1705;&#1585;&#1583;&#1606; (9-15) &#1711;&#1606;&#1583;&#1605;&#1740;"},"messageArchive":{"title":"&#1570;&#1585;&#1588;&#1740;&#1608; &#1662;&#1740;&#1594;&#1575;&#1605; &#1607;&#1575; &#1608;&#1711;&#1586;&#1575;&#1585;&#1588; &#1607;&#1575;","text":"&#1602;&#1575;&#1576;&#1604;&#1740;&#1578; &#1584;&#1582;&#1740;&#1585;&#1607; &#1608; &#1570;&#1586;&#1588;&#1740;&#1608; &#1662;&#1740;&#1575;&#1605; &#1607;&#1575; &#1608; &#1711;&#1586;&#1575;&#1585;&#1588; &#1576;&#1585;&#1575;&#1740; &#1583;&#1587;&#1578;&#1585;&#1587;&#1740; &#1576;&#1607;&#1578;&#1585;"}},"furtherInfos":"The <b>Gold club<\/b> will enable these features for the rest of the game round. Click the \"i\" for more information."}}
				}';
                echo $str;
                break;
            case 'GoldRules':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"title":"Buy Gold Rules","gold":"","subHeadLine":"Rules to buy Gold in travian Sx","goldButton":"","buttonSubtitle":"","goldclubPopupButtonExtraFeatures":"","features":{"1. ":{"title":"Automated system","text":"Our Payment system is automatic and after successful buy ,Gold will added to your account automatically"},"2. ":{"title":"The system didn\'t give your gold ?","text":"Sometime System will stuck and the gold will not transfer to user account! in this case you can\'t Get your money back! JUST send a message to multihunter and we will add your gold as soon as possible."},"Important :":{"title":"","text":"If you buy gold and play with it and request paypal for your money back, we can\'t accept that and your account will be banned!"},"Important_2 :":{"title":"","text":"if Our system goes Down we will give you extra gold or ... to make you happy and get back you to the game."},"Important_3 :":{"title":"","text":"You can\'t Request for get back your money from us or <b>paypal</b> for any reason."},"Important_4 :":{"title":"","text":"if Our system shut down for more than 1 day we will get back your gold"}},"furtherInfos":"you <b>Should<\/b> read these rules before buy any golds, by buying gold you accepted our rules!."}}
				}';
                echo $str;
                break;
            case 'checkRecipient':
				if($_POST['recipient'] != "[ally]"){
					$q = mysql_fetch_assoc(mysql_query('SELECT `id` FROM ' . TB_PREFIX . 'users WHERE username = "' . $_POST['recipient'] . '" LIMIT 1'));
					if ($q['id'] > 0) {
						$z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $session->uid . "'") or die(mysql_error());
						$z = mysql_fetch_assoc($z);
						$dataarray = explode(',', $z['ignore_msg']);
						$id = 0;
						foreach ($dataarray as $param) {
							$names = $database->getUserField($param, 'username', 0);
							if ($_POST['recipient'] == $names) {
								$id = 1;
								break;
							}
						}
						if ($id == 1) {
							$str = '{
								response: {"errorMsg":"To ignore messages from a specific player, go to its profile and click on \"Ignore\"! ","error":true}
							}';
						} else {
							$z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $q['id'] . "'") or die(mysql_error());
							$z = mysql_fetch_assoc($z);
							$dataarray = explode(',', $z['ignore_msg']);
							$id = 0;
							foreach ($dataarray as $param) {
								if ($param == $session->uid) {
									$id = 1;
									break;
								}
							}
							if ($id == 1) {
								$str = '{
									response: {"errorMsg":"To ignore messages from a specific player, go to its profile and click on \"Ignore\"! ","error":true}
								}';
							} else {
								$str = '{
									response: {"success":"success"}
								}';
							}
						}
					} else {
						$str = '{
							response: {"errorMsg":"The name .' . $_POST['recipient'] . ' does not exist.","error":true}
						}';
					}
					
				}else{
					$str = '{
						response: {"success":"success"}
					}';
				}
				echo $str;
                break;
            case 'reportSpamMessage':
                $msg_id = $_POST['messageId'];
                $reason = $_POST['spamReason'];
                $time = $_SERVER['REQUEST_TIME'];
                mysql_query("INSERT INTO " . TB_PREFIX . "msg_reports (id,msg_id,reported_by,reason,time) VALUES ('', " . $msg_id . ", '" . $_SESSION['username'] . "', '" . $reason . "', '" . $time . "') ") or die(mysql_error());
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"reportingSuccessful":"message successfully reported","closeButtonText":"close"}}
				}';
                echo $str;
                break;
            case 'paymentWizardAdvertisedPersons':
                $uid = $session->uid;
                $res1 = mysql_query("SELECT `username` FROM " . TB_PREFIX . "users WHERE id='$uid' LIMIT 1");
                $row = mysql_fetch_array($res1);
                $name = $row['username'];
                $result2 = mysql_query("SELECT `player_id` FROM " . TB_PREFIX . "refrence WHERE player_name='$name'");
                if (isset($result2)) {
                    $l = 0;
                    while ($row = mysql_fetch_array($result2)) {
                        $player_idx[$l] = $row['player_id'];
                        $l++;
                    }
                }
                if ($l > 0) {
                    for ($j = 0; $j < $l; $j++) {
                        $player_ids = $player_idx[$j];
                        $result3 = mysql_query("SELECT `pop`,`created` FROM " . TB_PREFIX . "vdata WHERE owner='" . $player_idx[$j] . "'");
                        if (isset($result3)) {
                            $k = 0;
                            while ($row = mysql_fetch_array($result3)) {
                                // echo $row['pop'];
                                $pop[$j] = $row['pop'];
                                $created[$j] = $row['created'];
                                $k++;
                            }
                        }
                    }
                }
                if ($l > 0) {
                    for ($ii = 0; $ii < $j; $ii++) {
                        $signtime = date('m/d/Y', $created[$ii]);
                        $num_rows = mysql_num_rows($result3);
                        $res1 = mysql_query("SELECT `username`,`reg2` FROM " . TB_PREFIX . "users WHERE id='" . $player_idx[$ii] . "' LIMIT 1");
                        $row = mysql_fetch_array($res1);
                        $reg = $row['reg2'];
                        $username = $row['username'];
                        if ($reg == 1) {
                            $block = '<strike>';
                            $block2 = '</strike>';
                        }
                        $data .= '<tr>\n\t\t\t<td>' . $block . $username . $block2 . '</td><td><center>' . $block . $player_idx[$ii] . $block2 . '</td><td><center>' . $block . $signtime . $block2 . '</td><td><center>' . $pop[$ii] . '</td><td><center>' . $num_rows . '</td>';
                    }
                } else {
                    $data = '<tr>\n\t\t\t<td class=\"noData\" colspan=\"6\">\n\t\t\t\tYou have not introduced a new player.\t\t\t<\/td>\n\t\t<\/tr>';
                }
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"html":"<table id=\"brought_in\" cellpadding=\"1\" cellspacing=\"1\">\n\t<thead>\n\t\t<tr>\n\t\t\t<td>Player Name<\/td>\n\t\t\t<td>Player ID<\/td>\n\t\t\t<td>Registration Date<\/td>\n\t\t\t<td>Population<\/td>\n\t\t\t<td>Villages<\/td>\n\t\t<\/tr>\n\t<\/thead>\n\n\t\t\t' . $data . '\n\t<\/table>"}}
				}';
                echo $str;
                break;
            case 'quest':
                if (isset($_POST['action'])) {
                    $qact = preg_replace("/[^a-zA-Z0-9_-]/", '', $_POST['action']);
                } else {
                    $qact = null;
                }
                if (isset($_POST['questTutorialId'])) {
                    $qact2 = preg_replace("/[^a-zA-Z0-9_-]/", '', $_POST['questTutorialId']);
                } else {
                    $qact2 = null;
                }

                // if (isset($_GET['qact3'])){$qact3=preg_replace("/[^a-zA-Z0-9_-]/",'',$_GET['qact3']);}else{$qact3=null;}
                include('Templates/Ajax/quest_core.php');
                break;
            case 'reportRightsGet':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"result":false,"right1":false,"right2":false,"right3":false,"right4":false,"description":""}}
				}';
                echo $str;
                break;
            case 'finishNowPopup':
                foreach ($building->buildArray as $jobs) {
                    $mid .= '<span>\n\t\t\t\t' . $building->procResType($jobs['type']) . '\t\t\t\t<\/span>';
                    $mid .= '\n\t\t\t\t\t\t\t\t\t<span class=\"lvl\">\n\t\t\t\t\tسطح ' . ($village->resarray['f' . $jobs['field']] + ($jobs['field'] == $BuildFirst ? 2 : 1)) . '\t\t\t\t\t<\/span>';
                }
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"html":"<div id=\"finishNowDialog\">\n<p>The following commands will be instantly completed:<\/p>\n\n<h5>Building instructions:<\/h5>\n<ul>\n\t\t\t\t<li >\n\t\t\t\t' . $mid . '\n\t\t\t\t\t\t\t<\/li>\n\t<\/ul>\n<div class=\"buttonWrapper\">\n\t<button  type=\"submit\" value=\"Redeem\" id=\"button5285fd1d3d67b\" class=\"gold \" title=\"Completion of construction and extend research to end.\" coins=\"' . $g_finish . '\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">' . $g_finish . '<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5285fd1d3d67b\'))\n\t{\n\t\t$(\'button5285fd1d3d67b\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Redeem\",\"name\":\"\",\"id\":\"button5285fd1d3d67b\",\"class\":\"gold \",\"title\":\"Completion of construction and extend research to end.\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":' . $g_finish . ',\"wayOfPayment\":{\"featureKey\":\"finishNow\",\"context\":\"\"}}]);\n\t\t});\n\t}\n\t});\n<\/script>\n<\/div>\n<\/div>"}}
				}';
                echo $str;
                break;
            case 'heroSetAttributes':
                // print_R($_POST);die;
                $prod = $_POST['resource'];
                // echo $prod;die;
                $res1 = $res2 = $res3 = $res4 = $res0 = 0;
                switch ($prod) {
                    case 0:
                        $res0 = 1;
                        break;
                    case 1:
                        $res1 = 1;
                        break;
                    case 2:
                        $res2 = 1;
                        break;
                    case 3:
                        $res3 = 1;
                        break;
                    case 4:
                        $res4 = 1;
                        break;
                }
                if ($_POST['attackBehaviour'] == "hide") {
                    $hide = 1;
                } else {
                    $hide = 0;
                }
                $array = $_POST['attributes'];
                $power = $array['power'];
                $offBonus = $array['offBonus'];
                $defBonus = $array['defBonus'];
                $prod_value = $array['productionPoints'];
                $total = $power + $offBonus + $defBonus + $prod_value;

                mysql_query("UPDATE " . TB_PREFIX . "hero set `points` = points-" . $total . ",`hide` ='" . $hide . "', `power` = `power` + '" . $power . "', `offBonus` = `offBonus`+ '" . $offBonus . "', `defBonus` = `defBonus` + '" . $defBonus . "',`r0` = '" . $res0 . "',`r1` = '" . $res1 . "',`r2` = '" . $res2 . "',`r3` = '" . $res3 . "',`r4` = '" . $res4 . "', `product`=product+'" . $prod_value . "' WHERE uid = " . $session->uid . "") or die(mysql_error());
                $str = '{
					response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
				}';
                echo $str;
                break;
            case 'tabFavorite';
                $str = ';{
					response: {"error":false,"errorMsg":null,"data":{"result":false,"success":true}}
				}';
                echo $str;
                break;
            case 'overlay':
                $_SESSION['done'][0] = 1;
                $_SESSION['interface'] = 1;
                $str = '{response: {"error":false,"errorMsg":null,"data":{"texts":{"defaultTitle":"به تراوین جدید خوش آمدید","defaultDescription":"نشانه گر موس خود را به قسمت های انتخاب شده حرکت دهید تا اطلاعات بیشتر در رابطه با آن قسمت نمایش داده شود.","closeLink":"این صفحه را ببند و به بازی ادامه بده.","mainPageTitle":"صفحه اصلی","mainPageDescription":"این صفحه اصلی بازی میباشد که در آن اخبار وجوایز اعلام میشود.","villageSwitchTitle":"تغییرنمایش دهکده","villageSwitchDescription":"توسط این بخش میتوانید به بخش ساختمان ها ومنابع برای ارتقا ومدریت آن ها رجوع کنید.","mainNavigationTitle":"مرور ویژه بازی","mainNavigationDescription":"<span class=\"important\">نقشه : در این قسمت دهکده شما و تمامی بازیکنان قابل مشاهده میباشد.<br \/>\r\n<span class=\"important\">آمار : بازیکنان واتحاد های در حال بازی و پیشرفت نشان داده میشود.<br \/>\r\n<span class=\"important\">گزارشات : گزارش های مربوط به حمله و تجارت شما در این قسمت مشاهده میشود.<br \/>\r\n<span class=\"important\">پیام : در این قسمت میتواند با بازیکنان دیگر ارتباط بر قرار کنید.","premiumFeaturesTitle":"خرید واستفاده از طلا","premiumFeaturesDescription":"در این قسمت میتواند سکه خریداری کنیدو از قابلیت های پلاس نیز استفاده کنید. کاربرد نقره در حراجی میباشد.","outOfGameTitle":"مدیریت","outOfGameDescription":"بخش های مورد استفاده بازی:<br \/>\r\n<span class=\"important\">\پروفایل:<\/span> تغییر مشخصات فردی.<br \/>\r\n<span class=\"important\">تنظیمات:<\/span> تنظیمات فنی و کلی اکانت<br \/>\r\n<span class=\"important\">فروم:<\/span>  فروم بازی تراوین.<br \/>\r\n<span class=\"important\">پاسخ ها:<\/span> صفحه سوالات وپاسخ های تراوین.<br \/>\r\n<span class=\"important\">رهنما:<\/span> راهنمایی آنلاین.<br \/>\r\n<span class=\"important\">خروج:<\/span> خارج شدن از اکانت.","villageResourcesTitle":"منابع داخل دهکده","منابع داخل دهکده":".<br \/>\r\n ","villageCropTitle":"گندم داخل دهکده","villageCropDescription":"<br \/>\r\n<br \/>\r\n","sidebarBoxAllianceTitle":"اتحاد شما","sidebarBoxAllianceDescription":"","sidebarBoxInfoboxTitle":"اعلانات","sidebarBoxInfoboxDescription":"","sidebarBoxLinklistTitle":"لینک ها","sidebarBoxLinklistDescription":"<br \/>\r\n","sidebarBoxActiveVillageTitle":"قسمت مربوط به دهکده فعلی","sidebarBoxActiveVillageDescription":"","sidebarBoxVillagelistTitle":"لیست دهکده ها","sidebarBoxVillagelistDescription":"","sidebarBoxQuestmasterTitle":"راهنما","sidebarBoxQuestmasterDescription":"","sidebarBoxPlusFutureTitle":"Plus Futures","sidebarBoxPlusFutureDescription":"","sidebarBoxTravianBankTitle":"Travian Bank System","sidebarBoxTravianBankDescription":"","sidebarBoxNewsTitle":"&#1575;&#1593;&#1604;&#1575;&#1606;&#1575;&#1578;","sidebarBoxNewsDescription":""}}}}';
                echo $str;
                break;
            case 'getLayoutButtonTitle':
                if ($_POST['buttonId'] == "adventureWhite") {
                    $time = mysql_fetch_assoc(mysql_query("SELECT `time` FROM " . TB_PREFIX . "adventure WHERE end = 0 and uid = " . $session->uid . " ORDER BY time ASC"));
                    $tot = mysql_fetch_array(mysql_query("SELECT COUNT(id) FROM " . TB_PREFIX . "adventure WHERE end = 0 and uid = " . $session->uid . ""));
                    $times = $generator->getTimeFormat($time['time'] - $_SERVER['REQUEST_TIME']);
                    $str = '{response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"&#1605;&#1575;&#1580;&#1585;&#1575;&#1580;&#1608;&#1740;&#1740;","newText":"&#1605;&#1575;&#1580;&#1585;&#1575;&#1580;&#1608;&#1740;&#1740; &#1607;&#1575;&#1740; &#1605;&#1608;&#1580;&#1608;&#1583; : ' . $tot[0] . '&lt;br \/&gt; &#1586;&#1605;&#1575;&#1606; &#1575;&#1578;&#1605;&#1575;&#1605; &#1605;&#1575;&#1580;&#1585;&#1575;&#1580;&#1608;&#1740;&#1740; &#1576;&#1593;&#1583;&#1740; &#1583;&#1585;' . $times . '","success":true}}}';

                } elseif ($_POST['buttonId'] == "embassyWhite") {
                    if ($building->getTypeLevel(18) == 0) {
                        $x = "&#1604;&#1591;&#1601;&#1575; &#1587;&#1601;&#1575;&#1585;&#1578; &#1578;&#1575;&#1587;&#1740;&#1587; &#1705;&#1606;&#1740;&#1583;.";
                        $str = '{
							response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"&#1587;&#1601;&#1575;&#1585;&#1578;","newText":"' . $x . '","success":true}}
						}';
                    } else {
                        $x = "";
                        $ci = mysql_fetch_array(mysql_query("SELECT COUNT(id) FROM " . TB_PREFIX . "ali_invite WHERE uid = " . $session->uid . ""));
                        $str = '{
							response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"&#1587;&#1601;&#1575;&#1585;&#1578;","newText":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1662;&#1740;&#1588;&#1606;&#1607;&#1575;&#1583; &#1607;&#1575;&#1740; &#1581;&#1585;&#1575;&#1580;&#1740; &#1588;&#1605;&#1575; : ' . $ci[0] . ' ' . $x . '","success":true}}
						}';
                    }
                } elseif ($_POST['buttonId'] == "auctionWhite") {
                    $sql = mysql_query("SELECT COUNT(id) FROM " . TB_PREFIX . "auction WHERE finish = 0 and uid = $session->uid");
                    $count = mysql_fetch_array($sql);
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"&#1581;&#1585;&#1575;&#1580;&#1740;","newText":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1662;&#1740;&#1588;&#1606;&#1607;&#1575;&#1583; &#1607;&#1575;&#1740; &#1581;&#1585;&#1575;&#1580;&#1740; &#1588;&#1605;&#1575; : ' . $count[0] . '","success":true}}
					}';
                    // {
                    // response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"Auctions","newText":"Auctions with maximum bid: 0&lt;br \/&gt;Auctions in which you got outbid: 0","success":true}}
// }
                } elseif ($_POST['buttonId'] == "marketWhite") {
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"بازار","newText":"تاجر آزاد: &lrm;&amp;#x202d;&amp;#x202d;&amp;#x202d;0&amp;#x202c;&amp;#x202c;\/&amp;#x202d;&amp;#x202d;1&amp;#x202c;&amp;#x202c;&amp;#x202c;&lrm;","success":true}}
					}';
                } elseif ($_POST['buttonId'] == "barracksWhite") {
                    $trainlist = $technology->getTrainingList(1);
                    $max = 0;
                    if (count($trainlist) > 0) {
                        foreach ($trainlist as $train) {
                            $max += $train['amt'];
                        }
                        $text = '' . $max . ' نیرو های در حال آموزش.';
                    } else {
                        $text = 'نیرویی در حال آموزش نیمباشد.';
                    }
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"به سربازخانه","newText":"' . $text . '","success":true}}
					}';
                } elseif ($_POST['buttonId'] == "stableWhite") {
                    $trainlist = $technology->getTrainingList(2);
                    $max = 0;
                    if (count($trainlist) > 0) {
                        foreach ($trainlist as $train) {
                            $max += $train['amt'];
                        }
                        $text = '' . $max . ' نیرو های در حال آموزش.';
                    } else {
                        $text = 'نیرویی در حال آموزش نیمباشد';
                    }
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"به اصطبل","newText":"' . $text . '","success":true}}
					}';
                } elseif ($_POST['buttonId'] == "workshopWhite") {
                    $trainlist = $technology->getTrainingList(3);
                    $max = 0;
                    if (count($trainlist) > 0) {
                        foreach ($trainlist as $train) {
                            $max += $train['amt'];
                        }
                        $text = '' . $max . ' نیرو های در حال آموزش.';
                    } else {
                        $text = 'نیرویی در حال آموزش نیمباشد';
                    }
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":false,"newTitle":"به کارگاه","newText":"' . $text . '","success":true}}
					}';
                }
                echo $str;
                break;
            case 'exchangeResources':
                // print_r($_POST);die;
                $total = round($village->awood) + round($village->aclay) + round($village->airon) + round($village->acrop);
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"html":"<div id=\"build\" class=\"exchangeResources\">\n\t<p class=\"npc_desc\">With trader NPC, you can Exchange the resources at your favorite warhouse.\r\n<br \/><br \/>\r\nOne source shows the first line. In the second line of your favorite type of Exchange resources can make selection. The third line shows the difference between the new and old sources<\/p>\n\n\t<input type=\"hidden\" name=\"t\" id=\"t\" value=\"3\" \/>\n\t<input type=\"hidden\" name=\"a\" id=\"a\" value=\"6\" \/>\n\t<input type=\"hidden\" name=\"c\" id=\"c\" value=\"07f\" \/>\n\n\t<table id=\"npc\" cellpadding=\"1\" cellspacing=\"1\">\n\t\t<thead>\n\t\t\t<tr>\n\t\t\t\t\t\t\t<td class=\"all\">\n\t\t\t\t\t<a href=\"#\" onclick=\"Travian.Game.Marketplace.ExchangeResources.fillup(0); return false;\"><img class=\"r1\" src=\"img\/x.gif\" alt=\"Lumber\" title=\"Lumber\" \/><\/a>\n\t\t\t\t\t<span id=\"org0\">' . round($village->awood) . '<\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t\t<td class=\"all\">\n\t\t\t\t\t<a href=\"#\" onclick=\"Travian.Game.Marketplace.ExchangeResources.fillup(1); return false;\"><img class=\"r2\" src=\"img\/x.gif\" alt=\"Clay\" title=\"Clay\" \/><\/a>\n\t\t\t\t\t<span id=\"org1\">' . round($village->aclay) . '<\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t\t<td class=\"all\">\n\t\t\t\t\t<a href=\"#\" onclick=\"Travian.Game.Marketplace.ExchangeResources.fillup(2); return false;\"><img class=\"r3\" src=\"img\/x.gif\" alt=\"Iron\" title=\"Iron\" \/><\/a>\n\t\t\t\t\t<span id=\"org2\">' . round($village->airon) . '<\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t\t<td class=\"all\">\n\t\t\t\t\t<a href=\"#\" onclick=\"Travian.Game.Marketplace.ExchangeResources.fillup(3); return false;\"><img class=\"r4\" src=\"img\/x.gif\" alt=\"Crop\" title=\"Crop\" \/><\/a>\n\t\t\t\t\t<span id=\"org3\">' . round($village->acrop) . '<\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t\t<td class=\"deco\"><\/td>\n\t\t\t\t<td class=\"sum\">Sum:&nbsp;<span id=\"org4\">' . $total . '<\/span><\/td>\n\t\t\t<\/tr>\n\t\t<\/thead>\n\t\t<tbody>\n\t\t\t<tr>\n\t\t\t\t\t\t<td class=\"sel\">\n\t\t\t\t\t<input class=\"text\" onkeyup=\"Travian.Game.Marketplace.ExchangeResources.calculateRest();\" name=\"m2[]\" id=\"m2[0]\" size=\"5\" maxlength=\"7\" value=\"' . $_POST['defaultValues']['r1'] . '\" \/>\n\t\t\t\t\t<input type=\"hidden\" name=\"m1[]\" id=\"m1[0]\" value=\"\" \/>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"sel\">\n\t\t\t\t\t<input class=\"text\" onkeyup=\"Travian.Game.Marketplace.ExchangeResources.calculateRest();\" name=\"m2[]\" id=\"m2[1]\" size=\"5\" maxlength=\"7\" value=\"' . $_POST['defaultValues']['r2'] . '\" \/>\n\t\t\t\t\t<input type=\"hidden\" name=\"m1[]\" id=\"m1[1]\" value=\"\" \/>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"sel\">\n\t\t\t\t\t<input class=\"text\" onkeyup=\"Travian.Game.Marketplace.ExchangeResources.calculateRest();\" name=\"m2[]\" id=\"m2[2]\" size=\"5\" maxlength=\"7\" value=\"' . $_POST['defaultValues']['r3'] . '\" \/>\n\t\t\t\t\t<input type=\"hidden\" name=\"m1[]\" id=\"m1[2]\" value=\"\" \/>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"sel\">\n\t\t\t\t\t<input class=\"text\" onkeyup=\"Travian.Game.Marketplace.ExchangeResources.calculateRest();\" name=\"m2[]\" id=\"m2[3]\" size=\"5\" maxlength=\"7\" value=\"' . $_POST['defaultValues']['r4'] . '\" \/>\n\t\t\t\t\t<input type=\"hidden\" name=\"m1[]\" id=\"m1[3]\" value=\"\" \/>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"deco\"><\/td>\n\t\t\t\t<td class=\"sum\">Sum:&nbsp;<span id=\"newsum\">0<\/span><\/td>\n\t\t\t<\/tr>\n\t\t\t<tr>\n\n\t\t\t\t\t\t<td class=\"rem numberDirectionRTL\">\n\t\t\t\t\t<span id=\"diff0\"><\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"rem numberDirectionRTL\">\n\t\t\t\t\t<span id=\"diff1\"><\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"rem numberDirectionRTL\">\n\t\t\t\t\t<span id=\"diff2\"><\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"rem numberDirectionRTL\">\n\t\t\t\t\t<span id=\"diff3\"><\/span>\n\t\t\t\t<\/td>\n\t\t\t\t\t\t<td class=\"deco\"><\/td>\n\t\t\t\t<td class=\"sum\">Rest:&nbsp;<span id=\"remain\">0<\/span><\/td>\n\t\t\t<\/tr>\n\t\t<\/tbody>\n\t<\/table>\n\t<p id=\"submitButton\" class=\"disableButtonHandler\"><button  type=\"submit\" value=\"Redeem\" id=\"npc_market_button\" class=\"gold \" title=\"Redeem now.\" coins=\"3\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Redeem<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">3<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'npc_market_button\'))\n\t{\n\t\t$(\'npc_market_button\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Redeem\",\"name\":\"\",\"id\":\"npc_market_button\",\"class\":\"gold \",\"title\":\"Redeem now.\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":3,\"wayOfPayment\":{\"featureKey\":\"marketplace\",\"context\":\"\",\"dataCallback\":\"returnInputValues\"}}]);\n\t\t});\n\t}\n\t});\n<\/script>\n<\/p>\n\t<p id=\"submitText\"><button  type=\"button\" value=\"Distribute remaining resources.\" id=\"button5308b67aa6c5c\" class=\"gold \" title=\"Distribute remaining resources.\" onclick=\"javascript:Travian.Game.Marketplace.ExchangeResources.portionOut();\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Distribute remaining resources.<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5308b67aa6c5c\'))\n\t{\n\t\t$(\'button5308b67aa6c5c\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Distribute remaining resources.\",\"name\":\"\",\"id\":\"button5308b67aa6c5c\",\"class\":\"gold \",\"title\":\"Distribute remaining resources.\",\"confirm\":\"\",\"onclick\":\"javascript:Travian.Game.Marketplace.ExchangeResources.portionOut();\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n<\/p>\n\t<script>\n\t\tTravian.Game.Marketplace.ExchangeResources.initialize(' . $village->maxstore . ',' . $village->maxcrop . ');\n\t\tTravian.Game.Marketplace.ExchangeResources.calculateRest();\n\n\t\tfunction returnInputValues()\n\t\t{\n\t\t    var inputFields = $$(\'form input\');\n\t\t    var returnObject = {};\n\n\t\t    Array.each(inputFields, function(element, index)\n\t\t    {\n\t\t\t    var name = element.get(\'id\');\n\t\t\t    var curObject = {};\n\t\t\t    curObject[name] = element.get(\'value\');\n\t\t\t    Object.append(returnObject, curObject);\n\t\t    });\n\n\t\t    return returnObject;\n\t\t}\n\t<\/script>\n<\/div>\n"}}
				}';
                echo $str;
                break;
            case 'infoboxSetReaded':
                $str = '{
					ajaxToken: null,
					response: {"error":false,"errorMsg":null,"data":{"html":""},"javascript":"Travian.WindowManager.getWindows().each(function($dialog){Travian.WindowManager.unregister($dialog);});"}
				}';
                echo $str;
                $str2 = '{
					ajaxToken: null,
					response: {"error":true,"errorMsg":"Token invalid","data":{"html":""}}
				}';
                break;
            case 'silverExchange':
                if ($session->is_sitter == 1) {
                    $setting = $database->getUsersetting($session->uid);
                    $who = $database->whoissitter($session->uid);
                    if ($who['whosit_sit'] == 1) {
                        $settings = $setting['sitter1_set_4'];
                    } else if ($who['whosit_sit'] == 2) {
                        $settings = $setting['sitter2_set_4'];
                    }
                }
                if (($settings == 1 || $session->is_sitter != 1)) {
                    $_POST['silver'] = $_POST['s'];
                    if (isset($_POST['silver']) && $session->silver >= $_POST['silver']) {
                        $silver = filter_var($_POST['silver'], FILTER_SANITIZE_NUMBER_INT);
                        $uid = $session->uid;
                        $silverz = $silver;
                        if (isset($_POST['silver']) && $_POST['silver'] != '') {
                            $silver = preg_replace('/\D/', '', $silver);
                            $silver = filter_var($silver, FILTER_SANITIZE_MAGIC_QUOTES);
                        }
                        if ($silver >= 200 && $silver <= $session->silver) {
                            $add = intval($silver / 200);
                            $sil = $add * 200;
                            $silvers = $sil;
                            $golds = $add;
                        }
                        $newgold = $session->gold + $golds;
                        $newsilver = $session->silver - $silvers;
                        $str = '{
							response: {"error":false,"errorMsg":null,"data":{"result":true,"type":"SilverToGold","silver":' . $_POST['silver'] . ',"gold":' . $golds . ',"oldSilver":"' . $session->silver . '","oldGold":"' . $session->gold . '","newSilver":' . $newsilver . ',"newGold":' . $newgold . ',"message":{"type":"info","message":"<img src=\"img\/x.gif\" class=\"silver\" alt=\"Silver\" title=\"Silver\" \/>' . $_POST['s'] . ' Changed To <img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\" title=\"Gold\" \/>' . $golds . '"}}}
						}';
                        //mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold +" . $golds . " WHERE id = '" . $uid . "'");
                        $database->modifyGold($session->uid, $golds, 1);
                        // mysql_query("UPDATE " . TB_PREFIX . "users SET silver = silver -" . $silvers . " WHERE id = '" . $uid . "'");
                        $database->setSilver($session->uid, $silvers, 0);
                        echo $str;
                    }
                }else{
                    $str = '{
                        response: {"error":true,"errorMsg":"You dont have Permision To Spend Gold!!"}
                    }';
                    echo $str;
                }
                break;
            case 'changeVillageName':
                include_once('GameEngine/Session.php');
                $_POST['name'] = join(' ', array_map('trim', explode(' ', $_POST['name'])));
                $search = array(chr(0xC2) . chr(0xA0), // c2a0; Alt+255; Alt+0160; Alt+511; Alt+99999999;
                    chr(0xC2) . chr(0x90), // c290; Alt+0144
                    chr(0xC2) . chr(0x9D), // cd9d; Alt+0157
                    chr(0xC2) . chr(0x81), // c281; Alt+0129
                    chr(0xC2) . chr(0x8D), // c28d; Alt+0141
                    chr(0xC2) . chr(0x8F), // c28f; Alt+0143
                    chr(0xC2) . chr(0xAD), // cdad; Alt+0173
                    chr(0xAD),
                    'fuck',
                    'multihunter',
                    'support',
                    'asshole',
                ); // Soft-Hyphen; AD
                $_POST['name'] = str_replace($search, "", $_POST['name']);
               // $_POST['name'] = str_replace("'", "\'", $_POST['name']);
                $_POST['name'] = join(' ', array_map('trim', explode(' ', $_POST['name'])));
                if ($_POST['name'] != $village->vname) {
                    if ($_POST['name'] != null && $_POST['name'] != '' && $_POST['name'] != ' ' && strlen($_POST['name']) > 0) {
                        $q = "UPDATE " . TB_PREFIX . "vdata SET name = '" . $_POST['name'] . "' where `wref` = '" . $_SESSION['wid'] . "'";
                    } else {
                        $str = '{
							response: {"error":true,"errorMsg":"&#1606;&#1575;&#1605; &#1583;&#1607;&#1705;&#1583;&#1607; &#1578;&#1594;&#1740;&#1740;&#1585; &#1606;&#1705;&#1585;&#1583;","data":[]}
						}';
                        echo $str;
                        break;
                    }
                    if (mysql_query($q)) {
                        $str = '{
							response: {"error":false,"errorMsg":"&#1606;&#1575;&#1605; &#1583;&#1607;&#1705;&#1583;&#1607; &#1578;&#1594;&#1740;&#1740;&#1585; &#1705;&#1585;&#1583;","data":{"name":"' . $_POST['name'] . '"}}
						}';
                        echo $str;
                    }
                } else {
                    $str = '{
						response: {"error":false,"errorMsg":"&#1606;&#1575;&#1605; &#1583;&#1607;&#1705;&#1583;&#1607; &#1578;&#1594;&#1740;&#1740;&#1585; &#1606;&#1705;&#1585;&#1583;","data":{"name":' . $_POST['name'] . '}}
					}';
                    echo $str;
                }
                break;
            case 'paymentWizard':
                include('Templates/Ajax/paymentWizard.tpl');
                break;
            case 'paymentWizardOpenOffers':
                // include 'paypal/packages.php';
                $query = mysql_query("SELECT * from " . TB_PREFIX . "transactions WHERE playerId = " . $session->uid);
                if (mysql_num_rows($query) > 0) {
                    while ($row = mysql_fetch_assoc($query)) {
                        $time = date('m/d/Y', $row['time']);
                        // if ($row['Status'] == "Failed") $row['Status'] = "<font color=red>" . $row['Status'] . "</font>";
                        $data .= '<tbody>\n\t\t\t\t\t<tr>\n\t\t\t\t<td>' . $time . '<\/td><td>' . $row['orderid'] . '<\/td><td>-<\/td><td>-<\/td><td>' . $row['amount'] . '<\/td><td>' . $row['gold'] . '<\/td>\n\t\t\t<\/tr>\n\t\t\t\t<\/tbody>';
                    }
                } else {
                    $data = '<tbody>\n\t\t\t\t\t<tr>\n\t\t\t\t<td colspan=\"6\" class=\"noData\">No open orders.<\/td>\n\t\t\t<\/tr>\n\t\t\t\t<\/tbody>';
                }
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"noResult":false,"html":"<h4>Orders open<\/h4>\n\t<table cellpadding=\"1\" cellspacing=\"1\" id=\"open_orders\" class=\" lang_ltr\">\n\t\t<thead>\n\t\t\t<tr>\n\t\t\t\t<th>Date of Order<\/th>\n\t\t\t\t<th>Order ID<\/th>\n\t\t\t\t<th>Booking<\/th>\n\t\t\t\t<th>Presenter<\/th>\n\t\t\t\t<th>Amount<\/th>\n\t\t\t\t<th>Gold<\/th>\n\t\t\t<\/tr>\n\t\t<\/thead>\n\t\t' . $data . '\n\t<\/table>\n"}}
				}';
                echo $str;
                break;
            case 'plusPopup':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"title":"Travian Plus","gold":"Gold: <img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\"\/> <span class=\"bold\">' . $P_GOLD . '<\/span>","subHeadLine":"For use this feature you need active plus","goldButton":"<button  type=\"button\" value=\"Activation of Travian Plus.\" id=\"button5280f31c3201e\" class=\"gold \" title=\"Active just now <br> &#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\" coins=\"10\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Activation of Travian Plus.<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">10<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f31c3201e\'))\n\t{\n\t\t$(\'button5280f31c3201e\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation of Travian Plus.\",\"name\":\"\",\"id\":\"button5280f31c3201e\",\"class\":\"gold \",\"title\":\"Active just now \\u003Cbr\\u003E &#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":10}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7 <span class=\"bold\"><\/span>","plusPopupButtonExtraFeatures":"In addition, you will have access to the following features:","features":{"attackWarning":{"title":"Attack Warning","text":"Entries  Attack will be displayed in the list of attacks on villages."},"buildingQueue":{"title":"Building Queue","text":"Queue structure which allows you to have a queue order further construction."},"directLinks":{"title":"Direct Link","text":"A direct link To the market, barracks, stables and workshops, as well as additional important information."},"linkList":{"title":"Link List","text":"Allow free use of the links is defined by you, which allows you easily to any page with a simple click on the screen where you want to go play."},"villageStatistics":{"title":"Village overview","text":" Overview of production, stocks, Culture and soldiers for all villages"},"fullScreen":{"title":"Large map","text":"For a better overview, the map can be used to cover the whole screen and displays a larger area developed."},"tradeMulti":{"title":"Traders are able to do 2 Trucking","text":"Traders can operate automatically deliver resources for a second time to repeat."}},"furtherInfos":"Travian Plus features up to 7 days that you can activate at any time during 7 days from the time change. Added, if you have to choose automatic to be 1 the day to check out the functionality will be added to Gold deducted . For more information click on (i) button.."}}
				}';
                echo $str;
                break;
            case 'adventureBuyDialog':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"title":"Buy Adventure Panel","gold":"Gold: <img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\"\/> <span class=\"bold\">' . $P_GOLD . '<\/span>","productionBoostChooseText":"","features":{"productionBoostWood":{"title":"Buy 1 adventure","subtitle":"","subtitleClassExtension":"bonusEndsSoon","button":"<button  type=\"button\" value=\"Activation\" id=\"button5280f45b147c1z\" class=\"gold productionBoostButton wood\" title=\"\" coins=\"1\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">1<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f45b147c1z\'))\n\t{\n\t\t$(\'button5280f45b147c1z\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation\",\"name\":\"\",\"id\":\"button5280f45b147c1z\",\"class\":\"gold productionBoostButton wood\",\"title\":\"Activation now\\u0026lt;br\\\/\\u0026gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":1}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":""}},"furtherInfos":""}}
				}';
                echo $str;
                break;
            case 'premiumFeature':
                if ($session->is_sitter == 1) {
                    $setting = $database->getUsersetting($session->uid);
                    $who = $database->whoissitter($session->uid);
                    if ($who['whosit_sit'] == 1) {
                        $settings = $setting['sitter1_set_4'];
                    } else if ($who['whosit_sit'] == 2) {
                        $settings = $setting['sitter2_set_4'];
                    }
                }
                if (($settings == 1 || $session->is_sitter != 1)) {
                    if (isset($_POST['featureKey']) && $_POST['featureKey'] == "plus") {
                        if ($session->gold >= 10) {
                            $total = $golds['plus'] + PLUS_TIME;
                            if ($golds['plus'] == 0 || $golds['plus'] <= time()) {
                                mysql_query("UPDATE " . TB_PREFIX . "users set plus = " . $_SERVER['REQUEST_TIME'] . "+" . PLUS_TIME . " where `username`='" . $session->username . "'");
                            } else {
                                mysql_query("UPDATE " . TB_PREFIX . "users set plus = plus + " . PLUS_TIME . " where `username`='" . $session->username . "'");
                            }
                            // mysql_query("UPDATE " . TB_PREFIX . "users set gold = gold - ".g_plus." where `username` = '" . $session->username . "'");
                            $database->modifyGold($session->uid, g_plus, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 10) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_plus." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    &#1587;&#1705;&#1607; &#1591;&#1604;&#1575;&#1740; &#1705;&#1575;&#1601;&#1740; &#1576;&#1585;&#1575;&#1740; &#1575;&#1740;&#1606; &#1711;&#1586;&#1740;&#1606;&#1607; &#1606;&#1583;&#1575;&#1585;&#1740;&#1583;!   <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Select a Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        &#1581;&#1575;&#1604;&#1575; &#1582;&#1585;&#1740;&#1583; &#1705;&#1606;&#1567;   <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Select a payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1582;&#1585;&#1740;&#1583; &#1587;&#1705;&#1607;<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Package selection of other    <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "productionboostWood") {
                        if ($session->gold >= 5) {
                            if ($golds['b1'] == 0) {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b1 = " . $_SERVER['REQUEST_TIME'] . "+" . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            } else {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b1 = b1 + " . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            }
                            // mysql_query("UPDATE " . TB_PREFIX . "users set gold = gold - ".g_wood." where `username` = '" . $session->username . "'");
                            $database->modifyGold($session->uid, g_wood, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 5) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_wood." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Package Other    <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "productionboostClay") {
                        if ($session->gold >= 5) {
                            if ($golds['b2'] == 0) {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b2 = " . $_SERVER['REQUEST_TIME'] . "+" . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            } else {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b2 = b2 + " . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            }
                            // mysql_query("UPDATE " . TB_PREFIX . "users set gold = gold - ".g_clay." where `username` = '" . $session->username . "'");
                            $database->modifyGold($session->uid, g_clay, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 5) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = bought - ".g_clay." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        &#1575;&#1606;&#1578;&#1582;&#1575;&#1576; &#1576;&#1587;&#1578;&#1607; &#1583;&#1740;&#1711;&#1585;     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                        // $str = "DONE Clay";
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "productionboostIron") {
                        if ($session->gold >= 5) {
                            if ($golds['b3'] == 0) {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b3 = " . $_SERVER['REQUEST_TIME'] . "+" . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            } else {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b3 = b3 + " . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            }
                            // mysql_query("UPDATE " . TB_PREFIX . "users set gold = gold - ".g_iron." where `username` = '" . $session->username . "'");
                            $database->modifyGold($session->uid, g_iron, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 5) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_iron." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "productionboostCrop") {
                        if ($session->gold >= 5) {
                            if ($golds['b4'] == 0) {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b4 = " . $_SERVER['REQUEST_TIME'] . "+" . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            } else {
                                mysql_query("UPDATE " . TB_PREFIX . "users set b4 = b4 + " . PLUS_PRODUCTION . " where `username`='" . $session->username . "'");
                            }
                            // mysql_query("UPDATE " . TB_PREFIX . "users set gold = gold - ".g_crop." where `username` = '" . $session->username . "'");
                            $database->modifyGold($session->uid, g_crop, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 5) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_crop." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "goldclub") {
                        if ($session->gold >= 100) {
                            mysql_query("UPDATE " . TB_PREFIX . "users set goldclub = 1 where `username`='" . $session->username . "'");
                            $database->modifyGold($session->uid, g_club, 0);
                            // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                            // if ($buyg >= 100) {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_club." where `username` = '" . $session->username . "'");
                            // } else {
                            // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                            // }
                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"7699\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"/img\/products\/Travian_Facelift_2.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'7699\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "finishNow") {
                        if ($session->gold >= 2) {
                            // global $database,$session,$logging,$village,$bid18,$bid10,$bid11,$technology,$_SESSION;
                            if ($session->access != BANNED) {
                                $ww = 1;
                                $finish = 0;
                                $finished = 0;
                                foreach ($building->buildArray as $jobs) {
                                    if ($jobs['type'] != 25 && $jobs['type'] != 26) {
                                        // $database->modifyGold($session->uid,2,0);
                                        if ($jobs['wid'] == $village->wid) {
                                            $wwvillage = $database->getResourceLevel($jobs['wid']);
                                            if ($wwvillage['f99t'] != 40) {
                                                $level = $jobs['level'];
                                                if ($jobs['type'] != 25 AND $jobs['type'] != 26 AND $jobs['type'] != 40) {
                                                    // $database->modifyGold($session->uid, g_finish, 0);
                                                    $finished = 1;
                                                    if ($finish == 0) {

                                                        // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                                                        // if ($buyg >= 10) {
                                                        // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - ".g_finish." where `username` = '" . $session->username . "'");
                                                        // } else {
                                                        // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                                                        // }
                                                        $_SESSION['finishAll'] = 1;
                                                        $_SESSION['done'][0] = 1;
                                                    }
                                                    $resource = $building->resourceRequired($jobs['field'], $jobs['type']);
                                                    if ($jobs['master'] == 0) {
                                                        $q = "UPDATE " . TB_PREFIX . "fdata set f" . $jobs['field'] . " = " . $jobs['level'] . ", f" . $jobs['field'] . "t = " . $jobs['type'] . " where vref = " . $jobs['wid'];
                                                    } else {
                                                        $query = mysql_query('SELECT `gold` FROM ' . TB_PREFIX . 'users WHERE id=' . $session->uid . ' LIMIT 1');
                                                        $mygold = mysql_fetch_assoc($query);
                                                        if ($mygold['gold'] >= 1) {
                                                            $villwood = $database->getVillageField($jobs['wid'], 'wood');
                                                            $villclay = $database->getVillageField($jobs['wid'], 'clay');
                                                            $villiron = $database->getVillageField($jobs['wid'], 'iron');
                                                            $villcrop = $database->getVillageField($jobs['wid'], 'crop');
                                                            $type = $jobs['type'];
                                                            $buildarray = $GLOBALS['bid' . $type];
                                                            $buildwood = $buildarray[$level]['wood'];
                                                            $buildclay = $buildarray[$level]['clay'];
                                                            $buildiron = $buildarray[$level]['iron'];
                                                            $buildcrop = $buildarray[$level]['crop'];
                                                            if ($buildwood < $villwood && $buildclay < $villclay && $buildiron < $villiron && $buildcrop < $villcrop) {
                                                                // $newgold = $session->gold-1;
                                                                // $database->updateUserField($session->uid, 'gold', $newgold, 1);
                                                                $database->modifyGold($session->uid, 1, 0);
                                                                // $buyg = mysql_query("SELECT `boughtgold` FROM " . TB_PREFIX . "users `username` = '" . $session->username . "' LIMIT 1");
                                                                // if ($buyg >= 10) {
                                                                // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = boughtgold - 1 where `username` = '" . $session->username . "'");
                                                                // } else {
                                                                // mysql_query("UPDATE " . TB_PREFIX . "users set boughtgold = 0 where `username` = '" . $session->username . "'");
                                                                // }
                                                                $enought_res = 1;
                                                                $q = "UPDATE " . TB_PREFIX . "fdata set f" . $jobs['field'] . " = " . $jobs['level'] . ", f" . $jobs['field'] . "t = " . $jobs['type'] . " where vref = " . $jobs['wid'];
                                                            }
                                                        }
                                                    }
                                                    if ($database->query($q) && ($enought_res == 1 or $jobs['master'] == 0)) {
                                                        $database->modifyPop($jobs['wid'], $resource['pop'], 0);
                                                        $database->addCP($jobs['wid'], $resource['cp']);
                                                        $database->query("DELETE FROM " . TB_PREFIX . "bdata where id = " . $jobs['id'] . "");
                                                        if ($jobs['type'] == 18) {
                                                            $owner = $database->getVillageField($jobs['wid'], 'owner');
                                                            $max = $bid18[$level]['attri'];
                                                            $database->query("UPDATE " . TB_PREFIX . "alidata set max = $max where leader = $owner");
                                                        }
                                                    }
                                                    if (($jobs['field'] >= 19 && ($session->tribe == 1 || ALLOW_ALL_TRIBE)) || (!ALLOW_ALL_TRIBE && $session->tribe != 1)) {
                                                        $innertimestamp = $jobs['timestamp'];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    $finish = 1;
                                }
                                if ($finished == 1) $database->modifyGold($session->uid, g_finish, 0);

                                $wwvillage1 = $database->getResourceLevel($village->wid);
                                if ($wwvillage1['f99t'] != 40) {
                                    $ww = 0;
                                }
                                if ($ww == 0) {
                                    $database->finishDemolition($village->wid);
                                    $technology->finishTech();
                                    $logging->goldFinLog($village->wid);
                                    $stillbuildingarray = $database->getJobs($village->wid);
                                    if (count($stillbuildingarray) == 1) {
                                        if ($stillbuildingarray[0]['loopcon'] == 1) {
                                            $q = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,timestamp=" . ($_SERVER['REQUEST_TIME'] + $stillbuildingarray[0]['timestamp'] - $innertimestamp) . " WHERE id=" . $stillbuildingarray[0]['id'] . " and master = 0";
                                            $database->query($q);
                                        }
                                    }
                                }
                                $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                            } else {
                                header('Location: banned.php');
                                exit;
                            }
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "marketplace") {
                        if ($session->userinfo['gold'] >= 3) {
                            // kijken of ze niet meer gs invoeren dan ze hebben
                            if (($_POST['m2'][0] + $_POST['m2'][1] + $_POST['m2'][2] + $_POST['m2'][3]) <= (round($village->awood) + round($village->aclay) + round($village->airon) + round($village->acrop))) {
                                $database->setVillageField($village->wid, 'wood', $_POST['m2'][0]);
                                $database->setVillageField($village->wid, 'clay', $_POST['m2'][1]);
                                $database->setVillageField($village->wid, 'iron', $_POST['m2'][2]);
                                $database->setVillageField($village->wid, 'crop', $_POST['m2'][3]);
                                $database->modifyGold($session->uid, 3, 0);
                            }
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"0\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'0\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "exchangeSilver") {
                        if (isset($_POST['coins']) && $session->gold >= $_POST['coins']) {
                            $_POST['gold'] = $_POST['coins'];
                            $gold = filter_var($_POST['gold'], FILTER_SANITIZE_NUMBER_INT);
                            $uid = $session->uid;
                            if (isset($_POST['gold']) && $_POST['gold'] != '') {
                                $gold = preg_replace('/\D/', '', $gold);
                                $gold = filter_var($gold, FILTER_SANITIZE_MAGIC_QUOTES);
                            }
                            if ($gold >= 1 || $Cgold == $gold) {
                                $silvers = $gold * 100;
                                $golds = $gold;
                            }
                            $newgold = $session->gold - $golds;
                            $newsilver = $session->silver + $silvers;
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"showFinishedExchangeGoldToSilver","options":{"oldSilver":' . $session->silver . ',"oldGold":' . $session->gold . ',"newSilver":' . $newsilver . ',"newGold":' . $newgold . ',"result":true,"message":{"type":"info","message":"<img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\" title=\"Gold\" \/>' . $golds . ' changed to <img src=\"img\/x.gif\" class=\"silver\" alt=\"Silver\" title=\"Silver\" \/>' . $silvers . '"}},"context":17}}
						}';
                            $database->modifyGold($session->uid, $golds, 0);
                            $database->setSilver($session->uid, $silvers, 1);
                            // mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold -" . $golds . " WHERE id = '" . $uid . "'");
                            // mysql_query("UPDATE " . TB_PREFIX . "users SET silver = silver +" . $silvers . " WHERE id = '" . $uid . "'");
                        }
                    } elseif (isset($_POST['featureKey']) && $_POST['featureKey'] == "adventureBuyDialog") {
                        if ($session->gold >= 1) {
                            $database->modifyGold($session->uid, 1, 0);
                            $herodetail = $database->getHero($session->uid);
                            $aday = max(86400 / SPEED, 450);
                            $tenday = max(43200 / SPEED, 1800);
                            if ($herodetail['lastadv'] <= $time - $tenday) $herodetail['lastadv'] = $time - $tenday + $aday;
                            $endat = $herodetail['lastadv'] + $tenday;
                            $dif = rand(0, 3);
                            $database->addAdventure($database->getVFH($herodetail['uid']), $herodetail['uid'], $endat, $dif);

                            $str = '{
							response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
						}';
                        } else {
                            $str = '{
							response: {"error":false,"errorMsg":null,"data":{"functionToCall":"renderDialog","options":{"dialogOptions":{"infoIcon":null,"saveOnUnload":false,"draggable":false,"buttonOk":false,"context":"smallestPackage"},"html":"\n<div id=\"smallestPackageDialog\">\n    To use this feature, you do not have enough Gold!    <div id=\"smallestPackageData\">\n        <div class=\"goldProduct\" title=\"Selection Package\">\n\t<input type=\"hidden\" class=\"goldProductId\" value=\"7699\" \/>\n\t<div class=\"goldProductContentWrapper\">\n\t\t<div class=\"goldProductImageWrapper\">\n\t\t\t<img src=\"img\/products\/Travian_Facelift_1' . $more . '.png\" width=\"100\" height=\"114\" alt=\"' . $packages[0]["title"] . '\" \/>\n\t\t<\/div>\n\t\t<div class=\"goldProductTextWrapper\">\n\t\t\t<div class=\"goldUnits\">' . $packages[0]["gold"] . '<\/div>\n\t\t\t<div class=\"goldUnitsTypeText\">Gold<\/div>\t\t\t<div class=\"footerLine\"><span class=\"price\">' . $packages[0]["price"] . '&nbspUSD&nbsp;*<\/span><\/div>\n\t\t<\/div>\n\t<\/div>\n<\/div>    <\/div>\n    <span class=\"boughtgoldQuestion\">\n        Do you want buy ?    <\/span>\n    <div>\n        <button  type=\"submit\" value=\"Purchase gold\" id=\"button5282219e075b2\" class=\"green \" title=\"Selection payment option\" onclick=\"openPaymentWizard(true); return false;\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">Buy Gold<\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5282219e075b2\'))\n\t{\n\t\t$(\'button5282219e075b2\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"submit\",\"value\":\"Purchase gold\",\"name\":\"\",\"id\":\"button5282219e075b2\",\"class\":\"green \",\"title\":\"Choose payment option\",\"confirm\":\"\",\"onclick\":\"openPaymentWizard(true); return false;\"}]);\n\t\t});\n\t}\n\t});\n<\/script>\n    <\/div>\n    <a class=\"changeGold' . $packages[0]["title"] . 'rrow\" href=\"#\" onclick=\"openPaymentWizard(false); return false;\">\n        Selection Other Package     <\/a>\n    <script>\n\n        function openPaymentWizard(withPackage) {\n            var options = {callback: \'reloadDialog\'};\n            if (withPackage) {\n                options = Object.merge(options, {goldProductId: \'7699\'});\n            }\n            Travian.Game.WayOfPaymentEventListener.WayOfPaymentObject.openPaymentWizard(options);\n        }\n    <\/script>\n<\/div>"}}}
						}';
                        }
                    }

                    echo $str;
                }else{
                    $str = '{
                        response: {"error":true,"errorMsg":"You dont have Permision To Spend Gold!!"}
                    }';
                    echo $str;
                }
                break;
            case 'productionBoostPopup':
                $MyGold = mysql_query("SELECT `b1`,`b2`,`b3`,`b4` FROM " . TB_PREFIX . "users WHERE `username`='" . $session->username . "'") or die(mysql_error());
                $golds = mysql_fetch_array($MyGold);
                if ($golds['b1'] <= $_SERVER['REQUEST_TIME']) {
                    mysql_query("UPDATE " . TB_PREFIX . "users set b1 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
                }
                if ($golds['b2'] <= $_SERVER['REQUEST_TIME']) {
                    mysql_query("UPDATE " . TB_PREFIX . "users set b2 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
                }
                if ($golds['b3'] <= $_SERVER['REQUEST_TIME']) {
                    mysql_query("UPDATE " . TB_PREFIX . "users set b3 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
                }
                if ($golds['b4'] <= $_SERVER['REQUEST_TIME']) {
                    mysql_query("UPDATE " . TB_PREFIX . "users set b4 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
                }
                if ($golds['b1'] > $_SERVER['REQUEST_TIME']) {
                    $exp2 = $generator->getTimeFormat($golds['b1'] - $_SERVER['REQUEST_TIME']);
                    $ACTIVE_WOOD = '&#1586;&#1605;&#1575;&#1606; &#1575;&#1578;&#1605;&#1575;&#1605; &#1583;&#1585; ' . $exp2 . '';
                }
                if ($golds['b2'] > $_SERVER['REQUEST_TIME']) {
                    $exp3 = $generator->getTimeFormat($golds['b2'] - $_SERVER['REQUEST_TIME']);
                    $ACTIVE_CLAY = '&#1586;&#1605;&#1575;&#1606; &#1575;&#1578;&#1605;&#1575;&#1605; &#1583;&#1585; ' . $exp3 . '';
                }
                if ($golds['b3'] > $_SERVER['REQUEST_TIME']) {
                    $exp4 = $generator->getTimeFormat($golds['b3'] - $_SERVER['REQUEST_TIME']);
                    $ACTIVE_IRON = '&#1586;&#1605;&#1575;&#1606; &#1575;&#1578;&#1605;&#1575;&#1605; &#1583;&#1585; ' . $exp4 . '';
                }
                if ($golds['b4'] > $_SERVER['REQUEST_TIME']) {
                    $exp5 = $generator->getTimeFormat($golds['b4'] - $_SERVER['REQUEST_TIME']);
                    $ACTIVE_CROP = '&#1586;&#1605;&#1575;&#1606; &#1575;&#1578;&#1605;&#1575;&#1605; &#1583;&#1585; ' . $exp5 . '';
                }
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"title":"&#1578;&#1608;&#1604;&#1740;&#1583;&#1575;&#1578; &#1662;&#1604;&#1575;&#1587;","gold":"&#1587;&#1705;&#1607; &#1591;&#1604;&#1575;: <img src=\"img\/x.gif\" class=\"gold\" alt=\"Gold\"\/> <span class=\"bold\">' . $P_GOLD . '<\/span>","productionBoostChooseText":"&#1576;&#1587;&#1578;&#1607; &#1605;&#1608;&#1585;&#1583; &#1606;&#1592;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1575;&#1606;&#1578;&#1582;&#1575;&#1576; &#1705;&#1606;&#1740;&#1583;:","features":{"productionBoostWood":{"title":"&#8206;&#8237;+&#8237;25&#8236;%&#8236;&#8206; &#1578;&#1608;&#1604;&#1740;&#1583; &#1670;&#1608;&#1576; &#1576;&#1740;&#1588;&#1578;&#1585;","subtitle":"' . $ACTIVE_WOOD . '","subtitleClassExtension":"bonusEndsSoon","button":"<button  type=\"button\" value=\"Activation\" id=\"button5280f45b147c1\" class=\"gold productionBoostButton wood\" title=\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;&lt;br\/&gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\" coins=\"5\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">5<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f45b147c1\'))\n\t{\n\t\t$(\'button5280f45b147c1\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation\",\"name\":\"\",\"id\":\"button5280f45b147c1\",\"class\":\"gold productionBoostButton wood\",\"title\":\"Activation now\\u0026lt;br\\\/\\u0026gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7: 7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":5}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7 <span class=\"bold\"><\/span>"},"productionBoostClay":{"title":"&#8206;&#8237;+&#8237;25&#8236;%&#8236;&#8206; &#1578;&#1608;&#1604;&#1740;&#1583; &#1582;&#1588;&#1578; &#1576;&#1740;&#1588;&#1578;&#1585;","subtitle":"' . $ACTIVE_CLAY . '","subtitleClassExtension":"bonusEndsSoon","button":"<button  type=\"button\" value=\"Activation\" id=\"button5280f45b152e5\" class=\"gold productionBoostButton clay\" title=\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now&lt;br\/&gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\" coins=\"5\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">5<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f45b152e5\'))\n\t{\n\t\t$(\'button5280f45b152e5\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation\",\"name\":\"\",\"id\":\"button5280f45b152e5\",\"class\":\"gold productionBoostButton clay\",\"title\":\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now\\u0026lt;br\\\/\\u0026gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":5}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7 <span class=\"bold\"><\/span>"},"productionBoostIron":{"title":"&#8206;&#8237;+&#8237;25&#8236;%&#8236;&#8206; &#1578;&#1608;&#1604;&#1740;&#1583; &#1570;&#1607;&#1606; &#1576;&#1740;&#1588;&#1578;&#1585;","subtitle":"' . $ACTIVE_IRON . '","subtitleClassExtension":"bonusEndsSoon","button":"<button  type=\"button\" value=\"Activation\" id=\"button5280f45b15be3\" class=\"gold productionBoostButton iron\" title=\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now&lt;br\/&gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\" coins=\"5\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">5<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f45b15be3\'))\n\t{\n\t\t$(\'button5280f45b15be3\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation\",\"name\":\"\",\"id\":\"button5280f45b15be3\",\"class\":\"gold productionBoostButton iron\",\"title\":\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now\\u0026lt;br\\\/\\u0026gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":5}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7<span class=\"bold\"><\/span>"},"productionBoostCrop":{"title":"&#8206;&#8237;+&#8237;25&#8236;%&#8236;&#8206; &#1578;&#1608;&#1604;&#1740;&#1583; &#1711;&#1606;&#1583;&#1605; &#1576;&#1740;&#1588;&#1578;&#1585;","subtitle":"' . $ACTIVE_CROP . '","subtitleClassExtension":"bonusEndsSoon","button":"<button  type=\"button\" value=\"Activation\" id=\"button5280f45b16407\" class=\"gold productionBoostButton crop\" title=\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now&lt;br\/&gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\" coins=\"5\">\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\">&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740;<img src=\"img\/x.gif\" class=\"goldIcon\" alt=\"\" \/><span class=\"goldValue\">5<\/span><\/div>\n\t<\/div>\n<\/button>\n<script type=\"text\/javascript\">\n\twindow.addEvent(\'domready\', function()\n\t{\n\tif($(\'button5280f45b16407\'))\n\t{\n\t\t$(\'button5280f45b16407\').addEvent(\'click\', function ()\n\t\t{\n\t\t\twindow.fireEvent(\'buttonClicked\', [this, {\"type\":\"button\",\"value\":\"Activation\",\"name\":\"\",\"id\":\"button5280f45b16407\",\"class\":\"gold productionBoostButton crop\",\"title\":\"&#1601;&#1593;&#1575;&#1604; &#1587;&#1575;&#1586;&#1740; now\\u0026lt;br\\\/\\u0026gt;&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":5}]);\n\t\t});\n\t}\n\t});\n<\/script>\n","buttonSubtitle":"&#1578;&#1593;&#1583;&#1575;&#1583; &#1585;&#1608;&#1586; &#1601;&#1593;&#1575;&#1604; :7 <span class=\"bold\"><\/span>"}},"furtherInfos":"&#1578;&#1608;&#1604;&#1740;&#1583;&#1575;&#1578; &#1662;&#1604;&#1575;&#1587; &#1576;&#1575;&#1593;&#1579; &#1575;&#1601;&#1586;&#1575;&#1740;&#1588; &#1578;&#1608;&#1604;&#1740;&#1583; &#1605;&#1606;&#1575;&#1576;&#1593; &#1583;&#1607;&#1705;&#1583;&#1607; &#1607;&#1575;&#1740; &#1588;&#1605;&#1575; &#1583;&#1585; &#1591;&#1608;&#1604; &#1740;&#1705; &#1586;&#1605;&#1575;&#1606; &#1605;&#1581;&#1583;&#1608;&#1583; &#1605;&#1740;&#1576;&#1575;&#1588;&#1583; &#1705;&#1607; &#1576;&#1575;&#1593;&#1579; &#1575;&#1601;&#1586;&#1575;&#1740;&#1588; 25% &#1578;&#1608;&#1604;&#1740;&#1583;&#1575;&#1578; &#1588;&#1605;&#1575; &#1582;&#1608;&#1575;&#1607;&#1583; &#1588;&#1583;. &#1575;&#1711;&#1585; &#1588;&#1605;&#1575; &#1740;&#1705; &#1576;&#1587;&#1578;&#1607; &#1585;&#1575; &#1575;&#1606;&#1578;&#1582;&#1575;&#1576; &#1608; &#1601;&#1593;&#1575;&#1604;&#1587;&#1575;&#1586;&#1740; &#1705;&#1606;&#1740;&#1583; &#1662;&#1587; &#1575;&#1586; &#1605;&#1583;&#1578; &#1578;&#1593;&#1740;&#1740;&#1606; &#1588;&#1583;&#1607; &#1575;&#1593;&#1578;&#1576;&#1575;&#1585; &#1588;&#1605;&#1575; &#1576;&#1607; &#1662;&#1575;&#1740;&#1575;&#1606; &#1582;&#1608;&#1575;&#1607;&#1583; &#1585;&#1587;&#1740;&#1583; &#1608; &#1576;&#1585;&#1575;&#1740; &#1575;&#1601;&#1586;&#1575;&#1740;&#1588; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1576;&#1575;&#1740;&#1583; &#1578;&#1605;&#1583;&#1740;&#1583; &#1705;&#1606;&#1740;&#1583;."}}
				}';
                echo $str;
                break;
            case 'News':
                $newsid = $_POST['id'];
                $t1 = trim(file_get_contents("Templates/News/newsbox" . $newsid . ".tpl"));

$t1 = str_replace('%PLAYER%', $_COOKIE['COOKUSR'], $t1);

                $t1 = str_replace('
', '<br />', $t1);
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"html":"' . $t1 . '"}}
				}';
                echo $str;
                break;
            case 'bb':
                $string = str_replace("\n\n", "<br />", $_POST['text']);
                $string = str_replace("\n", "<br />", $_POST['text']);
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"text":"' . $string . '","target":"message"}}
				}';
                echo $str;
                break;
            case 'ignoreList':
                if ($_POST['method'] == "render_ignore_list") {
                    $z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $session->uid . "'") or die(mysql_error());
                    $z = mysql_fetch_assoc($z);
                    $dataarray = explode(',', $z['ignore_msg']);
                    $i = $i2 = 0;
                    foreach ($dataarray as $param) {
                        if ($param != 0) {
                            $done = 1;
                            $z = mysql_query("SELECT `username` FROM " . TB_PREFIX . "users WHERE id = '" . $param . "'") or die(mysql_error());
                            $z = mysql_fetch_assoc($z);
                            $name[$i] = $z['username'];
                            $i2++;
                        }
                        $i++;
                    }
                    $result = '<div id=\'ignore-list-columns\'>';
                    $tr = 0;
                    foreach ($name as $username) {
                        if ($tr == 0) {
                            $result .= '\n\t\t<table class=\'column column1\'>\n<tbody>';
                            $go = 1;
                        }
                        $result .= '\n\t\t\t\t<td class=\"end\">\n<button type=\"submit\" class=\"icon \" title=\"Receive messages from this player.\" onclick=\"unignoreUser(' . $dataarray[$tr] . ');\"><img src=\"img\/x.gif\" class=\"del unignore-user\" alt=\"del unignore-user\" \/><\/button>                    \t\t\t\t<\/td>\n\t\t\t\t<td><a href=\"\/spieler.php?uid=' . $dataarray[$tr] . '\">' . $username . '<\/a><\/td>\n\t\t\t\t<td class=\"end\">&nbsp;<\/td>\n\t\t\t<\/tr>\n            \t\t\t';
                        $tr++;
                    }
                    if ($go) {
                        while ($tr <= 19) {
                            $result .= '<tr><td class=\"end\">&nbsp;<\/td><td>&nbsp;<\/td>\n\t\t\t<td class=\"end\">&nbsp;<\/td>';
                            if ($tr % 2 == 0) {
                                $result .= '</tr>';
                            }
                            if ($tr == 9) {
                                $result .= ' <table class=\'column column2\'>\n        <tbody>\n';
                            }
                            $tr++;
                        }
                    }
                    $result .= '<\/tbody>\n\t<\/table>\n\t<\/div>\n<div class=\"clear\"><\/div>\n<div>\n\t<table>\n\t\t<tfoot>\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"6\">\n\t\t\t\t\t' . $i2 . '\/20\t\t\t\t<\/td>\n\t\t\t<\/tr>\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"6\">\n\t\t\t\t\tبرای نادیده گرفتن بازیکن به پروفایل آن مراجعه کنیدو به لیست سیاه اضافه کنید \"نادیده گرفتن\! \t\t\t\t<\/td>\n\t\t\t<\/tr>\n\t\t<\/tfoot>\n\t<\/table>\n<\/div>\n<div class=\"clear\"><\/div>';
                    $str = '{
						response: {"error":false,"errorMsg":null,"data":{"result":"' . $result . '"}}
					}';
                } elseif ($_POST['method'] == "ignore_target_player") {
                    $z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $session->uid . "'") or die(mysql_error());
                    $z = mysql_fetch_assoc($z);
                    $dataarray = explode(',', $z['ignore_msg']);
                    $exist = 0;
                    foreach ($dataarray as $param) {
                        if ($param == $_POST['params']['targetPlayer']) {
                            $exist = 1;
                            break;
                        }
                    }
                    if ($exist != 1) {
                        $i = 0;
                        foreach ($dataarray as $param) {
                            if ($param == 0) {
                                $dataarray[$i] = $_POST['params']['targetPlayer'];
                                break;
                            }
                            $i++;
                        }
                        $total = "" . $dataarray[0] . "," . $dataarray[1] . "," . $dataarray[2] . "," . $dataarray[3] . "," . $dataarray[4] . "," . $dataarray[5] . "," . $dataarray[6] . "," . $dataarray[7] . "," . $dataarray[8] . "," . $dataarray[9]
                            . "," . $dataarray[10] . "," . $dataarray[11] . "," . $dataarray[12] . "," . $dataarray[13] . "," . $dataarray[14] . "," . $dataarray[15] . "," . $dataarray[16] . "," . $dataarray[17] . "," . $dataarray[18]
                            . "," . $dataarray[19] . "";
                        $done = mysql_query("UPDATE " . TB_PREFIX . "users set `ignore_msg` = '" . $total . "' WHERE id = '" . $session->uid . "'") or die(mysql_error());
                        if ($done) {
                            $str = '{
									response: {"error":false,"errorMsg":null,"data":{"result":"                        <span class=\"notice\">بازیکن نادیده گرفته شده.<\/span>\n                            <br\/>\n                <a href=\"\" id=\"ignore-player-button\" data-player-ignored=\"true\" data-uid=\"' . $_POST['params']['targetPlayer'] . '\"\n                   title=\"پذیرش پیام بازیکن\">\n                    خارج کردن از لیست نادیده ها                <\/a>\n"}}
								}';
                        }
                    }
                } elseif ($_POST['method'] == "stop_ignore_target_player") {
                    $z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $session->uid . "'") or die(mysql_error());
                    $z = mysql_fetch_assoc($z);
                    $dataarray = explode(',', $z['ignore_msg']);
                    $id = -1;
                    $count = 0;
                    foreach ($dataarray as $param) {
                        if ($param == $_POST['params']['targetPlayer']) {
                            $id = $count;
                            break;
                        }
                        $count++;
                    }
                    if ($id != -1) {
                        $dataarray[$id] = 0;
                        $total = "" . $dataarray[0] . "," . $dataarray[1] . "," . $dataarray[2] . "," . $dataarray[3] . "," . $dataarray[4] . "," . $dataarray[5] . "," . $dataarray[6] . "," . $dataarray[7] . "," . $dataarray[8] . "," . $dataarray[9]
                            . "," . $dataarray[10] . "," . $dataarray[11] . "," . $dataarray[12] . "," . $dataarray[13] . "," . $dataarray[14] . "," . $dataarray[15] . "," . $dataarray[16] . "," . $dataarray[17] . "," . $dataarray[18]
                            . "," . $dataarray[19] . "";
                        $done = mysql_query("UPDATE " . TB_PREFIX . "users set `ignore_msg` = '" . $total . "' WHERE id = '" . $session->uid . "'") or die(mysql_error());
                        if ($done) {
                            if ($_POST['renderPlayerMessageIgnoreButtons'] == true) {
                                $str = '{
									response: {"error":false,"errorMsg":null,"data":{"result":"                        <a class=\"message messageStatus messageStatusUnread\" href=\"nachrichten.php?t=1&amp;id=' . $_POST['params']['targetPlayer'] . '\">\n                ارسال پیام           <\/a>\n            <br\/>\n                                                <a href=\"\" id=\"ignore-player-button\" data-player-ignored=\"false\" data-uid=\"' . $_POST['params']['targetPlayer'] . '\"\n                        title=\"نادیده گرفتن پیام از این بازیکن\">\n                        نادیده گرفتن بازیکن                   <\/a>\n                                        "}}
								}';
                            } elseif ($_POST['renderIgnoreList'] == true) {
                                $str = '{
								response: {"error":false,"errorMsg":"Token invalid","data":{"html":""},"reload":true}
							}';
                            }
                        }
                    }
                } elseif ($_POST['method'] == "render_player_message_ignore_buttons") {
                    $id = $_POST['params']['targetPlayer'];
                    $z = mysql_query("SELECT `ignore_msg` FROM " . TB_PREFIX . "users WHERE id = '" . $session->uid . "'") or die(mysql_error());
                    $z = mysql_fetch_assoc($z);
                    $dataarray = explode(',', $z['ignore_msg']);
                    $id = -1;
                    $count = 0;
                    foreach ($dataarray as $param) {
                        if ($param == $_POST['params']['targetPlayer']) {
                            $id = $count;
                            break;
                        }
                        $count++;
                    }
                    if ($id != -1) {
                        $str = '{
							response: {"error":false,"errorMsg":null,"data":{"result":"                        <span class=\"notice\">بازیکن نادیده گرفته شده.<\/span>\n                            <br\/>\n                <a href=\"\" id=\"ignore-player-button\" data-player-ignored=\"true\" data-uid=\"' . $_POST['params']['targetPlayer'] . '\"\n                   title=\"پذیرش پیام بازیکن\">\n                    خارج کردن از لیست نادیده گرفته ها             <\/a>\n                        "}}
						}';
                    } else {
                        $str = '{
							response: {"error":false,"errorMsg":null,"data":{"result":"                        <a class=\"message messageStatus messageStatusUnread\" href=\"nachrichten.php?t=1&amp;id=' . $_POST['params']['targetPlayer'] . '\">\n                ارسال پیام           <\/a>\n            <br\/>\n                                                <a href=\"\" id=\"ignore-player-button\" data-player-ignored=\"false\" data-uid=\"' . $_POST['params']['targetPlayer'] . '\"\n                        title=\"نادیده گرفتن پیام از این بازیکن\">\n                        نادیده گرفتن بازیکن                   <\/a>\n                                        "}}
						}';
                    }
                }
                echo $str;
                break;
            case 'mapLowRes':
                $x = $_POST['x'];
                $y = $_POST['y'];
                $xx = $_POST['width'];
                $yy = $_POST['height'];
                include('Templates/Ajax/mapscroll.tpl');
                break;
            case 'mapSetting':
                echo '{
					response: {"error":false,"errorMsg":null,"data":{"result":false}}
				}';
                break;
            case 'mapFlagAdd':
                $inputs = $_POST['data'];
                $x = $inputs['x'];
                $y = $inputs['y'];
                $color = $inputs['color'];
                $owner = $inputs['owner'];
                $text = $inputs ['text'];
                $uid = $session->uid;
                mysql_query("INSERT INTO " . TB_PREFIX . "map_marks (`id`,`uid`,`x`,`y`,`index`,`text`) VALUES ('','" . $uid . "','" . $x . "','" . $y . "','" . $color . "','" . $text . "')") or die(mysql_error());
                $row = mysql_insert_id();
                $q = "UPDATE " . TB_PREFIX . "map_marks SET `dataId`='" . $row . "' WHERE id=" . $row;
                mysql_query($q) or die(mysql_error());
                echo '{
					response: {"error":false,"errorMsg":null,"data":{"text":"' . $text . '","index":' . $color . ',"kid":1,"position":{"x":' . $x . ',"y":' . $y . '},"dataId":' . $row . '}}
				}';
                break;
            case 'mapMultiMarkAdd':
                $inputs = $_POST['data'];
                $x = $inputs['x'];
                $y = $inputs['y'];
                $color = $inputs['color'];
                $owner = $inputs['owner'];
                $text = $inputs ['text'];
                $uid = $session->uid;
                $query = mysql_fetch_assoc(mysql_query("SELECT `id` FROM " . TB_PREFIX . "wdata WHERE x=" . $x . " AND y=" . $y . " LIMIT 1"));
                $query2 = mysql_fetch_assoc(mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref =" . $query['id'] . " LIMIT 1"));
                $query3 = mysql_fetch_assoc(mysql_query("SELECT `username` FROM " . TB_PREFIX . "users WHERE id =" . $query2['owner'] . " LIMIT 1"));
                mysql_query("INSERT INTO " . TB_PREFIX . "map_marks (`id`,`uid`,`x`,`y`,`index`,`type`,`text`,`dataId`) VALUES ('','" . $uid . "','" . $x . "','" . $y . "','" . $color . "','player','" . $query3['username'] . "','" . $query2['owner'] . "')") or die(mysql_error());
                $row = mysql_insert_id();
                // $q = "UPDATE ".TB_PREFIX."map_marks SET `dataId`='".$row."' WHERE id=".$row;
                // mysql_query($q)or die(mysql_error());
                echo '{
					response: {"error":false,"errorMsg":null,"data":{"owner":"player","color":' . $color . ',"text":"' . $query3['username'] . '","position":{"x":'. $x .',"y":'. $y .'},"markId":' . $query2['owner'] . ',"dataId":' . $row . '}}
				}';
                break;
            case 'mapFlagOrMultiMark':
                $data = $_POST['data'];
                mysql_query("DELETE from " . TB_PREFIX . "map_marks where id=" . $data['dataId'] . "") or die(mysql_error());
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"result":true}}
				}';
                echo $str;
                break;
            case 'mapFlagUpdate':
                $data = $_POST['data'];
                $id = $data['dataId'];
                $q = "UPDATE " . TB_PREFIX . "map_marks SET `index`='" . $data['index'] . "',`text`='" . $data['text'] . "' WHERE id=" . $id;
                mysql_query($q) or die(mysql_error());
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"result":true}}
				}';
                echo $str;
                break;
            case 'mapInfo':
                $str = '{
					response: {"error":false,"errorMsg":null,"data":{"blocks":"' . $_POST['data'] . '"}}
				}';
                echo $str;
                break;
            case 'viewTileDetails':
                include('Templates/Ajax/viewTileDetails.tpl');
                break;
            case 'mapPositionData':
                include('Templates/Ajax/mapPositionData.tpl');
                break;
            default:
                echo '{
					response: {"error":true,"errorMsg":"Parameter "' . $_GET['cmd'] . '" (ajax.php) is not valid in "cmd".","data":[]","data":{"blocks":"' . $_POST['data'] . '"}}
				}';
                break;
        }
    } else {
        echo json_encode(array('error' => true, 'errorMsg' => 'Parameter "cmd" can not be empty or null.","data":[]'));
    }
}
?>