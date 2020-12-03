<div class="contentNavi subNavi">
    <div class="container <?php if (!isset($_GET['s'])) {
        echo 'active';
    } else {
        echo 'normal';
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php"><span class="tabItem"><?php echo AL_OVERVIEW; ?></span></a></div>
    </div>
    <div class="container <?php if ($_GET['s'] == 2) {
        echo 'active';
    } else {
        echo 'normal';
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=2"><span class="tabItem"><?php echo VL_RESOURCE; ?></span></a></div>
    </div>
    <div class="container <?php if ($_GET['s'] == 3) {
        echo 'active';
    } else {
        echo 'normal';
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=3"><span class="tabItem"><?php echo B10; ?></span></a></div>
    </div>
    <div class="container <?php if ($_GET['s'] == 4) {
        echo 'active';
    } else {
        echo 'normal';
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=4"><span class="tabItem"><?php echo BL_CULTUREPOINTS; ?></span></a></div>
    </div>
    <div class="container <?php if ($_GET['s'] == 5) {
        echo 'active';
    } else {
        echo 'normal';
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php?s=5"><span class="tabItem"><?php echo AT_TROOPS; ?></span></a></div>
    </div>
    <div class="clear"></div>
</div>
