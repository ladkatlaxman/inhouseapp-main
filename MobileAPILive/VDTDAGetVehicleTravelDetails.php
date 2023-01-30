<?php
	require_once 'DBConnect.php'; 

	$VDTVehicleId = $_POST['VDTVehicleId']; 
	$VDTActivityDate = $_POST['VDTActivityDate']; 

	$response['success'] = 'false'; 
	$response['message'] = 'Data Not Set...'; 

	if (isset($VDTVehicleId) && isset($VDTActivityDate)) 
	{ 
		$query = "EXEC [dbo].[ssp_getVDTVehicleDistanceTravel]  @VDTVehicleId = '" . $VDTVehicleId . "', @VDTActivityDate = '" . $VDTActivityDate . "' "; 

		//$r = odbc_exec($conn,$query); 
		$r = sqlsrv_query($conn, $query); 

		//while($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			$response['VDTVehicleDistanceTravelId'] = $res['VDTVehicleDistanceTravelId']; 
			$response['VDTVehicleId'] = $res['VDTVehicleId']; 
			$response['VDTActivityDate'] = $res['VDTActivityDate']; 
			$response['VDTStartKMS'] = $res['VDTStartKMS']; 
			$response['VDTEndingKMS'] = $res['VDTEndingKMS']; 
			$response['NoOfPckgs'] = $res['NoOfPckgs']; 
		} 
		$response['success'] = 'true'; 
		$response['message'] = 'Data has been Set...'; 
	}
	else
	{ 
		$response['success'] = 'false'; 
		$response['message'] = 'Data Not Set...!!!'; 
	} 

	echo json_encode($response); 
?>