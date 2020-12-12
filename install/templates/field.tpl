<?php
//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             TRAVIANX                                             //
//            Only for advanced users, do not edit if you dont know what are you doing!             //
//                                Made by: Dzoki & Dixie (TravianX)                                 //
//                              - TravianX = Travian Clone Project -                                //
//                                 DO NOT REMOVE COPYRIGHT NOTICE!                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////

if(isset($_GET['c']) && $_GET['c'] == 1) {
echo "<div class=\"headline\"><span class=\"f10 c5\">Error creating wdata. Check configuration or file.</span></div><br>";
}
?>
<script type="text/javascript">
	function goAjax(){
		//var creatbtn = document.getElementById('creatbtn');
		//$('creatbtn').setStyle('visiblity','hidden');
		//alert('hi');
		return true;
	}
</script>
<div id="content" class="login">
	<form action="process.php" method="post" id="dataform" onsubmit="return goAjax();">
		<div class="lbox">
			<tr>
				<td>
					<span class="f9 c6">Create World Data:</span>
				</td>
				<td>
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
				</td>
			</tr>
			<br /><br />
			<font color="Red"><b>Warning:</b> This can take some time. Do not click, just wait till the next page has been loaded!</font>
		</div>
		<input type="hidden" name="subwdata" value="1">
	</form>
</div>
