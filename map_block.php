<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
ob_start();

//$gmt_mtime = gmdate('D, d M Y H:i:s', time() ) . ' GMT';
//header("Last-Modified: " . $gmt_mtime );
//echo "Last-Modified: " . $gmt_mtime ;
//die;

include('GameEngine/Database.php');
//session_cache_limiter('public');
session_start();

if (
    (isset($_GET['tx0']) && $_GET['tx0'] <= WORLD_MAX && $_GET['tx0'] >= -WORLD_MAX)
    &&
    (isset($_GET['tx1']) && $_GET['tx1'] <= WORLD_MAX && $_GET['tx1'] >= -WORLD_MAX)
    &&
    (isset($_GET['ty0']) && $_GET['ty0'] <= WORLD_MAX && $_GET['ty0'] >= -WORLD_MAX)
    &&
    (isset($_GET['ty1']) && $_GET['ty1'] <= WORLD_MAX && $_GET['ty1'] >= -WORLD_MAX)

) {

    $srcImagePaths = Array();
    $x0 = $_GET['tx0'];
    $y0 = $_GET['ty0'];
    $x1 = $_GET['tx1'];
    $y1 = $_GET['ty1'];
    $i = 0;
    $x2 = $x0;

    $til = $x1 - $x0;
    if ($x0 > 0 && $x1 < 0) {
        $x0 = -$x0;
        $til = $x1 - $x0;
        $x2 = -$x2;
        $x0--;
        $x1++;
        $til++;
    }

    if ($y0 > 0 && $y1 < 0) {
        $y0 = -$y0;
        $y0--;
        //$y1++;
    }

    $tileWidth = $tileHeight = 60;
    if ($til == 9) {
        $numberOfTiles = 10;
    } else {
        $numberOfTiles = 20;
    }
    $pxBetweenTiles = 0;
    $mapWidth = $mapHeight = ($tileWidth + $pxBetweenTiles) * $numberOfTiles;
    $mapImage = imagecreatetruecolor($mapWidth, $mapHeight);
    $bgColor = imagecolorallocate($mapImage, 50, 40, 0);
    imagefill($mapImage, 0, 0, $bgColor);

    function indexToCoords($index)
    {
        global $tileWidth, $pxBetweenTiles, $leftOffSet, $topOffSet, $numberOfTiles;
        $x = ($index % $numberOfTiles) * ($tileWidth + $pxBetweenTiles) + $leftOffSet;
        $y = floor($index / $numberOfTiles) * ($tileWidth + $pxBetweenTiles) + $topOffSet;
        return Array($x, $y);
    }

    $for_test = 0;
    $for_test2 = 0;

    while ($y1 >= $y0 && $x0 <= $x1) {
        $query = "SELECT `id` FROM " . TB_PREFIX . "wdata WHERE x='" . $x0 . "' AND y='" . $y1 . "' LIMIT 1";
        $result = mysql_query($query) or die(mysql_error());
        $row2 = mysql_fetch_assoc($result);
        $row = $database->getMInfo($row2['id']);

        $tribe = $username = $targetalliance = $oasisowner = $friendarray = $enemyarray = $neutralarray = $row2 = $t3 = '';

        $tribe2 = $database->getUserField($row['owner'], "tribe", 0);

        if ($row['occupied'] > 0 && $row['fieldtype'] >= 0) {
            $targetalliance = $database->getUserField($row['owner'], "alliance", 0);
            $tribe = $database->getUserField($row['owner'], "tribe", 0);
            $username = $database->getUserField($row['owner'], "username", 0);
            $oasisowner = $database->getUserField($row['owner'], "username", 0);
            $friendarray = array();
            $enemyarray = array();
            $neutralarray = array();
            //$row2 = $database->getOMInfo($row['id']);
        }

        unset($t4,$t,$t5);
        if($tribe == 4){
            $tribe = 1;
        }
        $t = ($row['occupied'] == 1 && $row['fieldtype'] > 0 && $row['owner'] != 4) ?
            (
                $row['pop'] >= 100 ? $row['pop'] >= 250 ?
                    $row['pop'] >= 500 ?
                        'P4-' . $tribe :
                        'P3-' . $tribe :
                    'P2-' . $tribe :
                    'P1-' . $tribe)   : $row['image'];
       // var_dump($t);
        if (strpos($t, '-') !== FALSE) {
            $loc = 'mkarte/villages';
            $t3 = GP_LOCATE . "img/" . $loc . "/" . $t . ".gif";
            //var_dump($t3);
            $loc = 'mkarte';
            $t2 = GP_LOCATE . "img/" . $loc . "/grassland0.gif";
        }elseif (strpos($t, '_') !== FALSE) {
            $loc = 'mkarte';
            $newt = explode('_', $t);

            $t4 = GP_LOCATE . "img/" . $loc . "/" . $newt[0] . $newt[1] . ".gif";
            $t2 = GP_LOCATE . "img/" . $loc . "/grassland". $newt[1] . ".gif";

            if ($row['oasistype'] != 0) {
                $loc = 'mkarte/oasis';
                $ads = '';
                if($row['occupied'] == 1){
                    $ads = 'o';
                }
                $t5 = GP_LOCATE . "img/" . $loc . "/o".$row['oasistype'].$ads.".gif";
            }
        }
        elseif(strpos($t, 'vulcano') !== FALSE){
            $loc = 'mkarte';
            $t4 = GP_LOCATE . "img/" . $loc . "/vulcano0.gif";
            $t2 = GP_LOCATE . "img/" . $loc . "/grassland0.gif";
        }
       else {
            $loc = 'mkarte';
            $t2 = GP_LOCATE . "img/" . $loc . "/".$t.".gif";
       }
        //$loc = 'mkarte';
        //$t2 = GP_LOCATE . "img/" . $loc . "/grassland0.gif";
        list ($xxx, $yyy) = indexToCoords($for_test2);
        $tileImg = imagecreatefromgif($t2);
        imagecopy($mapImage, $tileImg, $xxx, $yyy, 0, 0, $tileWidth, $tileHeight);
        imagedestroy($tileImg);



        $counter = $extra = 0;

        $xcords = array(
            0 => -99+$extra,
            60 => -98+$extra,
            120 => -97+$extra,
            180 => -96+$extra,
            240 => -95+$extra,
            300 => -94+$extra,
            360 => -93+$extra,
            420 => -92+$extra,
            480 => -91+$extra,
        );

        if(isset($t4)) {
            $test = imagecreatefromgif($t4);
            list($width, $height) = getimagesize($t4);

            $width2 = $width - 60;
            $height2 = $height - 60;

            $cter = $start_x = $start_y = $break = 0;

            for ($ii = 0; $ii <= ($width2 / 60); $ii++) {
                if ($break == 1) {
                    break;
                }
                for ($zz = 0; $zz <= ($height2 / 60); $zz++) {
                    if ($cter == $row['pos']) {

                        $tile_list = array(0, 60, 120, 180, 240, 300, 360, 420, 480, 540);
                        $core = indexToCoords($for_test);
                        //$to_crop_array = array('x' => $start_x, 'y' => $start_y, 'width' => 61, 'height' => 61);
                        //$tileImg = imagecrop($test, $to_crop_array);
                        //imagecopy($mapImage, $tileImg, $core[0], $core[1],0 , 0, $tileWidth, $tileHeight);
                        imagecopy($mapImage, $test, $core[0], $core[1], $start_x, $start_y, 61, 61);

                        if(isset($t5) && $t5 != null){
                            $test = imagecreatefromgif($t5);
                            //$to_crop_array = array('x' => 0, 'y' => 0, 'width' => 61, 'height' => 61);
                            //$tileImg = imagecrop($test, $to_crop_array);
                            //imagecopy($mapImage, $tileImg, $core[0], $core[1],0 , 0, $tileWidth, $tileHeight);
                            imagecopy($mapImage, $test, $core[0], $core[1], 0, 0, 61, 61);
                        }

                        $break = 1;
                        break;
                    }
                    $start_y += 59;
                    $cter++;
                }
                $start_x += 59;
                $start_y = 0;

            }
            imagedestroy($test);
        }

        if(isset($t3) && $t3 != null) {

            list ($x, $y) = indexToCoords($for_test);
            $tileImg = imagecreatefromgif($t3);
            imagecopy($mapImage, $tileImg, $x, $y, 0, 0, $tileWidth, $tileHeight);
            imagedestroy($tileImg);
        }

        if($x0 == 1 && $y1 == 0){
            $core = indexToCoords($for_test);
            $t45 = GP_LOCATE . "img/mkarte/villages/P4-5.gif";
            $test33 = imagecreatefromgif($t45);
            imagecopy($mapImage, $test33, $core[0], $core[1], 0, 0, 61, 61);
            imagedestroy($test33);
            $t45 = GP_LOCATE . "img/map/border.gif";
            $test33 = imagecreatefromgif($t45);
            imagecopy($mapImage, $test33, $core[0], $core[1], 0, 0, 61, 61);
            imagedestroy($test33);
        }

        $for_test++;
        $for_test2++;
        $i++;
        $x0++;
        if ($x0 > $x1) {
            $y1--;
            $x0 = $x2;
        }
    }

    $thumbSize = 600;
    $thumbImage = imagecreatetruecolor($thumbSize, $thumbSize);
    imagecopyresampled($thumbImage, $mapImage, 0, 0, 0, 0, $thumbSize, $thumbSize, $mapWidth, $mapWidth);

    imagejpeg($thumbImage, null, 100);


// Now save all the content from above into
// a variable
    $PageContent = ob_get_contents();


// Generate unique Hash-ID by using MD5
    $HashID = md5($PageContent);

// Specify the time when the page has
// been changed. For example this date
// can come from the database or any
// file. Here we define a fixed date value:
    $LastChangeTime = time();

// Define the proxy or cache expire time
    $ExpireTime = 3600; // seconds (= one hour)

// Get request headers:

    function parseRequestHeaders() {
        $headers = array();
        foreach($_SERVER as $key => $value) {
            if (substr($key, 0, 5) <> 'HTTP_') {
                continue;
            }
            $header = str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($key, 5)))));
            $headers[$header] = $value;
        }
        return $headers;
    }

    $headers = parseRequestHeaders();
// you could also use getallheaders() or $_SERVER
// or HTTP_SERVER_VARS

// Content language
    header('Content-language: en');

// Set cache/proxy informations:
    header('Cache-Control: max-age=' . $ExpireTime); // must-revalidate
    header('Expires: '.gmdate('D, d M Y H:i:s', time()+$ExpireTime).' GMT');

// Set last modified (this helps search engines
// and other web tools to determine if a page has
// been updated)
    header('Last-Modified: '.gmdate('D, d M Y H:i:s', $LastChangeTime).' GMT');


// Send a "ETag" which represents the content
// (this helps browsers to determine if the page
// has been changed or if it can be loaded from
// the cache - this will speed up the page loading)
    header('ETag: ' . $HashID);

// The browser "asks" us if the requested page has
// been changed and sends the last modified date he
// has in it's internal cache. So now we can check
// if the submitted time equals our internal time value.
// If yes then the page did not get updated

    $PageWasUpdated = !(isset($headers['If-Modified-Since']) and
        strtotime($headers['If-Modified-Since']) == $LastChangeTime);


// The second possibility is that the browser sends us
// the last Hash-ID he has. If he does we can determine
// if he has the latest version by comparing both IDs.

    $DoIDsMatch = (isset($headers['If-None-Match']) and
        preg_match("/$HashID/", $headers['If-None-Match']));


// Does one of the two ways apply?
    if (!$PageWasUpdated or $DoIDsMatch){

// And clear the buffer, so the
// contents will not be submitted to
// the client (we do that later manually)
        ob_end_clean();

        // Okay, the browser already has the
        // latest version of our page in his
        // cache. So just tell him that
        // the page was not modified and DON'T
        // send the content -> this saves bandwith and
        // speeds up the loading for the visitor

        header('HTTP/1.1 304 Not Modified');


        // That's all, now close the connection:
        header('Connection: close');

        // The magical part:
        // No content here ;-)
        // Just the headers

    }
    else {

        header('Content-type: image/jpeg');

        // Okay, the browser does not have the
        // latest version or does not have any
        // version cached. So we have to send him
        // the full page.

       header('HTTP/1.1 200 OK');

        // Tell the browser which size the content
//check for the page content

$pcon = strlen($PageContent);
       //header('Content-Length: ' . $pcon);
    }

    imagedestroy($thumbImage);
    imagedestroy($mapImage);

} else {
    $im = imagecreatetruecolor(1, 1);
    header("Content-Type: image/gif");
    imagegif($im);
    imagedestroy($im);
}
