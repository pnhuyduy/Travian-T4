<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    function celebrationComplete()
    {
        global $database;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        $varray = $database->getCel();
        foreach ($varray as $vil) {
            $id = $vil['wref'];
            $type = $vil['type'];
            $user = $vil['owner'];
            if ($type == 1) {
                $cp = 500;
            } else if ($type == 2) {
                $cp = 2000;
            }
            $database->clearCel($id);
            $database->setCelCp($user, $cp);
        }
    }

?>
