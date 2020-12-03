<?php
    $sql = $ranking->procAllianceDefRanking();
    $query = mysql_num_rows($sql);

    if (isset($_POST['name']) && $_POST['name'] != '') {
        $mydata = $database->getAlliance($_POST['name'], 2);
        if (empty($mydata)) {
            $mydata['id'] = $session->alliance;
            $err = PF_USRNTFOUND;
        }
        $myrank = $ranking->getAllianceDefRank($mydata['id']);
        $mydata = $database->getAlliance($mydata['id']);
    } elseif (isset($_POST['rank'])) {
        if ($_POST['rank'] > $query) {
            $_POST['rank'] = $query;
        } elseif ($_POST['rank'] <= 0) {
            $_POST['rank'] = 1;
        }
        $myrank = $_POST['rank'];
        $mr = $ranking->procAllianceDefRanking();
        $i = 0;
        $myid = $session->alliance;
        while ($row = mysql_fetch_array($mr)) {
            $i += 1;
            if ($i == $myrank) {
                $myid = $row['id'];
                break;
            }
        }
        $mydata = $database->getAlliance($myid);
    } else {
        $myrank = $ranking->getAllianceDefRank($session->alliance);
        $mydata = $database->getAlliance($session->alliance);
    }

    if (!isset($_GET['page'])) {
        if ($myrank > 20) {
            $_GET['page'] = intval(floor(($myrank - 1) / 20) + 1);
        } else {
            $_GET['page'] = 1;
        }
    }

?>
<div class="contentNavi tabNavi">
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=4"><span class="tabItem"><?php echo AL_OVERVIEW; ?></span></a>
        </div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=41"><span
                    class="tabItem"><?php echo REPORT_ATTACKER; ?></span></a></div>
    </div>
    <div class="container active">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=42"><span
                    class="tabItem"><?php echo REPORT_DEFENDER; ?></span></a></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=43"><span class="tabItem"><?php echo PF_TOP10; ?></span></a>
        </div>
    </div>
    <div class="clear"></div>
</div>
<h4 class="round"><?php echo PF_TOPDEFENDINGALLIANCES; ?></h4>
<?php if (isset($err)) echo '<h5 style="color:#f00;">' . $err . '</h5>'; ?>
<table cellpadding="1" cellspacing="1" id="alliance" class="row_table_data">
    <thead>
    <tr>
        <td></td>
        <td><?php echo AL_ALLIANCE; ?></td>
        <td><?php echo MK_PLAYERS; ?></td>
        <td>Ø</td>
        <td><?php echo AL_POINTS; ?></td>
    </tr>
    </thead>
    <tbody>
    <?php

        if (isset($_GET['page'])) {
            $page = preg_replace('#[^0-9]#i', '', $_GET['page']);
        } else {
            $page = 1;
        }

        $itemsPerPage = 20;
        $lastPage = ceil($query / $itemsPerPage);

        if ($page < 1) {
            $page = 1;
        } else if ($page > $lastPage) {
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
            $centerPages .= '<a class="number" href="?tid=42&page=2">2</a>';

        } elseif ($page == 1 && $lastPage == 3) {
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=2">2</a> ';
            $centerPages .= '<a class="number" href="?tid=42&page=3">3</a>';

        } elseif ($page == 1) {
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $add1 . '">' . $add1 . '</a> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $add2 . '">' . $add2 . '</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $lastPage . '">' . $lastPage . '</a>';

        } else if ($page == $lastPage && $lastPage == 2) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span>';

        } else if ($page == $lastPage && $lastPage == 3) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ';
            $centerPages .= '<a class="number" href="?tid=42&page=2">2</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span>';

        } else if ($page == $lastPage) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub2 . '">' . $sub2 . '</a> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub1 . '">' . $sub1 . '</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span>';

        } else if ($page == ($lastPage - 1) && $lastPage == 3) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $lastPage . '">' . $lastPage . '</a>';

        } else if ($page > 2 && $page < ($lastPage - 1)) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub1 . '">' . $sub1 . '</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $add1 . '">' . $add1 . '</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $lastPage . '">' . $lastPage . '</a>';

        } else if ($page == ($lastPage - 1)) {
            $centerPages .= '<a class="number" href="?tid=42&page=1">1</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub1 . '">' . $sub1 . '</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $lastPage . '">' . $lastPage . '</a>';

        } else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub1 . '">' . $sub1 . '</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $add1 . '">' . $add1 . '</a>';

        } else if ($page > 1 && $page < $lastPage) {
            $centerPages .= '<a class="number" href="?tid=42&page=' . $sub1 . '">' . $sub1 . '</a> ';
            $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $add1 . '">' . $add1 . '</a> ... ';
            $centerPages .= '<a class="number" href="?tid=42&page=' . $lastPage . '">' . $lastPage . '</a>';
        }


        $paginationDisplay = "";
        $nextPage = $_GET['page'] + 1;
        $previous = $_GET['page'] - 1;

        if ($page == "1" && $lastPage == "1") {
            $paginationDisplay .= '<img alt="' . FIRSTPAGE . '" src="img/x.gif" class="first disabled"> ';
            $paginationDisplay .= '<img alt="' . PREVPAGE . '" src="img/x.gif" class="previous disabled">';
            $paginationDisplay .= $centerPages;
            $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
            $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';

        } elseif ($lastPage == 0) {
            $paginationDisplay .= '<img alt="' . FIRSTPAGE . '" src="img/x.gif" class="first disabled"> ';
            $paginationDisplay .= '<img alt="' . PREVPAGE . '" src="img/x.gif" class="previous disabled">';
            $paginationDisplay .= $centerPages;
            $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
            $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';

        } elseif ($page == "1" && $lastPage != "1") {
            $paginationDisplay .= '<img alt="' . FIRSTPAGE . '" src="img/x.gif" class="first disabled"> ';
            $paginationDisplay .= '<img alt="' . PREVPAGE . '" src="img/x.gif" class="previous disabled">';
            $paginationDisplay .= $centerPages;
            $paginationDisplay .= '<a class="next" href="?tid=42&page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
            $paginationDisplay .= '<a class="last" href="?tid=42&page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

        } elseif ($page != "1" && $page != $lastPage) {
            $paginationDisplay .= '<a class="first" href="?tid=42&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
            $paginationDisplay .= '<a class="previous" href="?tid=42&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
            $paginationDisplay .= $centerPages;
            $paginationDisplay .= '<a class="next" href="?tid=42&page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
            $paginationDisplay .= '<a class="last" href="?tid=42&page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

        } elseif ($page == $lastPage) {
            $paginationDisplay .= '<a class="first" href="?tid=42&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
            $paginationDisplay .= '<a class="previous" href="?tid=42&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
            $paginationDisplay .= $centerPages;
            $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
            $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';
        }

        $limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;
        //$sql2 = $ranking->procAllianceRanking($limit);
        $ar = $ranking->procAllianceDefRanking($limit);
        if (isset($page) && $page > 1) {
            $rank = ($page - 1) * 20 + 1;
        } else {
            $rank = 1;
        }
        if ($ar) {
            while ($row = mysql_fetch_array($ar)) {
                if ($row['memcount'] > 0) {
                    if ($row['id'] == $mydata['id']) {
                        echo "<tr class=\"hl\"><td class=\"ra fc\" >" . $rank . ".</td>";
                    } else {
                        echo "<tr class=\"hover\"><td class=\"ra \" >" . $rank . ".</td>";
                    }
                    echo "<td class=\"al \" ><a href=\"allianz.php?aid=" . $row['id'] . "\">" . $row['tag'] . "</a></td>";

                    echo "<td class=\"pla \" >" . $row['memcount'] . "</td>";
                    echo "<td class=\"av \">" . round(($row['totalpop'] + $row['Aap'] + $row['Adp']) / $row['memcount']) . "</td>";
                    echo "<td class=\"po lc\">" . $row['Adp'] . "</td></tr>";
                    $rank++;
                }
            }
        }


    ?>
    </tbody>
</table>
<?php
    if (!isset($_GET['tid'])) {
        $_GET['tid'] = '1';
    }
?>
<div id="search_navi">
    <form method="post" action="statistiken.php?tid=<?php echo isset($_GET['tid']) ? $_GET['tid'] : 1; ?>">
        <div class="boxes boxesColor gray">
            <div class="boxes-tl"></div>
            <div class="boxes-tr"></div>
            <div class="boxes-tc"></div>
            <div class="boxes-ml"></div>
            <div class="boxes-mr"></div>
            <div class="boxes-mc"></div>
            <div class="boxes-bl"></div>
            <div class="boxes-br"></div>
            <div class="boxes-bc"></div>
            <div class="boxes-contents w292">
                <table class="transparent">
                    <tbody>
                    <tr>
                        <td>
                            <span><?php echo AL_RANK; ?> <input type="text" class="text ra" maxlength="5" name="rank"
                                                             value=""/></span>
                        </td>
                        <td>
                            <span><?php echo AL_NAME; ?> <input type="text" class="text name" maxlength="20" name="name"
                                                             value=""/></span>
                        </td>
                        <td>
                            <input type="hidden" name="ft"
                                   value="r<?php echo isset($_GET['tid']) ? $_GET['tid'] : 1; ?>"/>
                            <button type="submit" value="submit" name="submit" id="btn_ok" class="green ">
                                <div class="button-container addHoverClick">
                                    <div class="button-background">
                                        <div class="buttonStart">
                                            <div class="buttonEnd">
                                                <div class="buttonMiddle"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-content"><?php echo MP_SEARCH; ?></div>
                                </div>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
    <div class="paginator"><?php echo $paginationDisplay; ?></div>
</div>
<div class="clear">&nbsp;</div>
