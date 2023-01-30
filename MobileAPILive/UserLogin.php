<?php
	require_once 'DBConnect.php';
	$response = array();

	$userName = $_POST['userName'];
	$passWord = $_POST['passWord'];

	if (isset($userName) && isset($passWord)) 
	{
		//$query = "EXEC [dbo].[spMobileAppUserLogin] @userName = '" . $userName .  "', @passWord = '" . $passWord . "'";
		$query = "EXEC ssp_SessionData @username = '" . $userName .  "', @password = '" . $passWord . "'";
		//$r=odbc_exec($conn,$query);
		$r = sqlsrv_query($conn, $query);

		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			$response['error'] = false;
			$response['fullName'] = $res['FullName'];
			//$response['employeeID'] = $res['employeeID'];
			$response['employeeID'] = $res['userID'];
			$userid = $res['userID']; 
			$response['BranchID'] = $res['BranchId'];
			$response['BranchName'] = $res['BranchName'];
		}
		
		$queryBranch = "EXEC ssp_GetLastBranch @userId = '" . $userid . "'";
		$rBranch = sqlsrv_query($conn, $queryBranch);
		$response['query'] = $queryBranch; 
		while ($resBranch = sqlsrv_fetch_array($rBranch))
		{
			$response['BranchID'] = $resBranch['BranchId'];
			$response['BranchName'] = $resBranch['BranchName'];
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>