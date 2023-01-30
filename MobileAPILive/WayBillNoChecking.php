<?php
	require_once 'DBConnect.php';
	$response = array();
	error_reporting(0);

	$waybillNo = $_POST['waybillNo'];
	$branchID = $_POST['branchID'];

	if (isset($waybillNo) && $waybillNo!=null && isset($branchID) && $branchID!=null) 
	{
		$Checking = array(); 
		//$query1 = "EXEC [dbo].[spMobileAppWayBillNoChecking] @waybillNo=".$waybillNo.",@branchID=".$branchID.""; 
		$query1 = "EXEC [dbo].[ssp_GetWayBillStationaryId]     @waybillNo=".$waybillNo.",@branchID=".$branchID.""; 

		//$r1 = odbc_exec($conn,$query1);
		$r1 = sqlsrv_query($conn, $query1);

		//while($res1=odbc_fetch_array($r1))
		while ($res1 = sqlsrv_fetch_array($r1))
		{
			if ($res1['Count']==1) 
			{
				$response['error'] = false;
				$response['message'] = 'Valid WaybillNo';
			}
			else
			{
				$response['error'] = true;
				$response['message'] = 'Not Valid WaybillNo..' . $branchID . ":" . $waybillNo;
			}
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>