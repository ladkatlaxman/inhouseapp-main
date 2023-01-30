<?php
	require_once 'DBConnect.php';
	$response = array();

	$UserName = $_POST['username'];
	$PassWord = $_POST['password'];

	$response['status'] = false;
	$response['message'] = 'Wrong Credentials';
	if (isset($UserName) && isset($PassWord)) 
	{
		$query = "EXEC [dbo].[ssp_SessionData] @UserName = '" . $UserName .  "', @PassWord = '" . $PassWord . "'";
		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['status'] = true;
			$response['message'] = 'Data Received';
			$response['userId'] = $res['userID'];
		}
	}
	else
	{
		$response['status'] = false;
		$response['message'] = 'Data Not Set...';
	}
	//$response['response'] = $response;

	echo json_encode($response);
?>