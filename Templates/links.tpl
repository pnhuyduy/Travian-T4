<div id="sidebarBoxLinklist" class="sidebarBox   ">
    <div class="sidebarBoxBaseBox">
        <div class="baseBox baseBoxTop">
            <div class="baseBox baseBoxBottom">
                <div class="baseBox baseBoxCenter"></div>
            </div>
        </div>
    </div>
    <div class="sidebarBoxInnerBox">
        <div class="innerBox header ">
            <button type="button" id="button528bc9f5707f9" class="layoutButton <?php if (!$session->plus) {
                echo 'editBlack gold';
            } else {
                echo 'editWhite green';
            } ?>" onclick="return false;">
                <div class="button-container addHoverClick ">
                    <img src="img/x.gif" alt="">
                </div>
            </button>


            <?php if (!$session->plus) { ?>
                <script type="text/javascript">

                    if ($('button528bc9f5707f9')) {
                        $('button528bc9f5707f9').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "gold", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button528bc9f5707f9", "redirectUrl": "", "redirectUrlExternal": "", "plusDialog": {"featureKey": "linkList", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=Travian Answers#go2answer"}, "title": "<?php echo LL_LINKLIST;?>"}]);
                        });
                    }
                </script>
            <?php }else{ ?>
                <script type="text/javascript">
                    if ($('button528bc9f5707f9')) {
                        $('button528bc9f5707f9').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button528bc9f5707f9", "redirectUrl": "linklist.php", "redirectUrlExternal": "", "title": "<?php echo LL_LINKLIST;?>"}]);
                        });
                    }
                </script>
            <?php } ?>
            <div class="clear"></div>
            <div class="boxTitle"><?php echo LL_LINKLIST2; ?></div>
        </div>
        <div class="innerBox content">
            <?php
                if ($session->plus){
                $links = $database->getLinks($session->uid);
                $query = count($links);
                if ($query > 0){
                echo "<div id='linkList' class='listing'>
	<div class='head'>
	<a href='spieler.php?s=2' accesskey='L'>" . LL_LINKLIST2 . "</a>
</div><div class='list none'>";
                $t = 1;
                foreach ($links as $link) {
                    echo "<ul><li class='entry'><div style='position:absolute;right:4px;top:1px;'>" . $t . "</div>";
                    echo '<a href="' . $link['url'] . '" title="' . $link['name'] . '">' . $link['name'] . '</a></li></ul>';
                    $t++;
                }
            ?>
            <div class='pager'>
                <a href='#' class='back' style='display: none; '></a>
                <a href='#' class='next' style='display: none; '></a>
            </div>
        </div>
        <script type='text/javascript'>
            new Travian.Game.PageScroller({
                elementPrev: $('linkList').down('a.back'),
                elementNext: $('linkList').down('a.next'),
                elementList: $('linkList').down('div.list'),
                elementBackground: $('linkList').down('div.list')
            });
        </script>
    </div>
    <?php
        }
        } else {
        ?>
        <div class="linklistNotice"><?php echo LL_TPLUS; ?>
        </div><?php } ?>
</div>
<div class="innerBox footer"></div>
</div>
</div>

<?php $timestamp = $database->isDeleting($session->uid);
    if ($timestamp) {
        ?>
        <div id="sidebarBoxLinklist" class="sidebarBox ">
            <div class="sidebarBoxBaseBox">
                <div class="baseBox baseBoxTop">
                    <div class="baseBox baseBoxBottom">
                        <div class="baseBox baseBoxCenter"></div>
                    </div>
                </div>
            </div>
            <div class="sidebarBoxInnerBox">
                <div class="innerBox header ">
                    <button type="button" id="button528bc9f5707f9" class="layoutButton <?php if (!$session->plus) {
                        echo 'editBlack gold';
                    } else {
                        echo 'editWhite green';
                    } ?>" onclick="return false;">
                        <div class="button-container addHoverClick ">
                            <img src="img/x.gif" alt="">
                        </div>
                    </button>


                    <?php if (!$session->plus) { ?>
                        <script type="text/javascript">

                            if ($('button528bc9f5707f9')) {
                                $('button528bc9f5707f9').addEvent('click', function () {
                                    window.fireEvent('buttonClicked', [this, {"type": "gold", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button528bc9f5707f9", "redirectUrl": "", "redirectUrlExternal": "", "plusDialog": {"featureKey": "linkList", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=Travian Answers#go2answer"}, "title": "<?php echo LL_LINKLIST; ?>"}]);
                                });
                            }
                        </script>
                    <?php }else{ ?>
                        <script type="text/javascript">
                            if ($('button528bc9f5707f9')) {
                                $('button528bc9f5707f9').addEvent('click', function () {
                                    window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button528bc9f5707f9", "redirectUrl": "linklist.php", "redirectUrlExternal": "", "title": "<?php echo LL_LINKLIST; ?>"}]);
                                });
                            }
                        </script>
                    <?php } ?>
                    <div class="clear"></div>
                    <div class="boxTitle"><?php echo LL_LINKLIST2; ?></div>
                </div>
                <div class="innerBox content">
                    <?php echo "<tr><td colspan=\"2\" class=\"count\">";
                        $delduration = max(round(259200 / SPEED), 3600);
                        $cancelduration = $delduration * 2 / 3;
                        if ($timestamp > time() + $cancelduration) {
                            echo "<button type=\"button\" value=\"del\" class=\"icon\" onclick=\"window.location.href = 'spieler.php?s=3&id=" . $session->uid . "&a=1&e=4'; return false;\">
			<img src=\"img/x.gif\" class=\"del\" alt=\"del\"></button>";
                        }
                        $time = $generator->getTimeFormat(($timestamp - time()));
                        echo " " . DELETEIN . " <span id=\"timer" . $timer . "\">" . $time . "</span></td></tr>";
                        $timer++;
                    ?>
                </div>
                <div class="innerBox footer"></div>
            </div>
        </div>

    <?php
    }
?>