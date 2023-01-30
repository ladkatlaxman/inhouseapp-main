<?php
	require_once 'DBConnect.php';
	$ItemScans = array();

	$WayBillNo = (int) $_POST['WayBillNo'];

	if (isset($WayBillNo)) 
	{
		$query = "EXEC dbo.ssp_GetWayBillItemsScans @WayBillNo = " . $WayBillNo;  
		$r = sqlsrv_query($conn, $query); 

		if($r) 
		{ 
			while ($res = sqlsrv_fetch_array($r)) 
			{
				array_push($ItemScans, array('SrNo'=>$res['SrNo'], 'ScanCode'=>$res['ScanCode'], 'From'=>$res['From'], 'To'=>$res['To'], 'Qty'=>$res['ItemQty'], 'SrNo'=>$res['SrNo'])); 
			}
	
			$response['Success'] = true; 
		} 
		else 
		{ 
			$response['Success'] = false; 
		} 
	} 
	else 
	{ 
		$response['error'] = true; 
	} 
	$response['ItemScans'] = $ItemScans;

	echo json_encode($response); 
?>