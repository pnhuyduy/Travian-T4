<?php
    $txt = 'ARTEFACTSRELEASED';
    $ctxt = constant($txt);
    if ($ctxt != null) $txt = $ctxt;
    //bbcode = html code
    $txt = preg_replace("/\[b\]/is", '<b>', $txt);
    $txt = preg_replace("/\[\/b\]/is", '</b>', $txt);
    $txt = preg_replace("/\[i\]/is", '<i>', $txt);
    $txt = preg_replace("/\[\/i\]/is", '</i>', $txt);
    $txt = preg_replace("/\[u\]/is", '<u>', $txt);
    $txt = preg_replace("/\[\/u\]/is", '</u>', $txt);

    echo nl2br($txt);
?>
