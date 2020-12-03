<h4 class='round spacer'><?php echo PF_GAMEDEV; ?></h4>
<tr class='hover'>
    <table id='member'>
        <?php echo PF_GAMEDEVDESC; ?>
    </table>
    <br>
    <table id='member'><font color='red'>
            <?php echo PF_GAMEDEVDESC2; ?>
    </table>
    </font>
</tr>
<h4 class='round spacer'><?php echo PF_NUMBEROFTROOPS; ?></h4>
<div class='graph' style="background-image:url('stats.php?form=2');">
    <div class='legende'>
        <div class='box' style='background-color:#71D000;'></div><?php echo PF_TOTAL; ?><br/>

        <div class='box' style='background-color:#0061FF;'></div><?php echo AT_REINFORCEMENT; ?></div>
</div>
<h4 class='round spacer'><?php echo PF_RESPROANDPOP; ?></h4>
<div class='graph' style="background-image:url('stats.php?form=3');">
    <div class='legende'>
        <div class='box' style='background-color:#71D000;'></div><?php echo VL_RESOURCE; ?>/4<br/>

        <div class='box' style='background-color:#FFDF00;'></div><?php echo PF_INHABITANTS; ?></div>
</div>
<h4 class='round spacer'><?php echo AL_RANK; ?></h4>
<div class='graph' style="background-image:url('stats.php?form=4');">
</div>
<h4 class='round spacer'><?php echo PF_NUMOFKIILS; ?></h4>
<div class='graph' style="background-image:url('stats.php?form=1');">
    <div class='legende'>
        <div class='box' style='background-color:#71D000;'></div><?php echo PF_TOTAL; ?><br/>

        <div class='box' style='background-color:#FF0000;'></div><?php echo MV_ATTACK; ?></div>
</div>