<?php
	require_once 'DBConnect.php';
	$response = array();
	error_reporting(E_ERROR | E_PARSE);

	$VehicleRequestID = $_POST['VehicleRequestID'];
	$userID = $_POST['userID'];
	$branchID = $_POST['BranchID'];
	$creationDateTime = $_POST['creationDateTime'];
	$vehicleNo = $_POST['vehicleNo'];
	$mPin = $_POST['mPin'];


	if (isset($VehicleRequestID) && isset($userID) && isset($creationDateTime))
	{
		$query = "EXEC [dbo].[spMobileAppLogin] @VehicleNo = '" . $vehicleNo .  "', @mPin = '" . $mPin . "'";
		$r=odbc_exec($conn,$query);

		while ($res=odbc_fetch_array($r))
		{
			if($res['status']=='REJECTED')
			{
				$response['error'] = true;
				$response['message'] = 'This Vehicle Is '.$res['status'];
			}
			else
			{
				// This Is For Dispatch Entry

				$query = "EXEC [dbo].[ssp_CreateVehicleStatus] @VehicleRequestID = '" . $VehicleRequestID .  "',@statusId = 4 ,@userID = '" . $userID . "', @creationDateTime = '".$creationDateTime."',@BranchId = ".$branchID."";
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
		}
		
	}

	echo json_encode($response);
?>