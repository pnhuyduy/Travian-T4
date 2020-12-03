<?php

$blockAll = 0;

$y = $_POST['x'];

$x = $_POST['y'];

$d = $database->getVilWref($y, $x);

if ($database->getOasisV($d)) {

    $basearray = $database->getOMInfo($d);

    //$typ = "oasis oasis-".$basearray['oasistype']."";

} else {

    $basearray = $database->getMInfo($d);

    //$typ = "village village-".$basearray['fieldtype']."";

}

//$s = ($basearray['fieldtype'] == 0) ? 'oasis-' . $basearray['oasistype'] : 'village-' . $basearray['fieldtype'];


if (!$basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {

    $s1 = 'oasis';
    $s2 = 'oasis-' . $basearray['oasistype'];
    $texts = "&#1570;&#1576;&#1575;&#1583;&#1740; &#1578;&#1587;&#1582;&#1740;&#1585; &#1606;&#1588;&#1583;&#1607;";

} elseif ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {

    $s1 = 'oasis';
    $s2 = 'oasis-' . $basearray['oasistype'];
    $texts = "&#1570;&#1576;&#1575;&#1583;&#1740; &#1578;&#1587;&#1582;&#1740;&#1585; &#1588;&#1583;&#1607;";

} elseif ($basearray['occupied'] && !$basearray['oasistype'] && $basearray['fieldtype']) {

    $s1 = 'village';
    $s2 = 'village-' . $basearray['fieldtype'];
    $texts = $basearray['name'];

} else if(!$basearray['occupied'] && !$basearray['oasistype'] && !$basearray['fieldtype']){

    $s1 = 'landscape';
    $tile_split = explode('_', $basearray['image']);
//echo $tile_split[0];
    if($tile_split[0] == 'lake'){
        $matn = 'crop';
    }elseif($tile_split[0] == 'hill'){
        $matn = 'iron';
    }elseif($tile_split[0] == 'clay'){
        $matn = 'clay';
    }elseif($tile_split[0] == 'forest'){
        $matn = 'wood';
    }

    $s2 = 'landscape-' . $tile_split[0];
    $texts = "Wilderness";
    $blockAll = 1;
}else{
    $s1 = 'village';
    $s2 = 'village-' . $basearray['fieldtype'];
    $texts .= "Abandoned Valley";
}


$html .= '

	<div id=\"tileDetails\" class=\"'.$s1.' ' . $s2 . '\">

	<h1><span class=\"coordinates coordinatesWithText\">

	<span class=\"coordText\"> '.$texts
;

$html .= '</span>

<span class=\"coordinatesWrapperRTL\">

<span class=\"coordinateX\"> (' . $basearray['x'] . '</span>

<span class=\"coordinatePipe\">|</span>

<span class=\"coordinateY\">' . $basearray['y'] . ')</span>

</span></span><span class=\"clear\">&#8206;</span>&nbsp;</h1>';

if ($basearray['occupied'] && $basearray['capital']) {
    $html .= '<span class=\"mainVillage\">(&#1662;&#1575;&#1740;&#1578;&#1582;&#1578;)</span>';
}

$html .= '<span class=\"clear\">&nbsp;</span><br />

<div class=\"detailImage\">

<div id=\"options\">

<div class=\"option\"><a href=\"karte.php?x=' . $y . '&y=' . $x . '\" class=\"a arrow\" title=\"Map center.\">&#1605;&#1585;&#1705;&#1586; &#1606;&#1602;&#1588;&#1607;</a></div>';

if($blockAll == 0) {

    if (!$basearray['occupied']) {

        $html .= '<div class=\"option\">';

        $mode = CP;

        $total = count($database->getProfileVillages($session->uid));

        $need_cps = ${'cp' . $mode}[$total + 1];

        $cps = $database->getUserField($session->uid, 'cp', 0);


        if ($cps >= $need_cps) {
            $enough_cp = true;
        } else {
            $enough_cp = false;
        }


        // $otext = ($basearray['occupied'] == 1)? $html .= '&#1570;&#1576;&#1575;&#1583;&#1740;' : $html .= '&#1578;&#1587;&#1582;&#1740;&#1585; &#1606;&#1588;&#1583;&#1607;';

        if ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND $enough_cp) {

            $test = '<a href=\"a2b.php?id=' . $d . '&s=1\" class=\"a arrow\" >Found New village</a>';

        } elseif ($village->unitarray['u' . $session->tribe . '0'] >= 3 AND !$enough_cp) {

            $test = '<span class=\"a arrow disabled\" title=\"(' . $cps . '/' . $need_cps . ' culture points)\">Found New village</span>';

        } else {

            $test = '<span class=\"a arrow disabled\">Found New village.</span>';

        }

        $html .= ($basearray['fieldtype'] == 0) ? ($village->resarray['f39'] == 0) ? ($basearray['owner'] == $session->uid) ?

            '<a href=\"build.php?id=39\" class=\"a arrow\">&#1594;&#1575;&#1585;&#1578; $otext (Build Rally point)</a>' :

            '<span class=\"a arrow disabled\">&#1594;&#1575;&#1585;&#1578; ' . $otext . ' (Build Rally point)</span>' :

            '<a href=\"a2b.php?z=' . $d . '&o\" class=\"a arrow\">&#1594;&#1575;&#1585;&#1578; ' . $otext . '</a>' : $test;

        $html .= '</div>';

        if ($session->goldclub == 12312312312313) {

            $html .= '<div class=\"option\">

	<form action=\"build.php?id=39&t=99\" method=\"post\">

	<input type=\"hidden\" name=\"action\" value=\"addList\">

	<input type=\"hidden\" id=\"did\" name=\"did\" type=\"text\" value=\"' . $village->wid . '\">

	<input type=\"hidden\" id=\"name\" name=\"name\" type=\"text\" value=\"' . $data2["username"] . '\">

	<input type=\"hidden\" name=\"type\" value=\"addfarm\">

	';

            $t = $database->getAInfo($database->getVillageID($data2['id']));

            $html .= '<input type=\"hidden\" name=\"x\" value=\"' . $t["x"] . '\">

	<input type=\"hidden\" name=\"y\" value=\"' . $t["y"] . '\">

	<button class=\"a arrow\" type=\"submit\" value=\"create\" value=\"reportButton repeat\" class=\"icon\" title=\"Add to farmlist\"\">اضافه کرده به فارم لیست</button>

	</form></div>

	';

        }

    } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] == 0 && $basearray['wref'] != $_SESSION['wid']) {

        $html .= '<div class=\"option\">';

        $query1 = mysql_query('SELECT `owner` FROM `' . TB_PREFIX . 'vdata` WHERE `wref` = ' . $d . '');

        $data1 = mysql_fetch_assoc($query1);

        $query2 = mysql_query('SELECT `id`,`protect`,`username` FROM `' . TB_PREFIX . 'users` WHERE `id` = ' . $data1['owner'] . ' LIMIT 1');

        $data2 = mysql_fetch_assoc($query2);

        if ($database->checkBan($data2['id'])) {

            $html .= '<span class=\"a arrow disabled\" title=\"This Player Has been Banned\">&#1604;&#1588;&#1705;&#1585;&#1705;&#1588;&#1740;</span>';

        } else if ($data2['protect'] < time() || $data2['id'] == $session->uid) {

            $html .= $village->resarray['f39'] ? '<a href=\"a2b.php?z=' . $d . '\" class=\"a arrow\" >&#1604;&#1588;&#1705;&#1585;&#1705;&#1588;&#1740;</a>' : "<span class=\"a arrow disabled\" title=\"(Build Rally point)\">&#1604;&#1588;&#1705;&#1585; &#1705;&#1588;&#1740;</span>";

        } else {

            $html .= '<span class=\"a arrow disabled\" title=\"(Player is under beginner\'s protection)\">&#1604;&#1588;&#1705;&#1585;&#1705;&#1588;&#1740;</span>';

        }

        $html .= '</div><div class=\"option\">';

        $html .= $building->getTypeLevel(17) ? '<a href=\"build.php?z=' . $d . '&id=' . $building->getTypeField(17) . '\" class=\"a arrow\">ارسال تاجرها</a>' : '<span class=\"a arrow disabled\" title=\"(Build Market)\">&#1575;&#1585;&#1587;&#1575;&#1604; &#1578;&#1575;&#1580;&#1585; &#1607;&#1575;</span>';

        $html .= '</div>';

        if ($session->goldclub == 1) {

            $html .= '<div class=\"option\">

	<form action=\"build.php?id=39&t=99\" method=\"post\">

	<input type=\"hidden\" name=\"action\" value=\"addList\">

	<input type=\"hidden\" id=\"did\" name=\"did\" type=\"text\" value=\"' . $village->wid . '\">

	<input type=\"hidden\" id=\"name\" name=\"name\" type=\"text\" value=\"' . $data2["username"] . '\">

	<input type=\"hidden\" name=\"type\" value=\"addfarm\">

	';

            $t = $database->getAInfo($database->getVillageID($data2['id']));

            $html .= '<input type=\"hidden\" name=\"x\" value=\"' . $t["x"] . '\">

	<input type=\"hidden\" name=\"y\" value=\"' . $t["y"] . '\">

	<button class=\"a arrow\" type=\"submit\" value=\"create\" value=\"reportButton repeat\" class=\"icon\" title=\"Add to farmlist\">اضافه کرده به فارم لیست</button>

	</form></div>

	';

        }

    } else if ($basearray['occupied'] == 1 && $basearray['oasistype'] != 0 && $basearray['wref'] != $_SESSION['wid']) {

        $html .= '<div class=\"option\">';

        $html .= $village->resarray['f39'] ? '<a href=\"a2b.php?z=' . $d . '\" class=\"a arrow\" >Send troops.</a>' : '<span class=\"a arrow disabled\" title=\"(Build Rally point)\">&#1604;&#1588;&#1705;&#1585; &#1705;&#1588;&#1740;</span>';

        $html .= '  </div>';

    }

    $html .= '</div></div><div id=\"map_details\">';

    if ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {


        $html .= ' <table cellpadding=0 cellspacing=0 id=\"village_info\" class=\"transparent\">';

        $uinfo = $database->getUser($basearray['owner'], 1);

        $vilowner = $database->getVillage($basearray['conqured']);

        $html .= '	<tbody>

<tr class=\"first\" >

<th>Tribe</th>

<td>';

        switch ($uinfo['tribe']) {

            case 1:
                $html .= TRIBE1;
                break;

            case 2:
                $html .= TRIBE2;
                break;

            case 3:
                $html .= TRIBE3;
                break;

            case 5:
                $html .= TRIBE5;
                break;

        }

        $html .= '</td></tr><tr>

<th>Alliance</th>';

        if ($uinfo['alliance'] == 0) {

            $html .= '<td>-</td>';

        } else $html .= '

<td><a href=\"allianz.php?aid=' . $uinfo['alliance'] . '\">' . $database->getUserAlliance($basearray['owner']) . '</a></td>';

        $html .= '</tr>

<tr>

	<th>Owner</th>

	<td><a href=\"spieler.php?uid=' . $basearray['owner'] . '\">' . $database->getUserField($basearray['owner'], username, 0) . '</a></td>

</tr>

<tr>

	<th>&#1583;&#1607;&#1705;&#1583;&#1607;</th>

	<td><a href=\"karte.php?z=' . $basearray['wref'] . '\">' . $vilowner['name'] . '</a></td>

</tr>

</tbody></table><Br />.';

    }

    $html .= '<h4>';

    if (!$basearray['fieldtype'] && $basearray['oasistype']) {
        $html .= '&#1582;&#1589;&#1608;&#1589;&#1740;&#1575;&#1578; &#1587;&#1585;&#1586;&#1605;&#1740;&#1606;';
    } else {
        $html .= '&#1582;&#1589;&#1608;&#1589;&#1740;&#1575;&#1578; &#1587;&#1585;&#1586;&#1605;&#1740;&#1606;';
    }

    $html .= '</h4>';

    $html .= '<table cellpadding=\"1\" cellspacing=\"1\" id=\"distribution\" class=\"transparent\"><tbody>';

    if ($basearray['fieldtype'] && $basearray['owner']) {

        switch ($basearray['fieldtype']) {

            case 1:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 3</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 3</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 3</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 9</td>';

                break;

            case 2:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 3</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 4</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 5</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 3:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 4</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 4</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 4</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 4:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 4</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 5</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 3</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 5:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 5</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 3</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 4</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 6:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 1</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 1</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 1</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 15</td>';

                break;

            case 7:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 4</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 4</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 3</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 7</td>';

                break;

            case 8:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 3</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 4</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 4</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 7</td>';

                break;

            case 9:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 4</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 3</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 4</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 7</td>';

                break;

            case 10:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 3</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 5</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 4</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 11:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 4</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 3</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 5</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 12:

                $tt = '

	<td><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"> 5</td>

	<td><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"> 4</td>

	<td><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"> 3</td>

	<td><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"> 6</td>';

                break;

            case 0:

                switch ($basearray['oasistype']) {

                    case 1:

                        $tt = '

	<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . LUMBER . '</td>';

                        break;

                    case 2:

                        $tt = '

	<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">' . LUMBER . '</td>';

                        break;

                    case 3:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . LUMBER . '</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . CROP . '</td></tr>';

                        break;

                    case 4:

                        $tt = '

	<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">Clay</td>';

                        break;

                    case 5:

                        $tt = '

	<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">Clay</td>';

                        break;

                    case 6:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . CLAY . '</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . CROP . '</td></tr>';

                        break;

                    case 7:

                        $tt = '

	<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . IRON . '</td>';

                        break;

                    case 8:

                        $tt = '

	<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">' . IRON . '</td>';

                        break;

                    case 9:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . IRON . '</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . CROP . '</td></tr>';

                        break;

                    case 10:

                    case 11:

                        $tt = '

	<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">' . CROP . '</td>';

                        break;

                    case 12:

                        $tt = '

	<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">' . CROP . '</td>';

                        break;

                }

                break;

        }

    } else {

        switch ($basearray['fieldtype']) {

            case 1:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">3</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">3</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">3</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">9</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 2:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">3</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">4</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">5</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 3:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">4</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">4</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">4</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 4:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">4</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">5</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">3</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 5:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">5</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">3</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">4</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 6:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">1</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">1</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">1</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">15</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 7:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">4</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">4</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">3</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">7</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 8:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">3</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">4</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">4</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">7</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 9:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">4</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">3</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">4</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">7</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 10:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">3</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">5</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">4</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 11:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">4</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">3</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">5</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 12:

                $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td><td class=\"val\">5</td><td class=\"desc\">Woodcutters</td></tr>

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td><td class=\"val\">4</td><td class=\"desc\">Clay Pits</td></tr>

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td><td class=\"val\">3</td><td class=\"desc\">Iron Mines</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td><td class=\"val\">6</td><td class=\"desc\">Croplands</td></tr>';

                break;

            case 0:

                switch ($basearray['oasistype']) {

                    case 1:

                        $tt = '

	<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1670;&#1608;&#1576;</td>';

                        break;

                    case 2:

                        $tt = '

	<td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">&#1670;&#1608;&#1576;</td></tr>';

                        break;

                    case 3:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r1\" src=\"img/x.gif\" title=\"' . LUMBER . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1670;&#1608;&#1576;</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1711;&#1606;&#1583;&#1605;</td></tr>';

                        break;

                    case 4:

                        $tt = '

	<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1582;&#1588;&#1578;</td>';

                        break;

                    case 5:

                        $tt = '

	<td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">&#1582;&#1588;&#1578;</td>';

                        break;

                    case 6:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r2\" src=\"img/x.gif\" title=\"' . CLAY . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1582;&#1588;&#1578;</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1711;&#1606;&#1583;&#1605;</td></tr>';

                        break;

                    case 7:

                        $tt = '

	<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1570;&#1607;&#1606;</td></tr>';

                        break;

                    case 8:

                        $tt = '

	<td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">&#1570;&#1607;&#1606;</td></tr>';

                        break;

                    case 9:

                        $tt = '

	<tr><td class=\"ico\"><img class=\"r3\" src=\"img/x.gif\" title=\"' . IRON . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1570;&#1607;&#1606;</td></tr>

	<tr><td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1711;&#1606;&#1583;&#1605;</td></tr>';

                        break;

                    case 10:

                    case 11:

                        $tt = '

	<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">25%</td><td class=\"desc\">&#1711;&#1606;&#1583;&#1605;</td></tr>';

                        break;

                    case 12:

                        $tt = '

	<td class=\"ico\"><img class=\"r4\" src=\"img/x.gif\" title=\"' . CROP . '\"></td>

	<td class=\"val\">50%</td><td class=\"desc\">&#1711;&#1606;&#1583;&#1605;</td></tr>';

                        break;

                }

                break;

        }

    }

    $html .= $tt;

    $html .= '</tbody></table>';

    if ($basearray['fieldtype'] == 0 && !$basearray['occupied']) {

        $html .= '<br /><h4>&#1606;&#1740;&#1585;&#1608;&#1607;&#1575;</h4><table cellpadding=\"0\" cellspacing=\"0\" id=\"troop_info\" class=\"transparent\"><tbody>';

        $unit = $database->getUnit($d);

        $unarray = array(31 => U31, U32, U33, U34, U35, U36, U37, U38, U39, U40);

        $a = 0;

        for ($i = 31; $i <= 40; $i++) {

            if ($unit['u' . $i]) {

                $html .= '<tr>';

                $html .= '<td class=\"ico\"><img class=\"unit u' . $i . '\" src=\"img/x.gif\" alt=\"' . $unarray[$i] . '\" title=\"' . $unarray[$i] . '\" /></td>';

                $html .= '<td class=\"val\">' . $unit['u' . $i] . '</td>';

                $html .= '<td class=\"desc\">' . $unarray[$i] . '</td>';

                $html .= '</tr>';

            } else {

                $a = $a + 1;

            }

        }

        if ($a == 10) {

            $html .= '<tr><td>None.</td></tr>';

        }

        $html .= '</tbody></table>';

    } else if ($basearray['occupied'] && !$basearray['oasistype']) {

        $html .= '<br />

	<h4>&#1576;&#1575;&#1586;&#1740;&#1705;&#1606;</h4>

	<table cellpadding=\"0\" cellspacing=\"0\" id=\"village_info\" class=\"transparent\">';


        $uinfo = $database->getUser($basearray['owner'], 1);

        $html .= '<tbody><tr class=\"first\"><th>&#1606;&#1586;&#1575;&#1583;</th><td>';


        switch ($uinfo['tribe']) {

            case 1:
                $html .= '&#1585;&#1608;&#1605;';
                break;

            case 2:
                $html .= '&#1578;&#1608;&#1578;&#1606;';
                break;

            case 3:
                $html .= '&#1711;&#1608;&#1604;';
                break;

            case 5:
                $html .= '&#1591;&#1576;&#1740;&#1593;&#1578;';
                break;

        }

        $html .= '</td></tr><tr>

<th>&#1575;&#1578;&#1581;&#1575;&#1583;</th>';

        if ($uinfo['alliance'] == 0) {

            $html .= '<td>-</td>';

        } else {

            $html .= '

<td><a href=\"allianz.php?aid=' . $uinfo['alliance'] . '\">' . $database->getUserAlliance($basearray['owner']) . '</a></td>

';
        }

        $html .= '

</tr>

<tr>

	<th>&#1589;&#1575;&#1581;&#1576;</th>

	<td><a href=\"spieler.php?uid=' . $basearray['owner'] . '\">' . $database->getUserField($basearray['owner'], 'username', 0) . '</a></td>

</tr>

<tr>

<th>&#1580;&#1605;&#1593;&#1740;&#1578;</th>

<td>' . $basearray["pop"] . '</td>

</tr></tbody></table><br />';

    }

    if ($basearray['fieldtype'] && $basearray['owner']) {

        $html .= '

	<h4>&#1711;&#1586;&#1575;&#1585;&#1588; &#1607;&#1575;</h4>

	<table cellpadding=\"0\" cellspacing=\"0\" id=\"troop_info\" class=\"rep transparent\"><tbody>';


        $noticeClass = array("Scout Report", "Won as attacker without losses", "Won as attacker with losses", "Lost as attacker with losses", "Won as defender without losses", "Won as defender with losses", "Lost as defender with losses", "Lost as defender without losses", "Reinforcement arrived", "", "Wood Delivered", "Clay Delivered", "Iron Delivered", "Crop Delivered", "", "Won as defender without losses", "Won as defender with losses", "Lost as defender with losses", "Won scouting as attacker", "Lost scouting as attacker", "Won scouting as defender", "Lost scouting as defender", "Scout Report");


        if ($session->uid == $database->getVillage($d)) {

            $limit = 'ntype=0 and ntype=4 and ntype=5 and ntype=6 and ntype=7';

        } else {

            $limit = 'ntype!=8 and ntype!=9 and ntype!=10 and ntype!=11 and ntype!=12 and ntype!=13 and ntype!=14';

        }

        $result = mysql_query("SELECT `data`,`ntype`,`time`,`id` FROM " . TB_PREFIX . "ndata WHERE $limit AND uid = " . $session->uid . " AND toWref = " . $d . " ORDER BY time DESC Limit 5");

        while ($row = mysql_fetch_assoc($result)) {

            $dataarray = explode(",", $row['data']);

            $type = $row['ntype'];

            $html .= '<tr><td>';

            $html .= '<img src=\"img/x.gif\" class=\"iReport iReport' . $row['ntype'] . '\" title=\"' . $noticeClass[$type] . '\">';

            $date = $generator->procMtime($row['time']);

            $html .= '<a href=\"berichte.php?id=' . $row['id'] . '\">' . $date[0] . ' ' . date('H:i', $row['time']) . '</a>';

            $html .= '</td></tr>';

        }

    }
}

$html .= '</tbody></table></div></div><div class=\"clear\"></div>';

$html = str_replace('\t', '', $html);

$html = str_replace('\n', '', $html);

$html = str_replace('

', '', $html);


$str = '{

	response: {"error":false,"errorMsg":null,"data":{"html":"' . $html . '"}}

}';


echo $str;

?>