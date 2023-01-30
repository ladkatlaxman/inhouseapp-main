<?php
	require_once 'DBConnect.php';
	$waybills = array();

	$branchId = $_POST['BranchId'];
	$vehicleRequestId = $_POST['vehicleRequestId']; 

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_getWaybillLoadedQtyOnVehicleList @vehicleRequestId = " . $vehicleRequestId . ", @BranchId = " . $branchId . ", @statusId = 8 "; 
//echo($query); 
		$response['success'] = true;
		$response['message'] = '';

		$r = sqlsrv_query($conn, $query); 

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($waybills, array('wayBillId'=>$res['waybillID'],'WayBillItemId'=>$res['WayBillItemId'],'WayBillNo'=>$res['wayBillNo'],'WaybillDate'=>$res['WaybillDate'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'valueActualWt'=>$res['valueActualWt'],'invoiceNo'=>$res['InvoiceNo'],'itemQty'=>$res['itemQty'],'itemQty'=>$res['Qty'],'remQty'=>$res['RemQty']));
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