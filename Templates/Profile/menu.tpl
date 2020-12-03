<div class="contentNavi subNavi">
    <div title="" class="container <?php if (isset($_GET['uid'])) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="spieler.php?uid=<?php if (isset($_GET['uid'])) {
                echo $_GET['uid'];
            } else {
                echo $session->uid;
            } ?>"><span class="tabItem"><?php echo AL_OVERVIEW; ?></span></a></div>
    </div>
    <?php if (!$session->is_sitter) { ?>
        <div title="" class="container <?php if (isset($_GET['s']) && $_GET['s'] == 1) {
            echo "active";
        } else {
            echo "normal";
        } ?>">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content"><a href="spieler.php?s=1"><span
                        class="tabItem"><?php echo PF_EDITPROFILE; ?></span></a></div>
        </div>
        <div class="clear"></div>
    <?php } ?>
</div>
