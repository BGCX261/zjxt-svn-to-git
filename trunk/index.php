<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
require_once "./include/main.inc.php";
global $smarty;

$userid = 0;

if(GetSession('userid'))
{
	$userid = GetSession('userid');
	$smarty->assign("username",GetSession('username'));
}

$smarty->assign("userid", $userid);
$smarty->display('index.tpl');
?>