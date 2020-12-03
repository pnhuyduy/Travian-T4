<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Account.php");
    include "Templates/html.tpl";


    if (isset($_GET['activated'])) {
        $onload = 'onload="$H({data:{cmd:\'News\',id:\'activate\'}}).dialog();"';
    } else {
        $onload = '';
    }

    echo '
<body class="v35 gecko singup perspectiveBuildings" ' . $onload . '>
	<script type="text/javascript">
		window.ajaxToken = ' . md5($_SERVER["REQUEST_TIME"]) . ';
	</script>
	<link rel="stylesheet" href="img/jquery.countdown.css">
	<style type="text/css">
#defaultCountdown { width: 240px; height: 45px; }
div.innerLoginBox2{height:400px;background-image:url(img/quest_new_village.jpg);}
</style>
	<div id="background">
		<img id="staticElements" src="img/x.gif" alt="">
		<div id="bodyWrapper">
			<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="">
			<div id="header">
				<div id="mtop">
					<a id="logo" href="' . HOMEPAGE . '" target="_blank" title="' . SERVER_NAME . '"></a>
					<div class="clear"></div>
				</div>
			</div>
			<div id="center">
				<div id="sidebarBeforeContent" class="sidebar beforeContent">
					<div id="sidebarBoxMenu" class="sidebarBox   ">
	<div class="sidebarBoxBaseBox">
		<div class="baseBox baseBoxTop">
			<div class="baseBox baseBoxBottom">
				<div class="baseBox baseBoxCenter"></div>
			</div>
		</div>
	</div>
	<div class="sidebarBoxInnerBox">
		<div class="innerBox header noHeader"></div>
		<div class="innerBox content">
	<ul>
		<li>
			<a href="' . HOMEPAGE . '" title="' . HOME . '">' . HOME . '</a>
		</li>

		<li class="active">
			<a href="login.php" title="' . LOGIN . '">' . LOGIN . '</a>
		</li>

		<li>
			<a href="anmelden.php" title="' . REG . '">' . REG . '</a>
		</li>

		<li>
			<a href="#" target="_blank" title="' . FORUM . '">' . FORUM . '</a>
		</li>
		
		<li class="support">
			<a href="contact.php" title="' . SUPPORT . '">' . SUPPORT . '</a>
		</li>
		
	</ul>
</div>

<div class="innerBox footer">
					</div>
				</div></div></div>
						<div id="contentOuterContainer">
							<div class="contentTitle">
								<a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.ir" target="_blank">&nbsp;</a>
							</div>
							<div class="contentContainer">
								<div id="content" class="singup">
';
?>
<?php if(REG_OPEN == true){ ?>
		<h4 class="round">اطلاعات کاربر</h4>
		<form name="snd" method="post" action="anmelden.php">
		<input type="hidden" name="ft" value="a1" />
		<?php if(isset($_GET['anc']) && $_GET['anc']!='') { echo '<input type="hidden" name="anc" value="'.$_GET['anc'].'" />';}?>
			<table cellpadding="1" cellspacing="1" id="sign_input" class="transparent">
			<tbody>
				<tr class="top">
					<th><label for="userName">نام کاربری</label></th>
					<td>
						<input id="userName" class="text" type="text" name="name" value="<?php echo $form->getValue('name'); ?>" maxlength="15" />
						<span class="error"><?php echo $form->getError('name'); ?></span>
					</td>
				</tr>
				<tr>
					<th><label for="userEmail">ایمیل</label></th>
					<td>
						<input id="userEmail" class="text" type="text" name="email" value="<?php echo $form->getValue('email'); ?>" maxlength="40" />
						<span class="error"><?php echo $form->getError('email'); ?></span>
					</td>
				</tr>
				<tr class="btm">
					<th><label for="userPassword">رمز عبور</label></th>
					<td>
						<input id="userPassword" class="text" type="password" name="pw" value="<?php echo $form->getValue('pw'); ?>" maxlength="20" />
						<span class="error"><?php echo $form->getError('pw'); ?></span>
					</td>
				</tr>
			</tbody>
		</table>


	
			<h4 class="round">اطلاعات بیشتر</h4>
			<div class="checks">
<font size="3" color="red"><b>
قوانین بازی :
</font>
قوانین بازی : هر سیستمی ممکن است مشکلات و کاستی هایی داشته باشد، همچنین قوانین بازی ممکن است با سایر سایت های تراوین و بازی آنلاین، متفاوت باشد. در صورتی که نمی توانید این نواقص را بپذیرید و این تفاوت ها را قبول کنید از ثبت نام خودداری نمائید. زیرا پذیرفتن این کاستی ها و تفاوت ها قانون ثبت نام در بازی می باشد. البته تیم تراوین در حال رفع این کاستی ها بوده و سعی دارد بهترین بازی آنلاین را برای کاربران گرامی فراهم آورد. قبل از ثبت نام باید بپذیرید که از توهین به سایر کاربران، توهین به مقدسات اسلام و سایر ادیان بپرهیزید همچنین این وبسایت تابع قوانین جمهوری اسلامی ایران می باشد و از پذیرفتن کاربرانی که اعمال آنها ناقض این قوانین باشد معذور است. 
<br><br>
همچنین خواندن قوانین کلی سرور ها الزامی است  : <a href="agb.php"  target="_blank">قوانین</a>
<br><br>
				<input class="check" type="checkbox" id="agb" name="agb" value="1" <?php echo $form->getRadio('agb',1); ?>/>
				<label for="agb">من <a title='برای نمایش قوانین کلیک کنید' href='agb.php' target='_blank' >قوانین</a> را خوانده و قبول دارم.</b></label>
			</div>

        <ul class="important">
<?php
echo $form->getError('tribe');
echo $form->getError('agree');
?>
		</ul>
		<div class="btn">
        <input type="hidden" name="vid" value="0">
        <input type="hidden" name="kid" value="0">
			<button type="submit" value="" name="s1" class="green "  id="btn_signup" title="Register">
	<div class="button-container addHoverClick ">
		<div class="button-background">
			<div class="buttonStart">
				<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content"><?php echo REG; ?></div>
	</div>
            </button>
		</div>
	</form>
    <div class="clear">&nbsp;</div>
<?php }else{ ?>
<p><?php echo REGISTER_CLOSED; ?></p>
<?php } ?>   
    </div>  
							<div class="clear"></div>
					</div>
						<div class="contentFooter">&nbsp;</div>
					</div>
						<div id="sidebarAfterContent" class="sidebar afterContent">
<?php if(NEWSBOX1) { ?>
	<div id="sidebarBoxNews1" class="sidebarBox   sidebarBoxNews">
		<div class="sidebarBoxBaseBox">
			<div class="baseBox baseBoxTop">
				<div class="baseBox baseBoxBottom">
					<div class="baseBox baseBoxCenter"></div>
				</div>
			</div>
		</div>
		<div class="sidebarBoxInnerBox">
			<div class="innerBox header noHeader"></div>
			<div class="innerBox content">
		<div class="news news1"><?php include("Templates/News/newsbox1.tpl"); ?></div>
		</div>
			<div class="innerBox footer">	 
			</div>
		</div>
	</div>
<?php } ?>

<?php if(NEWSBOX2) { ?>
<div id="sidebarBoxNews2" class="sidebarBox   sidebarBoxNews">

	<div class="sidebarBoxBaseBox">
		<div class="baseBox baseBoxTop">
			<div class="baseBox baseBoxBottom">
				<div class="baseBox baseBoxCenter"></div>
			</div>
		</div>
	</div>
	<div class="sidebarBoxInnerBox">
		<div class="innerBox header noHeader"></div>
		<div class="innerBox content">
	<div class="news news2"><?php include("Templates/News/newsbox2.tpl"); ?></div>
	</div>
		<div class="innerBox footer">
				 
		</div>
	</div>
</div>
<?php } ?>
		</div>
					</div>
					
					<?php
					include("Templates/footer.tpl");
					?>
				</div>
				<div id="ce"></div></div></div></div>
			
</body>
</html>
