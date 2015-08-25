<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>用户登录</title>
</head>
<body>
<form action="./signin.php" method="post" name="signin" onsubmit="return false;">
	<table>
		<tr><td>用户名</td><td><input type="text" name="username"></input></td></tr>
		<tr><td>密码</td><td><input type="password" name="password"></input></td></tr>
		<tr><td colspan="2"><button onclick="document.signin.submit()">登录</button></td></tr>
	</table>
</form>
</body>
</html>
