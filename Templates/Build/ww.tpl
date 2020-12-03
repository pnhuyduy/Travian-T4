<h1 class="titleInHeader"><?php echo B40; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>

<div id="build" class="gid40">
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(40,4);" class="build_logo">
            <img class="building big white g40" src="img/x.gif" alt="<?php echo B40; ?>"
                 title="<?php echo B40; ?>"/></a>
        <?php echo B40_DESC; ?></div>

    <?php include "upgrade.tpl"; ?>
    <div class="clear"></div>
    <br/>

    <form action="GameEngine/Game/WorldWonderName.php" method="POST">
        <input type="hidden" name="vref" value="<?php echo $_SESSION['wid']; ?>"/>
        <?php
            $vref = $_SESSION['wid'];
            $wwname = $database->getWWName($vref);

            if ($village->resarray['f99'] < 5) {
                echo '<center>' . WWNAME . ': <input class="text" name="wwname" id="wwname" disabled="disabled" value="' . $wwname . '" maxlength="20">
					<button type="submit" value="button" class="green build" disabled="disabled">
		<div class="button-container addHoverClick">
			<div class="button-background">
				<div class="buttonStart">
					<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">' . OK . '</div></div>
		</button>
					

</center>';
            } else if ($village->resarray['f99'] >= 5) {
                echo '<center><br />' . WWNAME . ': <input class="text" name="wwname" id="wwname" value="' . $wwname . '" maxlength="20">
					<button type="submit" value="button" class="green build" name="s1">
		<div class="button-container addHoverClick">
			<div class="button-background">
				<div class="buttonStart">
					<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">' . OK . '</div></div>
                    </button></center>';
            } ?>
    </form>
    <?php
        if (isset($_GET['n'])) {
            echo '<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="Red"><b>' . WWNAMECHANGEDSUCCSS . '</b></font>';
        }
    ?>
    </p></div>