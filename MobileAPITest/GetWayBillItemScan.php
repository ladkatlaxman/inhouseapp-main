<?php
	require_once 'DBConnect.php';
	$ItemScans = array();

	$WayBillItemId = (int) $_POST['WayBillItemId'];
	$SrNo = (int) $_POST['SrNo'];

	if (isset($WayBillItemId)) 
	{
		//$query = "EXEC [dbo].[ssp_GetWayBillItemScanCode] @WayBillItemId = " . $WayBillItemId;  
		$query = "EXEC [dbo].[ssp_GetWayBillItemsScans] @WayBillNo = " . $WayBillItemId;  
		if (isset($SrNo)) 
		{
			if($SrNo != 0)
			{
				$query = $query . ", @SrNo = " . $SrNo; 
			}
		}
		$r = sqlsrv_query($conn, $query); 

		if($r) 
		{ 
			while ($res = sqlsrv_fetch_array($r)) 
			{
				array_push($ItemScans, array('SrNo'=>$res['SrNo'], 'ScanCode'=>$res['ScanCode'], 'From'=>$res['From'],'To'=>$res['To'],'Qty'=>$res['Qty'])); 		
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