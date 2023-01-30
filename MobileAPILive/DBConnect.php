<?php
	//$serverName = "148.72.232.166"; //serverName\instanceName
	$serverName = "208.91.198.174"; //serverName\instanceName
	$connectionInfo = array( "Database"=>"dbDexERP", "UID"=>"dexAdmin", "PWD"=>"DexAdmin#09876");
	$conn = sqlsrv_connect( $serverName, $connectionInfo);

	if( $conn ) 
	{
	     //echo "Connection established.<br />";
	}
	else
	{
		echo "Connection could not be established.<br />";
	    die( print_r( sqlsrv_errors(), true));
	}
?>