<?php

set_time_limit(0);
error_reporting(0);

//include("database.php");

$list = array(
    'lake0',
    'clay0',
    'hill0',
    'forest0',

    'lake1',
    'clay1',
    'lake0',
    'clay0',
    'hill1',
    'forest1',

    'lake2',
    'clay2',
    'hill0',
    'forest0',
    'hill2',
    'forest2',

    'lake3',
    'clay3',
    'lake0',
    'clay0',
    'hill3',
    'forest3',

    'lake4',
    'clay4',
    'hill0',
    'forest0',
    'hill4',
    'forest4',

    'lake5',
    'clay5',
    'hill0',
    'forest0',
    'hill5',
    'forest5',

    'lake6',
    'clay6',
    'lake0',
    'clay0',
    'hill6',
    'forest0',

    'lake7',
    'clay7',
    'hill0',
    'forest0',
    'hill2',
    'forest5',

);

$xt = 60;

for ($rand1 = 0; $rand1 <= 198; $rand1++) {
    $xtile[$rand1] = $xt;
    $xt += 60;
}

$Volcanolist = 'vulcano';

$vol_location = array(
    '-2 1 0', '-1 1 4', '0 1 8', '1 1 12', '2 1 16',
    '-2 0 1', '-1 0 5', '0 0 9', '1 0 13', '2 0 17',
    '-2 -1 2', '-1 -1 6', '0 -1 10', '1 -1 14', '2 -1 18',
    '-2 -2 3', '-1 -2 7', '0 -2 11', '1 -2 15', '2 -2 19',
);

$counter = $totalz = $maxcounter = 0;

foreach ($vol_location as $loc) {
    $locs = explode(' ', $loc);
    $x = $locs[0];
    $y = $locs[1];
    $pos = $locs[2];
    $image = $Volcanolist;
    //if ($pos == 10) {
    //    $image = 'grassland1';
    //}
    if ($pos == 13) {
        $fieldtyp = 3;
    } else {
        $fieldtyp = 0;
    }
    $q = "UPDATE s1_wdata set `fieldtype` = $fieldtyp , `image` = '$image' , `pos` ='$pos' WHERE x = '$x' AND y = '$y'";
    mysql_query($q) or die(mysql_error());
}

$max[] = "5880 6060";
$max[] = "5940 6060";
$max[] = "6000 6060";
$max[] = "6060 6060";
$max[] = "6120 6060";

$max[] = "5880 6000";
$max[] = "5940 6000";
$max[] = "6000 6000";
$max[] = "6060 6000";
$max[] = "6120 6000";

$max[] = "5880 5940";
$max[] = "5940 5940";
$max[] = "6000 5940";
$max[] = "6060 5940";
$max[] = "6120 5940";

$max[] = "5880 5880";
$max[] = "5940 5880";
$max[] = "6000 5880";
$max[] = "6060 5880";
$max[] = "6120 5880";

for ($i = 0; $i <= 198; $i += $rand_i) {
    unset($temp, $tile_counter);
    for ($z = 0; $z <= 198; $z += $rand_z) {
        unset($temp, $tile_counter);
        $lists = $list[mt_rand(0, 35)];

        if (isset($lists)) {
            $imgloc = "../../". GP_LOCATE . "img/mkarte/" . $lists . ".gif";

            $img = imagecreatefromgif($imgloc);

            list($width, $height) = getimagesize($imgloc);

            $width2 = $width - 60;
            $height2 = $height - 60;

            $pic_x_max = ($width) / 60;
            $pic_y_max = ($height) / 60;

            $maxwidth = round((540 - $width) / 60);
            $maxheight = round((540 - $height) / 60);


            $start_x = $xtile[$i];
            $start_y = $start_y_org = $xtile[$z];

$temp = array();

            if ($start_x < 11820 && $start_y < 11820) {
                $tile_counter[] = $lists;

                for ($iii = 0; $iii <= $width2 / 60; $iii++) {
                    if ($start_x >= 11820&& $start_y >= 11820) {
                        unset($temp);
                        break;
                    }

                    for ($zzz = 0; $zzz <= $height2 / 60; $zzz++) {
                        $temp[] = "$start_x $start_y";
                        $start_y += 60;
                    }
                    $start_x += 60;
                    $start_y = $start_y_org;

                }

                $notallow = $tiles = 0;


                foreach ($temp as $temporary) {
                    //foreach ($max as $max2) {
                        if (in_array($temporary, $max) != false) {
                            $notallow = 1;
break;
                        }
                   // }
                }

                if($notallow == 1){
unset($temp);
                    continue;
                }

                $maxcounter = 0;
                if ($notallow == 0) {
                    foreach ($temp as $temporary) {
                        $max[] = $temporary;

                        $tile_split = preg_split('#(?=\d)(?<=[a-z])#i', $tile_counter[0]);
                        $xtp = 0;
                        for ($rand3 = -99; $rand3 <= 99; $rand3++) {
                            $maptile[$xtp] = $rand3;
                            $xtp += 60;
                        }
                        $xtp2 = 0;
                        for ($rand4 = 99; $rand4 > -99; $rand4--) {
                            $maptile2[$xtp2] = $rand4;
                            $xtp2 += 60;
                        }

                        $res = explode(' ', $temporary);
                        $x = $maptile[$res[0]];
                        $y = $maptile2[$res[1]];

                        $t = $tiles;
                        $notil = $tile_split[0] . '_' . $tile_split[1];
                        $text = $notil . "_" . $t;
                        $rander = rand(0, 10);
                        $advance = '';

                        if ($rander < 5) {
                            if ($tile_split[0] == 'lake') {
                                $advance = "`oasistype` = " . rand(10, 12) . " , `fieldtype` = 0 , ";
                            } elseif ($tile_split[0] == 'hill') {
                                $advance = "`oasistype` = " . rand(7, 9) . " , `fieldtype` = 0 , ";
                            } elseif ($tile_split[0] == 'clay') {
                                $advance = "`oasistype` = " . rand(4, 6) . " , `fieldtype` = 0 , ";
                            } elseif ($tile_split[0] == 'forest') {
                                $advance = "`oasistype` = " . rand(1, 3) . " , `fieldtype` = 0 , ";
                            }
                        } else {
                            $advance = "`oasistype` = 0 , `fieldtype` = 0 , ";
                        }

                        $q = "UPDATE s1_wdata set $advance `image` = '$notil' , `pos` ='$t' WHERE x = '$x' AND y = '$y'";
                        mysql_query($q) or die(mysql_error());
                        $tiles++;
                    }
                }
                //$maxcounter++;
            }
        }
        $rand_z = rand(1, 4);
    }
    $rand_i = rand(1, 4);
}