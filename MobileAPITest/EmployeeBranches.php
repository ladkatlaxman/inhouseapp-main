<?php
	require_once 'DBConnect.php';
	$userId = $_POST['userId'];
	$response = array(); //$userId;

	if (isset($userId)) 
	{
		$branches = array();

		$query1 = "EXEC ssp_GetEmplBelongToBranch @employeeId = " . $userId . "";
		$r1 = sqlsrv_query($conn, $query1);

		while ($res1 = sqlsrv_fetch_array($r1))
		{
			array_push($branches, array('BranchID'=>$res1['branchID'], 'BranchName'=>$res1['branchName']));	
		} 
	} 
	else 
	{ 
		$response['error'] = true; 
		$response['message'] = 'Data Not Set...' . $userId; 
	}

	$response['empBranches'] = $branches; 
	echo json_encode($response);

?>