<?php
		define('_ADMINEXEC_',1);
        @include ("../../Admin/admin.model.php");
		
        @include ("../../GameEngine/config.php");
        @include ("../../GameEngine/lang/en.php");

        mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
        mysql_select_db(SQL_DB);
		
		$StartNatars = true;
		$admin = new adminModel();
/**
 * Functions
 */
    function generateHash($plainText, $salt = 1){
		$salt = substr($salt, 0, 9);
		return $salt . md5($salt . $plainText);
	}
        if(isset($_POST['mhpw'])) {
        	$password = $_POST['mhpw'];
        	mysql_query("UPDATE " . TB_PREFIX . "users SET password = '" . generateHash($password) . "' WHERE username = 'Multihunter'");
			mysql_query("UPDATE " . TB_PREFIX . "users SET password = '" . generateHash($password) . "' WHERE username = 'Support'");
        	$wid = $admin->getWref(1, 0);
        	$uid = 4;
        	$status = $database->getVillageState($wid);
        	if($status == 0) {
        		$database->setFieldTaken($wid);
        		$database->addVillage($wid, $uid, 'Multihunter', '1');
        		$database->addResourceFields($wid, $database->getVillageType($wid));
        		$database->addUnits($wid);
        		$database->addTech($wid);
        		$database->addABTech($wid);
        	}
        }


if($StartNatars){
		$username = "Natars";
        $password = $_POST['mhpw'];
        $email = "natars@travianx.com";
        $desc = "[#natars]";
		$uid = 2;

        mysql_query("INSERT INTO " . TB_PREFIX . "users (id,username,password,access,email,timestamp,desc2,tribe,location,act,protect,quest,fquest) VALUES ('$uid', 'Natars', '" . generateHash($password) . "', 2, '$email', ".time().", '$desc', 5, '', '', 0, 25, 35)");
        
        $wid = $admin->getWref(0, 0);
        $status = $database->getVillageState($wid);
        if($status == 0) {
        	$database->setFieldTaken($wid);
        	$database->addVillage($wid, $uid, 'Natars', '1');
        	$database->addResourceFields($wid, $database->getVillageType($wid));
        	$database->addUnits($wid);
        	$database->addTech($wid);
        	$database->addABTech($wid);
        }
        mysql_query("UPDATE " . TB_PREFIX . "vdata SET pop = '781' WHERE owner = $uid") or die(mysql_error());
        mysql_query("UPDATE " . TB_PREFIX . "units SET u41 = " . (274700 * SPEED) . ", u42 = " . (995231 * SPEED) . ", u43 = 10000, u44 = " . (3048 * SPEED) . ", u45 = " . (964401 * SPEED) . ", u46 = " . (617602 * SPEED) . ", u47 = " . (6034 * SPEED) . ", u48 = " . (3040 * SPEED) . " , u49 = 1, u50 = 9 WHERE vref = " . $wid . "") or die(mysql_error());
    $status = 0;
	for($i=1;$i<=13;$i++){
		$nareadis = NATARS_MAX;
		do{
			$x = rand(3,intval(floor(NATARS_MAX)));if(rand(1,10)>5)$x = $x*-1;
			$y = rand(3,intval(floor(NATARS_MAX)));if(rand(1,10)>5)$y = $y*-1;
			$dis = sqrt(($x*$x)+($y*$y));
			$wid = $admin->getWref($x, $y);
			$status = $database->getVillageState($wid);
		}while(($dis>$nareadis) || $status!=0);
        if($status == 0) {
        	$database->setFieldTaken($wid);
        	$database->addVillage($wid, $uid, 'Natars', '1');
        	$database->addResourceFields($wid, $database->getVillageType($wid));
        	$database->addUnits($wid);
        	$database->addTech($wid);
        	$database->addABTech($wid);
			mysql_query("UPDATE " . TB_PREFIX . "vdata SET pop = '238' WHERE wref = '$wid'");
			mysql_query("UPDATE " . TB_PREFIX . "vdata SET name = 'WW Village' WHERE wref = '$wid'");
			mysql_query("UPDATE " . TB_PREFIX . "vdata SET capital = 0 WHERE wref = '$wid'");
			mysql_query("UPDATE " . TB_PREFIX . "vdata SET natar = 1 WHERE wref = '$wid'");
			mysql_query("UPDATE " . TB_PREFIX . "units SET u41 = " . (rand(3000, 6000) * SPEED) . ", u42 = " . (rand(4500, 6000) * SPEED) . ", u43 = 10000, u44 = " . (rand(635, 1575) * SPEED) . ", u45 = " . (rand(3600, 5700) * SPEED) . ", u46 = " . (rand(4500, 6000) * SPEED) . ", u47 = " . (rand(1500, 2700) * SPEED) . ", u48 = " . (rand(300, 900) * SPEED) . " , u49 = 0, u50 = 9 WHERE vref = " . $wid . "");
			mysql_query("UPDATE " . TB_PREFIX . "fdata SET f22t = 27, f22 = 10, f28t = 25, f28 = 10, f19t = 23, f19 = 10, f99t = 40, f26 = 0, f26t = 0, f21 = 1, f21t = 15, f39 = 1, f39t = 16 WHERE vref = " . $wid . "");
        }
	}
}

        header("Location: ../index.php?s=5");
exit;