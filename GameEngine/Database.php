<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
ini_set("display_errors", 0);
error_reporting(E_ALL);
    require_once(__DIR__ . DIRECTORY_SEPARATOR . 'Protection.php');
    include_once("Database/connection.php");
    include_once("config.php");
    if (!isset($security_system) && $security_system != 1) die("<b>Error:</b> Security Setting Must Be Enabled To Run Script!...");
    include_once("Database/db_MYSQL.php");
?>
