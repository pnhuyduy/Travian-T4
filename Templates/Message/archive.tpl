<?php
$prefix = TB_PREFIX . "mdata";
$sql = mysql_query("SELECT `id` FROM $prefix WHERE target = $session->uid AND archived = 1 AND deltarget = 0 ORDER BY time DESC");
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
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=2">2</a>';

} elseif ($page == 1 && $lastPage == 3) {
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=2">2</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=3">3</a>';

} elseif ($page == 1) {
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $add1 . '">' . $add1 . '</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $add2 . '">' . $add2 . '</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page == $lastPage && $lastPage == 2) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == $lastPage && $lastPage == 3) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=2">2</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == $lastPage) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub2 . '">' . $sub2 . '</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == ($lastPage - 1) && $lastPage == 3) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page > 2 && $page < ($lastPage - 1)) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $add1 . '">' . $add1 . '</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page == ($lastPage - 1)) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $add1 . '">' . $add1 . '</a>';

} else if ($page > 1 && $page < $lastPage) {
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $add1 . '">' . $add1 . '</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '">' . $lastPage . '</a>';
}

if (isset($_GET['s']) && $_GET['o'] == 1) {
    $s = "ASC";
} else {
    $s = "DESC";
}
if (isset($_GET['s']) && $_GET['o'] == 2) {
    $by = "owner";
} else {
    $by = "time";
}

$limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;
$sql2 = mysql_query("SELECT * FROM $prefix WHERE target = $session->uid AND archived = 1 AND deltarget = 0 ORDER BY $by $s $limit");

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
    $paginationDisplay .= '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
    $paginationDisplay .= '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

} elseif ($page != "1" && $page != $lastPage) {
    $paginationDisplay .= '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
    $paginationDisplay .= '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
    $paginationDisplay .= $centerPages;
    $paginationDisplay .= '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
    $paginationDisplay .= '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

} elseif ($page == $lastPage) {
    $paginationDisplay .= '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
    $paginationDisplay .= '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
    $paginationDisplay .= $centerPages;
    $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
    $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';
}

$outputList = '';
$name = 1;
if ($query == 0) {
    $outputList .= "<td colspan=\"4\" class=\"none\">" . MS_NOMSGINBOX . ".</td>";
} else {
    while ($row = mysql_fetch_array($sql2)) {
        $id = $row["id"];
        $target = $row["target"];
        $owner = $row["owner"];
        $topic = $row["topic"];
        $messageText = $row["message"];
        $viewed = $row["viewed"];
        $archived = $row["archived"];
        $send = $row["send"];
        $time = $row["time"];

        switch($owner){
            case 0:
            case 1:
                $color = "background-color:#71D000";
                break;
            case 4:
                $color = "background-color:#FF0066";
                break;
            default:
                $color = "background-color:white";
                break;
        }

        $outputList .= "<tr><td class=\"sel\" style=\"$color\"><input class=\"check\" type=\"checkbox\" name=\"n" . $name . "\" value=\"" . $id . "\" /></td><td class=\"subject\"><div class=\"subjectWrapper\">";
        if ($viewed == 0) {
            $viewedclass = "Unread";
            $viewed = MS_UNREAD;
        } else {
            $viewedclass = "Read";
            $viewed = MS_READ;
        }
        $outputList .= "<img src=\"img/x.gif\" class=\"messageStatus messageStatus" . $viewedclass . "\" alt=\"" . $viewed . "\">
		<a href=\"nachrichten.php?id=" . $id . "\">" . $topic . "</a></div></td>";
        $date = $generator->procMtime($time);
        if ($owner <= 1) {
            $outputList .= "<td class=\"send\"><a><u>" . $database->getUserField($owner, 'username', 0) . "</u></a></td>";
        } else {
            $outputList .= "<td class=\"send\"><a href=\"spieler.php?uid=" . $owner . "\">" . $database->getUserField($owner, 'username', 0) . "</a></td>";
        }
        $outputList .= "<td class=\"dat\">" . $date[0] . " " . date('H:i', $time) . "</td>";

        $name++;
    }
}

?>
<form method="post" action="nachrichten.php" name="msg">

    <table cellpadding="1" cellspacing="1" id="overview" class="inbox">
        <thead>
        <tr>
            <th colspan="2"><?php echo AL_SUBJECT; ?></th>
            <th class="send"><?php echo MS_SENDER; ?></th>
            <th class="dat"><b><?php echo MS_SENT; ?></b></th>
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
    <div class="administration">
        <?php if ($session->plus) { ?>
            <div class="checkAll">
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
    <p>

        <?php if (!$session->is_sitter) { ?>
            <input type="hidden" name="t" value="3"/>
            <button type="submit" value="del" name="delmsg" id="del" class="green ">
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

            <?php if ($session->goldclub) { ?>
                <button type="unarchive" value="archive" name="unarchive" id="unarchive" class="green ">
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
            <?php
            }
        } ?>

        <input name="ft" value="m3" type="hidden"/>
</form>
