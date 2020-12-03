<?php
    if (WW == TRUE) {
        $result = mysql_query("select " . TB_PREFIX . "users.id, " . TB_PREFIX . "users.username," . TB_PREFIX . "users.alliance, " . TB_PREFIX . "fdata.wwname, " . TB_PREFIX . "fdata.f99, " . TB_PREFIX . "vdata.name, " . TB_PREFIX . "vdata.wref
                        FROM " . TB_PREFIX . "users
                        INNER JOIN " . TB_PREFIX . "vdata ON " . TB_PREFIX . "users.id = " . TB_PREFIX . "vdata.owner
                        INNER JOIN " . TB_PREFIX . "fdata ON " . TB_PREFIX . "fdata.vref = " . TB_PREFIX . "vdata.wref
                        WHERE " . TB_PREFIX . "fdata.f99t = 40 ORDER BY " . TB_PREFIX . "fdata.f99 Desc Limit 13");

        ?>
        <h4 class="round"><?php echo B40; ?></h4>
        <table cellpadding="1" cellspacing="1" id="wonder">
           		<thead>
            <tr>
                <td></td>
                <td><?php echo AL_PLAYER; ?></td>
		<td>&#1606;&#1575;&#1605; &#1583;&#1607;&#1705;&#1583;&#1607;</td>
                <td><?php echo AL_NAME; ?></td>
                <td><?php echo AL_ALLIANCE; ?></td>
                <td><?php echo BD_LEVEL; ?></td>
                <td><?php echo MV_ATTACK; ?></td>
            </tr>
            </thead>
<?php

                $cont = 1;
                while ($row = mysql_fetch_array($result)) {
$coor = $database->getCoor($row['wref']);
                    $ally = $database->getAlliance($row['alliance']);
                    ?>
                    <tr class="hover">
                        <td class="ra"><?php echo $cont;
                                $cont++; ?>.
                        </td>
                        <td class="pla"><a
                                href="spieler.php?uid=<?php echo $row['id']; ?>"><?php echo $row['username']; ?></a>
                        </td>

<td class="pla"><a href=karte.php?x=<?php echo $coor['x']; ?>&amp;y=<?php echo $coor['y']; ?>><?php echo $row['name']; ?></a></td>

                        <td class="nam"><?php echo $row['wwname']; ?></td>

                        <td class="al">

                            <?php
                                if ($ally['tag'] != "") {
                                    ?>
                                    <center><a
                                            href="allianz.php?aid=<?php echo $ally['id']; ?>"><?php echo $ally['tag']; ?></a>
                                    </center>
                                <?php
                                } else {
                                    echo "-";
                                } ?>
                        </td>
                        <td class="lev"><?php echo $row['f99']; ?></td>

                        <td class="attack"><?php
                                $vm['v31'] = $database->getMovement(3, $row['wref'], 1);
                                if (!is_array($vm['v31'])) $vm['v31'] = array();
                                $waveCount = count($waves);
                                for ($i = 0; $i < $waveCount; $i++) {
                                    if ($i >= 0 && $waves[$i]['attack_type'] <= 2) {
                                        $waveCount -= 1;
                                        array_splice($waves, $i, 1);
                                        $i--;
                                    }
                                }
                                if ($waveCount > 0) {
                                    echo '<img src="img/x.gif" class="att1" alt="Under Attack" title="Under Attack" />';
                                }

                            ?></td>
                    </tr>
                <?php
                }
            ?>
            </tbody>
        </table>
    <?php
    } else {
        header("Location: statistiken.php");
        die;
    }
?>
