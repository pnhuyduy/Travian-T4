<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include('GameEngine/Protection.php');
    include('GameEngine/Session.php');
    if ($session->plus) {
        switch ($_GET['form']) {
            case 1:
                $t1 = $database->getAttackCasualties($_SERVER['REQUEST_TIME']);
                $t2 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 1));
                $t3 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 2));
                $t4 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 3));
                $t5 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 4));
                $t6 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 5));
                $t7 = $database->getAttackCasualties($_SERVER['REQUEST_TIME'] - (86400 * 6));
                $ts1 = $database->getAttackByDate($_SERVER['REQUEST_TIME']);
                $ts2 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 1));
                $ts3 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 2));
                $ts4 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 3));
                $ts5 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 4));
                $ts6 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 5));
                $ts7 = $database->getAttackByDate($_SERVER['REQUEST_TIME'] - (86400 * 6));

                header('Content-type: image/jpeg');
                include_once('php.php');
                $cfg['width'] = 480;
                $cfg['height'] = 250;
                $cfg['column-color'] = 'ED3A20';
                $cfg['column-compare-color'] = 'B8E780';
                $cfg['column-divider-visible'] = '0';
                $cfg['horizontal-divider-alpha'] = '110';
                $data1 = array(
                    date('j. M')                                         => $t7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $t6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $t5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $t4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $t3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $t2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $t1

                );
                $data2 = array(
                    date('j. M')                                         => $ts7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $ts6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $ts5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $ts4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $ts3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $ts2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $ts1
                );
                $graph = new verticalLineGraph();
                $graph->parseCompare($data2, $data1, $cfg);
                break;
            case 2:
                $user = $session->uid;
                $t1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'troops');
                $t2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'troops');
                $t3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'troops');
                $t4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'troops');
                $t5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'troops');
                $t6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'troops');
                $t7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'troops');
                $ts1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'troops_reinf');
                $ts2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'troops_reinf');
                $ts3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'troops_reinf');
                $ts4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'troops_reinf');
                $ts5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'troops_reinf');
                $ts6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'troops_reinf');
                $ts7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'troops_reinf');

                header('Content-type: image/jpeg');
                include_once('php.php');
                $cfg['width'] = 480;
                $cfg['height'] = 250;
                $cfg['column-color'] = '0061FF';
                $cfg['column-compare-color'] = 'B8E780';
                $cfg['column-divider-visible'] = '0';
                $data1 = array(
                    date('j. M')                                         => $t7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $t6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $t5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $t4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $t3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $t2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $t1
                );
                $data2 = array(
                    date('j. M')                                         => $ts7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $ts6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $ts5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $ts4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $ts3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $ts2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $ts1
                );
                $graph = new verticalLineGraph();
                $graph->parseCompare($data1, $data2, $cfg);
                break;
            case 3:
                $user = $session->uid;
                $t1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'resources') / 4;
                $t2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'resources') / 4;
                $t3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'resources') / 4;
                $t4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'resources') / 4;
                $t5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'resources') / 4;
                $t6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'resources') / 4;
                $t7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'resources') / 4;
                $ts1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'pop');
                $ts2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'pop');
                $ts3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'pop');
                $ts4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'pop');
                $ts5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'pop');
                $ts6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'pop');
                $ts7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'pop');

                header('Content-type: image/jpeg');
                include_once('php.php');
                $cfg['width'] = 480;
                $cfg['height'] = 250;
                $cfg['column-color'] = 'FFDF00';
                $cfg['column-compare-color'] = 'B8E780';
                $cfg['column-divider-visible'] = '0';

                $data1 = array(
                    date('j. M')                                         => $t7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $t6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $t5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $t4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $t3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $t2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $t1

                );
                $data2 = array(
                    date('j. M')                                         => $ts7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $ts6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $ts5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $ts4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $ts3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $ts2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $ts1
                );
                $graph = new verticalLineGraph();
                $graph->parseCompare($data1, $data2, $cfg);
                break;
            case 4:
                $user = $session->uid;
                $t1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'rank');
                $t2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'rank');
                $t3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'rank');
                $t4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'rank');
                $t5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'rank');
                $t6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'rank');
                $t7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'rank');
                $ts1 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'], 'rank');
                $ts2 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 1), 'rank');
                $ts3 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 2), 'rank');
                $ts4 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 3), 'rank');
                $ts5 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 4), 'rank');
                $ts6 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 5), 'rank');
                $ts7 = $database->getStatsinfo($user, $_SERVER['REQUEST_TIME'] - (86400 * 6), 'rank');
                header('Content-type: image/jpeg');
                include_once('php.php');
                $cfg['width'] = 480;
                $cfg['height'] = 250;
                $cfg['round-value-range'] = TRUE;
                $cfg['column-color'] = 'B8E780';
                $cfg['column-compare-color'] = '71D000';
                $cfg['column-divider-visible'] = '0';

                $data1 = array(
                    date('j. M')                                         => $t7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $t6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $t5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $t4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $t3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $t2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $t1

                );
                $data2 = array(
                    date('j. M')                                         => $ts7,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 1)) => $ts6,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 2)) => $ts5,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 3)) => $ts4,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 4)) => $ts3,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 5)) => $ts2,
                    date('j. M', $_SERVER['REQUEST_TIME'] - (86400 * 6)) => $ts1
                );
                $graph = new verticalLineGraph();
                $graph->parseCompare($data1, $data2, $cfg);
        }
    } else {
        header('Location: statistiken.php');
        exit;
    }
?> 