<h1 class="titleInHeader"><?php echo B18; ?> <span
        class="level"> <?php echo BL_LVL . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid18">
    <div class="build_desc">
        <a href="#" onClick="return Travian.Game.iPopup(18,4);" class="build_logo">
            <img class="building big white g18" src="img/x.gif" alt="<?php echo B18; ?>" title="<?php echo B18; ?>"/>
        </a>
        <?php echo B18_DESC; ?></div>

    <?php
        include("upgrade.tpl");
        if ($village->resarray['f' . $id] >= 3 && $session->alliance == 0) {
            include("18_create.tpl");
        }
        if ($session->alliance != 0) {
        echo "
<table cellpadding=\"1\" cellspacing=\"1\" id=\"ally_info\" class=\"transparent\"><div class=\"clear\"></div>
        <h4 class=\"round\">Alliance</h4>
	<tbody><tr>
		<th>" . AL_TAG . ":</th>
		<td>" . $alliance->allianceArray['tag'] . "</td>
	</tr>
	<tr>
		<th>" . AL_NAME . ":</th>
		<td>" . $alliance->allianceArray['name'] . "</td>

	</tr>
	<tr>
		<td colspan=\"2\"><a href=\"allianz.php\" class=\"arrow\">" . AL_TOTHEALLIANCE . "</a></td>
	</tr></tbody>
	</table>";
    }
        else {
    ?>
    <div class="clear"></div>
    <h4 class="round"><?php echo AL_INVITES; ?></h4>
    <table cellpadding="1" cellspacing="1" id="join" class="transparent">
        <tbody>
        <form method="post" action="build.php">
            <input type="hidden" name="id" value="<?php echo $id ?>">
            <input type="hidden" name="a" value="2">
            <tr>
                <?php
                    if ($alliance->gotInvite) {
                        foreach ($alliance->inviteArray as $invite) {
                            echo "
             <div>
             <button type=\"button\" value=\"npc\" class=\"icon\" onclick=\"window.location.href = 'build.php?id=" . $id . "&a=2&d=" . $invite['id'] . "'; return false;\"><img class=\"del\" src=\"img/x.gif\" alt=\"" . AL_DELETE . "\" title=\"" . AL_DELETE . "\" /></button>
        <a href=\"allianz.php?aid=" . $invite['alliance'] . "\">&nbsp;" . $database->getAllianceName($invite['alliance']) . "</a>
         
		 <button type=\"submit\" value=\"button\" class=\"green build\" onclick=\"window.location.href = 'build.php?id=" . $id . "&a=3&d=" . $invite['id'] . "'; return false;\">
		<div class=\"button-container addHoverClick\">
			<div class=\"button-background\">
				<div class=\"buttonStart\">
					<div class=\"buttonEnd\">
					<div class=\"buttonMiddle\"></div>
				</div>
			</div>
		</div>
		<div class=\"button-content\">" . AL_ACCEPT . "</div></div></button></div>";
                        }
                    } else {
                        echo "<td colspan=\"3\" class=\"noData\">" . AL_NOINVITES . "</td>";
                    }
                ?>
            </tr>

            <?php
                if ($alliance->gotInvite) {
                    echo "<p class=\"error2\"></p>";
                }
                echo "<div class='error'>" . $form->getError('ally_accept') . "</div>";
                }
            ?>
        </form>
        </tbody>
    </table>
    <div class="clear"></div>
    <br/>
</div>
