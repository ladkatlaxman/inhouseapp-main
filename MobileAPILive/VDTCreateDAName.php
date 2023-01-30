<?php
	require_once 'DBConnect.php';
	$response = array();

	$DAIdentityNumber = $_POST['DAIdentityNumber'];
	$DAFirstName = $_POST['DAFirstName'];
	$DALastName = $_POST['DALastName'];
	$DAUserId = $_POST['DAUserId'];
	$DAActive = 1;

	$response['status'] = false;
	$response['message'] = 'Wrong Credentials';

	if (isset($DAIdentityNumber) && isset($DAFirstName) && isset($DALastName)) 
	{
		$query = "EXEC [dbo].[ssp_createVDTDAName] @DAIdentityNumber = '" . $DAIdentityNumber .  "', @DAFirstName = '" . $DAFirstName . "', @DALastName = '" . $DALastName . "', @DAUserId = '" . $DAUserId . "', @DAActive = '" . $DAActive . "'"; 
		//$r = odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['status'] = true;
			$response['message'] = 'Data Received';
			$response['DAId'] = $res['DAId'];
		}
	}
	else
	{
		$response['status'] = false;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>