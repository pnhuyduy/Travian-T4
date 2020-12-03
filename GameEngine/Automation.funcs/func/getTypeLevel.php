<?php
    function getTypeLevel($tid, $vid)
    {
        global $database;
        $keyholder = array();
        $resourcearray = $database->getResourceLevel($vid);
        if (!$resourcearray || empty($resourcearray)) return 0;
        foreach (array_keys($resourcearray, $tid) as $key) {
            if (strpos($key, 't')) {
                $key = preg_replace("/[^0-9]/", '', $key);
                array_push($keyholder, $key);
            }
        }
        $element = count($keyholder);
        if ($element >= 2) {
            if ($tid <= 4) {
                $temparray = array();
                for ($i = 0; $i <= $element - 1; $i++) {
                    array_push($temparray, $resourcearray['f' . $keyholder[$i]]);
                }
                foreach ($temparray as $key => $val) {
                    if ($val == max($temparray)) $target = $key;
                }
            } else {
                $target = 0;
                for ($i = 1; $i <= $element - 1; $i++) {
                    if ($resourcearray['f' . $keyholder[$i]] > $resourcearray['f' . $keyholder[$target]]) {
                        $target = $i;
                    }
                }
            }
        } elseif ($element == 1) {
            $target = 0;
        } else {
            return 0;
        }
        if ($keyholder[$target] != "") {
            return $resourcearray['f' . $keyholder[$target]];
        } else {
            return 0;
        }
    }

?>
