<form method="post" action="nachrichten.php">
    <div class="paper notices">
        <div class="layout">
            <div class="paperTop">
                <div class="paperContent">
                    <input type="hidden" name="ft" value="m6"/>
                    <input type="hidden" name="t" value="4"/>

                    <div id="bbEditor">
                        <textarea name="notizen" id="notice" class="messageEditor" rows=""
                                  cols=""><?php echo $message->note; ?></textarea>
                    </div>
                    <div class="btn" id="send">
                        <button type="submit" value="" name="s1" id="btn_save" class="green ">
                            <div class="button-container addHoverClick">
                                <div class="button-background">
                                    <div class="buttonStart">
                                        <div class="buttonEnd">
                                            <div class="buttonMiddle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-content"><?php echo SI_SAVE; ?></div>
                            </div>
                        </button>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                if ($('s1')) {
                                    $('s1').addEvent('click', function () {
                                        window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "<?php echo SI_SAVE;?>", "name": "s1", "id": "s1", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                                    });
                                }
                            });
                        </script>
                    </div>
                    <div class="notepad info">&nbsp;</div>
                </div>
            </div>
            <div class="paperBottom"></div>
        </div>
    </div>
</form>