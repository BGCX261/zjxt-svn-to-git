<?php
include "../config/tce_paths.php";
if(@$_GET['f'])
{
	header("Location: ../../admin/code/tce_select_mediafile.php?d=".urlencode(K_PATH_CACHE."upload/")."&f=".urlencode(K_PATH_CACHE."upload/").urldecode($_GET['f'])."&v=0&frm=form_subjecteditor&fld=subject_description");
}
?>