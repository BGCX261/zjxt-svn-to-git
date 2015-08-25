<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
function GetProcSignout()
{
	$user = new user;
	$user->Signout();
	header("Location: ./index.php");
}

?>