<?php 
	require_once 'DBConnect.php'; 
	$response = array(); 
	error_reporting(E_ERROR | E_PARSE); 

	$branchID = $_POST['BranchID']; 
	//$status = "DISPATCHED";
	$status = "3";
	$vehicleRequestType = "PD"; 
 
	$Vehicles = array(); 

	if (isset($branchID)) 
	{ 
		$query = "EXEC [dbo].[ssp_GetVehicleList] @branchId = '" . $branchID .  "', @status = '" . $status . "', @vehicleRequestType = '" . $vehicleRequestType . "'"; 
		
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
