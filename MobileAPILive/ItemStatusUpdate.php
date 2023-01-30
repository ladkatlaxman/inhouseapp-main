<?php
	require_once 'DBConnect.php';
	$response = array();

	$WayBillItemId = (int) $_POST['WayBillItemId'];
	$statusId = (int) $_POST['statusId'];
	$itemQty = (int) $_POST['itemQty'];
	$creationDateTime = $_POST['creationDateTime'];
	$branchId = (int) $_POST['branchId'];
	$vehicleRequestId = (int) $_POST['vehicleRequestId'];
	$userId = (int) $_POST['userId'];

	if (isset($WayBillItemId) && isset($statusId) && isset($itemQty) && isset($creationDateTime) 
		&& isset($branchId) && isset($vehicleRequestId) && isset($userId)) 
	{
		$query = "EXEC [dbo].[ssp_CreateWaybillItemStatus] @WayBillItemId = ".$WayBillItemId.",@statusId = ".$statusId.",@itemQty = ".$itemQty.",@creationDateTime = '".$creationDateTime."',@branchId = ".$branchId.",@vehicleRequestId = ".$vehicleRequestId.",@userId = ".$userId."";
		//$r=odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		if($r) 
		{
			$response['error'] = false;
			$response['message'] = 'Added';
		}
		else
		{
			$response['error'] = false;
			$response['message'] = 'Not Added';
		}

	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>