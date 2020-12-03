<div class="error RTL"><?php echo $form->getError("message"); ?></div>
<div id="messageNavigation">
    <div id="backToInbox">
        <a href="nachrichten.php"><?php echo MS_RETURNTOINBOX; ?></a><?php if ($_GET['error'] == 2) echo "<div span=\"error\" style =\"position:absolute;left:240px;top:100px;\"><font color=#ff33ff;?><b></b></font></div>"; ?>
    </div>
    <div class="clear"></div>
</div>
<div id="write_head" class="msg_head"></div>
<div id="write_content" class="msg_content">
<form method="post" action="nachrichten.php" accept-charset="UTF-8" name="msg">
    <input type="hidden" name="c" value="3e9"/>
    <input type="hidden" name="p" value=""/>

    <div class="paper">
        <div class="layout">
            <div class="paperTop">
                <div class="paperContent">
                    <div id="recipient">
                        <div class="header label"><?php echo MS_RECIPIENT; ?>:</div>
                        <div class="header text">
                            <input tabindex="1" class="text" type="text" name="an" id="receiver"
                                   value="<?php if (isset($id)) {
                                       echo $database->getUserField($id, 'username', 0);
                                   } ?>" maxlength="50" onkeyup="copyElement('receiver')">

                            <button title="<?php echo MS_ADDRESSBOOK; ?>" type="button" value="adbook" id="adbook"
                                    class="icon" onclick="Travian.Game.Messages.Write.showAddressBook('adressbook');"
                                    tabindex="5">
                                <img src="img/x.gif" class="adbook" alt="<?php echo MS_ADDRESSBOOK; ?>"></button>
                            <script>
                            </script>
                            <button title="<?php echo AL_ALLIANCE; ?>" type="button" value="ally" id="ally"
                                    class="icon" tabindex="6" onclick="this.form.receiver.value='[ally]';">
                                <img src="img/x.gif" class="ally" alt="<?php echo AL_ALLIANCE; ?>"></button>
                        </div>

                        <div class="clear"></div>
                    </div>
                    <div id="subject">
                        <div class="header label"><?php echo AL_SUBJECT; ?>:</div>
                        <div class="header text"><input tabindex="2" class="text" name="be" id="subject" type="text"
                                                        value="<?php if (isset($message->reply['topic'])) {
                                                            $matn = strtolower($message->reply['topic']);
                                                            $censorarray = explode(",", "<span style='color:,blue,red,green,;'>,<,>");
                                                            foreach ($censorarray as $key => $value) {
                                                                $censorarray[$key] = "/" . $value . "/i";
                                                            }
                                                            $msg = preg_replace("</span>", "", $matn);
                                                            $message->reply['topic'] = preg_replace($censorarray, "", $msg);

                                                            if (preg_match("/RE([0-9]+)/i", $message->reply['topic'], $c)) {
                                                                $c = $c[1] + 1;
                                                                echo $message->reply['topic'] = preg_replace("/RE[0-9]+/i", "RE" . ($c) . " ", $message->reply['topic']);
                                                            } else {
                                                                echo "RE1: " . $message->reply['topic'];
                                                            }
                                                        } ?>" name="be" onkeyup="copyElement('subject')"></div>
                        <div class="clear"></div>
                    </div>
                    <div id="bbEditor">

                        <div id="message_container" class="bbEditor">
                            <div class="boxes boxesColor gray">
                                <div class="boxes-tl"></div>
                                <div class="boxes-tr"></div>
                                <div class="boxes-tc"></div>
                                <div class="boxes-ml"></div>
                                <div class="boxes-mr"></div>
                                <div class="boxes-mc"></div>
                                <div class="boxes-bl"></div>
                                <div class="boxes-br"></div>
                                <div class="boxes-bc"></div>
                                <div class="boxes-contents">
                                    <div id="message_toolbar" class="bbToolbar">
                                        <button type="button" value="bbBold"
                                                class="icon bbButton bbBold bbType{d} bbTag{b}"><img src="img/x.gif"
                                                                                                     class="bbBold"
                                                                                                     alt="bbBold">
                                        </button>
                                        <button type="button" value="bbItalic"
                                                class="icon bbButton bbItalic bbType{d} bbTag{i}"><img src="img/x.gif"
                                                                                                       class="bbItalic"
                                                                                                       alt="bbItalic">
                                        </button>
                                        <button type="button" value="bbUnderscore"
                                                class="icon bbButton bbUnderscore bbType{d} bbTag{u}"><img
                                                src="img/x.gif" class="bbUnderscore" alt="bbUnderscore"></button>
                                        <button type="button" value="bbAlliance"
                                                class="icon bbButton bbAlliance bbType{d} bbTag{Alliance}"><img
                                                src="img/x.gif" class="bbAlliance" alt="bbAlliance"></button>
                                        <button type="button" value="bbPlayer"
                                                class="icon bbButton bbPlayer bbType{d} bbTag{Player}"><img
                                                src="img/x.gif" class="bbPlayer" alt="bbPlayer"></button>
                                        <button type="button" value="bbCoordinate"
                                                class="icon bbButton bbCoordinate bbType{d} bbTag{x|y}"><img
                                                src="img/x.gif" class="bbCoordinate" alt="bbCoordinate"></button>
                                        <button type="button" value="bbReport"
                                                class="icon bbButton bbReport bbType{d} bbTag{Report}"><img
                                                src="img/x.gif" class="bbReport" alt="bbReport"></button>
                                        <button type="button" value="bbResource" id="message_resourceButton"
                                                class="bbWin{resources} bbButton bbResource icon"><img src="img/x.gif"
                                                                                                       class="bbResource"
                                                                                                       alt="bbResource">
                                        </button>
                                        <button type="button" value="bbSmilies" id="message_smilieButton"
                                                class="bbWin{smilies} bbButton bbSmilies icon"><img src="img/x.gif"
                                                                                                    class="bbSmilies"
                                                                                                    alt="bbSmilies">
                                        </button>
                                        <button type="button" value="bbTroops" id="message_troopButton"
                                                class="bbWin{troops} bbButton bbTroops icon"><img src="img/x.gif"
                                                                                                  class="bbTroops"
                                                                                                  alt="bbTroops">
                                        </button>
                                        <button type="button" value="bbPreview" id="message_previewButton"
                                                class="icon bbButton bbPreview"><img src="img/x.gif" class="bbPreview"
                                                                                     alt="bbPreview"></button>
                                        <div class="clear"></div>
                                        <div id="message_toolbarWindows" class="bbToolbarWindow">
                                            <div id="message_resources"><a href="#" class="bbType{o} bbTag{l}"><img
                                                        src="img/x.gif" class="r1" alt="<?php echo WOOD; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{cl}"><img src="img/x.gif" class="r2"
                                                                                              alt="<?php echo CLAY; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{c}"><img src="img/x.gif" class="r4"
                                                                                             alt="<?php echo CROP; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{i}"><img src="img/x.gif" class="r3"
                                                                                             alt="<?php echo IRON; ?>"></a>
                                            </div>
                                            <div id="message_smilies"><a href="#" class="bbType{s} bbTag{*aha*}"><img
                                                        class="smiley aha" src="img/x.gif" alt="*aha*"></a><a href="#"
                                                                                                              class="bbType{s} bbTag{*angry*}"><img
                                                        class="smiley angry" src="img/x.gif" alt="*angry*"></a><a
                                                    href="#" class="bbType{s} bbTag{*cool*}"><img class="smiley cool"
                                                                                                  src="img/x.gif"
                                                                                                  alt="*cool*"></a><a
                                                    href="#" class="bbType{s} bbTag{*cry*}"><img class="smiley cry"
                                                                                                 src="img/x.gif"
                                                                                                 alt="*cry*"></a><a
                                                    href="#" class="bbType{s} bbTag{*cute*}"><img class="smiley cute"
                                                                                                  src="img/x.gif"
                                                                                                  alt="*cute*"></a><a
                                                    href="#" class="bbType{s} bbTag{*depressed*}"><img
                                                        class="smiley depressed" src="img/x.gif"
                                                        alt="*depressed*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{*eek*}"><img
                                                        class="smiley eek" src="img/x.gif" alt="*eek*"></a><a href="#"
                                                                                                              class="bbType{s} bbTag{*ehem*}"><img
                                                        class="smiley ehem" src="img/x.gif" alt="*ehem*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*emotional*}"><img
                                                        class="smiley emotional" src="img/x.gif"
                                                        alt="*emotional*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{:D}"><img
                                                        class="smiley grin" src="img/x.gif" alt=":D"></a><a href="#"
                                                                                                            class="bbType{s} bbTag{:)}"><img
                                                        class="smiley happy" src="img/x.gif" alt=":)"></a><a href="#"
                                                                                                             class="bbType{s} bbTag{*hit*}"><img
                                                        class="smiley hit" src="img/x.gif" alt="*hit*"></a><a href="#"
                                                                                                              class="bbType{s} bbTag{*hmm*}"><img
                                                        class="smiley hmm" src="img/x.gif" alt="*hmm*"></a><a href="#"
                                                                                                              class="bbType{s} bbTag{*hmpf*}"><img
                                                        class="smiley hmpf" src="img/x.gif" alt="*hmpf*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*hrhr*}"><img
                                                        class="smiley hrhr" src="img/x.gif" alt="*hrhr*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*huh*}"><img
                                                        class="smiley huh" src="img/x.gif" alt="*huh*"></a><a href="#"
                                                                                                              class="bbType{s} bbTag{*lazy*}"><img
                                                        class="smiley lazy" src="img/x.gif" alt="*lazy*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*love*}"><img
                                                        class="smiley love" src="img/x.gif" alt="*love*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*nocomment*}"><img
                                                        class="smiley nocomment" src="img/x.gif"
                                                        alt="*nocomment*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{*noemotion*}"><img
                                                        class="smiley noemotion" src="img/x.gif"
                                                        alt="*noemotion*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{*notamused*}"><img
                                                        class="smiley notamused" src="img/x.gif"
                                                        alt="*notamused*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{*pout*}"><img
                                                        class="smiley pout" src="img/x.gif" alt="*pout*"></a><a href="#"
                                                                                                                class="bbType{s} bbTag{*redface*}"><img
                                                        class="smiley redface" src="img/x.gif" alt="*redface*"></a><a
                                                    href="#" class="bbType{s} bbTag{*rolleyes*}"><img
                                                        class="smiley rolleyes" src="img/x.gif" alt="*rolleyes*"></a><a
                                                    href="#" class="bbType{s} bbTag{:(}"><img class="smiley sad"
                                                                                              src="img/x.gif" alt=":("></a><a
                                                    href="#" class="bbType{s} bbTag{*shy*}"><img class="smiley shy"
                                                                                                 src="img/x.gif"
                                                                                                 alt="*shy*"></a><a
                                                    href="#" class="bbType{s} bbTag{*smile*}"><img class="smiley smile"
                                                                                                   src="img/x.gif"
                                                                                                   alt="*smile*"></a><a
                                                    href="#" class="bbType{s} bbTag{*tongue*}"><img
                                                        class="smiley tongue" src="img/x.gif" alt="*tongue*"></a><a
                                                    href="#" class="bbType{s} bbTag{*veryangry*}"><img
                                                        class="smiley veryangry" src="img/x.gif"
                                                        alt="*veryangry*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{*veryhappy*}"><img
                                                        class="smiley veryhappy" src="img/x.gif"
                                                        alt="*veryhappy*"></a><a href="#"
                                                                                 class="bbType{s} bbTag{;)}"><img
                                                        class="smiley wink" src="img/x.gif" alt=";)"></a></div>
                                            <div id="message_troops"><a href="#" class="bbType{o} bbTag{tid1}"><img
                                                        class="unit u1" src="img/x.gif" alt="<?php echo U1; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid2}"><img class="unit u2"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U2; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid3}"><img class="unit u3"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U3; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid4}"><img class="unit u4"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U4; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid5}"><img class="unit u5"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U5; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid6}"><img class="unit u6"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U6; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid7}"><img class="unit u7"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U7; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid8}"><img class="unit u8"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U8; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid9}"><img class="unit u9"
                                                                                                src="img/x.gif"
                                                                                                alt="<?php echo U9; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid10}"><img class="unit u10"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U10; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid11}"><img class="unit u11"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U11; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid12}"><img class="unit u12"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U12; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid13}"><img class="unit u13"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U13; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid14}"><img class="unit u14"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U14; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid15}"><img class="unit u15"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U15; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid16}"><img class="unit u16"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U16; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid17}"><img class="unit u17"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U17; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid18}"><img class="unit u18"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U18; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid19}"><img class="unit u19"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U19; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid20}"><img class="unit u20"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U20; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid21}"><img class="unit u21"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U21; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid22}"><img class="unit u22"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U22; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid23}"><img class="unit u23"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U23; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid24}"><img class="unit u24"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U24; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid25}"><img class="unit u25"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U25; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid26}"><img class="unit u26"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U26; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid27}"><img class="unit u27"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U27; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid28}"><img class="unit u28"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U28; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid29}"><img class="unit u29"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U29; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid30}"><img class="unit u30"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U30; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid31}"><img class="unit u31"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U31; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid32}"><img class="unit u32"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U32; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid33}"><img class="unit u33"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U33; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid34}"><img class="unit u34"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U34; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid35}"><img class="unit u35"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo 35; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid36}"><img class="unit u36"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U36; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid37}"><img class="unit u37"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U37; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid38}"><img class="unit u38"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U38; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid39}"><img class="unit u39"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U39; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid40}"><img class="unit u40"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U40; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid41}"><img class="unit u41"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U41; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid42}"><img class="unit u42"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U42; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid43}"><img class="unit u43"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U43; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid44}"><img class="unit u44"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U44; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid45}"><img class="unit u45"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U45; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid46}"><img class="unit u46"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U46; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid47}"><img class="unit u47"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U47; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid48}"><img class="unit u48"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U48; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid49}"><img class="unit u49"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U49; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{tid50}"><img class="unit u50"
                                                                                                 src="img/x.gif"
                                                                                                 alt="<?php echo U50; ?>"></a><a
                                                    href="#" class="bbType{o} bbTag{Ù‚Ù‡Ø±Ù…Ø§Ù†}"><img
                                                        class="unit uhero" src="img/x.gif" alt="<?php echo U0; ?>"></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="line bbLine"></div>
                            <textarea id="message" name="message" class="messageEditor" tabindex="3" cols="1" rows="1"
                                      onkeyup="copyElement('body')"><?php if (isset($message->reply['message'])) {
                                    echo " \n_________________________\n" . MS_REPLY . ":\n" . htmlspecialchars_decode(stripslashes($message->reply['message']));
                                } ?></textarea>

                            <div id="message_preview" class="messageEditor preview" style="display: none; "></div>
                        </div>

                        <script type="text/javascript">

                            window.addEvent('domready', function () {
                                new Travian.Game.BBEditor("message");

                            });
                        </script>
                        <script type="text/javascript">
                            var myVal = $('message').val();
                            function preview() {
                                window.setTimeout(preview2, 1);
                                function preview2() {
                                    Travian.ajax({data: {cmd: 'Msg_prev', data: {msg: myVal}}});
                                }
                            }
                        </script>
                    </div>
                    <div id="send">
                        <span style="text-align:right !important;margin-right:10px;"><?php echo MS_CAPTCHA;?>: <img
                                src="capt-m.php"/> <input name="ses" type="text"/></span>
                        <input style="display:none;" type="text" name="robots" value=""/>
                        <button type="submit" value="Send" name="s1" id="s1" class="green ">
                            <div class="button-container addHoverClick">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content"><?php echo AT_SEND; ?></div>
                            </div>
                        </button>
                        <input type="hidden" name="loadtime" value="<?php echo time(); ?>"/>
                        <input type="hidden" name="ft" value="m2"/>
                    </div>

                </div>
            </div>
            <div class="clear"></div>
            <div class="line"></div>
            <script>
                var bbEditor = new BBEditor("message");
            </script>
</form>
<div class="hide" id="adressbook">
    <form method="post" name="abform" action="nachrichten.php" accept-charset="UTF-8">
        <input type="hidden" name="a" value="3e9"/>
        <input type="hidden" name="t" value="1"/>
        <input type="hidden" id="copy_receiver" name="copy_receiver" value=""/>
        <input type="hidden" id="copy_subject" name="copy_subject" value=""/>
        <input type="hidden" id="copy_igm" name="copy_igm" value=""/>
        <input type="hidden" name="sbmtype" value="default"/>
        <input type="hidden" name="sbmvalue" value=""/>

        <div class="friendListContainer">
            <table cellpadding="1" cellspacing="1" class="friendlist friendlist1">
                <tbody>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[0]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[2]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[4]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[6]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[8]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[10]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[12]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[14]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[16]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[18]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                </tbody>
            </table>

            <table cellpadding="1" cellspacing="1" class="friendlist friendlist2">
                <tbody>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[1]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[3]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[5]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[7]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[9]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[11]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[13]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[15]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[17]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                <tr>
                    <td class="end"></td>
                    <td class="pla">
                        <input class="text" type="text" name="addfriends[19]" value="" maxlength="15"/>
                    </td>
                    <td class="accept"></td>
                </tr>
                </tbody>
            </table>
    </form>
</div>
</div>
<script type="text/javascript">
    Travian.Translation.add(
        {
            'nachrichten.adressbuch': '<?php echo ADDRESSBOOK;?>',
            'allgemein.save': '<?php echo SI_SAVE;?>'
        });
    <?php if($session->plus){ ?>
    window.addEvent('domready', function () {
        Travian.Game.Messages.Write.initialize();
    });
    <?php } ?>
</script>
<div class="paperBottom"></div>
</div>
</div></div>