<?php
	require_once 'DBConnect.php';
	$response = array();

	$DAId = $_POST['DAId'];
	$VDTVehicleNumber = $_POST['VDTVehicleNumber'];
	$VDTVehicleActive = 1; 

	$response['success'] = 'false';
	$response['message'] = 'Wrong Credentials';

	if (isset($DAId) && isset($VDTVehicleNumber)) 
	{
		$query = "EXEC [dbo].[ssp_createVDTVehicle] @DAId  = '" . $DAId .  "', @VDTVehicleNumber = '" . $VDTVehicleNumber . "'"; 
		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['success'] = 'true';
			$response['message'] = 'Data Received';
			$response['VDTVehicleId'] = $res['VDTVehicleIdId'];
		}
	}
	else
	{
		$response['success'] = 'false';
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>