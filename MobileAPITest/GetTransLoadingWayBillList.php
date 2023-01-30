<?php
	require_once 'DBConnect.php';
	$waybills = array();

	$branchId = $_POST['BranchId'];
	$vehicleRequestId = $_POST['vehicleRequestId']; 
	$manifestBranchId = $_POST['manifestBranchId']; 


	if (isset($branchId)) 
	{
		$query = "EXEC ssp_GetManifestWayBillItems @vehicleRequestId = '" . $vehicleRequestId . "', @branchId = '" . $branchId . "', @manifestBranchId = '" . $manifestBranchId . "' "; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true;
		$response['message'] = '';
		while ($res = sqlsrv_fetch_array($r)) 
		{
			$remQty = (int)$res['3'] + (int)$res['5'] + (int)$res['7']; 
			array_push($waybills, array('wayBillId'=>$res['waybillID'],'WayBillItemId'=>$res['WayBillItemId'],'WayBillNo'=>$res['waybillNo'],'WaybillDate'=>$res['WaybillDate'],'materialName'=>$res['materialName'],'typeOfPackage'=>$res['typeOfPackage'],'valueActualWt'=>$res['valueActualWt'],'invoiceNo'=>$res['InvoiceNo'],'itemQty'=>$res['ItemQty'],'remQty'=>$remQty)); 
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