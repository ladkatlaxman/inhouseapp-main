<?php
	require_once 'DBConnect.php';
	$response = array();

	$WayBillNo = $_POST['WayBillNo'];

	if (isset($WayBillNo)) 
	{
		$query = "EXEC [dbo].[ssp_CreatePODUpdate] '" . $WayBillNo .  "'";
		//$r=odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['result'] = $res['RESULT']; 
		}
	}
	else
	{
		$response['result'] = 'NONE'; 
	}

	echo json_encode($response);
?>