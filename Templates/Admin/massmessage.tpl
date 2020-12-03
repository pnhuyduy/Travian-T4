<?php
if ($_POST['submit'] == 'Send') {
    unset ($_SESSION['m_message']);
    unset ($_SESSION['m_subject']);
    unset ($_SESSION['m_color']);
    if (!$_POST['message']) {
        die('You have to enter message');
    }
    if (!$_POST['subject']) {
        die('You have to enter subject');
    }
    if (!$_POST['color']) {
        $_SESSION['m_color'] = 'black';
    }
    $_SESSION['m_subject'] = $_POST['subject'];
    if (!$_SESSION['m_color']) {
        $_SESSION['m_color'] = $_POST['color'];
    }
    $_SESSION['m_message'] = $_POST['message'];
    $NextStep = true;
}


if (isset($_POST['confirm'])) {
    if ($_POST['confirm'] == 'Yes') $NextStep2 = true;
    if ($_POST['confirm'] == 'No') $Interupt = true;
}
$max_per_pass = 1000;
if (isset($_GET['send']) && isset($_GET['from'])) {
    $_SESSION['m_message'] = preg_replace("/\[img\]([a-z0-9\_\.\:\/\-]*)\[\/img\]/i", "<img src='$1' alt='Corrupted image'/>", $_SESSION['m_message']);
    $_SESSION['m_message'] = preg_replace("/\[url\]([a-z0-9\_\.\:\/\-]*)\[\/url\]/i", "<a href='$1'>$1</a>", $_SESSION['m_message']);
    $_SESSION['m_message'] = preg_replace("/\[url\=([a-z0-9\_\.\:\/\-]*)\]([a-z0-9\_\.\:\/\-]*)\[\/url\]/i", "<a href='$1'>$2</a>", $_SESSION['m_message']);
    $_SESSION['m_message'] = preg_replace("/\*u([0-9]*)(left|right)\*/i", "<img src='img/u2/u$1.gif' style='float:$2;' alt='unit$1' />", $_SESSION['m_message']);

    $users_count = mysql_fetch_assoc(mysql_query("SELECT count(*) as count FROM " . TB_PREFIX . "users WHERE id != 0"));
    $users_count = $users_count['count'];
    $result = mysql_query("SELECT `id` FROM " . TB_PREFIX . "users WHERE id > 2");
    $max = mysql_num_rows($result);
    $sql = "INSERT INTO " . TB_PREFIX . "mdata (`target`, `owner`, `topic`, `message`, `viewed`, `archived`, `send`, `time`) VALUES ";
    $Ffrom = $_GET['from'] ? $_GET['from'] : 0;
    for ($i = 0; $i <= $max; $i++) {
        $row = mysql_fetch_row($result);
        if ($_SESSION['m_color']) {
            $sql .= "('" . $row[0] . "', '" . $Ffrom . "', '<span style=\'color:{$_SESSION['m_color']};\'>{$_SESSION['m_subject']}</span>', \"{$_SESSION['m_message']}\", 0, 0, 0, " . time() . "),";
        } else {
            $sql .= "('" . $row[0] . "', '" . $Ffrom . "', '{$_SESSION['m_subject']}', \"{$_SESSION['m_message']}\", 0, 0, 0, " . time() . "),";
        }
    }
    if ($_SESSION['m_color']) {
        $sql .= "('" . $Ffrom . "', '" . $Ffrom . "', '<span style=\'color:{$_SESSION['m_color']};\'>{$_SESSION['m_subject']}</span>', \"{$_SESSION['m_message']}\", 0, 0, 0, " . time() . ")";
    } else {
        $sql .= "('" . $Ffrom . "', '" . $Ffrom . "', '{$_SESSION['m_subject']}', \"{$_SESSION['m_message']}\", 0, 0, 0, " . time() . "),";
    }
    mysql_query($sql);
    if (($users_count - $_GET['from']) > $max_per_pass) echo header("Location: Admins.php?tid=1&send=true&from=", $_GET['from'] + $max_per_pass); else $done = true;
}
?>

<?php if (!$NextStep && !$NextStep2 && !$done) { ?>
    <div id="bbEditor">
    <div id="message_container" class="bbEditor">
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
    <div id="message_toolbar" class="bbToolbar">
    <button type="button" value="bbBold" title="بلد"
            class="icon bbButton bbBold bbType{d} bbTag{b}"><img src="img/x.gif"
                                                                 class="bbBold"
                                                                 alt="bbBold"></button>
    <button type="button" title="ایتالیک" value="bbItalic"
            class="icon bbButton bbItalic bbType{d} bbTag{i}"><img src="img/x.gif"
                                                                   class="bbItalic"
                                                                   alt="bbItalic">
    </button>
    <button type="button" value="bbUnderscore" title="آندرلاین"
            class="icon bbButton bbUnderscore bbType{d} bbTag{u}"><img src="img/x.gif"
                                                                       class="bbUnderscore"
                                                                       alt="bbUnderscore">
    </button>
    <button type="button" value="bbAlliance" title="اتحاد<br><li>درج نام اتحاد</li>"
            class="icon bbButton bbAlliance bbType{d} bbTag{اتحاد0}"><img
            src="img/x.gif" class="bbAlliance" alt="bbAlliance"></button>
    <button type="button" title="بازیکن<br><li>درج نام بازیکن</li>" value="bbPlayer"
            class="icon bbButton bbPlayer bbType{d} bbTag{بازیکن0}"><img src="img/x.gif"
                                                                         class="bbPlayer"
                                                                         alt="bbPlayer">
    </button>
    <button type="button"
            title="مختصات<br><li>درج مختصات بصورت :</li><ul><font color=white size=3>(x|y)</font></ul>"
            value="bbCoordinate"
            class="icon bbButton bbCoordinate bbType{d} bbTag{مختصات0}"><img
            src="img/x.gif" class="bbCoordinate" alt="bbCoordinate"></button>
    <button type="button"
            title="گزارش<br><li>درج گزارش بصورت :</li><li>berichte.php?id=<font color=red>1</font></font></li><ul>[گزارش0]شماره آیدی گزارش[/گزارش0]</ul><ul>[گزارش0]<font color=red>1</font>[/گزارش0]</ul>"
            value="bbReport" class="icon bbButton bbReport bbType{d} bbTag{گزارش0}"><img
            src="img/x.gif" class="bbReport" alt="bbReport"></button>
    <button type="button" title="منابع" value="bbResource" id="message_resourceButton"
            class="bbWin{resources} bbButton bbResource icon"><img src="img/x.gif"
                                                                   class="bbResource"
                                                                   alt="bbResource">
    </button>
    <button type="button" title="شکلک" value="bbSmilies" id="message_smilieButton"
            class="bbWin{smilies} bbButton bbSmilies icon"><img src="img/x.gif"
                                                                class="bbSmilies"
                                                                alt="bbSmilies">
    </button>
    <button type="button" value="bbTroops" title="لشگریان" id="message_troopButton"
            class="bbWin{troops} bbButton bbTroops icon"><img src="img/x.gif"
                                                              class="bbTroops"
                                                              alt="bbTroops"></button>
    <button type="button" title="نمایش" value="bbPreview" id="message_previewButton"
            class="icon bbButton bbPreview"><img src="img/x.gif" class="bbPreview"
                                                 alt="bbPreview"></button>
    <div class="clear"></div>
    <div id="message_toolbarWindows" class="bbToolbarWindow">
    <div id="message_resources"><a href="#" class="bbType{o} bbTag{چوب}"><img
                src="img/x.gif" class="r1" alt="چوب" title="چوب"></a><a href="#"
                                                                        class="bbType{o} bbTag{خشت}"><img
                src="img/x.gif" class="r2" alt="خشت" title="خشت"></a><a href="#"
                                                                        class="bbType{o} bbTag{گندم}"><img
                src="img/x.gif" class="r4" alt="گندم" title="گندم"></a><a href="#"
                                                                          class="bbType{o} bbTag{آهن}"><img
                src="img/x.gif" class="r3" alt="آهن" title="آهن"></a></div>
    <div id="message_smilies"><a href="#" class="bbType{s} bbTag{*aha*}"
                                 title="*aha*"><img class="smiley aha"
                                                    src="img/x.gif" alt="*aha*"></a><a
            href="#" class="bbType{s} bbTag{*angry*} "><img class="smiley angry"
                                                            src="img/x.gif"
                                                            alt="*angry*"
                                                            title="*angry*"></a><a
            href="#" class="bbType{s} bbTag{*cool*} "><img class="smiley cool"
                                                           src="img/x.gif"
                                                           alt="*cool*"
                                                           title="*cool*"></a><a
            href="#" class="bbType{s} bbTag{*cry*} "><img class="smiley cry"
                                                          src="img/x.gif"
                                                          alt="*cry*" title="*cry*"></a><a
            href="#" class="bbType{s} bbTag{*cute*} "><img class="smiley cute"
                                                           src="img/x.gif"
                                                           alt="*cute*"
                                                           title="*cute*"></a><a
            href="#" class="bbType{s} bbTag{*depressed*} "><img
                class="smiley depressed" src="img/x.gif" alt="*depressed*"
                title="*depressed*"></a><a href="#" class="bbType{s} bbTag{*eek*} "><img
                class="smiley eek" src="img/x.gif" alt="*eek*" title="*eek*"></a><a
            href="#" class="bbType{s} bbTag{*ehem*} "><img class="smiley ehem"
                                                           src="img/x.gif"
                                                           alt="*ehem*"
                                                           title="*ehem*"></a><a
            href="#" class="bbType{s} bbTag{*emotional*} "><img
                class="smiley emotional" src="img/x.gif" alt="*emotional*"
                title="*emotional*"></a><a href="#"
                                           class="bbType{s} bbTag{:D} "><img
                class="smiley grin" src="img/x.gif" alt=":D" title=":D"></a><a
            href="#" class="bbType{s} bbTag{:)} "><img class="smiley happy"
                                                       src="img/x.gif" alt=":)"
                                                       title=":)"></a><a href="#"
                                                                         class="bbType{s} bbTag{*hit*} "><img
                class="smiley hit" src="img/x.gif" alt="*hit*" title="*hit*"></a><a
            href="#" class="bbType{s} bbTag{*hmm*}"><img class="smiley hmm"
                                                         src="img/x.gif" alt="*hmm*"
                                                         title="*hmm*"></a><a
            href="#" class="bbType{s} bbTag{*hmpf*}"><img class="smiley hmpf"
                                                          src="img/x.gif"
                                                          alt="*hmpf*"
                                                          title="*hmpf*"></a><a
            href="#" class="bbType{s} bbTag{*hrhr*}"><img class="smiley hrhr"
                                                          src="img/x.gif"
                                                          alt="*hrhr*"
                                                          title="*hrhr*"></a><a
            href="#" class="bbType{s} bbTag{*huh*}"><img class="smiley huh"
                                                         src="img/x.gif" alt="*huh*"
                                                         title="*huh*"></a><a
            href="#" class="bbType{s} bbTag{*lazy*}"><img class="smiley lazy"
                                                          src="img/x.gif"
                                                          alt="*lazy*"
                                                          title="*lazy*"></a><a
            href="#" class="bbType{s} bbTag{*love*}"><img class="smiley love"
                                                          src="img/x.gif"
                                                          alt="*love*"
                                                          title="*love*"></a><a
            href="#" class="bbType{s} bbTag{*nocomment*}"><img
                class="smiley nocomment" src="img/x.gif" alt="*nocomment*"
                title="*nocomment*"></a><a href="#"
                                           class="bbType{s} bbTag{*noemotion*}"><img
                class="smiley noemotion" src="img/x.gif" alt="*noemotion*"
                title="*noemotion*"></a><a href="#"
                                           class="bbType{s} bbTag{*notamused*}"><img
                class="smiley notamused" src="img/x.gif" alt="*notamused*"
                title="*notamused*"></a><a href="#" class="bbType{s} bbTag{*pout*}"><img
                class="smiley pout" src="img/x.gif" alt="*pout*" title="*pout*"></a><a
            href="#" class="bbType{s} bbTag{*redface*}"><img class="smiley redface"
                                                             src="img/x.gif"
                                                             alt="*redface*"
                                                             title="*redface*"></a><a
            href="#" class="bbType{s} bbTag{*rolleyes*}"><img
                class="smiley rolleyes" src="img/x.gif" alt="*rolleyes*"
                title="*rolleyes*"></a><a href="#" class="bbType{s} bbTag{:(}"><img
                class="smiley sad" src="img/x.gif" alt=":(" title=":("></a><a
            href="#" class="bbType{s} bbTag{*shy*}"><img class="smiley shy"
                                                         src="img/x.gif" alt="*shy*"
                                                         title="*shy*"></a><a
            href="#" class="bbType{s} bbTag{*smile*}"><img class="smiley smile"
                                                           src="img/x.gif"
                                                           alt="*smile*"
                                                           title="*smile*"></a><a
            href="#" class="bbType{s} bbTag{*tongue*}"><img class="smiley tongue"
                                                            src="img/x.gif"
                                                            alt="*tongue*"
                                                            title="*tongue*"></a><a
            href="#" class="bbType{s} bbTag{*veryangry*}"><img
                class="smiley veryangry" src="img/x.gif" alt="*veryangry*"
                title="*veryangry*"></a><a href="#"
                                           class="bbType{s} bbTag{*veryhappy*}"><img
                class="smiley veryhappy" src="img/x.gif" alt="*veryhappy*"
                title="*veryhappy*"></a><a href="#" class="bbType{s} bbTag{;)}"><img
                class="smiley wink" src="img/x.gif" alt=";)" title=";)"></a></div>
    <div id="message_troops"><a href="#" class="bbType{o} bbTag{tid1}"><img
                class="unit u1" src="img/x.gif" alt="سرباز لژیون"
                title="سرباز لژیون"></a>
        <a href="#" class="bbType{o} bbTag{tid2}"><img class="unit u2"
                                                       src="img/x.gif" alt="محافظ"
                                                       title="محافظ"></a>
        <a href="#" class="bbType{o} bbTag{tid3}"><img class="unit u3"
                                                       src="img/x.gif" alt="شمشیرزن"
                                                       title="شمشیرزن"></a>
        <a href="#" class="bbType{o} bbTag{tid4}"><img class="unit u4"
                                                       src="img/x.gif" alt="خبرچین"
                                                       title="خبرچین"></a>
        <a href="#" class="bbType{o} bbTag{tid5}"><img class="unit u5"
                                                       src="img/x.gif" alt="شوالیه"
                                                       title="شوالیه"></a>
        <a href="#" class="bbType{o} bbTag{tid6}"><img class="unit u6"
                                                       src="img/x.gif"
                                                       alt="شوالیۀ سزار"
                                                       title="شوالیۀ سزار"></a>
        <a href="#" class="bbType{o} bbTag{tid7}"><img class="unit u7"
                                                       src="img/x.gif" alt="دژکوب"
                                                       title="دژکوب"></a>
        <a href="#" class="bbType{o} bbTag{tid8}"><img class="unit u8"
                                                       src="img/x.gif"
                                                       alt="منجنیق آتشین"
                                                       title="منجنیق آتشین"></a>
        <a href="#" class="bbType{o} bbTag{tid9}"><img class="unit u9"
                                                       src="img/x.gif" alt="سناتور"
                                                       title="سناتور"></a>
        <a href="#" class="bbType{o} bbTag{tid10}"><img class="unit u10"
                                                        src="img/x.gif" alt="مهاجر"
                                                        title="مهاجر"></a>
        <a href="#" class="bbType{o} bbTag{tid11}"><img class="unit u11"
                                                        src="img/x.gif" alt="گرزدار"
                                                        title="گرزدار"></a>
        <a href="#" class="bbType{o} bbTag{tid12}"><img class="unit u12"
                                                        src="img/x.gif"
                                                        alt="نیزه دار"
                                                        title="نیزه دار"></a>
        <a href="#" class="bbType{o} bbTag{tid13}"><img class="unit u13"
                                                        src="img/x.gif" alt="تبرزن"
                                                        title="تبرزن"></a>
        <a href="#" class="bbType{o} bbTag{tid14}"><img class="unit u14"
                                                        src="img/x.gif" alt="جاسوس"
                                                        title="جاسوس"></a>
        <a href="#" class="bbType{o} bbTag{tid15}"><img class="unit u15"
                                                        src="img/x.gif" alt="دلاور"
                                                        title="دلاور"></a>
        <a href="#" class="bbType{o} bbTag{tid16}"><img class="unit u16"
                                                        src="img/x.gif"
                                                        alt="شوالیۀ توتن"
                                                        title="شوالیۀ توتن"></a>
        <a href="#" class="bbType{o} bbTag{tid17}"><img class="unit u17"
                                                        src="img/x.gif" alt="دژکوب"
                                                        title="دژکوب"></a>
        <a href="#" class="bbType{o} bbTag{tid18}"><img class="unit u18"
                                                        src="img/x.gif" alt="منجنیق"
                                                        title="منجنیق"></a>
        <a href="#" class="bbType{o} bbTag{tid19}"><img class="unit u19"
                                                        src="img/x.gif" alt="رئیس"
                                                        title="رئیس"></a>
        <a href="#" class="bbType{o} bbTag{tid20}"><img class="unit u20"
                                                        src="img/x.gif" alt="مهاجر"
                                                        title="مهاجر"></a>
        <a href="#" class="bbType{o} bbTag{tid21}"><img class="unit u21"
                                                        src="img/x.gif"
                                                        alt="سرباز پیاده"
                                                        title="سرباز پیاده"></a>
        <a href="#" class="bbType{o} bbTag{tid22}"><img class="unit u22"
                                                        src="img/x.gif"
                                                        alt="شمشیرزن"
                                                        title="شمشیرزن"></a>
        <a href="#" class="bbType{o} bbTag{tid23}"><img class="unit u23"
                                                        src="img/x.gif" alt="رد یاب"
                                                        title="رد یاب"></a>
        <a href="#" class="bbType{o} bbTag{tid24}"><img class="unit u24"
                                                        src="img/x.gif" alt="رعد"
                                                        title="رعد"></a>
        <a href="#" class="bbType{o} bbTag{tid25}"><img class="unit u25"
                                                        src="img/x.gif"
                                                        alt="کاهن سواره"
                                                        title="کاهن سواره"></a>
        <a href="#" class="bbType{o} bbTag{tid26}"><img class="unit u26"
                                                        src="img/x.gif"
                                                        alt="شوالیۀ گول"
                                                        title="شوالیۀ گول"></a>
        <a href="#" class="bbType{o} bbTag{tid27}"><img class="unit u27"
                                                        src="img/x.gif" alt="دژکوب"
                                                        title="دژکوب"></a>
        <a href="#" class="bbType{o} bbTag{tid28}"><img class="unit u28"
                                                        src="img/x.gif" alt="منجنیق"
                                                        title="منجنیق"></a>
        <a href="#" class="bbType{o} bbTag{tid29}"><img class="unit u29"
                                                        src="img/x.gif"
                                                        alt="رئیس قبیله"
                                                        title="رئیس قبیله"></a>
        <a href="#" class="bbType{o} bbTag{tid30}"><img class="unit u30"
                                                        src="img/x.gif" alt="مهاجر"
                                                        title="مهاجر"></a>
        <a href="#" class="bbType{o} bbTag{tid31}"><img class="unit u31"
                                                        src="img/x.gif"
                                                        alt="موش صحرایی"
                                                        title="موش صحرایی"></a>
        <a href="#" class="bbType{o} bbTag{tid32}"><img class="unit u32"
                                                        src="img/x.gif" alt="عنکبوت"
                                                        title="عنکبوت"></a>
        <a href="#" class="bbType{o} bbTag{tid33}"><img class="unit u33"
                                                        src="img/x.gif" alt="مار"
                                                        title="مار"></a>
        <a href="#" class="bbType{o} bbTag{tid34}"><img class="unit u34"
                                                        src="img/x.gif" alt="خفاش"
                                                        title="خفاش"></a>
        <a href="#" class="bbType{o} bbTag{tid35}"><img class="unit u35"
                                                        src="img/x.gif" alt="گراز"
                                                        title="گراز"></a>
        <a href="#" class="bbType{o} bbTag{tid36}"><img class="unit u36"
                                                        src="img/x.gif" alt="گرگ"
                                                        title="گرگ"></a>
        <a href="#" class="bbType{o} bbTag{tid37}"><img class="unit u37"
                                                        src="img/x.gif" alt="خرس"
                                                        title="خرس"></a>
        <a href="#" class="bbType{o} bbTag{tid38}"><img class="unit u38"
                                                        src="img/x.gif" alt="تمساح"
                                                        title="تمساح"></a>
        <a href="#" class="bbType{o} bbTag{tid39}"><img class="unit u39"
                                                        src="img/x.gif" alt="ببر"
                                                        title="ببر"></a>
        <a href="#" class="bbType{o} bbTag{tid40}"><img class="unit u40"
                                                        src="img/x.gif" alt="فیل"
                                                        title="فیل"></a>
        <a href="#" class="bbType{o} bbTag{tid41}"><img class="unit u41"
                                                        src="img/x.gif"
                                                        alt="نیزه دار ناتار"
                                                        title="نیزه دار ناتار"></a>
        <a href="#" class="bbType{o} bbTag{tid42}"><img class="unit u42"
                                                        src="img/x.gif"
                                                        alt="تيغ پوش"
                                                        title="تيغ پوش"></a>
        <a href="#" class="bbType{o} bbTag{tid43}"><img class="unit u43"
                                                        src="img/x.gif"
                                                        alt="محافظ ناتار"
                                                        title="محافظ ناتار"></a>
        <a href="#" class="bbType{o} bbTag{tid44}"><img class="unit u44"
                                                        src="img/x.gif"
                                                        alt="پرندگان شکاری"
                                                        title="پرندگان شکاری"></a>
        <a href="#" class="bbType{o} bbTag{tid45}"><img class="unit u45"
                                                        src="img/x.gif"
                                                        alt="تيشه زن"
                                                        title="تيشه زن"></a>
        <a href="#" class="bbType{o} bbTag{tid46}"><img class="unit u46"
                                                        src="img/x.gif"
                                                        alt="شوالیۀ ناتار"
                                                        title="شوالیۀ ناتار"></a>
        <a href="#" class="bbType{o} bbTag{tid47}"><img class="unit u47"
                                                        src="img/x.gif"
                                                        alt="فيل عظيم الجثۀ جنگی"
                                                        title="فيل عظيم الجثۀ جنگی"></a>
        <a href="#" class="bbType{o} bbTag{tid48}"><img class="unit u48"
                                                        src="img/x.gif"
                                                        alt="منجنیق عظيم"
                                                        title="منجنیق عظيم"></a>
        <a href="#" class="bbType{o} bbTag{tid49}"><img class="unit u49"
                                                        src="img/x.gif"
                                                        alt="امپراطوری ناتار"
                                                        title="امپراطوری ناتار"></a>
        <a href="#" class="bbType{o} bbTag{tid50}"><img class="unit u50"
                                                        src="img/x.gif" alt="مهاجر"
                                                        title="مهاجر"></a>
        <a href="#" class="bbType{o} bbTag{قهرمان}"><img class="unit uhero"
                                                         src="img/x.gif"
                                                         alt="قهرمان"
                                                         title="قهرمان"></a>
    </div>
    </div>
    </div>
    </div>
    </div>

    <form method="POST" action="Admins.php?tid=1" name="myform" id="myform">
        <table cellspacing="1" cellpadding="1" class="tbg"
               style="background-color:#C0C0C0; border: 0px solid #C0C0C0; font-size: 10pt;">
            <tbody>
            <tr>
                <td class="rbg" style="font-size: 10pt; text-align:center;"
                    colspan="3"><?php echo MASS; ?></td>
            </tr>
            <tr>
                <td style="font-size: 10pt; text-align: left; width: 200px;"><?php echo MASS_SUBJECT; ?></td>
                <td style="font-size: 10pt; text-align: left;">
                    <input type="text" style="width: 240px;" class="fm" name="subject" value=""
                           size="30" required></td>
            </tr>
            <tr>
                <td style="font-size: 10pt; text-align: left;"><?php echo MASS_COLOR; ?></td>
                <td style="font-size: 10pt; text-align: left;">
                    <input type="text" style="width: 240px;" class="fm" name="color" size="30"></td>
            </tr>
            <tr>
                <td style="font-size: 10pt; text-align: left;">از طرف :</td>
                <td style="font-size: 10pt; text-align: left;">
                    <select name="id_from">
                        <option value="1">ساپورت</option>
                        <option value="4">مولتی هانتر</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="font-size: 10pt; text-align:center;"><?php echo MASS; ?><br>
                    <textarea id="message" class="messageEditor" name="message" cols="60" rows="23"
                              required></textarea>

                    <div id="message_preview" class="messageEditor"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;"><?php echo MASS_REQUIRED; ?></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align:center;">
                    <input type="submit" value="Send" name="submit"/></td>
            </tr>
            </tbody>
        </table>
    </form>
    </div>
    <script type="text/javascript">
        window.addEvent('domready', function () {
            new Travian.Game.BBEditor("message");
        });
    </script>
    <script>
        var bbEditor = new BBEditor("message");
    </script>
    </div>
    <?php
    if (!$NextStep && !$NextStep2 && !$done) {

    }
} elseif ($NextStep) {
    ?>

    <form method="POST" action="Admins.php?tid=1">
        <input type="hidden" name="id_from" value="<?php echo $_POST['id_from']; ?>">
        <table cellspacing="1" cellpadding="2" class="tbg">
            <tbody>
            <tr>
                <textarea class="fm" name="message" cols="73" rows="23"
                          readonly="readonly"><?php echo $_POST['message']; ?></textarea>
            </tr>
            <tr>
                <td class="rbg" colspan="2"><?php echo MASS_CONFIRM; ?></td>
            </tr>
            <tr>
                <td style="text-align: left; width: 200px;"><?php echo MASS_REALLY; ?></td>
                <td style="text-align: left;">
                    <input type="submit" style="width: 240px;" class="fm" name="confirm" value="Yes">
                    <input type="submit" style="width: 240px;" class="fm" name="confirm" value="No"></td>
            </tr>
            </tbody>
        </table>
    </form>
<?php } elseif ($NextStep2) { ?>
    <script>document.location.href = 'Admins.php?tid=1&send=true&from=<?php echo $_POST['id_from'];?>'</script>
<?php } elseif ($Interupt) { ?>
    <b><?php echo MASS_ABORT; ?></b>
<?php
} elseif ($done) {
    echo MASS_SENT;
} else {
    die("مشکل در ارسال");
}?>
