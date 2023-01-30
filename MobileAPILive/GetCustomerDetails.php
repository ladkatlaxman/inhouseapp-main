<?php 
	require_once 'DBConnect.php'; 
	$consignorDetails = array(); 

	$ConsignorId = $_POST['CustomerId']; 
	$BranchId = $_POST['BranchID'];

	if (isset($ConsignorId)) 
	{ 
		$query = "EXEC ssp_GetPartyCustomerDetails @customerId = '" . $ConsignorId . "', @BranchId = '" . $BranchId . "' "; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true; 
		$response['message'] = ''; 

		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($consignorDetails, array('ConsignorName'=>$res['customerName'], 'contactNo'=>$res['customerContactNo'], 'locID'=>$res['locID'], 'locPincode'=>$res['locPincode'], 'locAreaID'=>$res['locAreaID'], 'areaName'=>$res['areaName'], 'Address'=>$res['billingAddress'], 'CFTValue'=>$res['CFTValue'])); 
		} 
		$response['ConsignorDetails'] = $consignorDetails; 
	} 
	else 
	{ 
		$response['success'] = false; 
		$response['message'] = 'Data Not Set...'; 
	} 

	echo json_encode($response); 
?> 