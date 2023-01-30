<?php
	require_once 'DBConnect.php';
	$response = array();

	$VDTVehicleId = $_POST['VDTVehicleId'];
	$VDTActivityDate = $_POST['VDTActivityDate'];
	$VDTStartKMS = $_POST['VDTStartKMS'];
	$VDTEndingKMS = $_POST['VDTEndingKMS'];
	$NoOfPckgs = $_POST['NoOfPckgs'];

	$response['success'] = 'false';
	$response['message'] = 'Wrong Credentials';

	if (isset($VDTVehicleId) && isset($VDTActivityDate) && isset($VDTStartKMS) && isset($VDTEndingKMS) && isset($NoOfPckgs)) 
	{
		$query = "EXEC [dbo].[ssp_createVDTVehicleDistanceTravel]  @VDTVehicleId = '" . $VDTVehicleId .  "', @VDTActivityDate = '" . $VDTActivityDate . "', @VDTStartKMS = '" . $VDTStartKMS . "', @VDTEndingKMS = '" . $VDTEndingKMS . "', @NoOfPckgs = '" . $NoOfPckgs . "'"; 

		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			$response['success'] = 'true'; 
			$response['message'] = 'Data Received'; 
			$response['VDTVehicleDistanceTravelId'] = $res['VDTVehicleDistanceTravelId']; 
		} 
	}
	else
	{
		$response['success'] = 'false';
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>