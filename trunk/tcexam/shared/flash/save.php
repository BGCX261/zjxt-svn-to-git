<?php
$filename = trim(com_create_guid(),"{}").".jpg";
$f=fopen("../../cache/upload/".$filename,"w");
fwrite($f,$HTTP_RAW_POST_DATA);
fclose($f);
echo $filename;
?>