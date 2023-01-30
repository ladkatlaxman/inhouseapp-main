<?php
	require_once 'DBConnect.php';
	$ItemScans = array();

	$WayBillNo = (int) $_POST['WayBillNo'];
	$SrNo = (int) $_POST['SrNo'];

	if (isset($WayBillNo)) 
	{
		$query = "EXEC [dbo].[ssp_GetWayBillQRCode] @WayBillNo = '" . $WayBillNo. "'";  
		/*if (isset($SrNo)) 
		{
			if($SrNo != 0)
			{
				$query = $query . ", @SrNo = " . $SrNo; 
			}
		}*/
		//echo $query; 
		$r = sqlsrv_query($conn, $query); 

		if($r) 
		{ 
			//echo 'here1'; 
			while ($res = sqlsrv_fetch_array($r)) 
			{
				//echo 'here2'; 
				array_push($ItemScans, array('SrNo'=>$res['SrNo'], 'ScanCode'=>$res['ScanCode'], 'From'=>$res['FromLocation'],'To'=>$res['ToLocation'], 'InvoiceNo'=>$res['InvoiceNo'])); 
			}
			$response['success'] = true; 
		} 
		else 
		{ 
			$response['success'] = false; 
		} 
	} 
	else 
	{ 
		$response['error'] = true; 
	} 
	$response['ItemScans'] = $ItemScans;

	echo json_encode($response); 
?>