<?php
	require_once 'DBConnect.php'; 
	$StateList = array(); 

	$query = "EXEC [dbo].[ssp_GetStateList]"; 	
	//$r = odbc_exec($conn,$query); 
	$r = sqlsrv_query($conn, $query); 

	//while($res=odbc_fetch_array($r)) 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($StateList, array('StateId'=>$res['stateId'], 'StateName'=>$res['stateName'])); 
	} 
	$response['StateList']  = $StateList; 

	echo json_encode($response);
?>