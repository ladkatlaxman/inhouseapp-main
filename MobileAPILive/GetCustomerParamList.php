<?php
	require_once 'DBConnect.php';
	$customerNames = array();

	$branchId = $_POST['BranchID']; 
	$nameParam = $_POST['nameParam']; 

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_GetCustomerList @branchID = " . $branchId . ", @NameParam = '" . $nameParam . "' "; 
		$r = sqlsrv_query($conn, $query);  
		//echo $query; 
		$response['success'] = 'true';
		$response['message'] = '';

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($customerNames, array('CustomerId'=>$res['customerID'], 'CustomerNo'=>$res['CUSTOMER NO'], 'CustomerName'=>$res['customerName'], 'LocId'=>$res['LocId'], 'LocAreaId'=>$res['locAreaID'], 'ContactNo'=>$res['ContactNo'], 'CFTValue'=>$res['CFTValue'], 'Area'=>$res['areaName'], 'Address'=>$res['Address'], 'PINCode'=>$res['locPincode'])); 
		}
		$response['CustomerNames'] = $customerNames; 
	}
	else
	{
		$response['success'] = 'false'; 
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>