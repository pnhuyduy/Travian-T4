<h1 class="titleInHeader"><?php echo B16; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid16">
    <div class="contentNavi subNavi ">
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey0">
                <a href="build.php?id=<?php echo $id; ?>" class="tabItem"><?php echo BL_OVERVIEW; ?>

                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div id="overviewRallyPoint" class="content favor favorActive favorKey1">
                <a href="a2b.php" class="tabItem"><?php echo AT_SENDTROOPS; ?>
                     
                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey2">
                <a href="warsim.php" class="tabItem"><?php echo AT_COMBATSIMULATOR; ?>

                </a>
            </div>
        </div>
        <div class="container normal">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey3">
                <a href="build.php?id=<?php echo $id; ?>&t=99" class="tabItem"><?php echo AT_FARMLIST; ?>

                </a>
            </div>
        </div>
        <div class="container gold active">
            <div class="background-start">&nbsp;</div>
            <div class="background-end">&nbsp;</div>
            <div class="content favor favorKey99">
                <a id="button5300d0c550a3c" href="<?php if ($session->goldclub) {
                    echo 'build.php?id=' . $id . '&t=100';
                } else {
                    echo '#';
                } ?>" class="tabItem"><?php echo AT_GOLDCLUB; ?>

                </a>
            </div>
        </div>
        <script type="text/javascript">
            if ($('button5300d0c550a3c')) {
                $('button5300d0c550a3c').addEvent('click', function () {
                    window.fireEvent('tabClicked', [this, {"class": "gold normal", "title": "<?php echo AT_FARMLISTDESC;?>", "target": false, "id": "button5300d0c550a3c", "href": "#", "onclick": false, "enabled": true, "text": "Farm List", "dialog": false, "plusDialog": false, <?php if(!$session->goldclub){ echo '"goldclubDialog":{"featureKey":"raidList","infoIcon":"http:\/\/t4.answers.travian.ir\/index.php?aid=Travian Answers#go2answer"},';} ?>"containerId": "", "buttonIdentifier": "button5300d0c550a3c"}]);
                });
            }
        </script>
        <div class="clear"></div>
    </div>

    <script type="text/javascript">
        window.addEvent('domready', function () {
            $$('.subNavi').each(function (element) {
                new Travian.Game.Menu(element);
            });
        });
    </script>
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(16,4);" class="build_logo">
            <img class="g16 big white" src="img/x.gif" alt="<?php echo B16; ?>" title="<?php echo B16; ?>"/>
        </a>
        <?php echo B4_DESC; ?></div>
    <?php include("upgrade.tpl");
        if (isset($_GET['disable'])) {
            $database->query("UPDATE `" . TB_PREFIX . "vdata` SET `evasion`=0 WHERE `wref` = '" . $village->wid . "'");
            header("Location: build.php?id=39&t=100");
            echo "<SCRIPT language='JavaScript'>window.location='build.php?id=39&t=100';</SCRIPT>";
        }
        if (isset($_GET['enable'])) {
            $database->query("UPDATE `" . TB_PREFIX . "vdata` SET `evasion`=1 WHERE `wref` = '" . $village->wid . "'");
            header("Location: build.php?id=39&t=100");
            echo "<SCRIPT language='JavaScript'>window.location='build.php?id=39&t=100';</SCRIPT>";
        }
        $evasion = mysql_fetch_array($database->query("SELECT * FROM `" . TB_PREFIX . "vdata` WHERE `wref` = '" . $village->wid . "'"));
    ?>
    <div class="contentNavi"></div>
    <div class="round spacer listTitle">
        <div class="listTitleText">
            Evasion
        </div>
        <div class="clear"></div>
    </div>
    <div id="raidList">
        <div class="options">
            <br>
            <?php echo AT_EXCAPEDESC; ?>
            <br>
            <?php if ($evasion['evasion'] == 1) {
                echo AT_EVASIONEN;
            } else {
                echo AT_EVASIONDA;
            } ?>
            <br><br><br>
            <input type="checkbox" class="check" name="hideShow"
                   onclick="window.location.href = '?id=39&t=100&<?php if ($evasion['evasion'] == 1) {
                       echo "disable";
                   } else {
                       echo "enable";
                   } ?>';"  <?php if ($evasion['evasion'] == 1) {
                echo "checked=\"checked\"";
            } else {
                echo "";
            } ?>>
           <?php echo AT_ACEVASION;?>
        </div>
    </div>
</div>