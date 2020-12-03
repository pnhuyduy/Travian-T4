<div class="contentNavi subNavi">
    <div title="" class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="plus.php"><span class="tabItem"><?php echo PL_RETTOPLUS; ?></span></a></div>
    </div>
</div>
<?php
    switch($session->tribe){
        case 1:
            $start = '';
            $end = 1;
            break;
        case 2:
            $start = 1;
            $end = 2;
            break;
        case 3:
            $start = 2;
            $end = 3;
            break;
    }
?>
<table class="plusFunctions" style="background-color:#E6CA2B;" cellpadding="1" cellspacing="1">
<tr>
<td style="background-color:#F5E9AA;font-family:tahoma;text-align:center;" colspan="4" align="center">Buy Animal For Defence <b> THIS VILLAGE </b>(<?php $get = $database->getVillage($village->wid); echo $get['name'];?>)</td>
</tr>

			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr1']['tr1_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr1']['cost'];?></td>
			<td  class="act">
                        <?php
            if(hasGold($plusConfig['tr1']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr1&id=tr1'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>            </td>
		</tr>
			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr2']['tr2_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr2']['cost'];?></td>
			<td  class="act">
                        <?php
            if(hasGold($plusConfig['tr2']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr2&id=tr2'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>            </td>
		</tr>

			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr3']['tr3_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr3']['cost'];?></td>
			<td  class="act">
                        <?php
            if(hasGold($plusConfig['tr3']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr3&id=tr3'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>            </td>
		</tr>

			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr4']['tr4_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr4']['cost'];?></td>
			<td  class="act">
                        <?php
            if(hasGold($plusConfig['tr4']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr4&id=tr4'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>            </td>
		</tr>

			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr5']['tr5_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr5']['cost'];?></td>
			<td  class="act">
                        <?php
            if(hasGold($plusConfig['tr5']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr5&id=tr5'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>            </td>
		</tr>

			<tr>
			<td  class="desc">
<table><tbody><tr align="center">
<td align="center"><center><img class="unit <?php echo 'u'.$start.'1';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_1'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'2';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_2'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'3';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_3'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'4';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_4'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'5';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_5'];?></center></td></tr><tr align="center"><td align="center"><center><img class="unit <?php echo 'u'.$start.'6';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_6'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'7';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_7'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'8';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_8'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$start.'9';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_9'];?></center></td><td align="center"><center><img class="unit <?php echo 'u'.$end.'0';?>" src="img/x.gif"><br><?php echo $plusConfig['tr6']['tr6_10'];?></center></td></tr>
</tbody></table>
			</td>
			<td  class="dur">instant</td>
			<td  class="cost"><img src="img/x.gif" class="gold" alt="<?php echo Travian?> Gold"><?php echo $plusConfig['tr6']['cost'];?></td>
			<td  class="act">
            <?php
            if(hasGold($plusConfig['tr6']['cost'])){
                echo "<button type=\"button\" class=\"green \" value=\"Build\" onclick=\"window.location.href = 'plus.php?selltroops=tr6&id=tr6'; return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Active Now</</div></button>";
            } else {
                echo "<button type=\"button\" class=\"green disabled\" value=\"Low Gold\" onclick=\"(new Event(event)).stop(); return false;\" onfocus=\"$$('button', 'input[type!=hidden]', 'select')[0].focus(); (new Event(event)).stop(); return false;\"><div class=\"button-container addHoverClick\"><div class=\"button-background\"><div class=\"buttonStart\"><div class=\"buttonEnd\"><div class=\"buttonMiddle\"></div></div></div></div><div class=\"button-content\">Low Gold</div></div></button>";
            }
            ?>
			</td>
		</tr>
  </tbody>
</table>
<font color="#c5c5c5" size="1" style="left:3px;position:absolute;top:735px">
	Travian Sell System by <b>SHadoW</b>
</font>