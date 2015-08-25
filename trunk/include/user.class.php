<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
class user extends base
{
	protected $username;
	private $password;
	public function __construct($id=0)
	{
		parent::__construct();
		if($id>0)
		{
			$this->load($id);
		}
	}
	public function __destruct()
	{
		parent::__destruct();
		unset($this->username);
		unset($this->password);
	}
	public function Signin($username,$password)
	{
		$userid = AuthFuncCheckUserSignin($username,$password);
		if($userid)
		{
			$this->Load($userid);
			SetSession("userid",$this->id);
			SetSession("username",$this->username);
			return true;
		}
		return false;
	}
	public function Signup($username,$password)
	{
		$userid = AuthFuncCheckUserSignup($username,$password);
		if($userid)
		{
			$this->SignIn($username,$password);
			return true;
		}
		return false;
	}
	public function Signout()
	{
		UnSetSession("userid");
		UnSetSession("username");
		$this->__destruct();
	}
	private function Load($userid)
	{
		$db = new db;
		$user = $db->Get('user',$userid);
		if($user)
		{
			$this->id = $userid;
			$this->username = $user['username'];
		}
	}
}
?>