<?php
	require_once 'DBConnect.php';
	$response = array();

	//$VehicleRequestID = $_POST['VehicleRequestID'];
	$branchId = $_POST['branchId'];
	$date = $_POST['date']; 

	if (isset($branchId)) 
	{
		//$query = "EXEC [dbo].[spMobileAppPickUpList] @VehicleRequestID = '" . $VehicleRequestID . "'";
		//$r = odbc_exec($conn,$query); 
		$query = "EXEC ssp_ViewPickUPRequestList @status = 'OPEN', @fromDate = '" . $date . "', @toDate = '" . $date . "', @branchID = " . $branchId ; 
		$r = sqlsrv_query($conn, $query); 

		//while ($res=odbc_fetch_array($r)) 
		while ($res = sqlsrv_fetch_array($r)) 
		{
			//array_push($response, array('pickupID'=>$res['pickupID'],'customerName'=>$res['CustomerName'],'FullAddress'=>$res['FullAddress'],'contactNo'=>$res['contactNo'],'telephoneNo'=>$res['telephoneNo']));
			array_push($response, array('pickupID'=>$res['pickupRequestID'],'customerName'=>$res['CustomerName'],'FullAddress'=>$res['pickupAddress'],'customerType'=>$res['customerType'],'contactNo'=>$res['contactNo'],'telephoneNo'=>$res['telephoneNo']));
		}
	}
	
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>