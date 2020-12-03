<div class="boxes villageList production">
    <div class="boxes-tl"></div>
    <div class="boxes-tr"></div>
    <div class="boxes-tc"></div>
    <div class="boxes-ml"></div>
    <div class="boxes-mr"></div>
    <div class="boxes-mc"></div>
    <div class="boxes-bl"></div>
    <div class="boxes-br"></div>
    <div class="boxes-bc"></div>
    <div class="boxes-contents cf">
        <table id="production" cellpadding="1" cellspacing="1">
            <thead>
            <tr>
                <th colspan="4"><?php echo PD_PRODPERHR; ?></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="ico">
                    <div><img class="r1Big" src="img/x.gif" alt="<?php echo PD_LUMBER; ?>"
                              title="<?php echo PD_LUMBER; ?>"/>
                        <?php if ($golds['b1']) echo '<img src="img/x.gif" class="productionBoost" alt="' . PD_WOODBONUS . '">'; ?>
                    </div>
                </td>
                <td class="res"><?php echo PD_LUMBER; ?>:</td>
                <td class="num"><?php echo round($village->getProd('wood')); ?></td>
            </tr>
            <tr>
                <td class="ico">
                    <div><img class="r2Big" src="img/x.gif" alt="<?php echo PD_CLAY; ?>"
                              title="<?php echo PD_CLAY; ?>"/>
                        <?php if ($golds['b2']) echo '<img src="img/x.gif" class="productionBoost" alt="' . PD_CLAYBONUS . '">'; ?>
                    </div>
                </td>
                <td class="res"><?php echo PD_CLAY; ?>:</td>
                <td class="num"><?php echo round($village->getProd('clay')); ?></td>
            </tr>
            <tr>
                <td class="ico">
                    <div><img class="r3Big" src="img/x.gif" alt="<?php echo PD_IRON; ?>"
                              title="<?php echo PD_IRON; ?>"/>
                        <?php if ($golds['b3']) echo '<img src="img/x.gif" class="productionBoost" alt="' . PD_IRONBONUS . '">'; ?>
                    </div>
                </td>
                <td class="res"><?php echo PD_IRON; ?>:</td>
                <td class="num"><?php echo round($village->getProd('iron')); ?></td>
            </tr>
            <tr>
                <td class="ico">
                    <div><img class="r4Big" src="img/x.gif" alt="<?php echo PD_CROP; ?>"
                              title="<?php echo PD_CROP; ?>"/>
                        <?php if ($golds['b4']) echo '<img src="img/x.gif" class="productionBoost" alt="' . PD_CROPBONUS . '">'; ?>
                    </div>
                </td>
                <td class="res"><?php echo PD_CROP; ?>:</td>
                <td class="num">
                    <?php echo $village->getProd("crop"); ?>
                </td>
            </tr>
            </tbody>
        </table>

        <div>
            <button type="button" value="&#8207;25%&#8207;" id="button5229e52541034" class="gold productionBoostButton" title="<?php echo PD_MINFO;?>">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content">&#8206;&#8237;+&#8237;25&#8236;%&#8236;&#8206;</div>
                </div>
            </button>
            <script type="text/javascript">
                window.addEvent('domready', function () {
                    if ($('button5229e52541034')) {
                        $('button5229e52541034').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "button", "value": "<?php echo PD_MINFO;?>", "name": "", "id": "button5229e52541034", "class": "gold productionBoostButton", "title": "<?php echo PD_MINFO;?>", "confirm": "", "onclick": "", "productionBoostDialog": {"infoIcon": "http:\/\/t4.answers.travian.com.sa\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}}]);
                        });
                    }
                });
            </script>
        </div>
        <!--
        <button type="button" value="Mass Upgrade Resources" class="gold" title="Master Upgrade Resources" onclick="location.href='dorf1.php?masterbuild'">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content">Mass Upgrade Resources</div>
            </div>
        </button>
        -->
    </div>
</div>