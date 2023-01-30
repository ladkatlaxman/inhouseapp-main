<?php
	require_once 'DBConnect.php';
	$response = array();

	$AppVersionID = $_POST['AppVersionID'];

	$response['success'] = 'false';
	$response['message'] = 'Wrong Credentials';

	if (isset($AppVersionID)) 
	{
		$query = "EXEC [dbo].[ssp_GetAppVersion] @AppVersionID = '" . $AppVersionID .  "'"; 
		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['success'] = 'true';
			$response['message'] = 'Data Received';
			$response['AppVer'] = $res['AppVer'];
		}
	}
	else
	{
		$response['success'] = 'false';
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>