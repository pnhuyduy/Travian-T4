<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    header('Cache-Control: max-age=5184000');
    include("GameEngine/Protection.php");
    include("GameEngine/Database.php");
    if (isset($_GET['uid'])) {
        $uid = $_GET['uid'];
    } else {
        $uid = $session->uid;
    }
    $heroFace = $database->getHeroFace($uid);
$gdir = $heroFace['gender'] == 0 ? 'male' : 'female';
    if (isset($_GET['size'])) {
        if ($_GET['size'] == 'profile') {
            $size = '160x205';
            $fsize = '31x40';


            if($heroFace['gender'] == 0){
                $w = 79;
                $h = 18;
            }else{
                $w = 79;
                $h = 24;
            }

        } elseif ($_GET['size'] == 'inventory') {
            $size = '330x422';
            $fsize = '64x82';

            if($heroFace['gender'] == 0){
                $h = 37;
                $w = 131;
            }else{
                $h = 52;
                $w = 134;
            }

        }
    } else {
        $size = "330x422";
        $fsize = '64x82';
        $w = 163;
        $h = 37;
    }
    switch ($heroFace['color']) {
        case 0:
            $color = 'black';
            break;
        case 1:
            $color = 'brown';
            break;
        case 2:
            $color = 'darkbrown';
            break;
        case 3:
            $color = 'yellow';
            break;
        case 4:
            $color = 'red';
            break;
    }
    $geteye = $heroFace['eye'];
    if ($gender == 0) $geteye %= 5;
    $geteyebrow = $heroFace['eyebrow'];
    if ($gender == 0) $geteyebrow %= 5;
    $getnose = $heroFace['nose'];
    if ($gender == 0) $getnose %= 5;
    $getear = $heroFace['ear'];
    if ($gender == 0) $getear %= 5;
    $getmouth = $heroFace['mouth'];
    if ($gender == 0) $getmouth %= 4;
    $getbeard = $heroFace['beard'];
    if ($gender == 1) $getbeard = 5;
    $gethair = $heroFace['hair'];
    if ($gender == 0) $gethair %= 5;
    $getface = $heroFace['face'];
    if ($gender == 0) $getface %= 5;
    $getfoot = $heroFace['foot'];


    $gethelmet = 0;
    if ($heroFace['helmet'] > 0) {
        $result = $database->getHeroItem($heroFace['helmet']);
        $gethelmet = $result['type'];
    }
    $getbody = 0;
    if ($heroFace['body'] > 0) {
        $result = $database->getHeroItem($heroFace['body']);
        $getbody = $result['type'];
    }
    $getarmor = 0;
    if ($heroFace['body'] > 0) {
        $result = $database->getHeroItem($heroFace['body']);
        $getarmor = $result['type'];
    }
    $getleftHand = 0;
    if ($heroFace['leftHand'] > 0) {
        $result = $database->getHeroItem($heroFace['leftHand']);
        $getleftHand = $result['type'];
    }
    $getrightHand = 0;
    if ($heroFace['rightHand'] > 0) {
        $result = $database->getHeroItem($heroFace['rightHand']);
        $getrightHand = $result['type'];
    }
    $getshoes = 0;
    if ($heroFace['shoes'] > 0) {
        $result = $database->getHeroItem($heroFace['shoes']);
        $getshoes = $result['type'];
    }
    $gethorse = 0;
    if ($heroFace['horse'] > 0) {
        $result = $database->getHeroItem($heroFace['horse']);
        $gethorse = $result['type'];
    }
    $getbag = 0;
    if ($heroFace['bag'] > 0) {
        $result = $database->getHeroItem($heroFace['bag']);
        $getbag = $result['type'];
    }

    // HERO FACE:
    $face0 = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/face0.png');
    $face = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/face/face' . $getface . '.png');
    $ear = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/ear/ear' . $getear . '.png');
    $eye = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/eye/eye' . $geteye . '.png');
    $eyebrow = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/eyebrow/eyebrow' . $geteyebrow . (($gender == 0) ? '-' . $color : '') . '.png');
    if ($gethair != 5) {
        $hair = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/hair/hair' . $gethair . '-' . $color . '.png');
    }
    $mouth = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/mouth/mouth' . $getmouth . '.png');
    $nose = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/nose/nose' . $getnose . '.png');
    if ($getbeard != 5) {
        $beard = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/head/' . $fsize . '/beard/beard' . $getbeard . '-' . $color . '.png');
    }

    if ($gethelmet >= 1 && $gethelmet <= 3) {
        $helmet = '0_' . ($gethelmet - 1);
    } elseif ($gethelmet >= 4 && $gethelmet <= 6) {
        $helmet = '1_' . ($gethelmet - 4);
    } elseif ($gethelmet >= 7 && $gethelmet <= 9) {
        $helmet = '2_' . ($gethelmet - 7);
    } elseif ($gethelmet >= 10 && $gethelmet <= 12) {
        $helmet = '3_' . ($gethelmet - 10);
    } elseif ($gethelmet >= 13 && $gethelmet <= 15) {
        $helmet = '4_' . ($gethelmet - 13);
    }

    if ($getbody >= 82 && $getbody <= 84) {
        $armors = '0_' . ($getbody - 82);
    } elseif ($getbody >= 85 && $getbody <= 87) {
        $armors = '1_' . ($getbody - 85);
    } elseif ($getbody >= 88 && $getbody <= 90) {
        $armors = '2_' . ($getbody - 88);
    } elseif ($getbody >= 91 && $getbody <= 93) {
        $armors = '3_' . ($getbody - 91);
    }

    if ($getshoes >= 94 && $getshoes <= 96) {
        $shoes = '0_' . ($getshoes - 94);
    } elseif ($getshoes >= 97 && $getshoes <= 99) {
        $shoes = '1_' . ($getshoes - 97);
    } elseif ($getshoes >= 100 && $getshoes <= 102) {
        $shoes = '2_' . ($getshoes - 100);
    }
    switch ($getleftHand) {
        case 0:
            $leftHand = 'leftHand';
            break;
        case 61:
        case 62:
        case 63:
            $leftHand = 'map0';
            break;
        case 64:
        case 65:
        case 66:
            $leftHand = 'flag0';
            break;
        case 67:
        case 68:
        case 69:
            $leftHand = 'flag1';
            break;
        case 73:
        case 74:
        case 75:
            $leftHand = 'sack0';
            break;
        case 76:
        case 77:
        case 78:
            $leftHand = 'shield0';
            break;
        case 79:
        case 80:
        case 81:
            $leftHand = 'horn0';
            break;
    }
    switch ($getrightHand) {
        case 0:
            $rightHand = 'rightHand';
            break;
        case 16:
        case 17:
        case 18:
            $rightHand = 'sword0';
            break;
        case 19:
        case 20:
        case 21:
            $rightHand = 'sword1';
            break;
        case 22:
        case 23:
        case 24:
            $rightHand = 'sword2';
            break;
        case 25:
        case 26:
        case 27:
            $rightHand = 'sword3';
            break;
        case 28:
        case 29:
        case 30:
            $rightHand = 'lance0';
            break;
        case 31:
        case 32:
        case 33:
            $rightHand = 'spear0';
            break;
        case 34:
        case 35:
        case 36:
            $rightHand = 'sword4';
            break;
        case 37:
        case 38:
        case 39:
            $rightHand = 'bow0';
            break;
        case 40:
        case 41:
        case 42:
            $rightHand = 'staff0';
            break;
        case 43:
        case 44:
        case 45:
            $rightHand = 'spear1';
            break;
        case 46:
        case 47:
        case 48:
            $rightHand = 'club0';
            break;
        case 49:
        case 50:
        case 51:
            $rightHand = 'spear2';
            break;
        case 52:
        case 53:
        case 54:
            $rightHand = 'axe0';
            break;
        case 55:
        case 56:
        case 57:
            $rightHand = 'hammer0';
            break;
        case 58:
        case 59:
        case 60:
            $rightHand = 'sword5';
            break;
    }
// switch ($getarmor) {
    // case 82:
    // case 83:
    // case 84:
    // $armors = 1;
    // break;
    // case 85:
    // case 86:
    // case 87:
    // $armors = 2;
    // break;
    // case 88:
    // case 89:
    // case 90:
    // $armors = 3;
    // break;
    // case 91:
    // case 92:
    // case 93:
    // $armors = 4;
    // break;
// }
// echo GP_LOCATE.'/img/hero/'.$gdir.'/body/'.$size.'/armor'.$armor.'.png';die;
    $bag = 0;
    if ($getbag >= 112 && $getbag <= 114) {
        $bag = $getbag;
    }

// HERO BODY:
    $body = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/hero_body0.png');
    if ($gethelmet != 0) {
        $helmet = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/helmet' . $helmet . '.png');
    }

    if ($getarmor != 0) {
        $armor = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/shirt' . $armors . '.png');
    }
    $leftHand = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/' . $leftHand . '.png');
    $rightHand = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/' . $rightHand . '.png');
    if ($getshoes != 0) {
        $shoes = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/shoes' . $shoes . '.png');
    }
    if ($gethorse != 0) {
        $horse = imagecreatefrompng(GP_LOCATE . '/img/hero/' . $gdir . '/body/' . $size . '/horse0.png');
    }
    if ($getbag != 0) {
        $bag = imagecreatefromgif(GP_LOCATE . '/img/hero/' . $gdir . '/items/item' . $getbag . '.gif');
    }

    if ($gethorse != 0) {
        $database->imagecopymerge_alpha($horse, $body, 0, 0, 0, 0, imagesx($body), imagesy($body), 100);
        $body = $horse;
    }

    $database->imagecopymerge_alpha($body, $face0, $w, $h, 0, 0, imagesx($face0), imagesy($face0), 100);
    $database->imagecopymerge_alpha($body, $face, $w, $h, 0, 0, imagesx($face), imagesy($face), 100);
    $database->imagecopymerge_alpha($body, $ear, $w, $h, 0, 0, imagesx($ear), imagesy($ear), 100);
    $database->imagecopymerge_alpha($body, $eye, $w, $h, 0, 0, imagesx($eye), imagesy($eye), 100);
    $database->imagecopymerge_alpha($body, $eyebrow, $w, $h, 0, 0, imagesx($eyebrow), imagesy($eyebrow), 100);
    if (!($gender == 0 && $gethair == 5) && !isset($helmet)) {
        $database->imagecopymerge_alpha($body, $hair, $w, $h, 0, 0, imagesx($hair), imagesy($hair), 100);
    }
    $database->imagecopymerge_alpha($body, $mouth, $w, $h, 0, 0, imagesx($mouth), imagesy($mouth), 100);
    $database->imagecopymerge_alpha($body, $nose, $w, $h, 0, 0, imagesx($nose), imagesy($nose), 100);
    if ($getbeard != 5) {
        $database->imagecopymerge_alpha($body, $beard, $w, $h, 0, 0, imagesx($beard), imagesy($beard), 100);
    }

// if($armor!=0){
    // $database->imagecopymerge_alpha($body, $armor, 0, 0, 0, 0, imagesx($armor), imagesy($armor),100);
// }

    if ($_GET['size'] == 'inventory') {
        if ($armor != 0) {
            $database->imagecopymerge_alpha($body, $armor, -32, 0, 0, 0, imagesx($armor), imagesy($armor), 100);
        }
        if ($getshoes != 0) {
            $database->imagecopymerge_alpha($body, $shoes, -32, 0, 0, 0, imagesx($shoes), imagesy($shoes), 100);
        }
        if ($gethelmet != 0) {
            $database->imagecopymerge_alpha($body, $helmet, -32, 0, 0, 0, imagesx($helmet), imagesy($helmet), 100);
        }
        $database->imagecopymerge_alpha($body, $rightHand, -32, 0, 0, 0, imagesx($rightHand), imagesy($rightHand), 100);
        $database->imagecopymerge_alpha($body, $leftHand, -32, 0, 0, 0, imagesx($leftHand), imagesy($leftHand), 100);

    } else {
        if ($armor != 0) {
            $database->imagecopymerge_alpha($body, $armor, 0, 0, 0, 0, imagesx($armor), imagesy($armor), 100);
        }
        if ($getshoes != 0) {
            $database->imagecopymerge_alpha($body, $shoes, 0, 0, 0, 0, imagesx($shoes), imagesy($shoes), 100);
        }
        if ($gethelmet != 0) {
            $database->imagecopymerge_alpha($body, $helmet, 0, 0, 0, 0, imagesx($helmet), imagesy($helmet), 100);
        }
        $database->imagecopymerge_alpha($body, $rightHand, 0, 0, 0, 0, imagesx($rightHand), imagesy($rightHand), 100);
        $database->imagecopymerge_alpha($body, $leftHand, 0, 0, 0, 0, imagesx($leftHand), imagesy($leftHand), 100);

    }


    if (($getbag != 0) and ($_GET['size'] == 'inventory')) {
        //$database->imagecopymerge_alpha($body, $bag, 0, 0, 0, 0, imagesx($bag), imagesy($bag),100);
    }

// OUTPUT IMAGE:
    header("Content-Type: image/png");
    imagesavealpha($body, TRUE);
    imagepng($body, NULL);
    imagedestroy($body);
?>