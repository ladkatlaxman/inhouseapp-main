<?php 
	require_once 'DBConnect.php'; 
	$consigneeDetails = array(); 

	$ConsigneeId = $_POST['ConsigneeId']; 

	if (isset($ConsigneeId)) 
	{ 
		$query = "EXEC ssp_GetConsigneeDetails @ConsigneeId = " . $ConsigneeId; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true; 
		$response['message'] = ''; 

		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($consigneeDetails, array('consigneename'=>$res['ConsigneeName'], 'contactNo'=>$res['contactNo'], 'locID'=>$res['locID'], 'locPincode'=>$res['locPincode'], 'locAreaID'=>$res['locAreaID'], 'areaName'=>$res['areaName'], 'Address'=>$res['deliveryAddress'], 'branchName'=>$res['branchName'])); 
		} 
		$response['ConsigneeDetails'] = $consigneeDetails; 
	} 
	else 
	{ 
		$response['success'] = false; 
		$response['message'] = 'Data Not Set...'; 
	} 

	echo json_encode($response); 
?> 