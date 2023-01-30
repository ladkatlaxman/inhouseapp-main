<?php
	require_once 'DBConnect.php';
	$response = array();
	error_reporting(E_ERROR | E_PARSE);

	$WayBillNo = $_POST['WayBillNo'];
	$userID = $_POST['userID'];
	$creationDateTime = $_POST['creationDateTime'];
	$branchId = $_POST['branchId'];

	if (isset($WayBillNo) && isset($userID) && isset($creationDateTime))
	{
		$query = "EXEC [dbo].[spMobileAppCancelledWaybill] @wayBillNo ='".$WayBillNo."', @userID = ".$userID.",@createdDateTime='".$creationDateTime."',@branchId=".$branchId."";
		$r=odbc_exec($conn,$query);

		if( $r === false ) 
		{
			$response['error'] = true;
     		$response['message'] = "Some Error Accured!";
		}
		else
		{
			$response['error'] = false;
     		$response['message'] = "INSERTED";	
		}
	}

	echo json_encode($response);
?>