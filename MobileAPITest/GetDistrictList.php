<?php
	require_once 'DBConnect.php'; 
	//$response = array(); 
	$DList = array(); 

	$StateId = $_POST['StateId']; 

	if (isset($StateId)) 
	{ 
			$query = "EXEC [dbo].[ssp_GetDistrictList] @StateId = '" . $StateId . "' "; 

		//$r = odbc_exec($conn,$query); 
		$r = sqlsrv_query($conn, $query); 

		//while($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{ 
			array_push($DList, array('DistrictId'=>$res['DistrictId'], 'DistrictName'=>$res['DistrictName'])); 
		} 
	}

	$response['success'] = 'true'; 
	$response['message'] = 'Data has been Set...'; 
	$response['District'] = $DList; 

	echo json_encode($response); 
?>