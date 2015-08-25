<?php 
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
function SetSession($name,$value)
{
	$_SESSION[$name]=$value;
	return true;
}
function GetSession($name)
{
	return @$_SESSION[$name];
}
function UnSetSession($name)
{
	unset($_SESSION[$name]);
	return ;
}
?>