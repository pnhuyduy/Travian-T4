<?php
    if ($session->gpack == null || GP_ENABLE == FALSE) {
        $gpack = GP_LOCATE;
    } else {
        $gpack = $session->gpack;
    }
    $geregistreerd = date('Y/m/d', ($allianceinfo['timestamp']));

    $profiel = preg_replace("/\[war]/s", AL_WARWITH.'<br>' . $database->getAllianceDipProfile($aid, 3), $profiel, 1);
    $profiel = preg_replace("/\[ally]/s", AL_CONFWITH.'<br>' . $database->getAllianceDipProfile($aid, 1), $profiel, 1);
    $profiel = preg_replace("/\[nap]/s", AL_NAPWITH.'<br>' . $database->getAllianceDipProfile($aid, 2), $profiel, 1);
    $profiel = preg_replace("/\[diplomatie]/s", AL_CONFWITH.'<br>' . $database->getAllianceDipProfile($aid, 1) . '<br>'.AL_NAPWITH.'<br>' . $database->getAllianceDipProfile($aid, 2) . '<br>'.AL_WARWITH.'<br>' . $database->getAllianceDipProfile($aid, 3), $profiel, 1);

    foreach ($varmedal as $medal) {
        switch ($medal['categorie']) {
            case "1":
                $titel = "Attackers Week";
                $woord = "Points";
                break;
            case "2":
                $titel = "Defenders Week";
                $woord = "Points";
                break;
            case "3":
                $titel = "Climbers Week";
                $woord = "Population";
                break;
            case "4":
                $titel = "Roobers Week";
                $woord = "Resources";
                break;
            case "5":
                $titel = "Receiving this medal shows that you were in the top 10 of both attackers and defenders of the week .";
                $bonus[$medal['id']] = 1;
                break;
            case "6":
                $titel = "Receiving this medal shows your alliance attacker week tops " . $medal['points'] . " three rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "7":
                $titel = "Receiving this medal shows your alliance defenders week tops " . $medal['points'] . " Three rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "8":
                $titel = "Receiving this medal shows your alliance Climbers week tops " . $medal['points'] . " Three rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "9":
                $titel = "Receiving this medal shows your alliance Robbers week tops " . $medal['points'] . " Three rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "11":
                $titel = "Receiving this medal shows your alliance climbers week tops " . $medal['points'] . " Three rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "12":
                $titel = "Receiving this medal shows your alliance attacker week tops " . $medal['points'] . " Ten rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "13":
                $titel = "Receiving this medal shows your alliance Defenders week tops " . $medal['points'] . " Ten rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "15":
                $titel = "Receiving this medal shows your alliance robbers week tops " . $medal['points'] . " Ten rank of week.";
                $bonus[$medal['id']] = 1;
                break;
            case "16":
                $titel = "Receiving this medal shows your alliance climbers week tops " . $medal['points'] . " Ten rank of week";
                $bonus[$medal['id']] = 1;
                break;
        }

        if (isset($bonus[$medal['id']])) {
            $profiel = preg_replace("/\[#" . $medal['id'] . "]/is", '<img src="' . $gpack . 'img/t/' . $medal['img'] . '.gif" border="0" onmouseout="med_closeDescription()" onmousemove="med_mouseMoveHandler(arguments[0],\'<table><tr><td>' . $titel . '<br /><br />'.AL_WEEK.': ' . $medal['week'] . '</td></tr></table>\')">', $profiel, 1);
        } else {
            $profiel = preg_replace("/\[#" . $medal['id'] . "]/is", '<img src="' . $gpack . 'img/t/' . $medal['img'] . '.gif" border="0" onmouseout="med_closeDescription()" onmousemove="med_mouseMoveHandler(arguments[0],\'<table><tr><td>'.AL_CATEGORY.':</td><td>' . $titel . '</td></tr><tr><td>'.AL_WEEK.':</td><td>' . $medal['week'] . '</td></tr><tr><td>'.AL_RANK.':</td><td>' . $medal['plaats'] . '</td></tr><tr><td>' . $woord . ':</td><td>' . $medal['points'] . '</td></tr></table>\')">', $profiel, 1);
        }
    }
?>