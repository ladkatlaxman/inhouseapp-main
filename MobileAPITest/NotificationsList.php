<?php
	require_once 'DBConnect.php';
	$Notes = array();

	$branchId = $_POST['BranchId'];

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_Notifications @BranchId = " . $branchId ; 
		$r = sqlsrv_query($conn, $query); 

		$response['success'] = true;
		$response['message'] = '';

		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($Notes, array('Notes'=>$res['tblNote'])); 
		}
		$response['Notes'] = $Notes; 
	}
	else
	{
		$response['success'] = false;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>