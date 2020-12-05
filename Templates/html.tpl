<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <noscript>
        <meta http-equiv="refresh" content="0;url=noscript.html">
    </noscript>
    <?php $_SESSION['lang'] = 'en'; ?>
    <title><?php echo SERVER_NAME ?></title>
    <meta HTTP-EQUIV="Cache-Control" CONTENT="max-age=0">
    <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Expires" CONTENT="0">
    <meta http-equiv='imagetoolbar' content='no'/>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
    <meta name='content-language' content='en'/>
    <link href='<?= GP_LOCATE;?>lang/en/compact.css' rel='stylesheet'
          type='text/css'/>
    <link href='<?= GP_LOCATE;?>lang/en/hero.css' rel='stylesheet'
          type='text/css'/>
    <link href='<?= GP_LOCATE;?>lang/en/chat.css' rel='stylesheet'
          type='text/css'/>
        <link href='<?= GP_LOCATE;?>lang/en/lang.css' rel='stylesheet'
           type='text/css'/>
    <!--<link href='http://<?php echo $_SERVER['HTTP_HOST']; ?>/img/travian_basics.css' rel='stylesheet' type='text/css' />-->
    <script type="text/javascript" src="crypt.js?0500"></script>
    <!--<script type="text/javascript" src="<?php echo GP_LOCATE; ?>/chat.js?v=1.15"></script>-->
    <?php //if ($session->logged_in) { //Load Chat ?>
        <div id="main_container">
        </div>
    <?php //} ?>
    <!--<script type="text/javascript">
        window.addEvent('domready', function () {
            Travian.Game.Chat.chatHeartbeatTime= 8000;
            Travian.Game.Chat.requestHeartbeatTime= 10000;
            Travian.Game.Chat.allychatHeartbeatTime= 5000;
            Travian.Game.Chat.flHeartbeatTime= 10000;
            Travian.Game.Chat.originalTitle = document.title;
            Travian.Game.Chat.savedconfigs = <?php echo $_SESSION['chat_config'];?>;
            Travian.Game.Chat.username = "<?php echo $session->username;?>";
            Travian.Game.Chat.alliance = "<?php echo $session->alliance;?>";
            Travian.Game.Chat.render("<?php echo GP_LOCATE;?>");
        });
    </script>
-->

    <script type="text/javascript">
        Travian.Translation.add(
            {
                'tpw.prepare': 'prepare',
                'tpw.whosonline': "Online friends in chat",
                'tpw.friends': 'Friends',
                'tpw.allychat': 'Ally chat',
                'tpw.requests': 'Requests',
                'tpw.onlinestatus': 'Online status',
                'tpw.notifications': 'Notifications',
                'tpw.youroffline': "You're offline from chat.",
                'tpw.offline': 'Offline',
                'tpw.invisible': 'Invisible',
                'tpw.invistononally': 'Invisible to non-ally friends',
                'tpw.invistoally': 'Invisible to my alliance members',
                'tpw.visible': 'Visible',
                'tpw.soundnotify': 'Sound notification',
                'tpw.popupnotify': 'Popup notification',
                'tpw.showprevchat': 'Show previous message',
                'tpw.wait': 'wait',
                'tpw.save': 'Save',
                'allgemein.anleitung': 'Instructions',
                'allgemein.cancel': 'cancel',
                'allgemein.ok': 'OK',
                'allgemein.close': 'close',
                'cropfinder.keine_ergebnisse': 'No search results found.'
            });
        Travian.applicationId = 'T4.4 Game';
        Travian.Game.version = '4.4';
        Travian.Game.worldId = '<?php echo SERVER_NAME;?>';
        Travian.Game.speed = <?php echo SPEED;?>;

        Travian.Templates = {};
        Travian.Templates.ButtonTemplate = "<button >\n\t<div class=\"button-container addHoverClick\">\n\t\t<div class=\"button-background\">\n\t\t\t<div class=\"buttonStart\">\n\t\t\t\t<div class=\"buttonEnd\">\n\t\t\t\t\t<div class=\"buttonMiddle\"><\/div>\n\t\t\t\t<\/div>\n\t\t\t<\/div>\n\t\t<\/div>\n\t\t<div class=\"button-content\"><\/div>\n\t<\/div>\n<\/button>\n";

        Travian.Game.eventJamHtml = '&lt;a href=&quot;#&quot; onclick=&quot;document.location.reload();&quot; title=&quot<?php echo HTM_REFRESH;?>&quot;&gt;&lt;img src=&quot;img/refresh.gif&quot;&gt;'.unescapeHtml();

        window.addEvent('domready', function () {
            Travian.Form.UnloadHelper.message = '<?php echo HTM_MADECHANGEALERT;?>';
        });
    </script>
    <style>
        body, input, a, button, div, span, ul, li {
            font-family: Tahoma;
            font-size: 11px;
        }
    </style>
    <meta name="alexaVerifyID" content="NWImDRfB7QhLL_T9p5Gd2uvYUYs"/>
</head>