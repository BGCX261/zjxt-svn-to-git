<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
//global configs
require_once "./config/init.conf.php";

//classes
include "base.class.php";
include "db.class.php";
include "Smarty.class.php";

//funcs
include "authorization.func.php";
include "utility.func.php";

//incs
include "session.inc.php";

//processes
include "get.process.php";
include "post.process.php";

//Smarty configs
require_once "./config/smarty.conf.php";
?>