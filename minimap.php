<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Database.php");

    header('Cache-Control: max-age=3600');

    $image = imagecreate(201, 201);

    // Choose the colors of background, normal village and highlighted alliance
    $color_background = imagecolorallocate($image, 0, 0, 0);
    $color_normal = imagecolorallocate($image, 250, 0, 0);
    $color_marked_silver = imagecolorallocate($image, 122, 122, 122);

    // Fill images background with chosen color
    imagefill($image, 0, 0, $color_background);
    //make backgroung transparent
    imagecolortransparent($image, $color_background);
    // Select ALL villages from the DB and order by ascending ID
    // (Fields are numbered from top left to bottom right)
    $query = 'SELECT `x`, `y` FROM x_world ORDER BY id ASC';
    $result = mysql_query($query) OR die('Can not select villages from table x_world!');
    // Check whether there any villages at all
    if (mysql_num_rows($result)) {
        // Select first village
        $row = mysql_fetch_assoc($result);
        // These variables save the location on which we are currently drawing
        $x_pointer = 0;
        $y_pointer = 0;
        // Outer loop for the Y-coordinates
        for ($y = 100; $y >= -100; $y--) {
            // Inner loop for the X-coordinates
            for ($x = -100; $x <= 100; $x++) {
                // echo $row['y'];
                // Once we reached the coordinates matching the current record selected from the DB:
                if ($row['x'] == $x AND $row['y'] == $y) {
                    $color = $color_normal;
                    // draw the white ellipse
                    imagefilledellipse($image, 100, 100, 45, 45, $color_marked_silver);
                    // Drawing the village with the selected color
                    imagefilledrectangle($image, $x_pointer, $y_pointer, ($x_pointer + 1), ($y_pointer + 1), $color);
                    // Select next record
                    $row = mysql_fetch_assoc($result);
                }

                // Increase pointer for X-coordinate
                $x_pointer++;
            }
            // Increase pointer for Y-coordinate
            $y_pointer++;
            // We reached the end of a line and have to set the X-pointer to 0 again
            $x_pointer = 0;
        }
    }
    // die;
    // Select the HTTP-Header for the selected filetype
    header("Content-Type: image/jpeg");

    // Redimensionnement
    $sourcefile = 'img/minimap.gif';
    $image2 = imagecreatefromgif($sourcefile);
    imagecopyresized($image2, $image, 0, 0, 0, 0, 185, 109, 200, 200);
    // Generate image and print it
    imagejpeg($image2);
    imagedestroy($image2);
?> 