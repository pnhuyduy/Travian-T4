<?php
    function getPop($tid, $level)
    {
        $name = "bid" . $tid;
        global $$name;
        $dataarray = $$name;
        $pop = $dataarray[($level + 1)]['pop'];
        $cp = $dataarray[($level + 1)]['cp'];
        return array($pop, $cp);
    }
?>
