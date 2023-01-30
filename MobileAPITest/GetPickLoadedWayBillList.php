<?php
	require_once 'DBConnect.php';
	$waybills = array();

	$branchId = $_POST['BranchId'];
	$vehicleRequestId = $_POST['vehicleRequestId']; 

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_getWaybillLoadedQtyOnVehicleList @vehicleRequestId = " . $vehicleRequestId . ", @branchID = " . $branchId . ", @statusId = 2"; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true;
		$response['message'] = '';

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($waybills, array('wayBillId'=>$res['waybillID'],'WayBillItemId'=>$res['WayBillItemId'],'WayBillNo'=>$res['wayBillNo'],'WaybillDate'=>$res['WaybillDate'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'valueActualWt'=>$res['valueActualWt'],'invoiceNo'=>$res['invoiceNo'],'itemQty'=>$res['itemQty'],'itemQty'=>$res['Qty'],'remQty'=>$res['RemQty']));
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