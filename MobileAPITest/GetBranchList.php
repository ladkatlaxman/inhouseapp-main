<?php
	require_once 'DBConnect.php'; 
	$BranchList = array(); 

	$query = "EXEC [dbo].[ssp_GetBranchList]"; 
	//$r = odbc_exec($conn,$query); 
	$r = sqlsrv_query($conn, $query); 

	//while($res=odbc_fetch_array($r)) 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($BranchList, array('BranchId'=>$res['branchID'], 'BranchName'=>$res['branchName'])); 
	} 
	$response['BranchList']  = $BranchList; 

	echo json_encode($response);
?>