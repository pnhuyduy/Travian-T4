<?php
    $dataarray = explode(",", $database->getNotice2($_GET['id'], 'data'));
    $toWref = $database->getNotice2($_GET['id'], 'toWref');
    $rowtopic = $message->readingNotice['topic'];
    $topics = explode('[=]', $rowtopic);
    $topCount = count($topics); // var_dump($topCount); die;
    if ($topCount == 2) {
        if (defined($topics[1])) $topics[1] = constant($topics[1]);
        $topic = sprintf(constant($topics[0]), $topics[1]);
    } elseif ($topCount == 3) {
        $t1 = explode('[|]', $topics[1]);
        if (defined($t1[0])) $t1[0] = constant($t1[0]);
        for ($i = 1; $i < count($t1); $i++) $t1[0] .= $t1[$i];
        $t2 = explode('[|]', $topics[2]);
        if (defined($t2[0])) $t2[0] = constant($t2[0]);
        for ($i = 1; $i < count($t2); $i++) $t2[0] .= $t2[$i];
        $topic = sprintf(constant($topics[0]), $t1[0], $t2[0]);
    } else {
        $topic = $rowtopic;
    }
    $time = $message->readingNotice['time'];
    $userarray = $database->getUser($message->readingNotice['uid'], 1);
    $da0name = $database->getVillageField($dataarray[0], 'name');
    if (defined($da0name)) $da0name = constant($da0name);
?>
<div class="clear"></div>
<div class="paper" id="report_surround">
    <div class="layout">
        <div class="paperTop">
            <div class="paperContent">
                <div id="subject">
                    <div class="header label"><?php echo AL_SUBJECT; ?></div>
                    <div class="header text"><?php echo $topic; ?></div>
                    <div class="clear"></div>
                </div>

                <div id="time">
                    <?php $date = $generator->procMtime($time); ?>
                    <div class="header label"><?php echo MS_SENT; ?></div>
                    <div
                        class="header text"><?php echo $date[0] . "<span> " . AT_AT . " " . $date[1]; ?></span></div>

                    <div class="toolList">
                        <button type="button" class="icon " onclick="return Travian.Game.Reports.editRights(this,
	{
		text:
		{
			anonymOpponent:		'make opponent anonymous',
			anonymMyself:		'make myself anonymous',
			hiddenOwnTroops:	'hide own troops',
			hiddenOtherTroops:	'hide opposing troops',
			description:		'Description:',
			buttonTextOk:		'save',
			buttonTextCancel:	'cancel',
			title:				'Access permissions'
		},
		datas:
		{
			reportId:	'21073608'
		}
	});"><img src="img/x.gif" class="reportButton access" alt="reportButton access"></button>
                        <?php if ($session->plus) { ?>
                            <button type="button" value="reportButton delete" class="icon"
                                    title="<?php echo AL_DELETE; ?>" onclick="return (function(){
                                ('<?php echo AL_AREYOUSURE; ?>').dialog(
                                {
                                onOkay: function(dialog, contentElement)
                                {
                                window.location.href = '?n1=<?php echo $_GET['id']; ?>&amp;del=1'}
                                });
                                return false;
                                })()"><img src="img/x.gif" class="reportButton delete" alt="reportButton delete"/>
                            </button>
                        <?php } ?>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div id="message">
                    <?php
                        $result = mysql_query('SELECT `nopicn` ' . TB_PREFIX . 'users_setting WHERE id = ' . $session->uid . ' LIMIT 1');
                        $query = mysql_fetch_assoc($result);
                        if ($query['nopicn'] == 0) {
                            ?>
                            <img src="img/x.gif" class="adventureReportImage <?php if ($dataarray[1] != 'dead') {
                                echo 'adventureGrasslandVictory';
                            } else {
                                echo 'adventureGrasslandLose';
                            } ?>" alt="">
                        <?php } ?>
                    <table cellspacing="0" cellpadding="0" id="attacker">
                        <thead>
                        <tr>
                            <td class="role">
                                <div class="boxes boxesColor red">
                                    <div class="boxes-tl"></div>
                                    <div class="boxes-tr"></div>
                                    <div class="boxes-tc"></div>
                                    <div class="boxes-ml"></div>
                                    <div class="boxes-mr"></div>
                                    <div class="boxes-mc"></div>
                                    <div class="boxes-bl"></div>
                                    <div class="boxes-br"></div>
                                    <div class="boxes-bc"></div>
                                    <div class="boxes-contents cf">
                                        <div class="role"><?php echo REPORT_ATTACKER; ?></div>
                                    </div>
                                </div>
                            </td>
                            <td colspan="11" class="troopHeadline">
                                <p>
                                    
								<a href="spieler.php?uid=<?php echo $session->uid; ?>"><?php echo $userarray['username']; ?></a> <?php echo REPORT_FROM_VIL; ?>
                                   <?php $coor = $database->getCoor($dataarray[0]); ?>
								   <a href="position_details.php?x=<?php echo $coor['x'] . "&amp;y=" . $coor['y'] ?>"><?php echo $da0name; ?></a>
                                </p>
                            </td>
                        </tr>
                        </thead>

                        <tbody class="units">
                        <tr>
                            <th class="coords"></th>
                            <?php
                                $owntribe = $userarray['tribe'];
                                $start = ($owntribe - 1) * 10 + 1;
                                $end = ($owntribe * 10);
                                for ($i = $start; $i <= $end; $i++) {
                                    echo '<td class="unit"><img src="img/x.gif" class="unit u' . $i . '" title="' . $technology->unarray[$i] . '"></td>';
                                }
                            ?>
                            <td class="unit last">
                                <img title="Hős" class="unit uhero" src="img/x.gif">
                            </td>
                        </tr>
                        </tbody>
                        <tbody class="units last">
                        <tr>
                            <th><?php echo AT_TROOPS; ?></th>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit none">0</td>
                            <td class="unit  last">1</td>
                        </tr>
                        </tbody>

                        <tbody class="infos">
                        <tr>
                            <td class="empty" colspan="12"></td>
                        </tr>
                        <tr>
                            <th><?php echo REPORT_INFORMATION; ?></th>
                            <td class="dropItems" colspan="11">
                                <?php if ($dataarray[1] != 'dead') { ?>
                                    <img src="img/x.gif" class="iExperience" title="<?php echo HERO_EXP; ?>:">
                                    +<?php echo $dataarray[5]; ?>
                                    <img src="img/x.gif" class="injury" title="<?php echo HERO_HEALTH; ?>:">
                                    -<?php echo round($dataarray[4]); ?>%
                                <?php
                                } else {
                                    echo '<img src="img/x.gif" class="adventureDifficulty0" title="' . HS_HERODEAD . '">' . constant($dataarray[2]);
                                }
                                ?>

                            </td>
                        </tr>
                        </tbody>
                        <?php if ($dataarray[1] != 'dead') { ?>
                            <tbody class="goods">
                            <tr>
                                <td class="empty" colspan="12"></td>
                            </tr>
                            <tr>
                                <th><?php echo REPORT_BOUNTY; ?></th>
                                <td colspan="11">
                                    <?php
                                        if ($dataarray[1]) {
                                            $typeArray = array('', 'helmet', 'body', 'leftHand', 'rightHand', 'shoes', 'horse', 'bandage25', 'bandage33', 'cage', 'scroll'
                                            , 'ointment', 'bucketOfWater', 'bookOfWisdom', 'lawTables', 'artWork');
                                            $btype = $dataarray[1];
                                            $type = $dataarray[2];
                                            include "Templates/Auction/alt.tpl";
                                            echo '<img src="img/x.gif" class="itemCategory itemCategory_' . $typeArray[$btype] . '" title="' . $title . '">';
                                            echo ' ' . $name . ' (' . $dataarray[3] . 'x)';
                                        } else {
                                            echo constant($dataarray[2]);
                                        }
                                    ?>
                                </td>
                            </tr>
                            </tbody>
                        <?php } ?>
                        </td></tr></tbody></table>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="paperBottom"></div>
    </div>
</div>
<div class="clear"></div>