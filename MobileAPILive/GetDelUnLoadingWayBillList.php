<?php
	require_once 'DBConnect.php';
	$waybills = array();

	$vehicleRequestId = $_POST['vehicleRequestId']; 
	$BranchId = $_POST['BranchId']; 

	if (isset($BranchId)) 
	{
		$query = "EXEC ssp_GetVehicleWayBill @vehicleRequestId = " . $vehicleRequestId . ", @branchID = " . $BranchId ; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true;
		$response['message'] = '';

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($waybills, array('wayBillId'=>$res['waybillID'],'WayBillItemId'=>$res['WayBillItemId'],'WayBillNo'=>$res['WayBillNo'],'WaybillDate'=>$res['WaybillDate'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'valueActualWt'=>$res['valueActualWt'],'invoiceNo'=>$res['invoiceNo'],'itemQty'=>$res['itemQty'],'itemQty'=>$res['itemQty'],'remQty'=>$res['DelREMQty']));
		}
		$response['WayBills'] = $waybills; 
	}
	else
	{
		$response['success'] = false;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>