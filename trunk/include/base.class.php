<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
class base
{
	public $id;
	protected function __construct()
	{
		$this->id=0;
	}
	protected function __destruct()
	{
		unset($this->id);
	}
}
require_once "user.class.php";
?>