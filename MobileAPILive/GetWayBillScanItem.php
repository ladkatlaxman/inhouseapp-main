<?php
	require_once 'DBConnect.php';
	$WayBillItem = array();

	$ScanCode = $_POST['ScanCode'];


	if (isset($ScanCode)) 
	{
		$query = "EXEC [dbo].[ssp_GetWayBillScanCode] @ScanCode = '" . $ScanCode . "' "; 
		//echo($query); 
		$r = sqlsrv_query($conn, $query); 

		if($r) 
		{ 
			while ($res = sqlsrv_fetch_array($r)) 
			{
				array_push($WayBillItem, array('SrNo'=>$res['SrNo'], 'WayBillItemId'=>$res['WayBillItemId'])); 	
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
	$response['WayBillItem'] = $WayBillItem; 

	echo json_encode($response); 
?>