<?php

    if ($session->gpack == null || GP_ENABLE == FALSE) {
        $gpack = GP_LOCATE;
    } else {
        $gpack = $session->gpack;
    }

    $geregistreerd = date('Y/m/d', ($allianceinfo['timestamp']));
    $profiel = preg_replace("/\[war]/s", AL_WARWITH . '<br>' . $database->getAllianceDipProfile($aid, 3), $profiel, 1);
    $profiel = preg_replace("/\[ally]/s", AL_CONFWITH . '<br>' . $database->getAllianceDipProfile($aid, 1), $profiel, 1);
    $profiel = preg_replace("/\[nap]/s", AL_NAPWITH . '<br>' . $database->getAllianceDipProfile($aid, 2), $profiel, 1);
    $profiel = preg_replace("/\[diplomatie]/s", AL_CONFWITH . '<br>' . $database->getAllianceDipProfile($aid, 1) . '<br>' . AL_NAPWITH . '<br>' . $database->getAllianceDipProfile($aid, 2) . '<br>' . AL_WARWITH . '<br>' . $database->getAllianceDipProfile($aid, 3), $profiel, 1);

    foreach ($varmedal as $medal) {
        switch ($medal['categorie']) {
            case "1":
                $titel = AL_AOFW;
                $woord = AL_POINTS;
                break;
            case "2":
                $titel = AL_DOFW;
                $woord = AL_POINTS;
                break;
            case "3":
                $titel = AL_COFW;
                $woord = AL_POINTS;
                break;
            case "4":
                $titel = AL_ROFW;
                $woord = AL_POINTS;
                break;
            case "5":
                $titel = AL_ADOFW;
                $bonus[$medal['id']] = 1;
                break;
            case "6":
                $titel = sprintf(AL_TOP3AOFW, $medal['points']);
                $bonus[$medal['id']] = 1;
                break;
            case "7":
                $titel = sprintf(AL_TOP3DOFW, $medal['points']);
                $bonus[$medal['id']] = 1;
                break;
            case "8":
                $titel = sprintf(AL_TOP3COFW, $medal['points']);
                $bonus[$medal['id']] = 1;
                break;
            case "9":
                $titel = sprintf(AL_TOP3ROFW, $medal['points']);
                $bonus[$medal['id']] = 1;
                break;
            case "11":
                $titel = sprintf(AL_TOP3COFW, $medal['points']);
                $bonus[$medal['id']] = 1;
                break;
            case "12":
                $titel = AL_POINTS . ': ' . $medal['points'];
                $bonus[$medal['id']] = 1;
                break;
            case "13":
                $titel = AL_POINTS . ': ' . $medal['points'];
                $bonus[$medal['id']] = 1;
                break;
            case "15":
                $titel = AL_POINTS . ': ' . $medal['points'];
                $bonus[$medal['id']] = 1;
                break;
            case "16":
                $titel = AL_POINTS . ': ' . $medal['points'];
                $bonus[$medal['id']] = 1;
                break;
        }

        if (isset($bonus[$medal['id']])) {
            $profiel = preg_replace("/\[#" . $medal['id'] . "]/is", '<img src="' . $gpack . 'img/t/' . $medal['img'] . '.gif" border="0" title="' . $titel . '<br />' . WEEK . ' ' . $medal['week'] . '">', $profiel, 1);
        } else {
            $profiel = preg_replace("/\[#" . $medal['id'] . "]/is", '<img src="' . $gpack . 'img/t/' . $medal['img'] . '.gif" border="0" title="' . JR_CATEGORY . ': ' . $titel . '<br />' . WEEK . ': ' . $medal['week'] . '<br />' . RANK . ': ' . $medal['plaats'] . '<br />' . $woord . ': ' . $medal['points'] . '<br />">', $profiel, 1);
        }
    }
?>