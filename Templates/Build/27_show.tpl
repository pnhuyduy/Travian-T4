<?php

    $artefact = $database->getArtefactDetails($_GET['show']);
    if ($artefact['size'] == 1) {
        $reqlvl = 10;
        $aoe = ART_ARTEAREAVILLAGE;
    } elseif ($artefact['size'] == 2 OR $artefact['size'] == 3) {
        $reqlvl = 20;
        $aoe = ART_ARTEAREAACCOUNT;
    }
    if (($artefact['conquered'] <= (time() - max(86400 / SPEED, 600))) && ($artefact['status'] == 1)) {
        $active = US_ACTIVE;
    } else {
        $active = US_INACTIVE;
        if ($artefact['status'] == 1) $active .= ' ' . ART_WILLACTIN . ' ' . $generator->getTimeFormat(max(86400 / SPEED, 600) - (time() - $artefact['conquered'])) . ' ' . AT_HRS;
    }
    $artefact['name'] = constant($artefact['name']);
?>

<div class="artefact.image-6">
    <h4 class="round"><?php echo $artefact['name']; ?> <b><?php echo $artefact['effect']; ?></b></h4>
    <table id="art_details" cellpadding="1" cellspacing="1">
        <tbody>
        <tr>
            <td colspan="2" class="desc">
                            <span class="detail">
				<center>
                    <?php
                        if (defined($artefact['desc'])) $artefact['desc'] = constant($artefact['desc']);
                        echo $artefact['desc'];
                    ?>
                </center>
			    </span>
            </td>
        </tr>
        <tr>
            <th><?php echo US_OWNER; ?></th>
            <td>
                <a href="spieler.php?uid=<?php echo $artefact['owner']; ?>"><?php echo $database->getUserField($artefact['owner'], "username", 0); ?></a>
            </td>
        </tr>
        <tr>
            <th><?php echo VL_VILLAGE; ?></th>
            <td>
                <a href="karte.php?d=<?php echo $artefact['vref']; ?>&c=<?php echo $generator->getMapCheck($artefact['vref']); ?>">
                    <?php
                        $avname = $database->getVillageField($artefact['vref'], "name");
                        if (defined($avname)) $avname = constant($avname);
                        echo $avname;
                    ?> </a>
            </td>
        </tr>
        <tr>
            <th><?php echo AL_ALLIANCE; ?></th>
            <td>
                <a href="allianz.php?aid=<?php echo $database->getUserField($artefact['owner'], "alliance", 0); ?>"><?php echo $database->getAllianceName($database->getUserField($artefact['owner'], "alliance", 0)); ?></a>
            </td>
        </tr>
        <tr>
            <th><?php echo ART_ARTE_AOE; ?></th>
            <td><?php echo $aoe; ?></td>
        </tr>
        <tr>
            <th><?php echo ART_EFFECT; ?></th>
            <td><?php
                    $str = 'ART_ETN_' . $artefact['effecttype'];
                    if (defined($str)) {
                        echo constant($str);
                    } else {
                        echo '-';
                    }
                ?></td>
        </tr>

        <tr>
            <th><?php echo ART_POWER; ?></th>
            <td><b><?php echo $artefact['effect']; ?></b></td>
        </tr>

        <tr>
            <th><?php echo B27; ?></th>
            <td>A <?php echo B27 . ' ' . BL_LVL . ' '; ?> <b><?php echo $reqlvl; ?></b></td>
        </tr>

        <tr>
            <th><?php echo AL_DATE; ?></th>
            <td><?php echo date("Y.m.d. H:i", $artefact['conquered']); ?></td>
        </tr>

        <tr>
            <th><?php echo US_ACTIVITY; ?></th>
            <td><?php echo $active; ?></td>
        </tr>
        </tbody>
    </table>
    <br/>
    <h4><?php echo ART_CAPTUREHISTORY; ?></h4>
    <table class="art_details" cellpadding="1" cellspacing="1">
        <thead>
        <tr>
            <td><?php echo AL_PLAYER; ?></td>
            <td><?php echo VL_VILLAGE; ?></td>
            <td><?php echo ART_CAPTUREHISTORY; ?></td>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td><span class="none"><?php echo US_NOUSER; ?></span></td>
            <td><span class="none">[?]</span></td>
            <td><span class="none"><?php echo ART_YETTOBECONQUERED; ?></span></td>

        </tr>

        </tr></tbody>
    </table>
</div>
