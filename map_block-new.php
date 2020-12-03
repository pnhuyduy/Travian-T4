<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/

include("GameEngine/database.php");

$list = array('lake', 'clay', 'hill', 'forest', 'lake', 'clay', 'hill', 'forest', 'lake', 'lake', 'clay', 'hill', 'forest');

$xextra = 0;
$yextra = 0;
$block = 0;
$blocker2 = 0;
$akharesh = 100;
//for ($nw = 0; $nw <= 0; $nw++) {
   // for ($ix = 0; $ix <= 0; $ix++) {
        for ($i = 0; $i <= $akharesh; $i++) {
            //unset($max, $max2);
            $max = array();
            $lists = $list[rand(0, 12)];

            if ($lists == "lake") {
                $rnd = rand(2, 7);
                if($rnd == 6)
                    $rnd++;
                $lists_backup[$i] = $lists . '_' . "$rnd";
                $lists2 = $lists . "$rnd";
            } elseif ($lists == "clay") {
                $rnd = rand(2, 7);
                $lists_backup[$i] = $lists . '_' . "$rnd";
                $lists2 = $lists . "$rnd";
            } elseif ($lists == "hill") {
                $rnd = rand(2, 6);
                if($rnd == 5)
                    $rnd++;
                $lists_backup[$i] = $lists . '_' . "$rnd";
                $lists2 = $lists . "$rnd";
            } elseif ($lists == "forest") {
                $rnd = rand(0, 4);
                $lists_backup[$i] = $lists . '_' . "$rnd";
                $lists2 = $lists . "$rnd";
            }


            $img = GP_LOCATE . "img/mkarte/" . $lists2 . ".gif";
            //echo $lists_backup[$i]." ".$img."<br>";

            $test = imagecreatefromgif($img);
            list($width, $height) = getimagesize($img);


            $width2 = $width - 60;
            $height2 = $height - 60;

            $pic_x_max = ($width) / 60;
            $pic_y_max = ($height) / 60;

            $maxwidth = ((540 - $width) / 60);
            $maxheight = ((540 - $height) / 60);

            $tile_list = array(0, 60, 120, 180, 240, 300, 360, 420, 480, 540);

            $start_x = $tile_list[round($i/10)];


            $start_y = $start_y_org = $tile_list[$blocker2];

            if(!isset($start_y) || ($i % 10 == 0)){
                $start_y = $start_y_org = $tile_list[$blocker2];
                $blocker2++;
                //echo $blocker2.' ';
            }

            echo $start_x.' '.$start_y."<br>";

            $tiles = 0;

            for ($ii = 0; $ii <= ($width2 / 60); $ii++) {

                for ($zz = 0; $zz <= ($height2 / 60); $zz++) {
                    //echo $start_x."<br>";
                    $max[] = array(0 => $start_x, 1 => $start_y, 2 => $tiles, 3 => $lists_backup[$i]);
                    $newmax[$i][] = $start_x . ' ' . $start_y;
                    $start_y += 60;
                    $tiles++;
                }

                $start_x += 60;
                $start_y = $start_y_org;

            }

            $counter = 0;

            $xcords = array(
                0 => -99 + $xextra,
                60 => -98 + $xextra,
                120 => -97 + $xextra,
                180 => -96 + $xextra,
                240 => -95 + $xextra,
                300 => -94 + $xextra,
                360 => -93 + $xextra,
                420 => -92 + $xextra,
                480 => -91 + $xextra,
                540 => -90 + $xextra,
            );

            $ycords = array(
                0 => 99 - $yextra,
                60 => 98 - $yextra,
                120 => 97 - $yextra,
                180 => 96 - $yextra,
                240 => 95 - $yextra,
                300 => 94 - $yextra,
                360 => 93 - $yextra,
                420 => 92 - $yextra,
                480 => 91 - $yextra,
                540 => 90 - $yextra,
            );
            $start_x = 0;
            $start_y = 0;

            if ($i > 0) {
                $arraykol = $newmax[$i];

                foreach ($newmax[$i] as $newloc => $llp) {
                    if (isset($block) && $block == 1) {
                        break;
                    }
                    $tester = explode(' ', $llp);
                    for ($ct = $i - 1; $ct >= 0; $ct--) {
                        if (isset($block) && $block == 1) {
                           break;
                        }
                        foreach ($newmax[$ct] as $newloc2 => $llp2) {
                            $tester2 = explode(' ', $llp2);
                            if ($tester2[0] == $tester[0] && $tester2[1] == $tester[1]) {
                                $block = 1;
                                //echo "BLOCKED";
                                break;
                            }
                        }
                    }
                }
               /* $past = 1;
                $block = 0;
                foreach ($newmax[$i] as $newloc) {
                    if($block == 1)
                        break;
                        foreach ($newmax[$i-$past] as $pastloc) {
                            if($block == 1)
                                break;
                            if(isset($newmax[$i-$past])){
                                //echo "newmax[$i-$past]"."<br>";
                                if($newloc[0] == $pastloc[0] && $newloc[1] == $pastloc[1]){
                                    //var_dump($newloc);
                                    //var_dump($pastloc);
                                    $block = 1;
                                    break;
                                }
                                $past++;
                            }
                        }
                }*/

            }
            if (isset($block) && $block == 1) {
                $block = 0;
                //$akharesh++;
            }else{
                foreach ($max as $res) {

                    $x = $xcords[$res[0]];
                    $y = $ycords[$res[1]];
                    $t = $res[2];
                    $notil = $res[3];
                    //echo "'x' => $x, 'y' => $y<br>";
                    //echo "then -> 'x' => $xcords[$x], 'y' => $ycords[$y] , Tiles => $t , noesh => $notil<br>";
                    $text = $notil . "_" . $t;
                    $q = "UPDATE s1_wdata set `image` = '$notil' , `pos` ='$t' WHERE x = '$x' AND y = '$y'";
                    echo $q . "<br>";
                    //mysql_query($q) or die(mysql_error());
                    $counter++;
                }
            }

            /*for ($ii = 0; $ii <= ($width2 / 60); $ii++) {

                for ($zz = 0; $zz <= ($height2 / 60); $zz++) {
                    $max2[] = array(0 => $start_x, 1 => $start_y);
                    $start_y += 60;
                }
                $start_x += 60;
                $start_y = 0;

            }
*/

        }

        //$xextra += 5;
    //}
   // $xextra = 0;
    //$yextra += 10;
//}

echo "DONE";
?>