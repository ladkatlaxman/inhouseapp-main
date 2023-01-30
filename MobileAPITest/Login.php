<?php
	require_once 'DBConnect.php';
	$response = array();

	$VehicleNo = $_POST['vehicleNo'];
	$mPin = $_POST['mPin'];

	if (isset($VehicleNo) && isset($mPin)) 
	{
		$query = "EXEC [dbo].[spMobileAppLogin] @VehicleNo = '" . $VehicleNo .  "', @mPin = '" . $mPin . "'";
		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['error'] = false;
			$response['VehicleRequestID'] = $res['VehicleRequestID'];
			$response['message'] = $res['status'];
			$response['userID'] = $res['userID'];
			$response['BranchID'] = $res['BranchID'];
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>