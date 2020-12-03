<?php if ($session->plus) { ?>
    <div title="" <?php if (isset($_GET['tid']) && $_GET['tid'] == 102) {
        echo "class=\"container gold active\"";
    } else {
        echo "class=\"container gold normal\"";
    } ?>>
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="statistiken.php?tid=102"><span class="tabItem"><?php echo PF_PLUS;?></span></a></div>
    </div>
<?php } ?>