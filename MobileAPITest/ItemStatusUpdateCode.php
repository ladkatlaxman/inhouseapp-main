<?php
	require_once 'DBConnect.php';
 	$x = sqlsrv_query($conn, 'insert into tblErrors values(next value for dbo.seqError, \'ssp_CreateWayBillItemStatusCode\', 410, \'Logging in \', GETDATE()');
	$response = array();

	$ScanCode = $_POST['ScanCode'];
	$statusId = (int) $_POST['statusId'];
	$creationDateTime = $_POST['creationDateTime'];
	$branchId = (int) $_POST['branchId'];
	$vehicleRequestId = (int) $_POST['vehicleRequestId'];
	$userId = (int) $_POST['userId'];

	if (isset($statusId) && isset($ScanCode) && isset($creationDateTime) 
		&& isset($branchId) && isset($vehicleRequestId) && isset($userId)) 
	{
		$query = "EXEC [dbo].[ssp_CreateWayBillItemStatusCode] @ScannedId  = '".$ScanCode."', @statusId = ".$statusId.", @creationDateTime = '".$creationDateTime."', @branchId = ".$branchId.", @vehicleRequestId = ".$vehicleRequestId.", @userId = ".$userId."";
		//$r=odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);
		//echo $query ; 
		if($r) 
		{
			$response['success'] = true;
			$response['message'] = 'Added';
			while ($res = sqlsrv_fetch_array($r))
			{
				$response['result'] = $res['Result'];
				$response['WayBillItemId'] = $res['WayBillItemId'];
			}

		}
		else
		{
			$response['success'] = false;
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