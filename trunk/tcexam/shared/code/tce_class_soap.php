<?php
//============================================================+
// File name   : tce_class_soap.php
// Begin       : 2011-10-07
// Last Update : 2011-10-08
//
// Description : User-level SOAP class.
//
// Author: LV Xinyan
//============================================================+

/**
 */

class soap
{
	private $wsdl;
	private $header;
	private $elements;
	private $call;
	private $response;
	public function __construct()
	{
		;
	}
	public function __destruct()
	{
		$this->wsdl = null;
		$this->header = null;
		$this->elements = null;
		$this->call = null;
		$this->response = null;
		unset($this->wsdl);
		unset($this->header);
		unset($this->elements);
		unset($this->call);
		unset($this->response);
	}
	/**
	 *
	 * Data struct & parameters:
	 * $wsdl: string SOAP服务的WSDL路径
	 * $header: array ('namespace'=>string namespace,'name'=>string name,'data'=>mixed data,'mustunderstand'=>bool mustunderstand)
	 * $elements: array (elements)
	 * $call: string 需要调用的服务
	 * $response: string 获取调用服务的返回
	 * 
	 */
	public function setSoap($wsdl,$header,$elements,$call,$response)
	{
		$this->wsdl=$wsdl; //MUST
		$this->header=$header; //
		$this->elements=$elements; //MUST
		$this->call=$call; //MUST
		$this->response=$response; //MUST
	}
	public function callSoap()
	{
		$soapClient=new SoapClient($this->wsdl);
		$arrSoapHeader=$this->header;
		if ($arrSoapHeader != null)
		{
			$soapHeader = new SoapHeader($arrSoapHeader["namespace"], $arrSoapHeader["name"], $arrSoapHeader["data"], $arrSoapHeader["understand"]);
		}
		else
		{
			$soapHeader = null;
		}
		$arrSoapElement = $this->elements;
		$SoapReturn = $soapClient->__soapcall($this->call,$prarm1=array($arrSoapElement), null, $soapHeader);
		unset($soapHeader);
		unset($soapClient);
		eval("\$return = \$SoapReturn->".$this->response.";");
		//$return = $SoapReturn->getWeatherbyCityNameResult;
		return $return;
	}
}

//============================================================+
// END OF FILE
//============================================================+