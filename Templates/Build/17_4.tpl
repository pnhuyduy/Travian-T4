<h1 class="titleInHeader"><?php echo B17; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid17">
    <?php include("17_menu.tpl"); ?>
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(17,4);" class="build_logo">
            <img class="building big white g17" src="img/x.gif" alt="<?php echo B17; ?>" title="<?php echo B17; ?>"/>
        </a>
        <?php echo B17_DESC; ?></div>
    <?php
        include("upgrade.tpl");

        if ($session->goldclub == 1 && count($database->getProfileVillages($session->uid)) > 1) {

        if (isset($_GET['action'])) {
            $_GET['action'] = filter_var($_GET['action'], FILTER_SANITIZE_SPECIAL_CHARS);
        }
        if (isset($_GET['routeid'])) {
            $_GET['routeid'] = filter_var($_GET['routeid'], FILTER_SANITIZE_NUMBER_INT);
            $_GET['routeid'] = abs($_GET['routeid']);
        }
        // echo time();
        // -- //
        if (isset($_GET['create']) && $session->gold > 1){
        include("17_create.tpl");
    }else if ($_GET['action'] == 'editRoute' && isset($_GET['routeid']) && $_GET['routeid'] != ""){
        $traderoute = $database->getTradeRouteUid($_GET['routeid']);
        if ($traderoute == $session->uid) {
            include("17_edit.tpl");
        }
    }else{
    ?>
    <div class="contentNavi"></div>
    <div class="round spacer listTitle">
        <div class="listTitleText">
            Trade Route
        </div>
        <div class="clear"></div>
    </div>
    <table id="npc" cellpadding="1" cellspacing="1">
        <thead>
        <tr>
            <th colspan="2"><?php echo AL_DESCRIPTION;?></th>
            <th><?php echo MK_START;?></th>
            <th><?php echo MK_MERCHANTS;?></th>
            <th><?php echo MK_ACTION;?></th>
        </tr>
        </thead>
        <tbody>
        <?php
            $routes = $database->getTradeRoute($session->uid);
            if (count($routes) == 0) {
                echo "<td colspan=\"5\" class=\"none\">".MK_NOTRADEROUTE."</td></tr>";
            } else {
                foreach ($routes as $route) {
                    ?>
                    <tr>
                        <th><a href="build.php?action=delRoute&routeid=<?php echo $route['id']; ?>"><img class="del"
                                                                                                         src="img/x.gif"
                                                                                                         alt="<?php echo MK_DELETE;?>"
                                                                                                         title="<?php echo MK_DELETE;?>"></a>
                        </th>
                        <th>
                            <?php
                                echo "Trade Route <a href=karte.php?d=" . $route['wid'] . "&c=" . $generator->getMapCheck($route['wid']) . ">" . $database->getVillageField($route['wid'], "name") . "</a></br>";
                            ?>
                            <img src="<?php echo GP_LOCATE; ?>img/r/1.gif" alt="wood"
                                 title="wood"> <?php echo $route['wood']; ?>  <img
                                src="<?php echo GP_LOCATE; ?>img/r/2.gif" alt="clay"
                                title="clay"> <?php echo $route['clay']; ?>  <img
                                src="<?php echo GP_LOCATE; ?>img/r/3.gif" alt="iron"
                                title="iron"> <?php echo $route['iron']; ?>  <img
                                src="<?php echo GP_LOCATE; ?>img/r/4.gif" alt="crop"
                                title="crop"> <?php echo $route['crop']; ?>
                        </th>
                        <th><?php if ($route['start'] > 9) {
                                echo $route['start'];
                            } else {
                                echo "0" . $route['start'];
                            }
                                echo ":00"; ?></th>
                        <th><?php echo $route['deliveries'] . "x" . $route['merchant']; ?></th>
                        <th>
                            <a href="build.php?id=<?php echo $id; ?>&t=4&action=editRoute&routeid=<?php echo $route['id']; ?>">»<?php echo MK_EDIT;?></a></th>
                    </tr>
                <?php }
            } ?>
        </tbody>
    </table>
    <br>

    <div class="options">
        <a class="arrow" href="build.php?gid=17&t=4&create"> <?php echo MK_NEWROUTE;?></a>
    </div>
</div>
<?php
    }

    } else {

    echo MK_NEWROUTEDESC;

    ?>
    <br><br>
    <button type="button" value="Gold club" id="button5300d0c553036" class="gold builder">
        <div class="button-container addHoverClick ">
            <div class="button-background">
                <div class="buttonStart">
                    <div class="buttonEnd">
                        <div class="buttonMiddle"></div>
                    </div>
                </div>
            </div>
            <div class="button-content"><?php echo AT_GOLDCLUB;?></div>
        </div>
    </button>
    <script type="text/javascript">
        window.addEvent('domready', function () {
            if ($('button5300d0c553036')) {
                $('button5300d0c553036').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "button", "value": "Gold club", "name": "", "id": "button5300d0c553036", "class": "gold builder", "title": "<?php echo MK_EVASIONDESC;?>", "confirm": "", "onclick": "", "goldclubDialog": {"featureKey": "troopEscape", "infoIcon": "http:\/\/t4.answers.travian.ir\/index.php?aid=Travian Answers#go2answer"}}]);
                });
            }
        });
    </script> </div>
<?php
}
?>