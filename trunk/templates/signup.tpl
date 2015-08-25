<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>用户注册</title>
</head>
<body>
<form action="./signup.php" method="post" name="signup" onsubmit="return false;">
	<table>
		<tr><td>用户名</td><td><input type="text" name="username"></input></td></tr>
		<tr><td>密码</td><td><input type="password" name="password"></input></td></tr>
		<tr><td>再输一次</td><td><input type="password" name="password2"></input></td></tr>
		<tr><td colspan="2"><button onclick="document.signup.submit()">注册</button></td></tr>
	</table>
</form>
</body>
</html>
