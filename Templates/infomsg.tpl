<?php
    $timer = 1;
    $total = 0;
    $golds = $database->getUser($_SESSION['username'], 0);
    $golds['plus'];
    if ($session->plus) {
        if ($golds['plus'] < ($_SERVER['REQUEST_TIME'] + 3600 * 24)) {
            $output .= "<li id=\"infoID_1\" class=\"\">";
            $exp = $generator->getTimeFormat($golds['plus'] - $_SERVER['REQUEST_TIME']);
            $output .= IM_PLUSDEACTIVE . ' <span id="timer' . $timer . '">' . $exp . '</span>';
            $output .= "<br><button type=\"button\" value=\"extend\" id=\"button5288d485c0f4f\" class=\"gold \" coins=\"" . g_plus . "\">
				<div class=\"button-container addHoverClick \">
					<div class=\"button-background\">
						<div class=\"buttonStart\">
							<div class=\"buttonEnd\">
								<div class=\"buttonMiddle\"></div>
							</div>
						</div>
					</div>
					<div class=\"button-content\">" . IM_EXTEND . " <img src=\"img/x.gif\" class=\"goldIcon\" alt=\"\"><span class=\"goldValue\">" . g_plus . "</span></div>
				</div>
			</button>
			<script type=\"text/javascript\">
				window.addEvent('domready', function()
				{
				if($('button5288d485c0f4f'))
				{
					$('button5288d485c0f4f').addEvent('click', function ()
					{
						window.fireEvent('buttonClicked', [this, {\"type\":\"button\",\"value\":\"extend\",\"name\":\"\",\"id\":\"button5288d485c0f4f\",\"class\":\"gold \",\"title\":\"\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":10,\"wayOfPayment\":{\"featureKey\":\"plus\",\"context\":\"infobox\"}}]);
					});
				}
				});
			</script>";
            $timer++;
        }
    }
    if ($golds['b1']) {
        if ($golds['b1'] < ($_SERVER['REQUEST_TIME'] + 3600 * 24)) {
            $output .= "<li id=\"infoID_2\" class=\"\">";
            $exp = $generator->getTimeFormat($golds['b1'] - $_SERVER['REQUEST_TIME']);
            $output .= IM_WOODDEACTIVE . ' <span id="timer' . $timer . '">' . $exp . '</span>';
            $output .= "<br><button type=\"button\" value=\"extend\" id=\"button652W890f4f\" class=\"gold \" coins=\"" . g_wood . "\">
				<div class=\"button-container addHoverClick \">
					<div class=\"button-background\">
						<div class=\"buttonStart\">
							<div class=\"buttonEnd\">
								<div class=\"buttonMiddle\"></div>
							</div>
						</div>
					</div>
					<div class=\"button-content\">" . IM_EXTEND . " <img src=\"img/x.gif\" class=\"goldIcon\" alt=\"\"><span class=\"goldValue\">" . g_wood . "</span></div>
				</div>
			</button>
			<script type=\"text/javascript\">
				window.addEvent('domready', function()
				{
				if($('button652W890f4f'))
				{
					$('button652W890f4f').addEvent('click', function ()
					{
						window.fireEvent('buttonClicked', [this, {\"type\":\"button\",\"value\":\"extend\",\"name\":\"\",\"id\":\"button652W890f4f\",\"class\":\"gold \",\"title\":\"\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":" . g_wood . ",\"wayOfPayment\":{\"featureKey\":\"productionboostWood\",\"context\":\"infobox\"}}]);
					});
				}
				});
			</script>";
            $timer++;
            if ($golds['b1'] <= time()) {
                mysql_query("UPDATE " . TB_PREFIX . "users set b1 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
            }
        }
    }
    if ($golds['b2']) {
        if ($golds['b2'] < ($_SERVER['REQUEST_TIME'] + 3600 * 24)) {
            $output .= "<li id=\"infoID_3\" class=\"\">";
            $exp = $generator->getTimeFormat($golds['b2'] - $_SERVER['REQUEST_TIME']);
            $output .= IM_CLAYDEACTIVE . ' <span id="timer' . $timer . '">' . $exp . '</span>';
            $output .= "<br><button type=\"button\" value=\"extend\" id=\"button652C890Lf4f\" class=\"gold \" coins=\"" . g_clay . "\">
				<div class=\"button-container addHoverClick \">
					<div class=\"button-background\">
						<div class=\"buttonStart\">
							<div class=\"buttonEnd\">
								<div class=\"buttonMiddle\"></div>
							</div>
						</div>
					</div>
					<div class=\"button-content\">" . IM_EXTEND . " <img src=\"img/x.gif\" class=\"goldIcon\" alt=\"\"><span class=\"goldValue\">" . g_clay . "</span></div>
				</div>
			</button>
			<script type=\"text/javascript\">
				window.addEvent('domready', function()
				{
				if($('button652C890Lf4f'))
				{
					$('button652C890Lf4f').addEvent('click', function ()
					{
						window.fireEvent('buttonClicked', [this, {\"type\":\"button\",\"value\":\"extend\",\"name\":\"\",\"id\":\"button652C890Lf4f\",\"class\":\"gold \",\"title\":\"\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":" . g_clay . ",\"wayOfPayment\":{\"featureKey\":\"productionboostClay\",\"context\":\"infobox\"}}]);
					});
				}
				});
			</script>";
            $timer++;
            if ($golds['b2'] <= time()) {
                mysql_query("UPDATE " . TB_PREFIX . "users set b2 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
            }
        }
    }
    if ($golds['b3']) {
        if ($golds['b3'] < ($_SERVER['REQUEST_TIME'] + 3600 * 24)) {
            $output .= "<li id=\"infoID_4\" class=\"\">";
            $exp = $generator->getTimeFormat($golds['b3'] - $_SERVER['REQUEST_TIME']);
            $output .= IM_IRONDEACTIVE . '<span id="timer' . $timer . '">' . $exp . '</span>';
            $output .= "<br><button type=\"button\" value=\"extend\" id=\"button652I8900f4f\" class=\"gold \" coins=\"" . g_iron . "\">
				<div class=\"button-container addHoverClick \">
					<div class=\"button-background\">
						<div class=\"buttonStart\">
							<div class=\"buttonEnd\">
								<div class=\"buttonMiddle\"></div>
							</div>
						</div>
					</div>
					<div class=\"button-content\">" . IM_EXTEND . " <img src=\"img/x.gif\" class=\"goldIcon\" alt=\"\"><span class=\"goldValue\">" . g_iron . "</span></div>
				</div>
			</button>
			<script type=\"text/javascript\">
				window.addEvent('domready', function()
				{
				if($('button652I8900f4f'))
				{
					$('button652I8900f4f').addEvent('click', function ()
					{
						window.fireEvent('buttonClicked', [this, {\"type\":\"button\",\"value\":\"extend\",\"name\":\"\",\"id\":\"button652I8900f4f\",\"class\":\"gold \",\"title\":\"\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":" . g_iron . ",\"wayOfPayment\":{\"featureKey\":\"productionboostIron\",\"context\":\"infobox\"}}]);
					});
				}
				});
			</script>";
            $timer++;
            if ($golds['b3'] <= time()) {
                mysql_query("UPDATE " . TB_PREFIX . "users set b3 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
            }
        }
    }
    if ($golds['b4']) {
        if ($golds['b4'] < ($_SERVER['REQUEST_TIME'] + 3600 * 24)) {
            $output .= "<li id=\"infoID_5\" class=\"\">";
            $exp = $generator->getTimeFormat($golds['b4'] - $_SERVER['REQUEST_TIME']);
            $output .= IM_CROPDEACTIVE . '<span id="timer' . $timer . '">' . $exp . '</span>';
            $output .= "<br><button type=\"button\" value=\"extend\" id=\"button652C890Rf4f\" class=\"gold \" coins=\"" . g_crop . "\">
				<div class=\"button-container addHoverClick \">
					<div class=\"button-background\">
						<div class=\"buttonStart\">
							<div class=\"buttonEnd\">
								<div class=\"buttonMiddle\"></div>
							</div>
						</div>
					</div>
					<div class=\"button-content\">" . IM_EXTEND . " <img src=\"img/x.gif\" class=\"goldIcon\" alt=\"\"><span class=\"goldValue\">" . g_crop . "</span></div>
				</div>
			</button>
			<script type=\"text/javascript\">
				window.addEvent('domready', function()
				{
				if($('button652C890Rf4f'))
				{
					$('button652C890Rf4f').addEvent('click', function ()
					{
						window.fireEvent('buttonClicked', [this, {\"type\":\"button\",\"value\":\"extend\",\"name\":\"\",\"id\":\"button652C890Rf4f\",\"class\":\"gold \",\"title\":\"\",\"confirm\":\"\",\"onclick\":\"\",\"coins\":" . g_crop . ",\"wayOfPayment\":{\"featureKey\":\"productionboostCrop\",\"context\":\"infobox\"}}]);
					});
				}
				});
			</script>";
            $timer++;
            if ($golds['b4'] <= time()) {
                mysql_query("UPDATE " . TB_PREFIX . "users set b4 = '0' where `username`='" . $session->username . "'") or die(mysql_error());
            }
        }
    }

    $output .= "</li>";
    //include('Templates/text.tpl');
    //if($txt != ''){ $output .= "<li class=\"\">".nl2br($txt)."</li>";$total++;}
    include('Templates/text_infobox.tpl');
    //bbcode = html code
    if ($txt2 != '') {
        $output .= "<li class=\"firstElement\">" . nl2br($txt2) . "</li>";
        $total++;
    }
    if ($golds['protect'] > $_SERVER['REQUEST_TIME']) {

        $total++;
        $tt = $golds['protect'] - $_SERVER['REQUEST_TIME'];
        $remaining = $generator->getTimeFormat($tt);
        $output .= "<li id=\"infoID_248172\" class=\"firstElement\">
	" . IM_STILL . " <span id=\"timer$timer\">" . $remaining . "</span> " . IM_BEGINERPROT . "</li>";
        $timer++;
    }
?>
<div id="sidebarBoxInfobox" class="sidebarBox toggleable <?php if (isset($_COOKIE['travian_toggle'])) {
    $class = explode(',', $_COOKIE['travian_toggle']);
    foreach ($class as $cs) {
        $expl = explode(':', $cs);
        if ($expl[0] == "infobox") {
            echo $expl[1];
        }
        //$i++;
    }
} else {
    echo "expanded";
}?>">
    <div class="sidebarBoxBaseBox">
        <div class="baseBox baseBoxTop">
            <div class="baseBox baseBoxBottom">
                <div class="baseBox baseBoxCenter"></div>
            </div>
        </div>
    </div>
    <div class="sidebarBoxInnerBox">
        <div class="innerBox header ">
            <div class="boxTitle">اعلانات</div>
<span class="messageShortInfo">
	
	<?php echo $total; ?> <img class="messages" src="img/x.gif" alt="<?php echo IM_TOTMSG . $total; ?>"
                               title="<?php echo IM_TOTMSG . $total; ?>"/>
</span>
        </div>
        <div class="innerBox content">
            <ul>
                <?php echo $output; ?>
            </ul>

        </div>
        <div class="innerBox footer">
            <button type="button" class="toggle" onclick="" title="<?php echo HS_HINFO; ?>">
                <div class="button-container addHoverClick"></div>
            </button>

            <script type="text/javascript">
                window.addEvent('domready', function () {
                    Travian.Translation.add(
                        {
                            'infobox_collapsed': '<?php echo HS_DMINFO;?>',
                            'infobox_expanded': '<?php echo HS_HINFO;?>'
                        });

                    var box = $('sidebarBoxInfobox');
                    box.down('button.toggle').addEvent('click', function (e) {
                        Travian.Game.Layout.toggleBox(box, 'travian_toggle', 'infobox');
                    });
                });
            </script>

            <script type="text/javascript">
                window.addEvent('domready', function () {
                    Travian.Game.Layout.setInfoboxItemsRead();
                });
            </script>
        </div>
    </div>
</div>	