<?php 
	require_once 'DBConnect.php'; 
	$response = array(); 
	error_reporting(E_ERROR | E_PARSE); 

	$vehicleRequestId = $_POST['vehicleRequestId']; 
	$branchID = $_POST['BranchID']; 
	$Branches = array(); 

	$response['success'] = false; 
	if (isset($branchID)) 
	{ 
		$query = "EXEC dbo.ssp_GetManifestBranch @vehicleRequestId = '" . $vehicleRequestId . "', @branchId = " . $branchID . " "; 
		$r = sqlsrv_query($conn, $query); 
		//echo $query; 
		$response['success'] = true; 
  		$response['message'] = "BRANCHES"; 

		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($Branches, array('BranchId'=>$res['toBranchID'],'BranchName'=>$res['ToBranchName'])); 
		} 
	} 
	$response['Branches'] = $Branches; 
	echo json_encode($response);
?> 
