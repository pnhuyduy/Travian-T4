<?php if (WW == TRUE) { ?>
    <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 99) {
        echo "class=\"container active\"";
    } else {
        echo "class=\"container normal\"";
    } ?>>
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=99"><span class="tabItem"><?php echo B40; ?></span></a></div>
    </div>
<?php } ?>