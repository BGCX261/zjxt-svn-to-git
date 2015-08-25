<?php
/*IMPORTANT: 注意检查文件字符集是否为UTF-8*/
function GetSql($table,$cols,$order,$desc)
{
	if(!@$cols)
	{
		return ;
	}
	if(!is_array($cols))
	{
		$query = "SELECT * FROM {$table} WHERE id={$cols}";
	}
	else
	{
		$query = "SELECT * FROM {$table} WHERE 1=1";
		foreach($cols as $col => $value)
		{
			$query .= " and {$col}='{$value}'";
		}
	}
	if($order!='id')
	{
		$query .= " order by {$order}";
	}
	if($desc)
	{
		$query .= " desc";
	}
	return $query;
}

function InsSql($table,$cols)
{
	if(!@$cols)
	{
		return ;
	}
	if(!is_array($cols))
	{
		$query = "INSERT INTO {$table} (id) VALUES ('{$cols}')";
	}
	else
	{
		$query = "INSERT INTO {$table} ";

		$key = array();
		$val = array();
		foreach($cols as $col => $value)
		{
			array_push($key,$col);
			array_push($val,$value);
		}

		$colstr = "(";
		$valstr = "(";
		for($i=0;$i<sizeof($cols);)
		{
			$colstr .= "`{$key[$i]}`";
			$valstr .= "'{$val[$i]}'";
			if(++$i!=sizeof($cols))
			{
				$colstr .= ", ";
				$valstr .= ", ";
			}
		}
		$colstr .=") ";
		$valstr .=") ";

		$query = $query.$colstr."VALUES ".$valstr;
	}
	return $query;
}
?>