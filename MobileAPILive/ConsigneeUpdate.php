<?php
	require_once 'DBConnect.php'; 
	$response = array(); 

	$Name = $_POST['Name']; 
	$contactNo = $_POST['contactNo']; 
	$locID = $_POST['locID']; 
	$locAreaID = $_POST['locAreaID']; 
	$Address = $_POST['Address']; 
	$gstNumber = $_POST['gstNumber']; 
	$userId = $_POST['userId']; 
	$creationDateTime = $_POST['creationDateTime']; 
	$value = "CONSIGNEE"; 
	$BranchId = $_POST['BranchId']; 

	if (isset($Name) && isset($contactNo) && isset($locID) && isset($locAreaID) && isset($Address) && 
	    isset($gstNumber) && isset($userId) && isset($creationDateTime) && isset($BranchId)) 
	{ 
		$query = "EXEC [dbo].[ssp_CreateConsignorOrConsignee] @Name = '" . $Name . "', @contactNo = '" . $contactNo . "', @locID = '" . $locID . "', @locAreaID = '" . $locAreaID . "', @Address = '" . $Address . "', @gstNumber  = '" . $gstNumber . "', @userId = '" . $userId . "', @creationDateTime = '" . $creationDateTime . "', @BranchId = '" . $BranchId . "', @Value = '" . $value . "' "; 

		//echo($query); 

		$r = sqlsrv_query($conn, $query); 

		if($r) 
		{ 
			$response['success'] = true;
			$response['message'] = 'Added';
			while ($res = sqlsrv_fetch_array($r)) 
			{	
				$response['ConsigneeId'] = $res['ID'];
			}
		} 
		else 
		{ 
			$response['success'] = false;
			$response['message'] = 'Not Added';
		} 
	} 
	else
	{ 
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	} 

	echo json_encode($response);
?>