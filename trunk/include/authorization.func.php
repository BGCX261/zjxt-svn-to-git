<?php 
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
require_once "sql/authorization.sql.php";
function AuthFuncCheckUserSignin($username,$password)
{
	$password = UtilFuncEncryptUserPassword($password);
	$db = new db;
	$user = $db->Get('user',array('username'=>$username,'password'=>$password));
	return @$user['id'];
}

function AuthFuncCheckUserSignup($username,$password)
{
	$password = UtilFuncEncryptUserPassword($password);
	$db = new db;
	$userid = $db->Ins('user',array('username'=>$username,'password'=>$password));
	return @$userid;
}
?>