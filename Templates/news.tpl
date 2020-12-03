<?php
    if (NEWSBOX1) {
        include "Templates/News/" . $_SESSION['lang'] . "/newsbox1.tpl";
    }
    if (NEWSBOX2) {
        include "Templates/News/" . $_SESSION['lang'] . "/newsbox2.tpl";
    }
    if (NEWSBOX3) {
        include "Templates/News/" . $_SESSION['lang'] . "/newsbox3.tpl";
    }
?>