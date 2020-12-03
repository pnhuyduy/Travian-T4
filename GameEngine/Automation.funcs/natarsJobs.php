<?php
include_once(dirname(__FILE__) . "/../Natars.php");

function natarsJobs()
{
    global $natars, $database;
    if (!$database->checkConnection()) {
        throw new Exception(__FILE__ . ' cant connect to database.');
        return;
    }
    $natars->doJobs();
}

?>
