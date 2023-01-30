<?php
	require_once 'DBConnect.php';
	$response = array();

	$branchID = $_POST['branchID'];

	if (isset($branchID)) 
	{
		$waybillNos = array();
		$query = "EXEC [dbo].[ssp_GetCurrentWayBIllNo] @branchID = " . $branchID . "";

		//$r1 = odbc_exec($conn,$query1);
		$r = sqlsrv_query($conn, $query);

		//while($res1=odbc_fetch_array($r1))
		while ($res = sqlsrv_fetch_array($r)) 
		{
			//array_push($waybillNos,array('error'=>false,'WayBillStationaryId'=>$res1['WayBillStationaryId'],'currentNo'=>$res1['currentNo']));
			//array_push($response, 'currentNo'=>$res1['WaybillNo']);
			$response['currentNo'] = $res['WaybillNo']; 
		}
		//array_push($response,array('waybillNos'=>$waybillNos));
		$response['success'] = true;
		$response['message'] = 'number Set';
	}
	else
	{
		$response['success'] = false;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>