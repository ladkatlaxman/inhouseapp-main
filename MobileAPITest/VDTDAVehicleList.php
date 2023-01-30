<?php
	require_once 'DBConnect.php'; 
	$daVehicleList = array(); 

	$DAId = $_POST['DAId']; 

	$response['success'] = 'false'; 
	$response['message'] = 'Data Not Set...'; 

	if (isset($DAId)) 
	{ 
		$query = "EXEC [dbo].[ssp_GetVDTDAVehicle]  @DAId = '" . $DAId . "' "; 
		//$r = odbc_exec($conn,$query); 
		$r = sqlsrv_query($conn, $query); 

		//while($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($daVehicleList, array('VDTVehicleId'=>$res['VDTVehicleId'], 'VDTVehicleNumber'=>$res['VDTVehicleNumber'])); 
		} 
		$response['success'] = 'true'; 
		$response['message'] = 'Data has been Set...'; 
		$response['daVehicleList']  = $daVehicleList; 
	}
	else
	{
		$response['success'] = 'false';
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>