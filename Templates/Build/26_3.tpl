<h1 class="titleInHeader"><?php echo B26; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid26">
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(26,4, 'gid');" class="build_logo">
            <img class="building big white g26" src="img/x.gif" alt="<?php echo B26; ?>" title="<?php echo B26; ?>"/>
        </a>
        <?php echo B26_DESC; ?></div>
    <?php
        include("upgrade.tpl");
        include("26_menu.tpl");
    ?>
<?php echo sprintf(BL_VILLAGELOYALTY, '<b>' . $database->getVillageField($village->wid, 'loyalty') . '</b>%') . '<br><br><b>' . BL_CANTCAPTURECAPITALS . '</b></div>'; ?>