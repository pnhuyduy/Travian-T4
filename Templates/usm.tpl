				<div id="content" class="messages">
					<?php
					if($database->checkBan($session->uid)){
						header("Location: banned.php");
                        exit;
					}else{?>
						<div id="block">
							<div class="messagesText"><br><br>
								<h1 class="titleInHeader"><?php echo MS_PUBMSGTITLE; ?></h1><br><br><br>
								<h2><?php echo HELLO.' '.$session->username; ?>,</h2>
								<br>
								<?php include("Templates/text.tpl"); ?>
							</div>
							<div class="btn">
								<button type="submit" name="s1" id="btn_back" onclick="window.location.href = 'dorf1.php?ok'">
									<div class="button-container">
										<div class="button-position">
											<div class="btl"><div class="btr"><div class="btc"></div></div></div>
											<div class="bml"><div class="bmr"><div class="bmc"></div></div></div>
											<div class="bbl"><div class="bbr"><div class="bbc"></div></div></div>
										</div>
										<div class="button-contents">
											<?php echo MS_GOTOMYVILLAGE; ?>
										</div>
									</div>
								</button>
							</div>
						</div>
					<?php } ?>
					<div class="clear"></div>
					<div class="clear">&nbsp;</div>
				</div>
				<div class="clear"></div>
