<?php
    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);

    $noticeArray = $database->readAlliNotice($aid);

    echo "<h1 class=\"titleInHeader\">" . $allianceinfo['tag'] . " - " . $allianceinfo['name'] . "</h1>";
?>

<div id="internInfo1" class="internInfo">
<h4 class="chartHeadline"><?php echo AL_ALPOWERINSIDE;?></h4>
<table class="barChart oneDir" cellpadding="1" cellspacing="1">
    <tbody>
    <tr>
        <td>
            <center><?php echo date("j/m"); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 1)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 2)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 3)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 4)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 5)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 6)); ?></td>
    </tr>
    <tr>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>

    </tr>
    <tr>
        <td colspan="7" class="legend">
            <div class="legend red"></div>
            &nbsp;<?php echo MV_ATTACK;?><br>

            <div class="legend blue"></div>
            &nbsp;<?php echo REPORT_DEFEND;?><br>

            <div class="clear"></div>
        </td>
    </tr>
    </tbody>
</table>
<br>
<br>
<h4 class="chartHeadline"><?php echo AL_POINTSTRUGGLE;?></h4>
<table class="barChart twoDirs" cellpadding="1" cellspacing="1">
    <tbody>
    <tr>
        <td>
            <center><?php echo date("j/m"); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 1)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 2)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 3)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 4)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 5)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 6)); ?></td>
    </tr>
    <tr>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="bar left red" style="height: 0%;">
                </div>
                <div class="bar right blue" style="height: 0%;">
                </div>
                <div class="clear"></div>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="7" class="legend">
            <div class="legend red"></div>
            &nbsp;حمله<br>

            <div class="legend blue"></div>
            &nbsp;دفاع<br>

            <div class="clear"></div>
        </td>
    </tr>
    </tbody>
</table>
</div>
<div id="internInfo2" class="internInfo">
<div id="allyInfoNews">
    <h4 class="chartHeadline"><?php echo AL_EVENTFINAL;?></h4>
    <table cellpadding="1" cellspacing="1" class="events">
        <tbody>
        <?php
            foreach ($noticeArray as $notice) {
                $date = $generator->procMtime($notice['date']);
                echo "<tr>";
                echo "<td class=\"event\">" . $notice['comment'] . "</td>";
                echo "<td class=\"dat\"><center>" . $date['0'] . " " . $date['1'] . "</center></td>";
                echo "</tr>";
            }
        ?>
        </tbody>
    </table>
    <div class="clear"></div>
</div>
<br>
<h4 class="chartHeadline"><?php echo AL_LOSSALLY?></h4>
<table class="barChart oneDir" cellpadding="1" cellspacing="1">
    <tbody>
    <tr>
        <td>
            <center><?php echo date("j/m"); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 1)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 2)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 3)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 4)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 5)); ?></td>
        <td>
            <center><?php echo date("j/m", time() - (86400 * 6)); ?></td>
    </tr>
    <tr>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
        <td class="bar positive">
            <div class="wrapper">
                <div class="stackedWrapper left" style="height: 0%;">
                    <div class="bar top tomato" style="height: 0%;">
                    </div>
                    <div class="bar red" style="height: 0%;">
                    </div>
                </div>
                <div class="stackedWrapper right" style="height: 0%;">
                    <div class="bar top cornflowerblue" style="height: 0%;">
                    </div>
                    <div class="bar blue" style="height: 0%;">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="7" class="legend">
            <div class="legend tomato"></div>
            &nbsp;<?php echo AL_TROOPSKILLBYALLY;?><br>

            <div class="legend red"></div>
            &nbsp;<?php echo AL_RESSTOLENALLY;?><br>

            <div class="legend cornflowerblue"></div>
            &nbsp; <?php echo AL_ALLYTROOPSKILLED;?><br>

            <div class="legend blue"></div>
            &nbsp;<?php echo AL_STOLEFROMALLY;?><br>

            <div class="clear"></div>
        </td>
    </tr>
    </tbody>
</table>
<br>
<h4 class="chartHeadline"><?php echo AL_LASTPOSTINFORUM;?></h4>

<div id="allyInfoForum">
    <ul><h4 class="chartHeadline">
            <?php

                $sql = mysql_query("SELECT `id` FROM " . TB_PREFIX . "forum_topic WHERE alliance = " . $session->alliance . " LIMIT 20");
                $query = mysql_num_rows($sql);

                if (isset($_GET['page'])) {
                    $page = preg_replace('#[^0-9]#i', '', $_GET['page']);
                } else {
                    $page = 1;
                }

                $itemsPerPage = 2;
                $lastPage = ceil($query / $itemsPerPage);

                if ($page < 1) {
                    $page = 1;
                } elseif ($page > $lastPage) {
                    $page = $lastPage;
                }

                $centerPages = "";
                $sub1 = $page - 1;
                $sub2 = $page - 2;
                $sub3 = $page - 3;
                $add1 = $page + 1;
                $add2 = $page + 2;
                $add3 = $page + 3;

                if ($page <= 1 && $lastPage <= 1) {
                    $centerPages .= '<span class="number currentPage">1</span>';
                } elseif ($page == 1 && $lastPage == 2) {
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=2">2</a>';
                } elseif ($page == 1 && $lastPage == 3) {
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=2">2</a> ';
                    $centerPages .= '<a class="number" href="?s=4&page=3">3</a>';
                } elseif ($page == 1) {
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $add1 . '">' . $add1 . '</a> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $add2 . '">' . $add2 . '</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $lastPage . '">' . $lastPage . '</a>';
                } else if ($page == $lastPage && $lastPage == 2) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span>';
                } else if ($page == $lastPage && $lastPage == 3) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ';
                    $centerPages .= '<a class="number" href="?s=4&page=2">2</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span>';
                } else if ($page == $lastPage) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub2 . '">' . $sub2 . '</a> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub1 . '">' . $sub1 . '</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span>';
                } else if ($page == ($lastPage - 1) && $lastPage == 3) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $lastPage . '">' . $lastPage . '</a>';
                } else if ($page > 2 && $page < ($lastPage - 1)) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub1 . '">' . $sub1 . '</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $add1 . '">' . $add1 . '</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $lastPage . '">' . $lastPage . '</a>';
                } else if ($page == ($lastPage - 1)) {
                    $centerPages .= '<a class="number" href="?s=4&page=1">1</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub1 . '">' . $sub1 . '</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $lastPage . '">' . $lastPage . '</a>';
                } else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub1 . '">' . $sub1 . '</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $add1 . '">' . $add1 . '</a>';
                } else if ($page > 1 && $page < $lastPage) {
                    $centerPages .= '<a class="number" href="?s=4&page=' . $sub1 . '">' . $sub1 . '</a> ';
                    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $add1 . '">' . $add1 . '</a> ... ';
                    $centerPages .= '<a class="number" href="?s=4&page=' . $lastPage . '">' . $lastPage . '</a>';
                }

                $paginationDisplay = "";
                $nextPage = $_GET['page'] + 1;
                $previous = $_GET['page'] - 1;

                if ($page == "1" && $lastPage == "1") {
                    $paginationDisplay .= '<img alt="First page" src="img/x.gif" class="first disabled"> ';
                    $paginationDisplay .= '<img alt="Previous Page" src="img/x.gif" class="previous disabled">';
                    $paginationDisplay .= $centerPages;
                    $paginationDisplay .= '<img alt="Next Page" src="img/x.gif" class="next disabled"> ';
                    $paginationDisplay .= '<img alt="Last page" src="img/x.gif" class="last disabled">';

                } elseif ($lastPage == 0) {
                    $paginationDisplay .= '<img alt="First page" src="img/x.gif" class="first disabled"> ';
                    $paginationDisplay .= '<img alt="Previous Page" src="img/x.gif" class="previous disabled">';
                    $paginationDisplay .= $centerPages;
                    $paginationDisplay .= '<img alt="Next Page" src="img/x.gif" class="next disabled"> ';
                    $paginationDisplay .= '<img alt="Last page" src="img/x.gif" class="last disabled">';

                } elseif ($page == "1" && $lastPage != "1") {
                    $paginationDisplay .= '<img alt="First page" src="img/x.gif" class="first disabled"> ';
                    $paginationDisplay .= '<img alt="Previous Page" src="img/x.gif" class="previous disabled">';
                    $paginationDisplay .= $centerPages;
                    $paginationDisplay .= '<a class="next" href="?s=4&page=' . $nextPage . '"><img alt="Next Page" src="img/x.gif"></a> ';
                    $paginationDisplay .= '<a class="last" href="?s=4&page=' . $lastPage . '"><img alt="Last page" src="img/x.gif"></a>';

                } elseif ($page != "1" && $page != $lastPage) {
                    $paginationDisplay .= '<a class="first" href="?s=4&page=1"><img alt="First page" src="img/x.gif"></a> ';
                    $paginationDisplay .= '<a class="previous" href="?s=4&page=' . $previous . '"><img alt="Previous Page" src="img/x.gif"></a>';
                    $paginationDisplay .= $centerPages;
                    $paginationDisplay .= '<a class="next" href="?s=4&page=' . $nextPage . '"><img alt="Next Page" src="img/x.gif"></a> ';
                    $paginationDisplay .= '<a class="last" href="?s=4&page=' . $lastPage . '"><img alt="Last page" src="img/x.gif"></a>';

                } elseif ($page == $lastPage) {
                    $paginationDisplay .= '<a class="first" href="?s=4&page=1"><img alt="First page" src="img/x.gif"></a> ';
                    $paginationDisplay .= '<a class="previous" href="?s=4&page=' . $previous . '"><img alt="Previous Page" src="img/x.gif"></a>';
                    $paginationDisplay .= $centerPages;
                    $paginationDisplay .= '<img alt="Next Page" src="img/x.gif" class="next disabled"> ';
                    $paginationDisplay .= '<img alt="Last page" src="img/x.gif" class="last disabled">';
                }

                $limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;

                if ($query != 0) {
                    $q = "SELECT `post`,`topic` FROM " . TB_PREFIX . "forum_post order by id DESC $limit";
                    $Posts = $database->query_return($q);
                    foreach ($Posts as $ps) {
                        $q2 = "SELECT * FROM " . TB_PREFIX . "forum_topic WHERE `id`= " . $ps['topic'] . " && `alliance` = " . $session->alliance . "";
                        $z = mysql_query($q2);
                        $z = mysql_fetch_array($z);
                        if ($z) {
                            $fixer = array('[message]', '[/message]');
                            $ps['post'] = str_replace($fixer, '', $ps['post']);
                            $ps['post'] = mb_substr($ps['post'], 0, 20) . " ... <br />";
                            $topic = $ps['topic'];
                            echo "<a href='allianz.php?s=2&gotolastanswer=" . $topic . "&tid=" . $topic . "'>" . $ps['post'] . "</a>";
                        }
                    }
                } else {
                    echo "<font size=1 color=gray>There are no posts ...</font>";
                }
            ?></h4></ul>
    <div class="paginator"><?php echo $paginationDisplay; ?></div>
    <div class="clear"></div>
</div>
</div>
<div class="clear">&nbsp;</div>