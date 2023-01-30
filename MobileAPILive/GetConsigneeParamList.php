<?php
	require_once 'DBConnect.php';
	$consigneeNames = array();

	$branchId = $_POST['BranchID']; 
	$nameParam = $_POST['nameParam']; 

	if (isset($branchId)) 
	{
		$query = "EXEC ssp_GetConsigneeNameParamList @branchID = " . $branchId;
		
		if (isset($nameParam))
		{
			if ($nameParam != "") 
			{
				$queryParam = ", @NameParam = '" . $nameParam . "' "; 
			}
		}
		$query = $query . $queryParam; 

		$r = sqlsrv_query($conn, $query);  
		$response['success'] = true;
		$response['message'] = '';
		while ($res = sqlsrv_fetch_array($r)) 
		{
			array_push($consigneeNames, array('ConsigneeId'=>$res['ConsigneeId'],'ConsigneeName'=>$res['ConsigneeName']));
		}
		$response['ConsigneeNames'] = $consigneeNames; 
	}
	else
	{
		$response['success'] = false;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>