<?php
	require_once 'DBConnect.php'; 
	$daList = array(); 

	$userId = $_POST['userId']; 

	$response['success'] = 'false'; 
	$response['message'] = 'Data Not Set...'; 

	if (isset($userId)) 
	{ 
		$query = "EXEC [dbo].[ssp_GetVDTDAName] @DAUserId = '" . $userId . "' "; 
		//$r = odbc_exec($conn,$query); 
		$r = sqlsrv_query($conn, $query); 

		//while($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($daList, array('DAId'=>$res['DAId'], 'DAIdentityNumber'=>$res['DAIdentityNumber'], 'DAFirstName'=>$res['DAFirstName'], 'DALastName'=>$res['DALastName'])); 
		} 
		$response['success'] = 'true'; 
		$response['message'] = 'Data has been Set...'; 
		$response['daList']  = $daList; 
	}
	else
	{
		$response['success'] = 'false';
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>