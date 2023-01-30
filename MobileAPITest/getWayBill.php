<?php
	require_once 'DBConnect.php'; 
	$WayBillHeader = array(); 
	$WayBillDetail = array(); 

	
	$WayBillNo = $_POST['WayBillNo']; 
	$query = "EXEC [dbo].[ssp_ReportWaybillStatusHeader] @waybillNo = '" . $WayBillNo . "' "; 
	$r = sqlsrv_query($conn, $query); 
	//echo $query; 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($WayBillHeader, array('Date'=>$res['WaybillDate'], 'Customer'=>$res['CustomerName'], 'Consignee'=>$res['consigneeName'], 'PickFrom'=>$res['pickUpBranchName'], 'DeliveryAt'=>$res['DeliveryBranchName'], 'PickupArea'=>$res['PickupArea'], 'DeliveryArea'=>$res['DelArea'])); 
	} 
	$response['WayBillHeader']  = $WayBillHeader; 

	$query = "EXEC [dbo].[ssp_ReportWaybillStatusDetail] @waybillNo = '" . $WayBillNo . "' ";  
	$r = sqlsrv_query($conn, $query); 

	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($WayBillDetail, array('Material'=>$res['Material'], 'Package'=>$res['Pack'], 'Dimension'=>$res['Size'], 'CFT'=>$res['CFT'], 'Weight'=>$res['Weight'], 'Quantity'=>$res['Item Qty'], 'MoveOn'=>$res['Vehicle Date'], 'Status'=>$res['Status'], 'Stage'=>$res['STAGE'], 'Branch'=>$res['Branch'])); 
	} 
	$response['WayBillDetail']  = $WayBillDetail; 

	echo json_encode($response);
?>