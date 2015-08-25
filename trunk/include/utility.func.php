<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
include "./config/util.conf.php";
function UtilFuncEncryptUserPassword($strPwd)
{
	global $userPasswordEncryptCode;
	return md5(sha1($strPwd).$userPasswordEncryptCode);
}

function UtilFuncInComingStringFilter($strIn)
{
	return addslashes($strIn);
}

function UtilFuncOutGoingStringFilter($strOut)
{
	return htmlspecialchars($strOut);
}
?>