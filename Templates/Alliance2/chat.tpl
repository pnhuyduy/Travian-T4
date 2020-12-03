<?php

    if (!isset($aid)) {
        $aid = $session->alliance;
    }
    $allianceinfo = $database->getAlliance($aid);
    echo "<h1 class=\"titleInHeader\">" . AL_ALLIANCE . " - " . $allianceinfo['tag'] . "</h1>";
    include("alli_menu.tpl");;

    if ($_POST) {
        $msg = $_POST['msg'];
        $msg = filter_var($msg, FILTER_SANITIZE_MAGIC_QUOTES);
        $msg = filter_var($msg, FILTER_SANITIZE_SPECIAL_CHARS);
        $name = $session->username;
        $msg = htmlspecialchars($msg);
        $id_user = $session->uid;
        $alliance = $session->alliance;
        $now = $_SERVER['REQUEST_TIME'];
        $q = "INSERT into " . TB_PREFIX . "chat (id,id_user,name,alli,date,msg) values ('','$id_user','$name','$alliance','$now','$msg')";
        mysql_query($q, $database->connection) or die(mysql_error());
    }
?>
<script type="text/javascript">
    function submitform2() {
        document.forms["Form1"].submit();
        alert('Please wait...');
    }
</script>
<script>
    <?php sajax_show_javascript();?>
    function show_data_cb(text) {
        document.getElementById("chat").innerHTML = text;
    }
    function start_it() {
        x_get_data(show_data_cb);
        setTimeout("start_it()", 2000);
    }
    function add_cb() {
    }
    function send_data() {
        msg = document.form1.msg.value;
        x_add_data(name + "|" + msg);
    }
</script>
<body onload="start_it()">
<form name="form1" onSubmit="send_data()" action="allianz.php?s=6" method="POST" id="Form1">
    <div id="TitleName" class="chatHeader">
        <div style="float:left;"></div>
        <div style="float:right;" id="TitleClose"></div>
        <div style="text-align:center"><?php echo AL_CHAT2; ?></div>
    </div>
    <div id="chatContainer"
         style="position: relative; top: 0px; left: 0px; height: 260px; overflow-x: hidden; overflow-y: hidden; background-color: rgb(255, 255, 255); border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-top-color: rgb(192, 192, 192); border-right-color: rgb(192, 192, 192); border-bottom-color: rgb(192, 192, 192); border-left-color: rgb(192, 192, 192); display: block; ">
		<span dir="ltr"><div id="chat"
                             style="position:absolute; top:10; right:5px; width:530px; background-color: #FFF;text-align:left; ">
                <center><img src="img/loading2.gif" style="position: absolute;top: 100px;left:245px;">
            </div>
		<div id="scrollbarbackground2"
             style="position: absolute; top: 0; left: 531px; width: 17px; height: 238px;"></div>
		<div id="scrollbarbackground"
             style="position: absolute; top: 0; left: 539px; width: 1px; height: 238px; border-width: 1px; border-style: solid; border-color: #71D000; background-color: #FFF;"></div>
			<div id="scrollbar"
                 style="position: absolute; left: 531px; width: 17px; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-top-color: rgb(113, 208, 0); border-right-color: rgb(113, 208, 0); border-bottom-color: rgb(113, 208, 0); border-left-color: rgb(113, 208, 0); background-color: rgb(240, 255, 240); height: 238px; top: 0px; "></div>
			<input id="scrollCheckbox" class="fm" checked="checked" disabled type="checkbox"
                   style="position: absolute; top: 240px; left: 531px;">
    </div>
    <div style="margin-top:10px; margin-bottom:10px;">
        <table cellpadding="1" cellspacing="1" id="chat_input">
            <tr>
                <td>
                    <input name="s" value="6" type="hidden"/>
                    <input class="text" type="text" name="msg" id="message" style="display: block; "/>
                    <input type="button" src="x.gif" id="btn_ok" style="border: 0px; float:left; height:0px; width:0px;"
                           alt="ok" onClick="send_data()"/></td>

                </td>
                <td>
                    <input type="hidden" id="room" name="room" value="429280664">
                    <input type="hidden" id="joincmd" name="joincmd" value="ss">
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
<div id="rooms"><span id="room429280664" name="-2" class="roomselectorActive"><span style="float:left;"><a href=""
                                                                                                           onclick="submitform2()"><span
                    id="channelName429280664"><?php echo AL_CHAT2; ?></span></a></span><span id="userCount429280664"
                                                                                             style="float:left;"></span></span>
</div>
