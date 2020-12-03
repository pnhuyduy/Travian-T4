<?php
    $_GET['uid'] = filter_var($_GET['uid'], FILTER_SANITIZE_NUMBER_INT);
    $_GET['uid'] = filter_var($_GET['uid'], FILTER_SANITIZE_MAGIC_QUOTES);
    $displayarray = $database->getUser($_GET['uid'], 1);
    $varmedal = $database->getProfileMedal($_GET['uid']);
    $profiel = "" . $displayarray['desc1'] . "" . md5('skJkev3') . "" . $displayarray['desc2'] . "";
    require("medal.php");
    $profiel = explode("" . md5('skJkev3') . "", $profiel);
    $varray = $database->getProfileVillages($_GET['uid']);
    $totalpop = 0;
    foreach ($varray as $vil) {
        $totalpop += $vil['pop'];
    }

    $heroface = $database->getHeroFace($_GET['uid']);
?>
<h4 class="round"><?php echo REPORT_INFORMATION; ?></h4>
<?php
    if ($_GET['uid'] == 2) {
        echo '<img src="' . GPACK . '/img/t/t10_2.jpg" border="0">';
    } else {
        echo '<img class="heroImage" style="width:160px;height:205px;" src="hero_body.php?uid=' . $_GET['uid'] . '&size=profile&' . md5($_GET['uid']) . '&' . $heroface['hash'] . '" alt="hero">';
    }
?>
<table cellpadding="1" cellspacing="1" id="details" class="transparent">
    <tr>
        <th>
            <img src="img/icon/Rank.png"><b><?php echo PF_RANK; ?></th>

        <td><?php echo $ranking->getUserRank($displayarray['username']); ?></td>
    </tr>
    <tr>
        <th>
            <img src="img/icon/Tribe.png"><b><?php echo TRIBE; ?></th>
        <td>
            <?php
                switch ($displayarray['tribe']) {
                    case 1:
                        echo TRIBE1;
                        break;
                    case 2:
                        echo TRIBE2;
                        break;
                    case 3:
                        echo TRIBE3;
                        break;
                    case 4:
                        echo TRIBE4;
                        break;
                    case 5:
                        echo TRIBE5;
                        break;
                }
            ?>
        </td>
    </tr>
    <tr>
        <th>
            <img src="img/icon/Ally.png"><b><?php echo AL_ALLIANCE; ?></th>
        <td>
            <?php
                if ($displayarray['alliance'] == 0) {
                    echo "-";
                } else {
                    $displayalliance = $database->getAllianceName($displayarray['alliance']);
                    echo "<a href=\"allianz.php?aid=" . $displayarray['alliance'] . "\">" . $displayalliance . "</a>";
                }
            ?>
        </td>
    </tr>
    <tr>
        <th>
            <img src="img/icon/Home.png"><b><?php echo VILLAGES; ?></th>
        <td><?php echo count($varray); ?></td>
    </tr>
    <tr>
        <th>
            <img src="img/icon/Populations.png"><b>&#1580;&#1605;&#1593;&#1740;&#1578; </th>
        <td><?php echo $totalpop; ?></td>
    </tr>
    <?php
        //Date of Birth
        if (isset($displayarray['birthday']) && $displayarray['birthday'] != 0) {
            $age = date('Y') - substr($displayarray['birthday'], 0, 4);
            if ((date('m') - substr($displayarray['birthday'], 5, 2)) < 0) {
                $age--;
            } elseif ((date('m') - substr($displayarray['birthday'], 5, 2)) == 0) {
                if (date('d') < substr($displayarray['birthday'], 8, 2)) {
                    $age--;
                }
            }
            echo "<tr><th>
        <img src='img/icon/Brithday.png'><b>" . PF_BIRTHDAY . "</th><td>$age</td></tr></b>";
        }
        //Gender
        if (isset($displayarray['gender']) && $displayarray['gender'] != 0) {
            $gender = ($displayarray['gender'] == 1) ? PF_GENDER1 : PF_GENDER2;
            define('Gender', 'Gender');
            echo "<tr>
			        <th>
        <img src='img/icon/Gender.png'><b>" . Gender . "</th><td>" . $gender . "</td></tr></b>";
        }
        //Location
        if ($displayarray['location'] != "") {
            echo "<tr><th>
        <img src='img/icon/location.png'><b>" . AT_LOCATION . ":</th><td>" . $displayarray['location'] . "</td></tr></b>";
        }
    ?>
    <tr>
        <?php
            if ($_GET['uid'] == $session->uid) {
                if ($session->is_sitter) {
                    echo "<td colspan=\"2\"> <span class=\"a arrow disabled\">" . PF_EDITPROFILE . "</span></td>";
                } else {
                    echo "<td colspan=\"2\"> <a class=\"arrow\" href=\"spieler.php?s=1\">" . PF_EDITPROFILE . "</a></td>";
                }
            } else {
                echo "<td colspan=\"2\" id=\"player_message-ignore-buttons-block\"> <a class=\"message messageStatus messageStatusUnread\" href=\"nachrichten.php?t=1&amp;id=" . $_GET['uid'] . "\">".MS_SENDMSG."</a>
					   <br>
						<a href=\"\" id=\"ignore-player-button\" data-player-ignored=\"false\" data-uid=\"" . $_GET['uid'] . "\">".MS_IGNPLY."</a>
					</td>";
            }
        ?>
    </tr>
</table>


<div class="clear"></div>
<br/>

<h4 class="round"><?php echo AL_DESCRIPTION; ?></h4>

<div class="description description1"><?php echo nl2br($profiel[1]); ?></div>
<div class="description description2"><?php echo nl2br($profiel[0]); ?></div>

<div class="clear"></div>


<h4 class="round"><?php echo VILLAGES; ?></h4>

<table cellpadding="1" cellspacing="1" id="villages">
    <thead>
    <tr>
        <th class="name"><?php echo AL_NAME; ?></th>
        <th><?php echo VL_OASIS; ?></th>
        <th>&#1580;&#1605;&#1593;&#1740;&#1578;</th>
        <th><?php echo AT_LOCATION; ?></th>
    </tr>
    </thead>
    <tbody>
    <?php
        foreach ($varray as $vil) {
            $coor = $database->getCoor($vil['wref']);
            $vname = $vil['name'];
            if (defined($vname)) {
                $vname = constant($vname);
            }
            echo "<tr><td class=\"name\"><a href=\"position_details.php?x=" . $coor['x'] . "&amp;y=" . $coor['y'] . "\">" . $vname . "</a> ";
            if ($vil['capital'] == 1) {
                echo "<span class=\"mainVillage\">(" . BL_CAPITAL . ")</span>";
            }
            echo "</td><td class=\"oases\">";

            $prefix = TB_PREFIX . "odata";
            $uid = $_GET['uid'];
            $wref = $vil['wref'];
            $sql2 = mysql_query("SELECT * FROM $prefix WHERE owner = $uid AND conqured = $wref");
            while ($row = mysql_fetch_array($sql2)) {
                $type = $row["type"];
                switch ($type) {
                    case 1:
                    case 2:
                        echo "<img class='r1' src='img/x.gif' title='" . VL_WOOD . "'>";
                        break;
                    case 3:
                        echo "<img class='r1' src='img/x.gif' title='" . VL_WOOD . "'> <img class='r4' src='img/x.gif' title='" . VL_CROP . "'>";
                        break;
                    case 4:
                    case 5:
                        echo "<img class='r2' src='img/x.gif' title='" . VL_CLAY . "'>";
                        break;
                    case 6:
                        echo "<img class='r2' src='img/x.gif' title='" . VL_CLAY . "'> <img class='r4' src='img/x.gif' title='" . VL_CROP . "'>";
                        break;
                    case 7:
                    case 8:
                        echo "<img class='r3' src='img/x.gif' title='" . VL_IRON . "'>";
                        break;
                    case 9:
                        echo "<img class='r3' src='img/x.gif' title='" . VL_IRON . "'> <img class='r4' src='img/x.gif' title='" . VL_CROP . "'>";
                        break;
                    case 10:
                    case 11:
                    case 12:
                        echo "<img class='r4' src='img/x.gif' title='" . VL_CROP . "'>";
                        break;
                }
            }
            echo "</td>";
            echo "<td class=\"inhabitants\">" . $vil['pop'] . "</td><td class=\"coords\">";
            echo "<a href=\"karte.php?x=" . $coor['x'] . "&amp;y=" . $coor['y'] . "\"><span class=\"coordinates coordinatesAligned\">";
            if (DIRECTION == 'ltr') {
                echo "<span class=\"coordinateX\">(" . $coor['x'] . "</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateY\">" . $coor['y'] . ")</span>";
            } elseif (DIRECTION == 'rtl') {
                echo "<span class=\"coordinateY\">" . $coor['y'] . ")</span><span class=\"coordinatePipe\">|</span><span class=\"coordinateX\">(" . $coor['x'] . "</span>";
            }
            echo "</span><span class=\"clear\">?</span></td></tr>";
        }
    ?>
    </tbody>
</table>
<script type="text/javascript">
    window.addEvent('domready', function () {
        "use strict";
        var renderPlayerMessageIgnoreButtons = function () {
            var targetPlayer = '<?php echo (int)$_GET['uid'];?>';
            Travian.ajax({
                data: {
                    cmd: 'ignoreList',
                    method: 'render_player_message_ignore_buttons',
                    params: {
                        targetPlayer: targetPlayer
                    }
                },

                onSuccess: function (response) {
                    if (response.result !== undefined) {
                        $$('#player_message-ignore-buttons-block').set('html', response.result);
                    }
                }
            });
        };
        $$('#player_message-ignore-buttons-block').addEvent("click:relay('a#ignore-player-button')", function (event) {
            var targetPlayer = $(this).get('data-uid'),
                isIgnored = $(this).get('data-player-ignored') === "false" ? false : true,
                method = isIgnored ? 'stop_ignore_target_player' : 'ignore_target_player';

            event.stop();

            Travian.ajax({
                data: {
                    cmd: 'ignoreList',
                    method: method,
                    renderPlayerMessageIgnoreButtons: true,
                    params: {
                        targetPlayer: targetPlayer
                    }
                },

                onSuccess: function (response) {
                    if (response.result !== undefined) {
                        $$('#player_message-ignore-buttons-block').set('html', response.result);
                    }
                }
            });
        });

        renderPlayerMessageIgnoreButtons();
    });
</script>