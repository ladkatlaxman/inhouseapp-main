<?php
	require_once 'DBConnect.php';
	$waybills = array();

	$branchId = $_POST['BranchId'];
	$vehicleRequestId = $_POST['vehicleRequestId']; 

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_GetVehicleWayBill @vehicleRequestId = '" . $vehicleRequestId . "', @branchId = '" . $branchId . "'"; 
		$response['success'] = true;
		$response['message'] = '';

		$r = sqlsrv_query($conn, $query); 

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($waybills, array('wayBillId'=>$res['waybillID'],'WayBillItemId'=>$res['WayBillItemId'],'WayBillNo'=>$res['WayBillNo'],'WaybillDate'=>$res['WaybillDate'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'valueActualWt'=>$res['valueActualWt'],'invoiceNo'=>$res['invoiceNo'],'itemQty'=>$res['itemQty'],'remQty'=>$res['TranshipREMQty'])); 
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