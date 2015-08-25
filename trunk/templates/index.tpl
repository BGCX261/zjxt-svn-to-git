<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
</head>
<body>
<p>正在建设中...</p>
<!--{if $userid>0}-->
<p>欢迎您 <!--{$username}--> <a href="./signout.php">注销</a></p>
<!--{else}-->
<p>用户未登录 <a href="./signin.php">登录</a>/<a href="./signup.php">注册</a></p>
<!--{/if}-->
</body>
</html>
