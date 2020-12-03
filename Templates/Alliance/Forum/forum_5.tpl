<!-- //////////////// made by TTMTT //////////////// -->
<?php
    if ($session->access != BANNED) {
        $y = date('Y');
        $m = date('F');
        $d = date('d');
        ?>
        <form method="post" name="post"
              action="allianz.php?s=2&fid=<?php echo $_GET['fid']; ?>&pid=<?php echo $_GET['pid']; ?>">
            <input type="hidden" name="newtopic" value="1">
            <input type="hidden" name="pid" value="<?php echo $_GET['pid']; ?>">
            <input type="hidden" name="fid" value="<?php echo $_GET['fid']; ?>">
            <input type="hidden" name="ac" value="newtopic">
            <input type="hidden" name="checkstr" value="<?php echo time(); ?>">
            <h4 class="round"><?php echo AL_POSTNEWTH;?></h4>
            <table class="transparent" id="new_topic">
                <tbody>
                <tr>
                    <th><?php echo AL_THREAD;?>:</th>
                    <td colspan="2"><input class="text" type="text" name="thema" maxlength="35"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div id="text_container" class="bbEditor">
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
                                    <div id="text_toolbar" class="bbToolbar">
                                        <button type="button" value="bbBold"
                                                class="icon bbButton bbBold bbType{d} bbTag{b}" title="Bold"><img
                                                src="img/x.gif" class="bbBold" alt="bbBold" title="Bold"></button>
                                        <button type="button" value="bbItalic"
                                                class="icon bbButton bbItalic bbType{d} bbTag{i}" title="Italic"><img
                                                src="img/x.gif" class="bbItalic" alt="bbItalic" title="Italic"></button>
                                        <button type="button" value="bbUnderscore"
                                                class="icon bbButton bbUnderscore bbType{d} bbTag{u}" title="Underline">
                                            <img src="img/x.gif" class="bbUnderscore" alt="bbUnderscore"
                                                 title="Underline"></button>
                                        <button type="button" value="bbAlliance"
                                                class="icon bbButton bbAlliance bbType{d} bbTag{alliance0}"
                                                title="Alliance"><img src="img/x.gif" class="bbAlliance"
                                                                      alt="bbAlliance" title="Alliance"></button>
                                        <button type="button" value="bbPlayer"
                                                class="icon bbButton bbPlayer bbType{d} bbTag{player0}"
                                                title="Player</li>"><img src="img/x.gif" class="bbPlayer" alt="bbPlayer"
                                                                         title="Player</li>"></button>
                                        <button type="button" value="bbCoordinate"
                                                class="icon bbButton bbCoordinate bbType{d} bbTag{coor0}"
                                                title="Coordinates"><img src="img/x.gif" class="bbCoordinate"
                                                                         alt="bbCoordinate" title="Coordinates">
                                        </button>
                                        <button type="button" value="bbReport"
                                                class="icon bbButton bbReport bbType{d} bbTag{report0}"><img
                                                src="img/x.gif" class="bbReport" alt="bbReport" title="Report"></button>
                                        <button type="button" value="bbResource" id="text_resourceButton"
                                                class="bbWin{resources} bbButton bbResource icon" title="Resources"><img
                                                src="img/x.gif" class="bbResource" alt="bbResource"></button>
                                        <button type="button" value="bbSmilies" id="text_smilieButton"
                                                class="bbWin{smilies} bbButton bbSmilies icon" title="Smilies"><img
                                                src="img/x.gif" class="bbSmilies" alt="bbSmilies"></button>
                                        <button type="button" value="bbTroops" id="text_troopButton"
                                                class="bbWin{troops} bbButton bbTroops icon" title="Troops"><img
                                                src="img/x.gif" class="bbTroops" alt="bbTroops"></button>
                                        <button type="button" value="bbPreview" id="text_previewButton"
                                                class="icon bbButton bbPreview" title="Preview"><img src="img/x.gif"
                                                                                                     class="bbPreview"
                                                                                                     alt="bbPreview">
                                        </button>
                                        <div class="clear"></div>
                                        <div id="text_toolbarWindows" class="bbToolbarWindow">
                                            <div id="text_resources"><a href="#" class="bbType{o} bbTag{lumber}"><img
                                                        src="img/x.gif" class="r1" alt="Wood" title="Wood"></a><a
                                                    href="#" class="bbType{o} bbTag{clay}"><img src="img/x.gif"
                                                                                                class="r2" alt="clay"
                                                                                                title="clay"></a><a
                                                    href="#" class="bbType{o} bbTag{Crop}"><img src="img/x.gif"
                                                                                                class="r4" alt="Crop"
                                                                                                title="Crop"></a><a
                                                    href="#" class="bbType{o} bbTag{Iron}"><img src="img/x.gif"
                                                                                                class="r3" alt="Iron"
                                                                                                title="Iron"></a></div>
                                            <div id="text_smilies"><a href="#" class="bbType{s} bbTag{*aha*}"><img
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
                                            <div id="text_troops"><a href="#" class="bbType{o} bbTag{tid1}"><img
                                                        class="unit u1" src="img/x.gif" alt="Legionnaire"></a><a
                                                    href="#" class="bbType{o} bbTag{tid2}"><img class="unit u2"
                                                                                                src="img/x.gif"
                                                                                                alt="Praetorian"
                                                                                                title="Praetorian"></a><a
                                                    href="#" class="bbType{o} bbTag{tid3}"><img class="unit u3"
                                                                                                src="img/x.gif"
                                                                                                alt="Imperian"
                                                                                                title="Imperian"></a><a
                                                    href="#" class="bbType{o} bbTag{tid4}"><img class="unit u4"
                                                                                                src="img/x.gif"
                                                                                                alt="Equites Legati"
                                                                                                title="Equites Legati"></a><a
                                                    href="#" class="bbType{o} bbTag{tid5}"><img class="unit u5"
                                                                                                src="img/x.gif"
                                                                                                alt="Equites Imperatoris"
                                                                                                title="Equites Imperatoris"></a><a
                                                    href="#" class="bbType{o} bbTag{tid6}"><img class="unit u6"
                                                                                                src="img/x.gif"
                                                                                                alt="Equites Caesaris"
                                                                                                title="Equites Caesaris"></a><a
                                                    href="#" class="bbType{o} bbTag{tid7}"><img class="unit u7"
                                                                                                src="img/x.gif"
                                                                                                alt="Ram"
                                                                                                title="Ram"></a><a
                                                    href="#" class="bbType{o} bbTag{tid8}"><img class="unit u8"
                                                                                                src="img/x.gif"
                                                                                                alt="Fire Catapult"
                                                                                                title="Fire Catapult"></a><a
                                                    href="#" class="bbType{o} bbTag{tid9}"><img class="unit u9"
                                                                                                src="img/x.gif"
                                                                                                alt="Senator"
                                                                                                title="Senator"></a><a
                                                    href="#" class="bbType{o} bbTag{tid10}"><img class="unit u10"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Settler"
                                                                                                 title="Settler"></a><a
                                                    href="#" class="bbType{o} bbTag{tid11}"><img class="unit u11"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Maceman"
                                                                                                 title="Maceman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid12}"><img class="unit u12"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Spearman"
                                                                                                 title="Spearman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid13}"><img class="unit u13"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Axeman"
                                                                                                 title="Axeman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid14}"><img class="unit u14"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Scout"
                                                                                                 title="Scout"></a><a
                                                    href="#" class="bbType{o} bbTag{tid15}"><img class="unit u15"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Paladin"
                                                                                                 title="Paladin"></a><a
                                                    href="#" class="bbType{o} bbTag{tid16}"><img class="unit u16"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Teutonic Knight"
                                                                                                 title="Teutonic Knight"></a><a
                                                    href="#" class="bbType{o} bbTag{tid17}"><img class="unit u17"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Ram" title="Ram"></a><a
                                                    href="#" class="bbType{o} bbTag{tid18}"><img class="unit u18"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Catapult"
                                                                                                 title="Catapult"></a><a
                                                    href="#" class="bbType{o} bbTag{tid19}"><img class="unit u19"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Chieftain"
                                                                                                 title="Chieftain"></a><a
                                                    href="#" class="bbType{o} bbTag{tid20}"><img class="unit u20"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Settler"
                                                                                                 title="Settler"></a><a
                                                    href="#" class="bbType{o} bbTag{tid21}"><img class="unit u21"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Phalanx"
                                                                                                 title="Phalanx"></a><a
                                                    href="#" class="bbType{o} bbTag{tid22}"><img class="unit u22"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Swordsman"
                                                                                                 title="Swordsman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid23}"><img class="unit u23"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Pathfinder"
                                                                                                 title="Pathfinder"></a><a
                                                    href="#" class="bbType{o} bbTag{tid24}"><img class="unit u24"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Theutates Thunder"
                                                                                                 title="Theutates Thunder"></a><a
                                                    href="#" class="bbType{o} bbTag{tid25}"><img class="unit u25"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Druidrider"
                                                                                                 title="Druidrider"></a><a
                                                    href="#" class="bbType{o} bbTag{tid26}"><img class="unit u26"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Haeduan"
                                                                                                 title="Haeduan"></a><a
                                                    href="#" class="bbType{o} bbTag{tid27}"><img class="unit u27"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Battering Ram"
                                                                                                 title="Battering Ram"></a><a
                                                    href="#" class="bbType{o} bbTag{tid28}"><img class="unit u28"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Trebuchet"
                                                                                                 title="Trebuchet"></a><a
                                                    href="#" class="bbType{o} bbTag{tid29}"><img class="unit u29"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Chief"
                                                                                                 title="Chief"></a><a
                                                    href="#" class="bbType{o} bbTag{tid30}"><img class="unit u30"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Settler"
                                                                                                 title="Settler"></a>
                                                <a href="#" class="bbType{o} bbTag{tid31}"><img class="unit u31"
                                                                                                src="img/x.gif"
                                                                                                alt="Rat"
                                                                                                title="Rat"></a><a
                                                    href="#" class="bbType{o} bbTag{tid32}"><img class="unit u32"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Spider"
                                                                                                 title="Spider"></a>
                                                <a href="#" class="bbType{o} bbTag{tid33}"><img class="unit u33"
                                                                                                src="img/x.gif"
                                                                                                alt="Snake"
                                                                                                title="Snake"></a><a
                                                    href="#" class="bbType{o} bbTag{tid34}"><img class="unit u34"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Bat" title="Bat"></a><a
                                                    href="#" class="bbType{o} bbTag{tid35}"><img class="unit u35"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Wild Boar"
                                                                                                 title="Wild Boar"></a><a
                                                    href="#" class="bbType{o} bbTag{tid36}"><img class="unit u36"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Wolf"
                                                                                                 title="Wolf"></a><a
                                                    href="#" class="bbType{o} bbTag{tid37}"><img class="unit u37"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Bear"
                                                                                                 title="Bear"></a><a
                                                    href="#" class="bbType{o} bbTag{tid38}"><img class="unit u38"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Crocodile"
                                                                                                 title="Crocodile"></a><a
                                                    href="#" class="bbType{o} bbTag{tid39}"><img class="unit u39"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Tiger"
                                                                                                 title="Tiger"></a><a
                                                    href="#" class="bbType{o} bbTag{tid40}"><img class="unit u40"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Elephant"
                                                                                                 title="Elephant"></a><a
                                                    href="#" class="bbType{o} bbTag{tid41}"><img class="unit u41"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Pikeman"
                                                                                                 title="Pikeman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid42}"><img class="unit u42"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Thorned Warrior"
                                                                                                 title="Thorned Warrior"></a>
                                                <a href="#" class="bbType{o} bbTag{tid43}"><img class="unit u43"
                                                                                                src="img/x.gif"
                                                                                                alt="Guardsman"
                                                                                                title="Guardsman"></a><a
                                                    href="#" class="bbType{o} bbTag{tid44}"><img class="unit u44"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Birds of Prey"
                                                                                                 title="Birds of Prey"></a><a
                                                    href="#" class="bbType{o} bbTag{tid45}"><img class="unit u45"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Axerider"
                                                                                                 title="Axerider"></a><a
                                                    href="#" class="bbType{o} bbTag{tid46}"><img class="unit u46"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Natarian Knight"
                                                                                                 title="Natarian Knight"></a><a
                                                    href="#" class="bbType{o} bbTag{tid47}"><img class="unit u47"
                                                                                                 src="img/x.gif"
                                                                                                 alt="War Elephant"
                                                                                                 title="War Elephant"></a>
                                                <a href="#" class="bbType{o} bbTag{tid48}"><img class="unit u48"
                                                                                                src="img/x.gif"
                                                                                                alt="Ballista"
                                                                                                title="Ballista"></a><a
                                                    href="#" class="bbType{o} bbTag{tid49}"><img class="unit u49"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Natarian Emperor"
                                                                                                 title="Natarian Emperor"></a><a
                                                    href="#" class="bbType{o} bbTag{tid50}"><img class="unit u50"
                                                                                                 src="img/x.gif"
                                                                                                 alt="Settler"
                                                                                                 title="Settler"></a><a
                                                    href="#" class="bbType{o} bbTag{Hero}"><img class="unit uhero"
                                                                                                src="img/x.gif"
                                                                                                alt="Hero" title="Hero"></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <textarea id="text" name="text"></textarea>

                            <div id="text_preview" name="text_preview"></div>
                        </div>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                new Travian.Game.BBEditor("text");
                            });
                        </script>
                    </td>
                <tr>

                    <th><?php echo AL_SURVEY;?>:</th>
                    <td>
                        <script language="JavaScript" type="text/javascript">
                            <!--
                            function vote() {
                                if (document.post.umfrage.checked == true) {
                                    document.post.umfrage_thema.disabled = false;
                                    document.getElementById('options').className = '';
                                    document.post.umfrage_thema.focus();

                                } else {
                                    document.post.umfrage_thema.disabled = true;
                                    document.getElementById('options').className = 'hide';
                                }
                            }
                            //-->
                        </script>
                        <input class="text" type="text" name="umfrage_thema" maxlength="60" disabled="disabled"/></td>
                    <td class="sel"><input class="check" type="checkbox" name="umfrage" value="1" onclick="vote();"/>
                    </td>
                </tr>
                <tr id="options" class="hide">

                    <th><?php echo AL_OPTIONS;?></th>
                    <td>
                        <input class="text" type="text" name="option_1" maxlength="60"/><input class="text" type="text"
                                                                                               name="option_2"
                                                                                               maxlength="60"/><input
                            class="text" type="text" name="option_3" maxlength="60"/><input class="text" type="text"
                                                                                            name="option_4"
                                                                                            maxlength="60"/>
                </tr>
                <tr>
                    <th><?php echo AL_ENDSON;?></th>
                    <td>
                        <script language="JavaScript" type="text/javascript">
                            <!--
                            function voteEnd() {
                                if (document.post.umfrage_ende.checked == true) {
                                    document.post.month.disabled = false;
                                    document.post.day.disabled = false;
                                    document.post.year.disabled = false;
                                    document.post.hour.disabled = false;
                                    document.post.minute.disabled = false;
                                    document.post.meridiem[0].disabled = false;
                                    document.post.meridiem[1].disabled = false;
                                } else {
                                    document.post.month.disabled = true;
                                    document.post.day.disabled = true;
                                    document.post.year.disabled = true;
                                    document.post.hour.disabled = true;
                                    document.post.minute.disabled = true;
                                    document.post.meridiem[0].disabled = true;
                                    document.post.meridiem[1].disabled = true;
                                }
                            }
                            //-->

                        </script>
                        <select class="dropdown" name="month" disabled="disabled">
                            <option value="1" <?php if ($m == 'January') {
                                echo 'selected="selected"';
                            } ?> >Jan
                            </option>
                            <option value="2" <?php if ($m == 'February') {
                                echo 'selected="selected"';
                            } ?> >Feb
                            </option>
                            <option value="3" <?php if ($m == 'March') {
                                echo 'selected="selected"';
                            } ?> >Mar
                            </option>
                            <option value="4" <?php if ($m == 'April') {
                                echo 'selected="selected"';
                            } ?> >Apr
                            </option>
                            <option value="5" <?php if ($m == 'May') {
                                echo 'selected="selected"';
                            } ?> >May
                            </option>
                            <option value="6" <?php if ($m == 'June') {
                                echo 'selected="selected"';
                            } ?> >Jun
                            </option>
                            <option value="7" <?php if ($m == 'July') {
                                echo 'selected="selected"';
                            } ?> >Jul
                            </option>
                            <option value="8" <?php if ($m == 'August') {
                                echo 'selected="selected"';
                            } ?> >Aug
                            </option>
                            <option value="9" <?php if ($m == 'September') {
                                echo 'selected="selected"';
                            } ?> >Sep
                            </option>
                            <option value="10" <?php if ($m == 'October') {
                                echo 'selected="selected"';
                            } ?> >Oct
                            </option>
                            <option value="11" <?php if ($m == 'November') {
                                echo 'selected="selected"';
                            } ?> >Nov
                            </option>
                            <option value="12" <?php if ($m == 'December') {
                                echo 'selected="selected"';
                            } ?> >Dec
                            </option>

                        </select><select class="dropdown" name="day" disabled="disabled">
                            <option value="1">01</option>
                            <option value="2">02</option>
                            <option value="3">03</option>
                            <option value="4">04</option>
                            <option value="5">05</option>
                            <option value="6">06</option>
                            <option value="7">07</option>
                            <option value="8">08</option>
                            <option value="9">09</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19" selected="selected">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select><select class="dropdown" name="year" disabled="disabled">
                            <option value="15" selected="selected">2015</option>
                            <option value="16">2016</option>
                        </select>&nbsp;&nbsp;&nbsp;
                        <select class="dropdown" name="hour" disabled="disabled">
                            <option value="0">00</option>
                            <option value="1">01</option>
                            <option value="2">02</option>
                            <option value="3">03</option>
                            <option value="4">04</option>
                            <option value="5">05</option>
                            <option value="6">06</option>
                            <option value="7">07</option>
                            <option value="8">08</option>
                            <option value="9">09</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                        </select><select class="dropdown" name="minute" disabled="disabled">
                            <option value="0">00</option>
                            <option value="1">01</option>
                            <option value="2">02</option>
                            <option value="3">03</option>
                            <option value="4" selected="selected">04</option>
                            <option value="5">05</option>
                            <option value="6">06</option>
                            <option value="7">07</option>
                            <option value="8">08</option>
                            <option value="9">09</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                            <option value="32">32</option>
                            <option value="33">33</option>
                            <option value="34">34</option>
                            <option value="35">35</option>
                            <option value="36">36</option>
                            <option value="37">37</option>
                            <option value="38">38</option>
                            <option value="39">39</option>
                            <option value="40">40</option>
                            <option value="41">41</option>
                            <option value="42">42</option>
                            <option value="43">43</option>
                            <option value="44">44</option>
                            <option value="45">45</option>
                            <option value="46">46</option>
                            <option value="47">47</option>
                            <option value="48">48</option>
                            <option value="49">49</option>
                            <option value="50">50</option>
                            <option value="51">51</option>
                            <option value="52">52</option>
                            <option value="53">53</option>
                            <option value="54">54</option>
                            <option value="55">55</option>
                            <option value="56">56</option>
                            <option value="57">57</option>
                            <option value="58">58</option>
                            <option value="59">59</option>
                        </select>

                        <!-- <input class="radio" type="radio" name="meridiem" value="0" disabled="disabled" /> am
                         <input class="radio" type="radio" name="meridiem" value="1" disabled="disabled" checked="checked" /> pm -->
                    </td>
                    <td class="sel"><input class="check" type="checkbox" name="umfrage_ende" onclick="voteEnd();"/>
                    </td>
                </tr>
                </tr></tbody>
            </table>
            <div class="spacer"></div>
            <button type="submit" value="ok" name="s1" id="btn_ok" class="green ">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content"><?php echo OK;?></div>
                </div>
            </button>
            <script type="text/javascript">
                window.addEvent('domready', function () {
                    if ($('btn_ok')) {
                        $('btn_ok').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                        });
                    }
                });
            </script>
        </form></p>
    <?php
    } else {
        header("Location: banned.php");
        die;
    }
?>