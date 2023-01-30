<?php
	require_once 'DBConnect.php';
	$response = array();

	$WayBillItemId = (int) $_POST['WayBillItemId'];
	$SrNo = (int) $_POST['SrNo'];
	$ScanCode = $_POST['ScanCode'];

	if (isset($WayBillItemId) && isset($SrNo) && isset($ScanCode)) 
	{
		$query = "EXEC [dbo].[ssp_CreateWayBillItemScanCode] @WayBillItemId = " . $WayBillItemId . ", @SrNo = " . $SrNo . ", @ScanCode = '". $ScanCode . "' ";
		//$r=odbc_exec($conn,$query);

		$r = sqlsrv_query($conn, $query);

		if($r) 
		{ 
			$response['Success'] = true; 
			$response['message'] = 'Added'; 
		} 
		else 
		{ 
			$response['Success'] = false; 
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