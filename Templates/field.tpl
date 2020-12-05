<map name='rx' id='rx'>
<?php
$coorarray = array(1=>"180,80,28","269,81,28","338,93,28","122,119,28","235,132,28","292,139,28","377,137,28","62,170,28","143,171,28","333,171,28","420,171,28","70,231,28","143,221,28","279,257,28","401,226,28","174,311,28","265,316,28","355,293,28");
    for ($i = 1; $i <= 18; $i++) {
		$loopsame = $building->isCurrent($i)?1:0;
        if ($loopsame>0 && $building->isLoop($i)) {$doublebuild = 1;}
		$lev = $village->resarray['f'.$i]+($loopsame > 0 ? 2:1)+$doublebuild;
		$uprequire = $building->resourceRequired($i,$village->resarray['f'.$i.'t'],($loopsame > 0 ? 2:1)+$doublebuild);
		$t = $_SESSION['wid'];
		$lvl = $lev - 1;
        echo "<area id=\"BuildStatus".$i."\" href=\"build.php?id=$i\" coords=\"$coorarray[$i]\" shape=\"circle\"
		title=\"".FD_LOADING."\"/>";

?>

<script type="text/javascript">
window.addEvent('domready', function(){
	var element = $('BuildStatus<?php echo $i;?>');
	if (!element){return;}
	var fnbuildTitle = function(){
		element.removeEvent('mouseover', fnbuildTitle);
		Travian.ajax({
			data:{cmd: 'getFieldStatus',data:{id:<?php echo $i;?>}},
			onSuccess: function(data){
				element.setTitle(data.getFieldStatus);
			}
		});
	};
element.addEvent('mouseover', fnbuildTitle);
});
</script>
<?php } ?>
<area href='dorf2.php' coords='250,191,32' shape='circle' title='ساختمان ها'>
</map>
<div id='village_map' class="f<?php echo $village->type; ?>">
<div id='village_circles'></div>
<?php 
for($i=1;$i<=18;$i++){
    if($village->resarray['f'.$i.'t'] != 0){
		$text = '';
		switch($i){
		case 1:$style = 'right:179px;top:78px;';$stylex = 'left:179px;top:78px;';break;
		case 2:$style = 'right:269px;top:79px;';$stylex = 'left:269px;top:77px;';break;
		case 3:$style = 'right:337px;top:91px;';$stylex = 'left:338px;top:89px;';break;
		case 4:$style = 'right:121px;top:117px;';$stylex = 'left:122px;top:115px;';break;
		case 5:$style = 'right:234px;top:130px;';$stylex = 'left:235px;top:128px;';break;
		case 6:$style = 'right:291px;top:137px;';$stylex = 'left:292px;top:135px;';break;
		case 7:$style = 'right:376px;top:135px;';$stylex = 'left:377px;top:133px;';break;
		case 8:$style = 'right:61px;top:168px;';$stylex = 'left:62px;top:166px;';break;
		case 9:$style = 'right:142px;top:169px;';$stylex = 'left:143px;top:167px;';break;
		case 10:$style = 'right:332px;top:169px;';$stylex = 'left:333px;top:167px;';break;
		case 11:$style = 'right:419px;top:169px;';$stylex = 'left:420px;top:167px;';break;
		case 12:$style = 'right:69px;top:229px;';$stylex = 'left:70px;top:227px;';break;
		case 13:$style = 'right:142px;top:219px;';$stylex = 'left:143px;top:217px;';break;
		case 14:$style = 'right:278px;top:255px;';$stylex = 'left:279px;top:253px;';break;
		case 15:$style = 'right:400px;top:224px;';$stylex = 'left:401px;top:222px;';break;
		case 16:$style = 'right:173px;top:309px;';$stylex = 'left:174px;top:307px;';break;
		case 17:$style = 'right:264px;top:314px;';$stylex = 'left:265px;top:312px;';break;
		case 18:$style = 'right:354px;top:291px;';$stylex = 'left:355px;top:289px;';break;
		}
		$cstyle = "underConstruction";
		if($village->resarray['f'.$i] != 0) {
			echo "<div class=\"level colorLayer ".($village->resarray['f'.$i] == 20 ? 'maxLevel' : 'notNow')." gid".$village->resarray['f'.$i.'t']." level".$village->resarray['f'.$i]."\" style=\"".$stylex." \"><div class=\"labelLayer\">".$village->resarray['f'.$i]."</div></div>";
		}else{
			echo "<div class=\"level colorLayer good gid".$village->resarray['f'.$i.'t']." level0\" style=\"".$stylex." \"><div class=\"labelLayer\"></div></div>";
		}
		if ($database->getBuildingByField($t, $i)){
			echo "<div class=\"level colorLayer good ".$cstyle."\" style=\"".$stylex."\"><div class=\"labelLayer\">".$village->resarray['f'.$i]."</div></div>";
		}
    }
}
?>
<img id='resfeld' usemap='#rx' src='img/x.gif' alt=''>
</div>