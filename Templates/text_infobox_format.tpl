<?php
    $txt2="%TEKST%";

    //bbcode = html code
    $txt2 = preg_replace("/\[b\]/is", '<b>', $txt2);
    $txt2 = preg_replace("/\[\/b\]/is", '</b>', $txt2);
    $txt2 = preg_replace("/\[i\]/is", '<i>', $txt2);
    $txt2 = preg_replace("/\[\/i\]/is", '</i>', $txt2);
    $txt2 = preg_replace("/\[u\]/is", '<u>', $txt2);
    $txt2 = preg_replace("/\[\/u\]/is", '</u>', $txt2);
?>