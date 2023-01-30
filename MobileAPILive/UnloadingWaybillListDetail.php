<?php
	require_once 'DBConnect.php';
	$response = array();

	$VehicleRequestID = $_POST['VehicleRequestID'];
	$waybillID = $_POST['waybillID'];


	if (isset($waybillID)) 
	{
		$query = "EXEC [dbo].[spMobileAppUnloadingWaybillListDetail] @VehicleRequestID = " . $VehicleRequestID . ", @WaybillID = " . $waybillID . "";
		$r=odbc_exec($conn,$query);

		while ($res=odbc_fetch_array($r))
		{
		
			array_push($response, array('WayBillItemId'=>$res['WayBillItemId'],'vehicleRequestId'=>$res['vehicleRequestId'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'UnloadQty'=>$res['UnloadQty']));
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>