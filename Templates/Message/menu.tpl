<div class="contentNavi subNavi">
    <div title="" class="<?php if (!isset($_GET['t'])) {
        echo "container active";
    } else {
        echo "container normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="nachrichten.php"><span class="tabItem"><?php echo MS_INBOX; ?></span></a></div>
    </div>
    <div title="" class="<?php if (isset($_GET['t']) && $_GET['t'] == 1) {
        echo "container active";
    } else {
        echo "container normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="nachrichten.php?t=1"><span class="tabItem"><?php echo MS_WRITE; ?></span></a>
        </div>
    </div>
    <div title="" class="<?php if (isset($_GET['t']) && $_GET['t'] == 2) {
        echo "container active";
    } else {
        echo "container normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="nachrichten.php?t=2"><span class="tabItem"><?php echo MS_SENT; ?></span></a>
        </div>
    </div>
    <?php if ($session->goldclub) { ?>
        <div class="<?php if (isset($_GET['t']) && $_GET['t'] == 3) {
            echo "container active";
        } else {
            echo "container normal";
        } ?>">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content"><a href="nachrichten.php?t=3"><span
                        class="tabItem"><?php echo MS_ARCHIVE; ?></span></a>
            </div>
        </div>
    <?php }else{ ?>
        <div class="container gold normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content">
                <a id="button5290832f16f3f" href="#"><span class="tabItem"><?php echo MS_ARCHIVE; ?></span></a></div>
        </div>
        <script type="text/javascript">
            if ($('button5290832f16f3f')) {
                $('button5290832f16f3f').addEvent('click', function () {
                    window.fireEvent('tabClicked', [this, {"class": "gold normal", "title": "<?php echo MS_ARCHIVEDESC;?>", "target": false, "id": "button5290832f16f3f", "href": "#", "onclick": false, "enabled": true, "text": "Archive", "dialog": false, "plusDialog": false, "goldclubDialog": {"featureKey": "messageArchive", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=Travian Answers#go2answer"}, "containerId": "", "buttonIdentifier": "button5290832f16f3f"}]);
                });
            }
        </script>
    <?php } ?>
    <div class="<?php if (isset($_GET['t']) && $_GET['t'] == 4) {
        echo "container active";
    } else {
        echo "container normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="nachrichten.php?t=4"><span class="tabItem"><?php echo MS_NOTEBOOK; ?></span></a>
        </div>
    </div>

    <div class="<?php if (isset($_GET['t']) && $_GET['t'] == 5) {
        echo "container active";
    } else {
        echo "container normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="nachrichten.php?t=5"><span class="tabItem"
                                                                 title="Ignored Player(s)"><?php echo MS_IGNOREP; ?></span></a>
        </div>
    </div>
    <?php if ($session->uid < 5) { ?>
        <div class="<?php if (isset($_GET['t']) && $_GET['t'] == 6) {
            echo "container gold active";
        } else {
            echo "container gold normal";
        } ?>">
            <div class="background-start">&nbsp;</div>
            <div class="background-end"><?php
                    $prefix = TB_PREFIX . "msg_reports";
                    $sql = mysql_query("SELECT `id` FROM $prefix WHERE viewed = 0 ORDER BY time DESC");
                    $query = mysql_num_rows($sql);
                    if ($query > 0) {
                        echo '<div class="speechBubbleContainer ">
			<div class="speechBubbleBackground">
				<div class="start">
					<div class="end">
						<div class="middle"></div>
					</div>
				</div>
			</div>
			<div class="speechBubbleContent">' . $query . '</div>
		</div>';
                    }
                ?>&nbsp;</div>
            <div class="content"><a href="nachrichten.php?t=6"><span class="tabItem" title="Reports"><?php echo MS_REPORTS;?></span></a>
            </div>
        </div>
    <?php } ?>

    <div class="clear"></div>
</div>
<script type="text/javascript">
    window.addEvent('domready', function () {
        $$('.subNavi').each(function (element) {
            new Travian.Game.Menu(element);
        });
    });
</script>