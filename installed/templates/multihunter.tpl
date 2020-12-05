<?php
	rename("include/constant.php","../GameEngine/config.php");
    rename("include/connection.php","../GameEngine/Database/connection.php");
	$time = time();
?>
<div id="content" class="login">

<style>

    span.c3 {position: absolute;right:10%}
    span.c2 {position: absolute;left:10%}
    
</style>
<form action="include/multihunter.php" method="post" id="dataform">
    <span>Choose a password for Multihunter:</span>
    <span >
        <input type="text" name="mhpw" id="mhpw" value="123456789" dir="rtl" class="text">
    </span><br /><br />
   	<center>
			<button  type="submit" value="submit" name="submit" id="btn_ok" class="green ">
			<div class="button-container addHoverClick">
				<div class="button-background">
					<div class="buttonStart">
						<div class="buttonEnd">
							<div class="buttonMiddle"></div>
						</div>
					</div>
				</div>
				<div class="button-content">Submit</div>
			</div>
		</button>
    </center>
</form>
    
</div>