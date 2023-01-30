<?php
	require_once 'DBConnect.php';
	$AccessList = array();

	$userId = $_POST['UserId'];

	if (isset($userId)) 
	{
		$query = "EXEC ssp_GetAccessPageListByUserID @userId = '" . $userId .  "'"; 
		$r = sqlsrv_query($conn, $query);

		while ($res = sqlsrv_fetch_array($r)) 
		{ 

			array_push($AccessList, array('AccessMenu'=>$res['AccessMenuName'], 'AccessName'=>$res['AccessName']));
		} 
		$response['success'] = true; 
		$response['message'] = 'Data has been Set...'; 
		$response['Access'] = $AccessList; 
	} 
	else 
	{ 
		$response['success'] = false; 
		$response['message'] = 'Data Not Set...'; 
	}

	echo json_encode($response);
?>