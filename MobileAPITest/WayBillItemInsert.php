<?php

	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	require_once 'DBConnect.php';

	//$query = "INSERT INTO tblErrors(errId,errSource, errNo, errMessage, createdDateTime) 
    //    VALUES(NEXT VALUE FOR seqError,'ssp_CreateWayBillItems(Auto)', -1, '', '24/03/2020')";

	//$r=odbc_exec($conn,$query);
	//$r = sqlsrv_query($conn, $query);

	$response = array();

	$WayBillId =(int) $_POST['WayBillId'];
	$materialID =(int) $_POST['materialID'];
	$packID =(int) $_POST['packID'];
	$valueL =(int) $_POST['valueL'];
	$valueB  =(int) $_POST['valueB'];
	$valueC =(int) $_POST['valueC'];
	$valueCFT = $_POST['valueCFT'];
	$valueChargedWt = $_POST['valueChargedWt'];
	$valueActualWt = $_POST['valueActualWt'];
	$itemQty =(int) $_POST['itemQty'];
	$innerqQty =(int) $_POST['innerqQty'];
	$invoiceNo = $_POST['invoiceNo'];
	$invoiceDate = $_POST['invoiceDate'];
	$invoiceAmount = $_POST['invoiceAmount'];
	$createdDateTime = $_POST['createdDateTime'];
	$branchID = (int) $_POST['branchID'];
	$VehicleRequestID = (int) $_POST['vehicleRequestID'];
	$valueUOM = (int) $_POST['valueUOM']; 
	$eWayBillNo = $_POST['eWayBillNo']; 
	$eWayBillDate = $_POST['eWayBillDate']; 
	$eWayBillExpiryDate = $_POST['eWayBillExpiryDate']; 

	if($VehicleRequestID==0)
	{
		$VehicleRequestID = 'null';
		//echo 'null';
	}
	if(isset($_POST['userId'])) 
	{
		//echo  $_POST['userId'];
		$userId = $_POST['userId']; 
	}

	$query = "EXEC [dbo].[ssp_CreateWaybillItems] @WayBillId = ".$WayBillId.", @materialID = ".$materialID.", @packID = ".$packID.",@valueL = ".$valueL.",@valueB = ".$valueB.",@valueC = ".$valueC.",@valueCFT = ".$valueCFT.",@valueChargedWt = ".$valueChargedWt.",@valueActualWt = ".$valueActualWt.",@itemQty = ".$itemQty.",@innerqQty = ".$innerqQty.",@invoiceNo = '".$invoiceNo."',@invoiceDate = '".$invoiceDate."',@invoiceAmount = '".$invoiceAmount."',@createdDateTime = '".$createdDateTime."',@branchID = ".$branchID.",@vehicleRequestID = ".$VehicleRequestID.",@userId=".$userId.",@valueUOM='".$valueUOM."'".",@eWayBillNo='".$eWayBillNo."',@eWayBillDate='".$eWayBillDate."',@eWayBillExpiryDate='".$eWayBillExpiryDate."'";

	//echo $query;

	//$r=odbc_exec($conn,$query);
	$r = sqlsrv_query($conn, $query);
	
	if ($r) 
	{
		$response['error'] = false;
		$response['message'] = "Added";
	}
	else
	{
		$response['error'] = true;
		$response['message'] = "Something Wrong";	
	}
		
	echo json_encode($response);
?>