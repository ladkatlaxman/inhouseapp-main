<?php 
	require_once 'DBConnect.php'; 
	$response = array(); 
	error_reporting(E_ERROR | E_PARSE); 

	$branchID = $_POST['BranchID']; 
	$status = 'DISPATCHED'; 
	$Vehicles = array(); 

	if (isset($branchID)) 
	{ 
		$query = "EXEC [dbo].[ssp_GetVehicleList] @branchId = '" . $branchID .  "', @Status = 4, @vehicleRequestType = 'RT'"; 

		$r = sqlsrv_query($conn, $query); 

		$response['success'] = false; 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			$response['success'] = true; 
	  		$response['message'] = "VEHICLES"; 

			array_push($Vehicles, array('vehicleRequestId'=>$res['VehicleRequestID'],'vehicleNo'=>$res['vehicleNo'])); 
		} 
	} 
	$response['Vehicles'] = $Vehicles; 
	echo json_encode($response);
?> 
