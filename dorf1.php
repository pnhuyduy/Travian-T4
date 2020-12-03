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
    include("GameEngine/Lang/ui/dorf1.php");

    if (COMMENCE > $_SERVER['REQUEST_TIME']) {
        header("Location: logout.php");
    }
    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['ok'])) {
        $database->updateUserField($session->username, 'ok', '0', '0');
        $_SESSION['ok'] = '0';
    }

    if (isset($_GET['newdid'])) {
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['newdid'] = filter_var($_GET['newdid'], FILTER_SANITIZE_MAGIC_QUOTES);
        $t = mysql_query("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '" . $_GET['newdid'] . "' LIMIT 1");
        $row = mysql_fetch_assoc($t);
        if ($row['owner'] == $session->uid) {
            $_SESSION['wid'] = $_GET['newdid'];
        }
        header("Location: " . $_SERVER['PHP_SELF']);
        exit;
    } else {
        $building->procBuild($_GET);
    }

    $time = time();

    /*
    if(isset($_GET['masterbuild']) && $session->userinfo['gold'] >= 1 AND ( ($_SESSION['MASTER'] < $time) || !isset($_SESSION['MASTER']) ) ){
    $_SESSION['MASTER'] = time() + 60;
        function isMax($id,$field,$loop=0) {
            $name = "bid".$id;
            global $$name,$village;
            $dataarray = $$name;

            if($id <= 4) {
                if($village->capital == 1) {
                    return ($village->resarray['f'.$field] == (count($dataarray) - 1 - $loop));
                }
                else {
                    return ($village->resarray['f'.$field] == (count($dataarray) - 11 - $loop));
                }
            }
            else {
                return ($village->resarray['f'.$field] == count($dataarray) - $loop);
            }
        }

        $master = 0;

        for($i=1;$i<=18;$i++){

            $RPA_LEVEL = $village->resarray['f' . $i];
            $FIELD_BID = $village->resarray['f' . $i . 't'];
            $bindicate = isMax($i, $FIELD_BID);
            $maxLvL = sizeof($GLOBALS['bid' . $FIELD_BID])-1;

            if($village->resarray['f'.$i.'t'] < $maxLvL && $session->userinfo['gold'] >= 1){

                if(!in_array($FIELD_BID, array(40, 25, 26)) && !in_array($bindicate, array(1, 10, 11))){
                    if($maxLvL - $RPA_LEVEL){
                        $pop = $cp = 0;
                        $lvl = $RPA_LEVEL+1;
                        //for($ix = 1+$RPA_LEVEL; $ix <= $maxLvL; ++$ix){
                            $pop += $GLOBALS['bid' . $FIELD_BID][$lvl]['pop'];
                            $cp += $GLOBALS['bid' . $FIELD_BID][$lvl]['cp'];
                        //}
                        $database->modifyPop($village->wid, $pop,0);
                        $database->addCP($village->wid, $cp);

                        $uprequire = $building->resourceRequired($i,$village->resarray['f'.$i.'t']);

                        //$time = time()+ $uprequire['time'];

                        $loop = ($bindicate == 9 ? 1 : 0);
                        $loopsame = 0;
                        if($loop == 1) {
                            foreach($building->buildArray as $build) {
                                if($build['field']==$i) {
                                    $loopsame += 1;
                                    $uprequire = $building->resourceRequired($i,$village->resarray['f'.$i.'t'],($loopsame>0?2:1));
                                }
                            }
                            if($session->tribe == 1 || ALLOW_ALL_TRIBE) {
                                if($i >= 19) {
                                    foreach($building->buildArray as $build) {
                                        if($build['field'] >= 19) {
                                            $time = $build['timestamp'] + $uprequire['time'];
                                        }
                                    }
                                }
                                else {
                                    foreach($building->buildArray as $build) {
                                        if($build['field'] <= 18) {
                                            $time = $build['timestamp'] + $uprequire['time'];
                                        }
                                    }
                                }
                            }
                            else {
                                $time = $building->buildArray[0]['timestamp'] + $uprequire['time'];
                            }
                        }
                        $level = $database->getResourceLevel($village->wid);
                        if($master ==0){
                            $time = time();
                            $time = $time+($loop==1?ceil(60/SPEED):0);
                        }else{
                            $time = 2;
                        }
                        $newlevel = $level['f'.$i] + 1 + count($database->getBuildingByField($village->wid,$i));
                        if($database->addBuilding($village->wid,$i,$village->resarray['f'.$i.'t'],$loop,$time,$master,$newlevel)){
                            $database->modifyResource($village->wid,$uprequire['wood'],$uprequire['clay'],$uprequire['iron'],$uprequire['crop'],0);
                            $master=1;
                            //$database->modifyGold($session->uid, 1, 0);
                        }
                    }
                }
            }
        }
        header("Location: dorf1.php");
        exit;
    }
    */
    include "Templates/html.tpl";
?>
<body class="v35 gecko chrome village1 perspectiveResources">
<script type="text/javascript">
    window.ajaxToken = "<?php echo md5($_REQUEST['SERVER_TIME']);?>";
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
                <img class="question" alt="<?php echo HDR_HELP2; ?>" src="img/x.gif">
            </a>

            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <?php
                    require('Templates/heroSide.tpl');
                    require('Templates/Alliance.tpl');
                    require('Templates/infomsg.tpl');
                    require('Templates/links.tpl');
                ?>
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer">
                <?php require('Templates/res.tpl'); ?>
                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php"></a>
                    <a id="answersButton" class="contentTitleButton"
                       href="http://t4.answers.travian.com/index.php?aid=300#go2answer" target="_blank"></a>
                </div>
                <div class="contentContainer">
                    <div id="content" class="village1">
                        <?php
                            require('Templates/field.tpl');
                            if ($building->NewBuilding) {
                                require('Templates/Building.tpl');
                            }
                        ?>
                        <div id="map_details">
                            <?php
                                require 'Templates/movement.tpl';
                                require 'Templates/production.tpl';
                                require 'Templates/troops.tpl';
                            ?>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
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
                    <?php require 'Templates/sideinfo.tpl'; ?>
                </div>
                <?php
                    require 'Templates/multivillage.tpl';
                    require 'Templates/quest.tpl';
                ?>
            </div>
            <div class="clear"></div>
            &#65279;<?php
                require 'Templates/footer.tpl';
            ?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>