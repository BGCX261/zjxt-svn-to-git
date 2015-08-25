<?php
//============================================================+
// File name   : tce_page_weather.php
// Begin       : 2010-10-07
// Last Update : 2010-10-08
//
// Description : Display weather
//
// Author: LV Xinyan
//
//============================================================+

/**
 * @file
 * Display weather.
 * @package com.tecnick.tcexam.shared
 * @author LV Xinyan
 * @since 2010-10-07
 */
require_once ("tce_class_soap.php");
$sms = new soap;
$header = null;
$elements = array('theCityName'=>'上海');
$sms->setSoap("http://www.webxml.com.cn/WebServices/WeatherWebService.asmx?WSDL",$header,$elements,"getWeatherbyCityName","getWeatherbyCityNameResult");
$r = $sms->callSoap();
if($r)
{
	echo '<div style="margin-top:-4px;">'.K_NEWLINE;
	echo '<span style="color:#fff" title="'.$r->string[13].$r->string[12].'">'.$r->string[1].' - '.$r->string[6].'<img src="../../images/weather/'.$r->string[8].'" alt=""/>'.$r->string[5].'</span>'.K_NEWLINE;
	echo '</div>'.K_NEWLINE;
}

//============================================================+
// END OF FILE
//============================================================+
