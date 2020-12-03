<?php
define('_ADMINEXEC_',1);
session_start();
include(dirname(__FILE__)."/../GameEngine/Protection.php");

include('admin.controller.php');
$controller = new adminController();

?>

