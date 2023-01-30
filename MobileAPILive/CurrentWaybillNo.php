<?php
	require_once 'DBConnect.php';
	$response = array();

	$branchID = $_POST['branchID'];

	if (isset($branchID)) 
	{
		$waybillNos = array();
		//$query1 = "EXEC [dbo].[spMobileAppCurrentWayBillNo] @branchID=".$branchID."";
		$query1 = "EXEC [dbo].[ssp_GetCurrentWayBIllNo] @branchID = " . $branchID . "";

		//$r1 = odbc_exec($conn,$query1);
		$r1 = sqlsrv_query($conn, $query1);

		//while($res1=odbc_fetch_array($r1))
		while ($res1 = sqlsrv_fetch_array($r1)) 
		{
			//array_push($waybillNos,array('error'=>false,'WayBillStationaryId'=>$res1['WayBillStationaryId'],'currentNo'=>$res1['currentNo']));
			array_push($waybillNos,array('error'=>false,'currentNo'=>$res1['WaybillNo']));

		}
		array_push($response,array('waybillNos'=>$waybillNos));
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>