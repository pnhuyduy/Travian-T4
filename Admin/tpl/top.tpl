<div>
    <img border="0" src="../img/admin/logoBig.png"/>
    <div>
        <div class="point2"><b><?php echo sprintf(TODAYIS,date('l j F Y')); ?></b></div>
        <div class="point2">
			<?php
			if($_SESSION['access'] == MULTIHUNTER) { 
				$msg = '<b><font color="Blue">Multihunter</font></b>';
			} elseif($_SESSION['access'] == ADMIN){
				$msg = '<b><font color="Red">Administrator</font></b>'; 
			}
			echo sprintf(ADMINWELCOMEMSG,$msg);
			?>
		</div>
        <div class="point2"><?php echo sprintf(IP,$_SERVER['REMOTE_ADDR']); ?></div>
    </div>
</div>