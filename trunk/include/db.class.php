<?php 
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
class db
{
	private $conn;
	private $tablepre;
	private $result;
	public function __construct()
	{
		include "./config/db.conf.php";
		$this->conn = new mysqli($dbConfig['host'], $dbConfig['user'], $dbConfig['password'], $dbConfig['schema'], $dbConfig['port']);
		$this->tablepre = $dbConfig['prefix'];
		//Clear the config array, for security reasons.
		$dbConfig = array();
		unset($dbConfig);
		if (mysqli_connect_errno())
		{
			die("Error: Cannot connect to database.");
			return false;
		}
		if (!$this->conn->set_charset("utf8"))
		{
			die("Error: Character set utf8 not found.");
		}
		require_once "sql/db.sql.php";
	}
	public function __destruct()
	{
		$this->conn->close();
	}
	//Database CRUD operation functions
	/*	
	Parameters:
		String $table: the name of table
		Array $cols
	*/
	public function Ins($table,$cols)
	{
		$table = $this->tablepre.$table;
		$this->result = $this->conn->query(InsSql($table,$cols));
		if($this->result)
			return $this->conn->insert_id;
		return ;
	}
	public function Get($table,$cols,$order='id',$desc=false)
	{
		$table = $this->tablepre.$table;
		$this->result = $this->conn->query(GetSql($table,$cols,$order,$desc));
		if ($this->result->num_rows == 1)
		{
			return $this->result->fetch_assoc();
		}
		$results = array();
		while ($result = $this->result->fetch_assoc())
		{
			array_push ($results, $result);
		}
		return $results;
	}
	public function Set($table,$src_cols,$dest_cols)
	{
		$table = $this->tablepre.$table;
		return ;
	}
	public function Del($table,$cols)
	{
		$table = $this->tablepre.$table;
		return ;
	}
}
?>