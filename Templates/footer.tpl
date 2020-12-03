<?php
if($session->logged_in){
?>
</div>
<div id="servertime" class="stime">
	<?php echo FT_SERVERTIME;?>&nbsp;
	<span id="tp1"><?php echo date('H:i:s'); ?></span>
</div>
<?php
}
?>
<div id='footer'>
	<div id='pageLinks'>
		<a href='../#' target='_blank'><?php echo FT_HOMEPAGE;?></a>
		<a href='../#forum' target='_blank'><?php echo FT_FORUM;?></a>
		<a href='../#links' target='_blank'><?php echo FT_LINKS;?></a>
		<a href='http://t4.answers.travian.com' target='_blank'><?php echo FT_FAQANS;?></a>
		<a href='../#agb' target='_blank'><?php echo FT_TERMS;?></a>
		<a target='blank' class='flink' href='../#spielregeln'><?php echo FT_RULES;?></a>
	</div>
	<p class="copyright"><center> <a href="ymsgr:addfriend?gorz1872"> <b><font color="green" size="1">Travian System by O&#951;&#8467;&#1091; &#969;&#953;&#8467;D</font></b> </a> </center></p>
	</br><center> <a href="ymsgr:addfriend?gorz1872"> <b><font color="green" size="1">استفاده از اسکریپت بدون درج نویسنده حرام میباشد</font></b> </a> </center></p>
</div>