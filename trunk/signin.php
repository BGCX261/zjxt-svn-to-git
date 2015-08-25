<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
require_once "./include/main.inc.php";
PostProcSignin();
$smarty = new Smarty;
$smarty->display('signin.tpl');
?>