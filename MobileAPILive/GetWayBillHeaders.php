<?php
	require_once 'DBConnect.php'; 

	$WayBillHeader = array(); 

	$FromDate = $_POST['FromDate']; 
	$ToDate = $_POST['ToDate']; 
	$BranchId = $_POST['BranchId']; 

	$query = "EXEC [dbo].[ssp_ReportWayBillsBookingReport] @FromDate = '" . $FromDate . "', @ToDate = '" . $ToDate . "', @BranchId = '" . $BranchId . "'"; 
	$r = sqlsrv_query($conn, $query); 

	//echo $query; 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($WayBillHeader, array('WayBillNo'=>$res['WayBill No'], 'Date'=>$res['Date'], 'PayMode'=>$res['Pay Mode'], 'CustomerName'=>$res['Customer Name'], 'PickupPIN'=>$res['Pickup PIN'], 'ConsigneeName'=>$res['Consignee Name'], 'DeliveryArea'=>$res['Delivery Area'], 'DeliveryPIN'=>$res['Delivery PIN'], 'DeliveryBranch'=>$res['Delivery Branch'], 'Material'=>$res['Material'], 'Pack'=>$res['Pack'], 'InvoiceNo'=>$res['Invoice No'], 'InvoiceAmount'=>$res['Invoice Amount'], 'Qty'=>$res['Qty'], 'ActualWt'=>$res['Actual Wt'], 'ChargedWt'=>$res['Charged Wt'], 'CreatedDate'=>$res['Created Date'])); 
	} 
	$response['WayBillHeader']  = $WayBillHeader; 

	echo json_encode($response);
?>