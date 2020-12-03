<?php
    if (isset($_GET['aid'])) {
        $aid = $session->alliance;
    }
    $varmedal = $database->getProfileMedalAlly($aid);


    $allianceinfo = $database->getAlliance($aid);
    $memberlist = $database->getAllMember($aid);
    $totalpop = 0;

    foreach ($memberlist as $member) {
        $totalpop += $database->getVSumField($member['id'], "pop");
    }

    echo "<h1 class=\"titleInHeader\">" . AL_LEAVEALLI . " - " . $allianceinfo['tag'] . "</h1>";

    $profiel = "" . $allianceinfo['notice'] . "" . md5(skJkev3) . "" . $allianceinfo['desc'] . "";
    require("medal.php");
    $profiel = explode("" . md5(skJkev3) . "", $profiel);

    include("alli_menu.tpl");

?>
<div id="details">
    <h4 class="round small"><?php echo AL_DETAILS; ?>:</h4>
    <table cellpadding="1" cellspacing="1" class="transparent">
        <tbody>
        <tr>
            <th><?php echo AL_TAG; ?>:</th>
            <td><?php echo $allianceinfo['tag']; ?></td>
        </tr>
        <tr>
            <th><?php echo AL_NAME; ?>:</th>
            <td><?php echo $allianceinfo['name']; ?></td>
        </tr>
        <tr>
            <th><?php echo AL_RANK; ?>:</th>
            <td><?php echo $ranking->getAllianceRank($aid); ?></td>
        </tr>

        <tr>
            <th><?php echo AL_POINTS; ?>:</th>
            <td><?php echo $totalpop; ?></td>
        </tr>

        <tr>
            <th><?php echo AL_MEMBERS; ?>:</th>
            <td><?php echo count($memberlist); ?></td>
        </tr>

        </tbody>
    </table>
</div>
<div id="memberTitles">
    <h4 class="round small"><?php echo AL_POSITION; ?></h4>
    <table cellpadding="1" cellspacing="1" class="transparent">
        <tbody>
        <?php
            foreach ($memberlist as $member) {

                //rank name
                $rank = $database->getAlliancePermission($member['id'], "rank", 0);

                //username
                $name = $database->getUserField($member['id'], "username", 0);

                //if there is no rank defined, user will not be printed
                if ($rank == '') {
                    echo '';
                } //if there is user rank defined, user will be printed
                else if ($rank != '') {
                    echo "<tr>";
                    echo "<th>" . $rank . "</th>";
                    echo "<td><a href='spieler.php?uid=" . $member['id'] . "'>" . $name . "</td>";
                    echo "</tr>";
                }
            }?>

        </tbody>
    </table>
</div>
<div class="clear"></div>
<h4 class="round"><?php echo AL_DESCRIPTION; ?></h4>
<div class="description description1">
    <?php echo nl2br($profiel[1]); ?>
</div>
<div class="description description2">
    <?php echo nl2br($profiel[0]); ?>
</div>
<div class="clear"></div>
<h4 class="round"><?php echo AL_MEMBERS; ?></h4>
<table cellpadding="1" cellspacing="1" id="member">
    <thead>
    <tr>
        <th><?php echo AL_NAME; ?></th>
        <th><?php echo AL_POPULATION; ?></th>
        <th><?php echo MV_VILL2; ?></th>
    </tr>
    </thead>
    <tbody>
    <?php
        // Alliance Member list loop
        $rank = 0;
        foreach ($memberlist as $member) {

            $rank = $rank + 1;
            $TotalUserPop = $database->getVSumField($member['id'], "pop");
            $TotalVillages = $database->getProfileVillages($member['id']);

            echo "<tr>";
            echo "<td class=pla>";
            if ($aid == $session->alliance) {
                if ((time() - 600) < $member['timestamp']) { // 0 Min - 10 Min
                    echo "<img class='online online1' src=img/x.gif title='" . AL_ONLINE . "' alt='" . AL_ONLINE . "' />";
                } elseif ((time() - 86400) < $member['timestamp'] && (time() - 600) > $member['timestamp']) { // 10 Min - 1 Days
                    echo "<img class='online online2' src=img/x.gif title='" . AL_ACTIVE_PLAYERS . "' alt='" . AL_ACTIVE_PLAYERS . "' />";
                } elseif ((time() - 259200) < $member['timestamp'] && (time() - 86400) > $member['timestamp']) { // 1-3 Days
                    echo "<img class='online online3' src=img/x.gif title='" . AL_ACTIVE_LAST3DAYS . "' alt='" . AL_ACTIVE_LAST3DAYS . "' />";
                } elseif ((time() - 604800) < $member['timestamp'] && (time() - 259200) > $member['timestamp']) { // 3-7 Days
                    echo "<img class='online online4' src=img/x.gif title='" . AL_ACTIVE_LAST7DAYS . "' alt='" . AL_ACTIVE_LAST7DAYS . "' />";
                } else {
                    echo '<img class="online online5" src="img/x.gif" title="' . AL_LAZY . '" alt="' . AL_LAZY . '" />';
                }
            }
            echo "<a href=spieler.php?uid=" . $member['id'] . ">" . $member['username'] . "</a></td>";
            echo "<td class=hab>" . $TotalUserPop . "</td>";
            echo "<td class=vil>" . count($TotalVillages) . "</td>";
            echo "</tr>";
        }

    ?>
    </tbody>
</table>