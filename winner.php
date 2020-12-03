<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
include("GameEngine/Protection.php");
include("GameEngine/Village.php");
$start = $generator->pageLoadTimeStart();
if(isset($_GET['newdid'])) {
	$_SESSION['wid'] = $_GET['newdid'];
	header("Location: ".$_SERVER['PHP_SELF']);
}
else {
	$building->procBuild($_GET);
}
include "Templates/html.tpl";

## Get Rankings for Ranking Section
$sql = $ranking->procUsersRanking(); $pop[] = mysql_fetch_assoc($sql);$pop[] = mysql_fetch_assoc($sql); $pop[] = mysql_fetch_assoc($sql);
$sql = $ranking->procUsersAttRanking(); $attacker[] = mysql_fetch_assoc($sql); $attacker[] = mysql_fetch_assoc($sql); $attacker[] = mysql_fetch_assoc($sql);
$sql = $ranking->procUsersDefRanking(); $defender[] = mysql_fetch_assoc($sql); $defender[] = mysql_fetch_assoc($sql); $defender[] = mysql_fetch_assoc($sql);

## Get WW Winner Details
$sql = mysql_fetch_assoc(mysql_query("SELECT vref FROM ".TB_PREFIX."fdata WHERE f99 = '100' and f99t = '40'"));
$vref = $sql['vref'];

$sql = mysql_fetch_assoc(mysql_query("SELECT name FROM ".TB_PREFIX."vdata WHERE wref = '$vref'"));
$winningvillagename = $sql['name'];

$sql = mysql_fetch_assoc(mysql_query("SELECT owner FROM ".TB_PREFIX."vdata WHERE wref = '$vref'"));
$owner = $sql['owner'];

$sql = mysql_fetch_assoc(mysql_query("SELECT username FROM ".TB_PREFIX."users WHERE id = '$owner'"));
$username = $sql['username'];

$sql = mysql_fetch_assoc(mysql_query("SELECT alliance FROM ".TB_PREFIX."users WHERE id = '$owner'"));
$allianceid = $sql['alliance'];

$sql = mysql_fetch_assoc(mysql_query("SELECT name, tag FROM ".TB_PREFIX."alidata WHERE id = '$allianceid'"));
$winningalliance = $sql;

$sql = mysql_fetch_assoc(mysql_query("SELECT tag FROM ".TB_PREFIX."alidata WHERE id = '$allianceid'"));
$winningalliancetag = $sql['tag'];

$winner = $database->hasWinner();

if($winner){
?>
<body class='v35 gecko universal perspectiveResources'>
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
    <div id="headerBar"></div>
    <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>
        <?php
            include('Templates/Header.tpl');
        ?>
        <div id="center">
            <a id="ingameManual" href="help.php">
                <img class="question" alt="Help" src="img/x.gif">
            </a>

            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <?php
                    include('Templates/heroSide.tpl');
                    include('Templates/Alliance.tpl');
                    include('Templates/infomsg.tpl');
                    include('Templates/links.tpl');
                ?>
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer">
                <?php include('Templates/res.tpl'); ?>
                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">&nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank" title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="universal">
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
<img src="gpack/travian_4.4-TomBox/img/g/g40_100-<?php echo DIRECTION;?>.png" <?php if (DIRECTION=='ltr') {echo 'align="right"';} else {echo 'align="left"';}?> style="padding-top: 40px;">
<p>
<?php 
	echo sprintf(WINNER_STR,SERVER_NAME,$vref,$generator->getMapCheck($vref),$winningvillagename,date('H:i:s',WINMOMENT),date('Y-m-d',WINMOMENT),$allianceid,$winningalliancetag,$owner,$username,$owner,$username,$pop[0]['userid'],$pop[0]['totalvillages'],$pop[0]['totalpop'],$pop[0]['username'],
	$pop[1]['userid'],$pop[1]['totalvillages'],$pop[1]['totalpop'],$pop[1]['username'],
	$pop[2]['userid'],$pop[2]['totalvillages'],$pop[2]['totalpop'],$pop[2]['username'],
	$attacker[0]['userid'],$attacker[0]['totalvillages'],$attacker[0]['apall'],$attacker[0]['username'],
	$defender[0]['userid'],$defender[0]['totalvillages'],$defender[0]['dpall'],$defender[0]['username'],SERVER_NAME);

?>

</div>
                    <div class="clear"></div>
                </div>
                <div class='contentFooter'>&nbsp;</div>
            </div>
            <div id="sidebarAfterContent" class="sidebar afterContent">
                <div id="sidebarBoxActiveVillage" class="sidebarBox ">
                    <div class="sidebarBoxBaseBox">
                        <div class="baseBox baseBoxTop">
                            <div class="baseBox baseBoxBottom">
                                <div class="baseBox baseBoxCenter"></div>
                            </div>
                        </div>
                    </div>
                    <?php include 'Templates/sideinfo.tpl'; ?>
                </div>
                <?php
                    include 'Templates/multivillage.tpl';
                    include 'Templates/quest.tpl';
                ?>
            </div>
            <div class="clear"></div>
            <?php
                include 'Templates/footer.tpl';
            ?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>
<?php
}else{
	header("Location: dorf1.php");
}
?>
