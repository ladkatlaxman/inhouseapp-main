<?php
	require_once 'DBConnect.php';
	$response = array();

	$VehicleRequestID = $_POST['VehicleRequestID'];

	if (isset($VehicleRequestID)) 
	{
		$query = "EXEC [dbo].[spMobileAppUnloadingWaybillList] @VehicleRequestID = ".$VehicleRequestID."";
		$r=odbc_exec($conn,$query);

		while ($res=odbc_fetch_array($r))
		{
		
			array_push($response, array('waybillID'=>$res['waybillID'],'wayBillNo'=>$res['wayBillNo'],'createdDateTime'=>$res['createdDateTime']));
		}
	}
	
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>