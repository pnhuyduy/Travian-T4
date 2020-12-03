<?php
    global $database;
    $x = $_POST['data']['x'];
    $y = $_POST['data']['y'];
    $zoom = $_POST['data']['zoomLevel'];

    if ((isset($x) && $x <= 100 && $x >= -100) && (isset($y) && $y <= 100 && $y >= -100)) {
        $error = FALSE;
    } else {
        $error = TRUE;
    }

    $x1 = $x + 5;
    $xorg = $x1;
    $x2 = $x - 5;

    $y1 = $y + 4;
    $y2 = $y - 4;

    while ($x1 >= $x2 && $y1 >= $y2) {
// while($x2 <= 10 && $y2 <= 8){
        $html = $t = $c = $c2 = $c3 = null;


        $d = $database->getVilWref($x1, $y1);
        if ($database->getOasisV($d)) {
            $basearray = $database->getOMInfo($d);
        } else {
            $basearray = $database->getMInfo($d);
        }
        $html .= '</span>
<span class=\"coordinatesWrapper\">
<span class=\"coordinateX\">(' . $basearray['x'] . '</span>
<span class=\"coordinatePipe\">|</span>
<span class=\"coordinateY\">' . $basearray['y'] . ')</span>
</span></span><span class=\"clear\">&#8206;</span>&nbsp;</h1>';
        switch ($basearray['fieldtype']) {
            case 1:
                $c2 = 'k.f1';
                break;
            case 2:
                $c2 = 'k.f2';
                break;
            case 3:
                $c2 = 'k.f3';
                break;
            case 4:
                $c2 = 'k.f4';
                break;
            case 5:
                $c2 = 'k.f5';
                break;
            case 6:
                $c2 = 'k.f6';
                break;
            case 7:
                $c2 = 'k.f7';
                break;
            case 8:
                $c2 = 'k.f8';
                break;
            case 9:
                $c2 = 'k.f9';
                break;
            case 10:
                $c2 = 'k.f10';
                break;
            case 11:
                $c2 = 'k.f11';
                break;
            case 12:
                $c2 = 'k.f12';
                break;
            case 0:
                switch ($basearray['oasistype']) {
                    case 1:
                        $c3 = '{a:r1} {a.r1} 25%';
                        break;
                    case 2:
                        $c3 = '{a:r1} {a.r1} 50%';
                        break;
                    case 3:
                        $c3 = '{a:r1} {a.r1} 25%<br>{a:r4} {a.r4} 25%';
                        break;
                    case 4:
                        $c3 = '{a:r2} {a.r2} 25%';
                        break;
                    case 5:
                        $c3 = '{a:r2} {a.r2} 50%';
                        break;
                    case 6:
                        $c3 = '{a:r2} {a.r2} 25%<br>{a:r4} {a.r4} 25%';
                        break;
                    case 7:
                        $c3 = '{a:r3} {a.r3} 25%';
                        break;
                    case 8:
                        $c3 = '{a:r3} {a.r3} 50%';
                        break;
                    case 9:
                        $c3 = '{a:r3} {a.r3} 25%<br>{a:r4} {a.r4} 25%';
                        break;
                    case 10:
                    case 11:
                        $c3 = '{a:r4} {a.r4} 25%';
                        break;
                    case 12:
                        $c3 = '{a:r4} {a.r4} 50%';
                        break;
                }
                break;
        }
        switch ($basearray['name']) {
            case 'JR_ART_BPVN';
                $name = ART_BPVN;
                break;
            case 'ART_AR_SVN';
                $name = ART_AR_SVN;
                break;
            case 'ART_AR_GVN';
                $name = ART_AR_GVN;
                break;
            case 'ART_AR_UVN';
                $name = ART_AR_UVN;
                break;
            case 'ART_MH_SVN';
                $name = ART_MH_SVN;
                break;
            case 'ART_MH_GVN';
                $name = ART_MH_GVN;
                break;
            case 'ART_MH_UVN';
                $name = ART_MH_UVN;
                break;
            case 'ART_HS_SVN';
                $name = ART_HS_SVN;
                break;
            case 'ART_HS_GVN';
                $name = ART_HS_GVN;
                break;
            case 'ART_HS_UVN';
                $name = ART_HS_UVN;
                break;
            case 'ART_TD_SVN';
                $name = ART_TD_SVN;
                break;
            case 'ART_TD_GVN';
                $name = ART_TD_GVN;
                break;
            case 'ART_TD_UVN';
                $name = ART_TD_UVN;
                break;
            case 'ART_AA_SVN';
                $name = ART_AA_SVN;
                break;
            case 'ART_AA_GVN';
                $name = ART_AA_GVN;
                break;
            case 'ART_AA_UVN';
                $name = ART_AA_UVN;
                break;
            case 'ART_RC_SVN';
                $name = ART_RC_SVN;
                break;
            case 'ART_RC_GVN';
                $name = ART_RC_GVN;
                break;
            case 'ART_RC_UVN';
                $name = ART_RC_UVN;
                break;
            case 'ART_SP_SVN';
                $name = ART_SP_SVN;
                break;
            case 'ART_SP_GVN';
                $name = ART_SP_GVN;
                break;
            case 'ART_AF_SVN';
                $name = ART_AF_SVN;
                break;
            case 'ART_AF_GVN';
                $name = ART_AF_GVN;
                break;
            default :
                $name = $basearray['name'];
                break;
        }
// echo $name;
        if (isset($basearray['owner']) && $basearray['owner'] > 0) {
            if ($name != "آبادی تسخیر نشده") {
                $c = '{k.dt} ' . $name . '';
            } else {
                $c = $name;
            }
        } elseif (!$basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {
            $c = '{k.fo} ';
        } elseif ($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) {
            $c = '{k.bt} ';
        } elseif ($basearray['occupied'] && !$basearray['oasistype'] && $basearray['fieldtype']) {
            $c = '{k.dt} ';
        } else {
            $c = '{k.vt} {' . $c2 . '}';
        }
        if (($basearray['occupied'] && $basearray['oasistype'] && !$basearray['fieldtype']) || (isset($basearray['owner']) && $basearray['owner'] > 5)) {
            $uinfo = $database->getUser($basearray['owner'], 1);
            // $vilowner = $database->getVillage($basearray['conqured']);
            $ally_name = $database->getAllianceName($uinfo['alliance']);

            switch ($uinfo['tribe']) {
                case 1:
                    $t = 'a.v1';
                    break;
                case 2:
                    $t = 'a.v2';
                    break;
                case 3:
                    $t = 'a.v3';
                    break;
                case 4:
                    $t = 'a.v4';
                    break;
                case 5:
                    $t = 'a.v5';
                    break;
            }
            // echo $basearray['owner']."S";die;
            $vname = $database->getUserField($basearray['owner'], 'username', 0);
            // echo $vname;die;
            //if ($vname == 'Nature') $vname='&#1591;&#1576;&#1740;&#1593;&#1578;';
            $html .= '<br>{k.spieler} ' . $vname . '
	<br>{k.einwohner} ' . $basearray['pop'] . '';
            if ($uinfo['alliance'] > 0) {
                $html .= '<br>{k.allianz} ' . $ally_name . '';
            }
            $html .= '<br>{k.volk} {' . $t . '}';
        }
        $html .= '<br>' . $c3;
// $data = array('error' => false,'errorMsg' => Null,'data' => array('tiles' => array ('0' => array('x' => $x , 'y'=> $y , 'c' => $c ,'t' => $html) )));

// if($y0 > 0 && $y1 < 0){
        if ($y1 >= -99 && $y1 <= -91 && $x1 >= -99 && $x1 <= -91 && $zoom == 2) {
            $x1--;
        }

        $numb .= '{"x":"' . $x1 . '","y":"' . $y1 . '"';
        if ($basearray['owner'] > 4 || $basearray['owner'] == 3) {
            $numb .= ',"d":"' . $d . '"';
        }
        if ($basearray['owner'] > 5) {
            $numb .= ',"u":"' . $d . '"';
        }
        if ($c) {
            $numb .= ',"c":"' . $c . '","t":"' . $html . '"},';
        } else {
            $numb .= '},';
        }

        $x1--;
        if ($x1 < $x2) {
            $y1--;
            $x1 = $xorg;
        }
        $dd .= $basearray['x'] . ' ' . $basearray['y'] . "\n";

    }
    $numb = str_replace('\t', '', $numb);
    $numb = str_replace('\n', '', $numb);
    $numb = str_replace('
', '', $numb);

    $str = '{
	response: {"error":false,"errorMsg":null,"data":{"tiles":[' . $numb . ']}}
}';
    echo $str;
?>