<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       Protection.php                                              ##
##  Developed by:  Jok3r                                                       ##
##  License:       TTWar Project                                               ##
##  Copyright:     TTWar    (c) 2010-2013. All rights reserved.                ##
##                                                                             ##
#################################################################################

foreach($_POST as $k=>$v) {
	if(!is_array($_POST[$k])) {
		$_POST[$k] = htmlspecialchars(get_magic_quotes_gpc()?$v:addslashes($v));
	} else {
		foreach($_POST[$k] as $subk=>$subv){
			if(!is_array($_POST[$k][$subk])) $_POST[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc()?$subv:addslashes($subv));
		}
	}
}
foreach($_GET as $k=>$v){
	if(!is_array($_GET[$k])) {
		$_GET[$k] = htmlspecialchars(get_magic_quotes_gpc()?$v:addslashes($v));
	} else {
		foreach($_GET[$k] as $subk=>$subv){
			if(!is_array($_GET[$k][$subk])) $_GET[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc()?$subv:addslashes($subv));
		}
	}
}
foreach($_COOKIE as $k=>$v) {
	if(!is_array($_COOKIE[$k])) {
		$_COOKIE[$k] = htmlspecialchars(get_magic_quotes_gpc()?$v:addslashes($v));
	} else {
		foreach($_COOKIE[$k] as $subk=>$subv){
			if(!is_array($_COOKIE[$k][$subk])) $_COOKIE[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc()?$subv:addslashes($subv));
		}
	}
}
if (isset($_SESSION)){
	if(!is_array($_SESSION[$k])) {
		$_SESSION[$k] = addslashes($v);
	} else {
		foreach($_SESSION[$k] as $subk=>$subv){
			if(!is_array($_SESSION[$k][$subk])) $_SESSION[$k][$subk] = addslashes($subv);
		}
	}
}
?>
