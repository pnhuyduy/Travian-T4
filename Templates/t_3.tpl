<?php
    $_SESSION['Surroundings'] = 1;
    $noticeClass = array(NOTICE1, NOTICE2, NOTICE3, NOTICE4, NOTICE5, NOTICE6, NOTICE7, NOTICE8, NOTICE9, NOTICE10, NOTICE11, NOTICE12, NOTICE13, NOTICE14, NOTICE15,
        NOTICE16, NOTICE17, NOTICE18, NOTICE19, NOTICE20, NOTICE21, NOTICE22, NOTICE23);
    $prefix = "" . TB_PREFIX . "ndata";
    $sql = mysql_query("SELECT * FROM $prefix WHERE uid = " . $session->uid . " and archive=1 ORDER BY time DESC");
    $query = mysql_num_rows($sql);

    if (isset($_GET['page'])) {
        $page = preg_replace('#[^0-9]#i', '', $_GET['page']);
    } else {
        $page = 1;
    }

    $itemsPerPage = 10;
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
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=2">2</a>';

    } elseif ($page == 1 && $lastPage == 3) {
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=2">2</a> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=3">3</a>';

    } elseif ($page == 1) {
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $add1 . '">' . $add1 . '</a> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $add2 . '">' . $add2 . '</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page == $lastPage && $lastPage == 2) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == $lastPage && $lastPage == 3) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=2">2</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == $lastPage) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub2 . '">' . $sub2 . '</a> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == ($lastPage - 1) && $lastPage == 3) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page > 2 && $page < ($lastPage - 1)) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $add1 . '">' . $add1 . '</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page == ($lastPage - 1)) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $add1 . '">' . $add1 . '</a>';

    } else if ($page > 1 && $page < $lastPage) {
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $add1 . '">' . $add1 . '</a> ... ';
        $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '">' . $lastPage . '</a>';
    }


    $limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;

    $sql2 = mysql_query("SELECT * FROM $prefix WHERE uid = " . $session->uid . " and archive=1 ORDER BY time DESC $limit");
    $paginationDisplay = "";
    $nextPage = isset($_GET['page']) ? $_GET['page'] + 1 : 0;
    $previous = isset($_GET['page']) ? $_GET['page'] - 1 : 0;

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
        $paginationDisplay .= '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=2"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=3"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

    } elseif ($page != "1" && $page != $lastPage) {
        $paginationDisplay .= '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
        $paginationDisplay .= $centerPages;
        $paginationDisplay .= '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

    } elseif ($page == $lastPage) {
        $paginationDisplay .= '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?t=' . $_GET['t'] . '&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
        $paginationDisplay .= $centerPages;
        $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
        $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';
    }


    $outputList = '';
    $name = 1;
    if ($query == 0) {
        $outputList .= "<td colspan=\"4\" class=\"none\">" . REPORT_NOREPORT . "</td>";
    } else {
        while ($row = mysql_fetch_array($sql2)) {
            $id = $row["id"];
            $toWref = $row["toWref"];
            $topics = explode('[=]', $row["topic"]);
            $topCount = count($topics); // var_dump($topCount); die;
            if ($topCount == 2) {
                $t1 = explode('[|]', $topics[1]);
                if (defined($t1[0])) $t1[0] = constant($t1[0]);
                for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
                $topic = sprintf(constant($topics[0]), $t1[0]);
            } elseif ($topCount == 3) {
                $t1 = explode('[|]', $topics[1]);
                if (defined($t1[0])) $t1[0] = constant($t1[0]);
                for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
                $t2 = explode('[|]', $topics[2]);
                if (defined($t2[0])) $t2[0] = constant($t2[0]);
                for ($i = 1; $i < count($t2); $i++) $t2[0] .= $t2[$i];
                $topic = sprintf(constant($topics[0]), $t1[0], $t2[0]);
            } else {
                $topic = $row["topic"];
            }
            $ntype = $row["ntype"];
            $data = $row["data"];
            $time = $row["time"];
            $viewed = $row["viewed"];
            $archive = $row["archive"];
            $type = (isset($_GET['t']) && $_GET['t'] == 5) ? $archive : $ntype;
            $dataarray = explode(",", $data);


            $outputList .= "<tr><td class=\"sel\"><input class=\"check\" type=\"checkbox\" name=\"n" . $name . "\" value=\"" . $id . "\" /></td><td class=\"sub\">";

            if ($type == 9) {
                $outputList .= "<img src=\"img/x.gif\" class=\"iReport iReport21\" alt=\"" . $noticeClass[$ntype] . "\" title=\"" . $noticeClass[$ntype] . "\" /> <div>";
            } else {
                $outputList .= "<img src=\"img/x.gif\" class=\"iReport iReport$type\" alt=\"" . $noticeClass[$type] . "\" title=\"" . $noticeClass[$type] . "\" /> <div>";
            }

            if ($type == 1 || $type == 2 || $type == 5 || $type == 6 || $type == 7) {
                if ($dataarray[24] + $dataarray[25] + $dataarray[26] + $dataarray[27] == 0) {
                    $style = "empty";
                } elseif ($dataarray[24] + $dataarray[25] + $dataarray[26] + $dataarray[27] != $dataarray[28]) {
                    $style = "half";
                } else {
                    $style = "full";
                }
                $carry = ($dataarray[24] + $dataarray[25] + $dataarray[26] + $dataarray[27]) . "/" . $dataarray[28];

                $outputList .= "<div class=\"reportInfoIcon\"><img title=\"" . $carry . "\" src=\"img/x.gif\" class=\"reportInfo carry " . $style . "\"></div>";

            } elseif ($type == 9) {
                $btype = $dataarray[1];
                $type = $dataarray[2];
                include "Templates/Auction/alt.tpl";
                $typeArray = array("", "helmet", "body", "leftHand", "rightHand", "shoes", "horse", "bandage25", "bandage33", "cage", "scroll", "ointment", "bucketOfWater", "bookOfWisdom", "lawTables", "artWork");
                if ($dataarray[1] != 'dead') {
                    if ($dataarray[1] != '') {
                        $outputList .= "<div class=\"reportInfoIcon\"><img title=\"" . $name . " (" . $dataarray[3] . "x)\" src=\"img/x.gif\" class=\"reportInfo itemCategory itemCategory_" . $typeArray[$dataarray[1]] . "\"></div>";
                    }
                } else {
                    $outputList .= "<div class=\"reportInfoIcon\"><img src=\"img/x.gif\" class=\"reportInfo adventureDifficulty0\" title=\"" . HS_HERODEAD . "\"></div>";
                }
            }
            $outputList .= "<a href=\"berichte.php?id=" . $id . "\">" . $topic . " </a> ";
            if ($viewed == 0) {
                $outputList .= "(" . NEWSTR . ")";
            }
            $date = $generator->procMtime($time);
            $outputList .= "</div><div class=\"clear\"></div></td>
			<td class=\"dat\">" . $date[0] . " " . date('H:i', $time) . "</td></tr>";
            $name++;
        }
    }


?>
<form method="post" action="berichte.php" name="msg">
    <input type="hidden" name="t" id="t" value="<?php echo $_GET['t']; ?>">
    <table cellpadding="1" cellspacing="1" id="overview" class="row_table_data">
        <thead>
        <tr>
            <th colspan="2"><?php echo AL_SUBJECT; ?>:</th>
            <th class="sent"><?php echo MS_SENT; ?></th>
        </tr>
        </thead>
        <tbody>
        <?php

            if (isset($_GET['s'])) {
                $s = $_GET['s'];
            } else {
                $s = 0;
            }

            print "$outputList";

        ?>


        </tbody>
    </table>

    <div class="footer">
        <?php if ($session->plus) { ?>
            <div id="markAll">
                <input class="check" type="checkbox" id="sAll" onclick="
				$(this).up('form').getElements('input[type=checkbox]').each(function(element)
				{
					element.checked = this.checked;
				}, this);
			">
                <span><label for="sAll"><?php echo SELECTALL; ?></label></span>
            </div>
        <?php } ?>

        <div class="paginator">
            <?php echo $paginationDisplay; ?>
        </div>

        <div class="clear"></div>
    </div>
    <button type="submit" value="del" name="delntc" id="del" class="green ">
        <div class="button-container addHoverClick">
            <div class="button-background">
                <div class="buttonStart">
                    <div class="buttonEnd">
                        <div class="buttonMiddle"></div>
                    </div>
                </div>
            </div>
            <div class="button-content"><?php echo AL_DELETE; ?></div>
        </div>
    </button>
    <?php if ($session->plus) { ?>
        <button type="submit" value="start" name="start" id="start" class="green ">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo MS_UNARCHIVE; ?></div>
            </div>
        </button>
    <?php } ?>
</form>
