<?php
	require_once 'DBConnect.php';
	$response = array();

	$type = "WAYBILL"; //$_POST['type'];

	$RateTypes = array();

	$query = "EXEC [dbo].[ssp_GetRateType] @type = " . $type ; 
	//$r1 = odbc_exec($conn,$query); 
	$r = sqlsrv_query($conn, $query);

	//while($res = odbc_fetch_array($r)) 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($RateTypes, array('RateTypeId'=>$res['RateTypeId'], 'RateTypeName'=>$res['RateTypeName'], 'RateTypeValue'=>$res['RateTypeValue'])); 
	} 

	$response['RateTypes'] = $RateTypes; 
	echo json_encode($response);
?>