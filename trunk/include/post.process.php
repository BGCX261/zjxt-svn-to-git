<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
function PostProcSignin()
{
	if(@$_POST['username']&&@$_POST['password'])
	{
		$username = UtilFuncInComingStringFilter($_POST['username']);
		$password = UtilFuncInComingStringFilter($_POST['password']);
		$user = new user;
		if ($user->Signin($username,$password))
		{
			//登录成功
			header("Location: ./index.php");
		}
		else
		{
			//登录失败
		}
	}
}

function PostProcSignup()
{
	if(@$_POST['username']&&@$_POST['password']&&@$_POST['password2'])
	{
		$username = UtilFuncInComingStringFilter($_POST['username']);
		$password = UtilFuncInComingStringFilter($_POST['password']);
		$password2 = UtilFuncInComingStringFilter($_POST['password2']);
		$user = new user;
		if ($user->Signup($username,$password))
		{
			//登录成功
			header("Location: ./index.php");
		}
		else
		{
			//登录失败
		}
	}
}
?>