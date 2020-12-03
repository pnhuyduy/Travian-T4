<div class="boxes boxesColor gray silverExchange">
	<div class="boxes-tl"></div>
	<div class="boxes-tr"></div>
	<div class="boxes-tc"></div>
	<div class="boxes-ml"></div>
	<div class="boxes-mr"></div>
	<div class="boxes-mc"></div>
	<div class="boxes-bl"></div>
	<div class="boxes-br"></div>
	<div class="boxes-bc"></div>
	<div class="boxes-contents cf"><div id="silverExchange" class="silverExchange">
	<h4><?php echo HR_EXCHANGEOFFICE;?></h4>
		<div class="exchangeLine">
		<form method="post" action="#">
			<div class="directionButtons">
				<button class="directionButton GoldToSilver active"><img src="img/x.gif" class="gold" alt="Gold"><img src="img/x.gif" class="arrow" alt=""><img src="img/x.gif" class="silver" alt="Silver"></button>
				<button class="directionButton SilverToGold"><img src="img/x.gif" class="silver" alt="Silver"><img src="img/x.gif" class="arrow" alt=""><img src="img/x.gif" class="gold" alt="Gold"></button>
			</div>
			<div class="exchangeTypeGoldToSilver exchangeType active">
				<button type="button" value="GoldToSilver" id="button53089fa729927" class="gold " coins="1">
	<div class="button-container addHoverClick">
		<div class="button-background">
			<div class="buttonStart">
				<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content"><?php echo HR_EXCHANGE;?><img src="img/x.gif" class="goldIcon" alt=""><span class="goldValue">1</span></div>
	</div>
</button>
<script type="text/javascript">
	window.addEvent('domready', function()
	{
	if($('button53089fa729927'))
	{
		$('button53089fa729927').addEvent('click', function ()
		{
			window.fireEvent('buttonClicked', [this, {"type":"button","value":"GoldToSilver","name":"","id":"button53089fa729927","class":"gold ","title":"<?php echo HR_CONVERTNOW;?>","confirm":"","onclick":"","coins":"1","wayOfPayment":{"featureKey":"exchangeSilver","dataCallback":"getExchangeCoins"}}]);
		});
	}
	});
</script>

				<div class="exchangeItem formularDirectionLTR">
					<span class="silverExchangeFormularTerm"><img src="img/x.gif" class="gold" alt="Gold"></span>
					<span class="silverExchangeFormularTerm"><input id="exchangeGoldToSilverInput" class="goldInput text" value="1" type="text"></span>
					<span class="silverExchangeFormularTerm">×</span>
					<span class="silverExchangeFormularTerm">100</span>
					<span class="silverExchangeFormularTerm">=</span>
					<span class="silverExchangeFormularTerm resultTerm"><img src="img/x.gif" class="silver" alt="Silver"><span class="silverResult">100</span></span>
				</div>

			</div>
			<div class="exchangeTypeSilverToGold exchangeType">
				<button type="button" value="SilverToGold" id="button53089fa729ae2" class="green ">
	<div class="button-container addHoverClick">
		<div class="button-background">
			<div class="buttonStart">
				<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content"><?php echo HR_EXCHANGE;?></div>
	</div>
</button>
<script type="text/javascript">
	window.addEvent('domready', function()
	{
	if($('button53089fa729ae2'))
	{
		$('button53089fa729ae2').addEvent('click', function ()
		{
			window.fireEvent('buttonClicked', [this, {"type":"button","value":"SilverToGold","name":"","id":"button53089fa729ae2","class":"green ","title":"<?php echo HR_EXSILVERTOGOLD;?>","confirm":"","onclick":""}]);
		});
	}
	});
</script>

                <div class="exchangeItem formularDirection formularDirectionLTR">
                    <span class="silverExchangeFormularTerm"><img src="img/x.gif" class="silver" alt="Silver"></span>
                    <span class="silverExchangeFormularTerm"><input id="exchangeSilverToGoldInput"
                                                                    class="silverInput text" value="200"
                                                                    type="text"></span>
                    <span class="silverExchangeFormularTerm">÷</span>
                    <span class="silverExchangeFormularTerm">200</span>
                    <span class="silverExchangeFormularTerm">=</span>
                    <span class="silverExchangeFormularTerm resultTerm"><img src="img/x.gif" class="gold"
                                                                             alt="Gold"><span
                            class="goldResult">1</span></span>
                </div>

			</div>
		</form>
	</div>
	<div class="clear"></div>
	<div class="exchangeMessageLine">
		&nbsp;	</div>
</div>

<script type="text/javascript">
	function getExchangeCoins()
	{
		var input = $('exchangeGoldToSilverInput');
		var gold = <?php echo $session->uid;?>;
		if(typeof input.get('value') !== 'undefined')
		{
			gold = parseInt(input.get('value'));
		}
		if (gold == 0)
		{
			return false;
		}
		return {coins: gold};
	}

    // check if pasted text is an integer and update exchangeValue, otherwise discard it imidiatly
    function checkGoldSilverPaste(e, inputElement, exchange)
    {
        var pastedText = undefined;
        if (window.clipboardData && window.clipboardData.getData) { // IE
            pastedText = window.clipboardData.getData('Text');
        } else if (e.clipboardData && e.clipboardData.getData) {
            pastedText = e.clipboardData.getData('text/plain');
        }

        if(!isNaN(pastedText) && (parseInt(pastedText) == pastedText))
        {
            // update exchange gold value on submit button
            exchange.updateExchangeValue(parseInt(inputElement.value + '' + pastedText));
        }
    }

	$$('#silverExchange form').addEvent('submit', function(e){
		e.stop();
	});

	window.addEvent('domready', function()
	{

		var goldToSilverExchange = new Travian.Game.Hero.SilverExchange(
		{
			exchangeOptions:
			{
				directionType: 'GoldToSilver',
				showExchangeTypeElement: $$('#silverExchange .directionButtons .GoldToSilver')[0],
				inputElement: $$('#silverExchange .exchangeTypeGoldToSilver input')[0],
				resultValueElements:
				[
					{
						setType:'html',
						element: $$('#silverExchange .exchangeTypeGoldToSilver .silverResult')[0]
					}
				],
				inputValueElements:
					[
						{
							setType:'html',
							element: $$('#silverExchange .exchangeTypeGoldToSilver button.gold .goldValue')[0]
						},
						{
							setType:'coins',
							element: $$('#silverExchange .exchangeTypeGoldToSilver button.gold')[0]
						}
					],
				baseMultiplier: 100,
				maxAmount: <?php echo $session->gold;?>,
				submitButton: $$('#silverExchange .exchangeTypeGoldToSilver button.gold')[0],
				handleMaxFunction: function(targetValue)
				{
					this.showMessageByKey('notEnoughGold');
					return targetValue;
				}
			},
			messages :
			{
				notEnoughGold:
				{
					type : 'error', message:"<?php echo HR_EXERROR1;?>"
				},
				autoCorrect:
				{
					type : 'notice', message:"<?php echo HR_EXERROR2;?>"
				},
				disabledSubmitTooltip:
				{
					type : 'tooltip', message:"<?php echo HR_EXERROR3;?>"
				},
				enabledSubmitTooltip:
				{
					type : 'tooltip', message:"<?php echo HR_EXCHANGE;?>"
				},
				maxAmountTooltip:
				{
					type : 'tooltip', message:"<?php echo HR_EXERROR4;?>"
				}
			}
		});

		var silverToGoldExchange = new Travian.Game.Hero.SilverExchange(
		{
			exchangeOptions:
			{
				directionType: 'SilverToGold',
				showExchangeTypeElement:$$('#silverExchange .directionButtons .SilverToGold')[0],
				inputElement:$$('#silverExchange .exchangeTypeSilverToGold input')[0],
				resultValueElements:
				[
					{
						setType:'html',
						element: $$('#silverExchange .exchangeTypeSilverToGold .goldResult')[0]
					}
				],
				baseMultiplier:0.005,
				maxAmount:<?php echo $session->silver;?>,
				submitButton: $$('#silverExchange .exchangeTypeSilverToGold button.green')[0],
				submitButtonClickListener: null,
				handleMaxFunction: function(targetValue)
				{
					targetValue = this.options.exchangeOptions.maxAmount;
					this.options.exchangeOptions.inputElement.set('value', targetValue);
					this.showMessageByKey('autoCorrect');
					return targetValue;
				}
			},

			messages :
			{
				notEnoughGold:
				{
					type : 'error',
					message:"<?php echo HR_EXERROR1;?>"
				},
				autoCorrect:
				{
					type : 'notice',
					message:"<?php echo HR_EXERROR5;?>"
				},
				disabledSubmitTooltip:
				{
					type : 'tooltip',
					message:"<?php echo HR_EXERROR6;?>"
				},
				enabledSubmitTooltip:
				{
					type : 'tooltip',
					message:"<?php echo HR_EXERROR7;?>"
				}
			}
		});

		silverToGoldExchange.addEvent(
			'changeMaxAmounts',
			function(eventData)
			{
				goldToSilverExchange.setMaxAmounts(eventData);
			});

		window.showFinishedExchangeGoldToSilver = function(options, context)
		{
			if (options.message)
			{
				goldToSilverExchange.showMessage(options.message);
			}
			goldToSilverExchange.overrideGoldAndSilver(options.oldGold, options.oldSilver, options.newGold, options.newSilver);
			silverToGoldExchange.setMaxAmounts(options);
		}

        // check paste value
        $$('#silverExchange .exchangeTypeGoldToSilver input')[0].onpaste = function(e) {
            checkGoldSilverPaste(e, this, goldToSilverExchange);
            return false; // Prevent the default handler from running.
        };

        // check paste value
        $$('#silverExchange .exchangeTypeSilverToGold input')[0].onpaste = function(e) {
            checkGoldSilverPaste(e, this, silverToGoldExchange);
            return false; // Prevent the default handler from running.
        };

		// nach dem alle listener korrekt gesetzt wurden einmal dem Input wert aktualisieren.
		goldToSilverExchange.updateExchangeValue(1);

	});
</script>
	</div>
</div>

<div class="contentNavi tabNavi">
				<div class="container <?php if(isset($_GET['action']) && $_GET['action'] == 'buy') { echo "active"; } else { echo "normal"; } ?>">
					<div class="background-start">&nbsp;</div>
					<div class="background-end">&nbsp;</div>
					<div class="content"><a href="hero_auction.php?action=buy"><span class="tabItem"><?php echo 'buy';?></span></a></div>
				</div>
				<div class="container <?php if(isset($_GET['action']) && $_GET['action'] == 'sell') { echo "active"; } else { echo "normal"; } ?>">
					<div class="background-start">&nbsp;</div>
					<div class="background-end">&nbsp;</div>
					<div class="content"><a href="hero_auction.php?action=sell"><span class="tabItem"><?php echo 'sell';?></span></a></div>
				</div>
				<div class="container <?php if(isset($_GET['action']) && $_GET['action'] == 'bids') { echo "active"; } else { echo "normal"; } ?>">
					<div class="background-start">&nbsp;</div>
					<div class="background-end">&nbsp;</div>
					<div class="content"><a href="hero_auction.php?action=bids"><span class="tabItem"><?php echo 'bids';?></span></a></div>
				</div><div class="clear"></div>
</div>