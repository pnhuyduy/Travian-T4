<?php
//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             TRAVIANX                                             //
//            Only for advanced users, do not edit if you dont know what are you doing!             //
//                                Made by: Dzoki & Dixie (TravianX)                                 //
//                              - TravianX = Travian Clone Project -                                //
//                                 DO NOT REMOVE COPYRIGHT NOTICE!                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////

if(isset($_GET['c']) && $_GET['c'] == 1) {
echo "<div class=\"headline\"><span class=\"f10 c5\">Error importing database. Check configuration.</span></div><br>";
}
?>
<div id="content" class="login">
<form action="process.php" method="post" id="dataform">
<div class="lbox">
<tr>
<td><span class="f9 c6">Create SQL Structure:</span></td><td>

<button  type="submit" value="submit" name="submit" id="btn_ok" class="green ">
	<div class="button-container addHoverClick">
		<div class="button-background">
			<div class="buttonStart">
				<div class="buttonEnd">
					<div class="buttonMiddle"></div>
				</div>
			</div>
		</div>
		<div class="button-content">Create</div>
	</div>
</button>
</td></tr>

</div>
<input type="hidden" name="substruc" value="1">
</form>
</div>