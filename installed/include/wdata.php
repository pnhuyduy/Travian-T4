<?php


include("database.php");


$xyas = (1 + (2 * WORLD_MAX));
$nareadis = NATARS_MAX;
for ($i = 0; $i < $xyas; $i++) {
    $y = (WORLD_MAX - $i);
    for ($j = 0; $j < $xyas; $j++) {
        $x = ((WORLD_MAX * -1) + $j);


        //choose a field type
        if ($x >= -2 && $x <= 2 && $y >= -2 && $y <= 1) {
            if ($x == 0 && $y == 0) {
                $typ = '1';
            } else {
                $typ = '3';
            }
            $otype = '0';
        } else {
            $rand = rand(1, 1000);
            if ("900" >= $rand) {
                if ("10" >= $rand) {
                    $typ = '1';
                    $otype = '0';
                } else if ("90" >= $rand) {
                    $typ = '2';
                    $otype = '0';
                } else if ("400" >= $rand) {
                    $typ = '3';
                    $otype = '0';
                } else if ("480" >= $rand) {
                    $typ = '4';
                    $otype = '0';
                } else if ("560" >= $rand) {
                    $typ = '5';
                    $otype = '0';
                } else if ("570" >= $rand) {
                    $typ = '6';
                    $otype = '0';
                } else if ("600" >= $rand) {
                    $typ = '7';
                    $otype = '0';
                } else if ("630" >= $rand) {
                    $typ = '8';
                    $otype = '0';
                } else if ("660" >= $rand) {
                    $typ = '9';
                    $otype = '0';
                } else if ("740" >= $rand) {
                    $typ = '10';
                    $otype = '0';
                } else if ("820" >= $rand) {
                    $typ = '11';
                    $otype = '0';
                } else {
                    $typ = '12';
                    $otype = '0';
                }
            }
        }

        //image pick
        $image = "grassland" . rand(1, 11) . "";

        $q = "INSERT into " . TB_PREFIX . "wdata values (0,'" . $typ . "','" . $otype . "','" . $x . "','" . $y . "',0,'" . $image . "','')";
        $database->query($q);
    }
}

include("tiles.php");

header("Location: ../index.php?s=4");
?>