<?php
	require_once 'DBConnect.php';
	$response = array();

	
	$pickupDate = $_POST['pickupDate'];
	$BranchID = $_POST['BranchID'];
	
	if(isset($pickupDate) && isset($BranchID))
	{
		$query = "EXEC [dbo].[spMobileAppPickUpListSchedule] @pickupDate = '" . $pickupDate . "', @BranchID = ".$BranchID;
		//$r=odbc_exec($conn,$query);
		$r = sqlsrv_query($conn,$query);
		
		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			array_push($response, array('pickupID'=>$res['pickupID'],'customerName'=>$res['customerName'],'CustomerType'=>$res['CUSTOMERtYPE'],'FullAddress'=>$res['FullAddress'],'contactNo'=>$res['contactNo'],'telephoneNo'=>$res['telephoneNo']));
		}
		
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}
	echo json_encode($response);
?>