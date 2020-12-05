<?php
include("../GameEngine/config.php");
unlink(dirname(dirname(dirname(__FILE__)))."/GameEngine/Prevention/Automation.log");
unlink(dirname(dirname(dirname(__FILE__)))."/GameEngine/Prevention/Automation.pid");
fclose(fopen(dirname(dirname(dirname(__FILE__)))."/GameEngine/Prevention/Automation.log","w"));
fclose(fopen(dirname(dirname(dirname(__FILE__)))."/GameEngine/Prevention/Automation.pid","w"));
?>
<div id="content" class="login">
<div class="headline"><h2>TravianT4 Installation Script</h2></div><br>
<br>
&nbsp;&nbsp; Starting the Automation process<br>
<?php
//$cmd = dirname(__FILE__)."/../../GameEngine/Automation.php --start";
//exec($cmd, $output, $result);
//var_dump($output);
//echo PHP_EOL;
//var_dump($result);

$time = time();
rename("../install/","../installed_".$time);
?>
<br><br>
&nbsp;&nbsp;The installation was completed
    &nbsp;&nbsp;For security installation folder name is automatically changed.<br/><br/>
    &nbsp;&nbsp;The file config.php was replaced.
  
<br /><br />

<div align="center"><font size="4"><a href="<?php echo HOMEPAGE; ?>"> My TravianT4 homepage</font></a>
</div></div>
