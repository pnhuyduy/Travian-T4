<span class="error">
	<?php
        if (isset($_GET['err'])) {
            $errtxt = 'HR_HEROBIDERROR' . $_GET['err'];
            echo constant($errtxt)."<br>";
        }
    echo sprintf(HR_MAXBIDALLOW, ALLOWEDMAXBID);
    ?>
</span>
<div id="auction">
<div id="filter">
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
        <div class="boxes-contents">
            <div class="wrapper">

                <div class="silver"><img title="<?php echo HDR_SILVER; ?>" class="silver"
                                         src="img/x.gif"> <?php $now = $database->getAuctionSilver($session->uid);
                        echo($session->silver - $now['silver']); ?> / <?php echo $session->silver; ?></div>

                <div class="filterContainer">
                    <button title="<?php echo HR_FILTER1; ?>" type="button"
                            value="itemCategory itemCategory_helmet" <?php if (isset($_GET['filter']) && $_GET['filter'] == 1) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=1'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_helmet"
                                                                                                         alt="itemCategory itemCategory_helmet">
                    </button>
                    <button title="<?php echo HR_FILTER2; ?>" type="button"
                            value="itemCategory itemCategory_body" <?php if (isset($_GET['filter']) && $_GET['filter'] == 2) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=2'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_body"
                                                                                                         alt="itemCategory itemCategory_body">
                    </button>
                    <button title="<?php echo HR_FILTER3; ?>" type="button"
                            value="itemCategory itemCategory_leftHand" <?php if (isset($_GET['filter']) && $_GET['filter'] == 3) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=3'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_leftHand"
                                                                                                         alt="itemCategory itemCategory_leftHand">
                    </button>
                    <button title="<?php echo HR_FILTER4; ?>" type="button"
                            value="itemCategory itemCategory_rightHand" <?php if (isset($_GET['filter']) && $_GET['filter'] == 4) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=4'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_rightHand"
                                                                                                         alt="itemCategory itemCategory_rightHand">
                    </button>
                    <button title="<?php echo HR_FILTER5; ?>" type="button"
                            value="itemCategory itemCategory_shoes" <?php if (isset($_GET['filter']) && $_GET['filter'] == 5) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=5'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_shoes"
                                                                                                         alt="itemCategory itemCategory_shoes">
                    </button>
                    <button title="<?php echo HR_FILTER6; ?>" type="button"
                            value="itemCategory itemCategory_horse" <?php if (isset($_GET['filter']) && $_GET['filter'] == 6) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=6'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_horse"
                                                                                                         alt="itemCategory itemCategory_horse">
                    </button>
                    <button title="<?php echo HR_FILTER7; ?>" type="button"
                            value="itemCategory itemCategory_bandage25" <?php if (isset($_GET['filter']) && $_GET['filter'] == 7) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=7'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_bandage25"
                                                                                                         alt="itemCategory itemCategory_bandage25">
                    </button>
                    <button title="<?php echo HR_FILTER8; ?>" type="button"
                            value="itemCategory itemCategory_bandage33" <?php if (isset($_GET['filter']) && $_GET['filter'] == 8) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=8'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_bandage33"
                                                                                                         alt="itemCategory itemCategory_bandage33">
                    </button>
                    <button title="<?php echo HR_FILTER9; ?>" type="button"
                            value="itemCategory itemCategory_cage" <?php if (isset($_GET['filter']) && $_GET['filter'] == 9) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=9'; return false;"><img src="img/x.gif"
                                                                                                         class="itemCategory itemCategory_cage"
                                                                                                         alt="itemCategory itemCategory_cage">
                    </button>
                    <button title="<?php echo HR_FILTER10; ?>" type="button"
                            value="itemCategory itemCategory_scroll" <?php if (isset($_GET['filter']) && $_GET['filter'] == 10) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=10'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_scroll"
                            alt="itemCategory itemCategory_scroll"></button>
                    <button title="<?php echo HR_FILTER11; ?>" type="button"
                            value="itemCategory itemCategory_ointment" <?php if (isset($_GET['filter']) && $_GET['filter'] == 11) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=11'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_ointment"
                            alt="itemCategory itemCategory_ointment"></button>
                    <button title="<?php echo HR_FILTER12; ?>" type="button"
                            value="itemCategory itemCategory_bucketOfWater" <?php if (isset($_GET['filter']) && $_GET['filter'] == 12) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=12'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_bucketOfWater"
                            alt="itemCategory itemCategory_bucketOfWater"></button>
                    <button title="<?php echo HR_FILTER13; ?>" type="button"
                            value="itemCategory itemCategory_bookOfWisdom" <?php if (isset($_GET['filter']) && $_GET['filter'] == 13) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=13'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_bookOfWisdom"
                            alt="itemCategory itemCategory_bookOfWisdom"></button>
                    <button title="<?php echo HR_FILTER14; ?>" type="button"
                            value="itemCategory itemCategory_lawTables" <?php if (isset($_GET['filter']) && $_GET['filter'] == 14) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=14'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_lawTables"
                            alt="itemCategory itemCategory_lawTables"></button>
                    <button title="<?php echo HR_FILTER15; ?>" type="button"
                            value="itemCategory itemCategory_artWork" <?php if (isset($_GET['filter']) && $_GET['filter'] == 15) {
                        echo "class=\"iconFilter iconFilterActive\"";
                    } else {
                        echo "class=\"iconFilter\"";
                    } ?> onclick="window.location.href = '?action=buy&amp;filter=15'; return false;"><img
                            src="img/x.gif" class="itemCategory itemCategory_artWork"
                            alt="itemCategory itemCategory_artWork"></button>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>

<?php
    $prefix = "" . TB_PREFIX . "auction";
    if (isset($_GET['filter'])) {
        $mmm = "AND btype=" . $_GET['filter'];
    } else {
        $mmm = "";
    }
    $sql = mysql_query("SELECT * FROM $prefix WHERE finish = 0 and owner != $session->uid $mmm ORDER BY time ASC");
    $query = mysql_num_rows($sql);

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

    if (isset($_GET['filter'])) {
        $filterPages = "&filter=" . $_GET['filter'];
    } else {
        $filterPages = "";
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
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=2">2</a>';

    } elseif ($page == 1 && $lastPage == 3) {
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=2">2</a> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=3">3</a>';

    } elseif ($page == 1) {
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $add1 . '">' . $add1 . '</a> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $add2 . '">' . $add2 . '</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page == $lastPage && $lastPage == 2) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == $lastPage && $lastPage == 3) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=2">2</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == $lastPage) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub2 . '">' . $sub2 . '</a> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span>';

    } else if ($page == ($lastPage - 1) && $lastPage == 3) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page > 2 && $page < ($lastPage - 1)) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $add1 . '">' . $add1 . '</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page == ($lastPage - 1)) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=1">1</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $lastPage . '">' . $lastPage . '</a>';

    } else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $add1 . '">' . $add1 . '</a>';

    } else if ($page > 1 && $page < $lastPage) {
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $sub1 . '">' . $sub1 . '</a> ';
        $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $add1 . '">' . $add1 . '</a> ... ';
        $centerPages .= '<a class="number" href="?action=buy' . $filterPages . '&page=' . $lastPage . '">' . $lastPage . '</a>';
    }

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
        $paginationDisplay .= '<a class="next" href="?action=buy' . $filterPages . '&page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="last" href="?action=buy' . $filterPages . '&page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

    } elseif ($page != "1" && $page != $lastPage) {
        $paginationDisplay .= '<a class="first" href="?action=buy' . $filterPages . '&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="previous" href="?action=buy' . $filterPages . '&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
        $paginationDisplay .= $centerPages;
        $paginationDisplay .= '<a class="next" href="?action=buy' . $filterPages . '&page=' . $nextPage . '"><img alt="' . NEXTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="last" href="?action=buy' . $filterPages . '&page=' . $lastPage . '"><img alt="' . LASTPAGE . '" src="img/x.gif"></a>';

    } elseif ($page == $lastPage) {
        $paginationDisplay .= '<a class="first" href="?action=buy' . $filterPages . '&page=1"><img alt="' . FIRSTPAGE . '" src="img/x.gif"></a> ';
        $paginationDisplay .= '<a class="previous" href="?action=buy' . $filterPages . '&page=' . $previous . '"><img alt="' . PREVPAGE . '" src="img/x.gif"></a>';
        $paginationDisplay .= $centerPages;
        $paginationDisplay .= '<img alt="' . NEXTPAGE . '" src="img/x.gif" class="next disabled"> ';
        $paginationDisplay .= '<img alt="' . LASTPAGE . '" src="img/x.gif" class="last disabled">';
    }

    if (isset($_GET['filter'])) {
        $mmm = "AND btype=" . $_GET['filter'];
    } else {
        $mmm = "";
    }
    $limit = 'LIMIT ' . ($page - 1) * $itemsPerPage . ',' . $itemsPerPage;
    $sql2 = mysql_query("SELECT * FROM $prefix WHERE finish = 0 and owner != $session->uid $mmm ORDER BY time ASC $limit");


    $typeArray = array('', 'helmet', 'body', 'leftHand', 'rightHand', 'shoes', 'horse', 'bandage25', 'bandage33', 'cage', 'scroll'
    , 'ointment', 'bucketOfWater', 'bookOfWisdom', 'lawTables', 'artWork');

    $outputList = '';

    if ($query == 0) {
        $outputList .= "<td colspan=\"6\" class=\"none\"><center>" . HR_NOITEM . "</center></td>";
    } else {
        while ($row = mysql_fetch_array($sql2)) {
            $id = $row["id"];
            $owner = $row["owner"];
            $btype = $row["btype"];
            $type = $row["type"];
            $num = $row["num"];
            $uid = $row["uid"];
            $bids = $row["bids"];
            $silver = $row["silver"];
            $maxsilver = $row["maxsilver"];
            $time = $row["time"];

            include "Templates/Auction/alt.tpl";

            if (isset($_GET['a']) && $_GET['a'] == $id) {
                $sStyle = " selected";
                $switchStyle = "Opened";
            } else {
                $sStyle = "";
                $switchStyle = "Closed";
            }
            $outputList .= "<tr><td class=\"icon" . $sStyle . "\"><img class=\"itemCategory itemCategory_" . $typeArray[$btype] . "\" src=\"img/x.gif\" title=\"" . $name . "||" . $title . "\"></td>";

            $outputList .= "<td class=\"name" . $sStyle . "\">" . $num . " x " . $name . "</td>";
            $outputList .= "<td class=\"bids" . $sStyle . "\">";
            if ($bids == 0) {
                $outputList .= "<span class=\"none\">" . $bids . "</span>";
            } else {
                $outputList .= $bids;
            }
            $outputList .= "</td>";
            $outputList .= "<td class=\"silver" . $sStyle . "\" title=\"" . round($silver / $num, 2) . " " . HR_FOREACHUNIT . "\">" . $silver . "</td>";
            $outputList .= "<td class=\"time" . $sStyle . "\"><span id=\"timer" . $timer . "\">" . $generator->getTimeFormat($time - time()) . "</span></td>";
            $outputList .= "";

            if ($session->uid == $uid || $session->silver > $silver) {
                if ($session->uid == $uid) {
                    $bidd = HR_CHANGE;
                } elseif ($session->silver > $silver) {
                    $bidd = HR_BID;
                }
                if (isset($_GET['page'])) {
                    $pURL = "&page=" . $_GET['page'];
                }
                if (isset($_GET['filter'])) {
                    $fURL = "&filter=" . $_GET['filter'];
                }
                $outputList .= "<td class=\"bid" . $sStyle . "\"><a class=\"bidButton openedClosedSwitch switch" . $switchStyle . "\" href=\"?action=buy" . $pURL . "" . $fURL . "&a=" . $id . "\">" . $bidd . "</a></td>";
            } else {
                $outputList .= "<td class=\"notEnoughSilver" . $sStyle . "\">" . HR_SILVERSHORTAGE . "</td>";
            }

            $outputList .= "</tr>";

            if (isset($_GET['a']) && $_GET['a'] == $id) {
                $outputList .= "<tr><td class=\"icon selected\"></td><td colspan=\"5\" class=\"name selected detail\">";
                $outputList .= "<form class=\"auctionDetails\" id=\"auctionDetails" . $_GET['a'] . "\" action=\"hero_auction.php\" method=\"POST\">";
                $outputList .= "<input type=\"hidden\" name=\"page\" value=\"" . $_GET['page'] . "\">";
                $outputList .= "<input type=\"hidden\" name=\"filter\" value=\"" . $_GET['filter'] . "\">";
                $outputList .= "<input type=\"hidden\" name=\"action\" value=\"" . $_GET['action'] . "\">";
                $outputList .= "<input type=\"hidden\" name=\"z\" value=\"1ce\">";
                $outputList .= "<input type=\"hidden\" name=\"silver\" value=\"" . $silver . "\">";
                $outputList .= "<input type=\"hidden\" name=\"a\" value=\"" . $_GET['a'] . "\">";
                $outputList .= "<div class=\"bidHeadline\">" . HR_BIDFOR . " " . $num . " × " . $name . "</div><div>";
                $outputList .= HR_CURRENTBID . ": <img title=\"" . HDR_SILVER . "\" class=\"silver\" src=\"img/x.gif\"> <span>" . $silver . "</span><br>" . HR_CURRENTBIDDER . ": ";
                if ($uid != 0) {
                    $outputList .= "" . $database->getUserField($uid, 'username', 0) . "";
                }
                if ($session->uid == $uid) {
                    $bidvalue = $maxsilver;
                } else {
                    $bidvalue = $silver + 1;
                }
                $outputList .= "<span></span><br>" . HR_MAXBID . ":<input class=\"maxBid text\" type=\"text\" name=\"maxBid\" value=\"" . $bidvalue . "\">";
                $outputList .= "<span> (" . HR_MINBID . " <img title=\"" . HDR_SILVER . "\" class=\"silver\" src=\"img/x.gif\"> " . (($session->uid == $uid) ? $silver : $silver + 1) . ")</span>";
                $outputList .= '<div class="submitBid">
	<button type="submit" value="' . HR_BID . '" name="s1" id="btn_ok" class="green build">
		<div class="button-container addHoverClick">
			<div class="button-background">
				<div class="buttonStart">
					<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">' . HR_BID . '</div></div></button></div></div></form></td></tr>';
            }

            $timer++;
        }
    }


?>

<table cellspacing="1" cellpadding="1">
    <thead>
    <tr>
        <th class="name" colspan="2"><?php echo AL_DESCRIPTION; ?></th>
        <th class="bids"><img title="<?php echo HR_BID; ?>" class="bids" src="img/x.gif"></th>
        <th class="silver"><img title="<?php echo HDR_SILVER; ?>" class="silver" src="img/x.gif"></th>
        <th class="time"><img title="<?php echo HR_DURATION; ?>" class="clock" src="img/x.gif"></th>
        <th class="bid"><?php echo HR_AUCTIONS; ?></th>
    </tr>
    </thead>

    <tbody>
    <?php echo $outputList; ?>
    </tbody>
</table>

<div class="paginator"><?php if ($query > 20) {
        echo $paginationDisplay;
    } ?></div>
</div>