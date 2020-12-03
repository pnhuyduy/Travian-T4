<h1 class="titleInHeader"><?php echo sprintf(PL_TRAVIANBANK,'PLUS');?> </font></h1>
<div class="contentNavi subNavi">
    <div title="" class="container <?php if (!isset($_GET['id']) || (isset($_GET['id']) && $_GET['id'] == 1)) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start"></div>
        <div class="background-end"></div>
        <div class="content"><a href="plus.php"><span class="tabItem"> <?php echo HDR_BUYGOLD; ?> </span></a></div>
    </div>
    <div title="" class="container <?php if (isset($_GET['id']) && $_GET['id'] == 2) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php?id=2"><span class="tabItem"> <?php echo PL_ADVANTAGES; ?> </span></a></div>
    </div>
    <div title="" class="container <?php if (isset($_GET['id']) && $_GET['id'] == 3) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php?id=3"><span class="tabItem"> <?php echo PL_PLUSFEA; ?></span></a></div>
    </div>
    <div title="" class="container <?php if (isset($_GET['id']) && $_GET['id'] == 5) {
        echo "active";
    } else {
        echo "normal";
    } ?>">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php?id=5"><span class="tabItem"> <?php echo PL_FREEGOLD; ?></span></a></div>
    </div>
    <div class="clear"></div>
</div>
