<h1 class="titleInHeader"><?php echo B17; ?> <span
        class="level"> <?php echo BL_LVL . ' ' . $village->resarray['f' . $id]; ?></span></h1>
<div id="build" class="gid17">
<?php 
include("17_menu.tpl");

    if (isset($_GET['c'])) {
        ?>

        <p><b><?php echo MK_RAWMATERIALSDISTRIBUTED ?>.</b> <?php echo BL_COSTS; ?>: <b>3 </b><img src="img/x.gif" class="gold"
                                                                                            alt="<?php echo HDR_GOLD; ?>"
                                                                                            title="<?php echo HDR_GOLD; ?>"/>
        </p>
        <a href="javascript: history.go(-2)"><?php echo BL_BACKTOTHEBUILDING; ?></a>

    <?php } else { ?>
        <div class="contentNavi"></div>
        <div class="round spacer listTitle">
            <div class="listTitleText">
                NPC Merchants
            </div>
            <div class="clear"></div>
        </div>
        <p><?php echo MK_MARKETRESREDISTDESC; ?></p>


        <script language="JavaScript">
            var overall;
            function calculateRes() {
                resObj = document.getElementsByName("m2");
                overall = 0;
                for (i = 0; i < resObj.length; i++) {
                    var tmp = "";
                    for (j = 0; j < resObj[i].value.length; j++)
                        if ((resObj[i].value.charAt(j) >= "0") && (resObj[i].value.charAt(j) <= "9")) tmp = tmp + resObj[i].value.charAt(j);
                    resObj[i].value = tmp;
                    if (tmp == "") tmp = "0";
                    newRes = Math.round(parseInt(tmp) * summe / 100);
                    if (((i < 3) && (newRes <= max123)) || ((i == 3) && (newRes <= max4)))
                        newHTML = newRes;
                    else
                        newHTML = "<span class='corr'>" + newRes + "</span>";
                    document.getElementById("new" + i).innerHTML = newHTML;
                    overall += parseInt(tmp);
                }
                document.getElementById("overall").innerHTML = overall + "%";
            }
            function normalize() {
                calculateRes();
                resObj = document.getElementsByName("m2");
                for (i = 0; i < resObj.length; i++) {
                    tmp = parseInt(resObj[i].value);
                    tmp = tmp * (100 / overall);
                    resObj[i].value = Math.round(tmp);
                }
                calculateRes();
            }


            function calculateRest() {
                resObj = document.getElementsByName("m2[]");
                overall = 0;
                for (i = 0; i < resObj.length; i++) {
                    var tmp = "";
                    for (j = 0; j < resObj[i].value.length; j++)
                        if ((resObj[i].value.charAt(j) >= "0") && (resObj[i].value.charAt(j) <= "9")) tmp = tmp + resObj[i].value.charAt(j);
                    if (tmp == "") {
                        tmp = "0";
                        newRes = 0;
                        resObj[i].value = "";
                    } else {
                        newRes = parseInt(tmp);
                        if ((i < 3) && (newRes > max123)) newRes = max123;
                        if ((i == 3) && (newRes > max4)) newRes = max4;
                        resObj[i].value = newRes;
                    }
                    dif = newRes - parseInt(document.getElementById("org" + i).innerHTML);
                    newHTML = dif;
                    if (dif > 0) newHTML = "+" + dif;
                    document.getElementById("diff" + i).innerHTML = newHTML;
                    overall += newRes;
                }
                document.getElementById("newsum").innerHTML = overall;
                rest = parseInt(document.getElementById("org4").innerHTML) - overall;
                document.getElementById("remain").innerHTML = rest;
                testSum();
            }

            function fillup(nr) {
                resObj = document.getElementsByName("m2[]");
                if (nr < 3) {
                    resObj[nr].value = max123;
                } else {
                    resObj[nr].value = max4;
                }
                calculateRest();
            }
            function portionOut() {
                restRes = parseInt(document.getElementById("remain").innerHTML);
                rest = restRes;
                resObj = document.getElementsByName("m2[]");
                nullCount = 0;
                notNullCount = 0;
                // Z&#65533;hlen
                for (j = 0; j < resObj.length; j++) {
                    if ((restRes > 0) && (resObj[j].value == "")) nullCount++;
                    if ((restRes < 0) && (resObj[j].value != "")) notNullCount++;
                }
                // distribute
                nullCount2 = 0;
                if (restRes > 0) {
                    // In allen Feldern schon Zahlen?
                    if (nullCount == 0) {
                        for (i = 0; i < resObj.length; i++) {
                            free = max123 - parseInt(resObj[i].value);
                            resObj[i].value = (parseInt(resObj[i].value) + Math.round(rest / (4 - i)));
                            rest = rest - Math.min(free, Math.round(rest / (4 - i)));
                            if ((i < 3) && (parseInt(resObj[i].value) < max123)) nullCount2++;
                        }
                    } else {
                        for (i = 0; i < resObj.length; i++) {
                            if (resObj[i].value == "") {
                                resObj[i].value = Math.round(rest / nullCount);
                                rest = rest - Math.round(rest / nullCount);
                                nullCount--;
                            }
                            if ((i < 3) && (parseInt(resObj[i].value) < max123)) nullCount2++;
                        }
                    }
                } else {
                    for (j = 0; j < resObj.length; j++) {
                        if (parseInt(resObj[j].value) > 0) {
                            resObj[j].value = (parseInt(resObj[j].value) + Math.round(rest / notNullCount));
                            rest = rest - Math.round(rest / notNullCount);
                            notNullCount--;
                        }
                    }
                }
                calculateRest();
                // Still some residual?
                if (rest > 0) {
                    if (max123 > max4) {
                        for (j = 0; j < 3; j++) {
                            if (parseInt(resObj[j].value) < max123) {
                                resObj[j].value = (parseInt(resObj[j].value) + Math.round(rest / nullCount2));
                                rest = rest - Math.round(rest / nullCount2);
                                nullCount2--;
                            }
                        }
                    } else {
                        resObj[3].value = (parseInt(resObj[3].value) + rest);
                    }
                }
                calculateRest();
            }

            function testSum() {
                if (document.getElementById("remain").innerHTML != 0) {
                    document.getElementById("submitText").innerHTML = "<p id='submitText' style='display: block; '><button type='submit' value='<?php echo MK_TRADERESOURCES;?> (1/2)' id='npc_market_button' class='green build' onclick='javascript:portionOut();'><div class='button-container addHoverClick'><div class='button-background'><div class='buttonStart'><div class='buttonEnd'><div class='buttonMiddle'></div></div></div></div><div class='button-content'><?php echo MK_REDISTRIBUTERESOURCES;?> (1/2)</div></div></button></p>";
                    document.getElementById("submitText").style.display = "block";
                    document.getElementById("submitButton").style.display = "none";
                } else {
                    document.getElementById("submitText").innerHTML = "";
                    document.getElementById("submitText").style.display = "none";
                    document.getElementById("submitButton").style.display = "block";
                }
            }
        </script>
        <script
            language="JavaScript">var summe =<?php echo floor($village->awood+$village->acrop+$village->airon+$village->aclay); ?>;
            var max123 =<?php echo $village->maxstore; ?>;
            var max4 =<?php echo $village->maxcrop; ?>;</script>
        <form method="post" name="snd" action="build.php">
            <input type="hidden" name="id" value="<?php echo $id; ?>">
            <input type="hidden" name="ft" value="mk3">
            <input type="hidden" name="t" value="<?php echo $_GET['t']; ?>">

            <table id="npc" cellpadding="1" cellspacing="1">
                <thead>
                <tr>

                    <td class="all">
                        <a href="javascript:fillup(0);"><img class="r1" src="img/x.gif" alt="Wood" title="Wood"/></a>
                        <span id="org0"><?php echo floor($village->awood); ?></span>
                    </td>

                    <td class="all">
                        <a href="javascript:fillup(1);"><img class="r2" src="img/x.gif" alt="Clay" title="Clay"/></a>
                        <span id="org1"><?php echo floor($village->aclay); ?></span>
                    </td>

                    <td class="all">
                        <a href="javascript:fillup(2);"><img class="r3" src="img/x.gif" alt="Iron" title="Iron"/></a>
                        <span id="org2"><?php echo floor($village->airon); ?></span>
                    </td>

                    <td class="all">
                        <a href="javascript:fillup(3);"><img class="r4" src="img/x.gif" alt="Wheat" title="Wheat"/></a>
                        <span id="org3"><?php echo floor($village->acrop); ?></span>
                    </td>

                    <td class="sum"><?php echo BL_TOTAL; ?>:&nbsp;<span
                            id="org4"><?php echo floor($village->awood + $village->acrop + $village->airon + $village->aclay); ?></span>
                    </td>
                </tr>
                </thead>
                <tbody>
                <tr>

                    <td class="sel">
                        <input class="text" onkeyup="calculateRest();" name="m2[]" size="9"
                                <?php if (isset($_GET['r1'])) {
                            echo "value=\"" . $_GET['r1'] . "\"";
                        } ?>/>
                        <input type="hidden" name="m1[]" value="<?php echo floor($village->awood); ?>"/>
                    </td>

                    <td class="sel">
                        <input class="text" onkeyup="calculateRest();" name="m2[]" size="9"
                                <?php if (isset($_GET['r2'])) {
                            echo "value=\"" . $_GET['r2'] . "\"";
                        } ?>/>
                        <input type="hidden" name="m1[]" value="<?php echo floor($village->aclay); ?>"/>
                    </td>

                    <td class="sel">
                        <input class="text" onkeyup="calculateRest();" name="m2[]" size="9"
                               <?php if (isset($_GET['r3'])) {
                            echo "value=\"" . $_GET['r3'] . "\"";
                        } ?>/>
                        <input type="hidden" name="m1[]" value="<?php echo floor($village->airon); ?>"/>
                    </td>

                    <td class="sel">
                        <input class="text" onkeyup="calculateRest();" name="m2[]" size="9"
                                <?php if (isset($_GET['r4'])) {
                            echo "value=\"" . $_GET['r4'] . "\"";
                        } ?>/>
                        <input type="hidden" name="m1[]" value="<?php echo floor($village->acrop); ?>"/>
                    </td>

                    <td class="sum"><?php echo BL_TOTAL; ?>:&nbsp;<span
                            id="newsum"><?php if (isset($_GET['r1']) && isset($_GET['r2']) && isset($_GET['r3']) && isset($_GET['r4'])) {
                                echo $_GET['r1'] + $_GET['r2'] + $_GET['r3'] + $_GET['r4'];
                            } else {
                                echo 0;
                            } ?></span></td>
                </tr>
                <tr>

                    <td class="rem">
                        <span id="diff0"><?php echo 0 - floor($village->awood); ?></span>
                    </td>

                    <td class="rem">
                        <span id="diff1"><?php echo 0 - floor($village->aclay); ?></span>
                    </td>

                    <td class="rem">
                        <span id="diff2"><?php echo 0 - floor($village->airon); ?></span>
                    </td>

                    <td class="rem">
                        <span id="diff3"><?php echo 0 - floor($village->acrop); ?></span>
                    </td>

                    <td class="sum"><?php echo BL_REMINDERS; ?>:&nbsp;<span id="remain">
                    <?php if (isset($_GET['r1']) && isset($_GET['r2']) && isset($_GET['r3']) && isset($_GET['r4'])) {
                        echo floor($village->awood + $village->acrop + $village->airon + $village->aclay) - ($_GET['r1'] + $_GET['r2'] + $_GET['r3'] + $_GET['r4']);
                    } else {
                        echo floor($village->awood + $village->acrop + $village->airon + $village->aclay);
                    } ?></span></td>
                </tr>
                </tbody>
            </table>
            <p id="submitButton" style="display: block; ">
                <?php if ($session->userinfo['gold'] >= 3) { ?>
                <button type="submit" value="<?php echo MK_TRADERESOURCES; ?> (2/2)" id="npc_market_button"
                        class="green build"
                        onclick="$('npc_market_button').addClass('disabled').disabled = true;document.snd.submit();">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo MK_TRADERESOURCES; ?> (2/2)
                        </div>
                    </div>
                </button>
                <span class="npc_price"><b>3</b><img src="img/x.gif" class="gold"/> <?php echo HDR_GOLD; ?></span></p>
            <?php } else {
                echo "<a href=\"plus.php\"><span class=\"none\">" . MK_NOTENOUGHGOLD . "</span></a>";
            } ?></p>
            <p id="submitText"></p>
        </form>
        <script>
            calculateRest();
            testSum();
        </script>
    <?php } ?>
</div>
<div class="clear">&nbsp;</div>