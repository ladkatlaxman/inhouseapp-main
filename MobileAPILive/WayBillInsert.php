<?php

	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	require_once 'DBConnect.php';
	$response = array();

	$waybillNo = $_POST['waybillNo'];
	$waybillDate = $_POST['waybillDate']; 
	$branchID =(int) $_POST['branchID'];
	$pickupID =(int) $_POST['pickupID'];
	//$pickupDateTime = $_POST['pickupDateTime'];
	$customerID  =(int) $_POST['customerID'];
	$contactNo = $_POST['contactNo']; 
	$paymentMode = $_POST['paymentMode'];
	$pickupAreaId =(int) $_POST['pickupAreaId'];
	$pickUpLocationId =(int) $_POST['pickUpLocationId'];
	//$pickupAddress = $_POST['pickupAddress'];
	$consigneeID =(int) $_POST['consigneeID'];
	$consigneeAreaID  =(int) $_POST['consigneeAreaID'];
	$consigneeLocationId =(int) $_POST['consigneeLocationId'];
	$consigneeAddress = $_POST['consigneeAddress'];
	$consigneeContactNo = $_POST['consigneeContactNo']; 
	//$eWaybillNo = $_POST['eWaybillNo'];
	//$eWaybillDate = $_POST['eWaybillDate'];
	$eWaybillNo = "";
	$eWaybillDate = "";
	//$eWayBillExpiryDate = $_POST['eWayBillExpiryDate'];
	//$distance = $_POST['distance'];
	//$mapDistance = $_POST['mapDistance'];
	//$TotalPrice = $_POST['TotalPrice'];
	$createdBy = (int) $_POST['createdBy'];
	$createdDateTime = $_POST['createdDateTime'];
	$origin = "";

	// For Distance Calculation Using Google API
		
	$query = "EXEC [dbo].[ssp_FullAddress] @locID =".$pickUpLocationId.", @locAreaID = ".$pickupAreaId."";

	//$r=odbc_exec($conn,$query);
	$r = sqlsrv_query($conn, $query);
	
	//while ($res=odbc_fetch_array($r)) 
	while ($res = sqlsrv_fetch_array($r))
	{	
		$origin = $res['Addres'];
	}

	$query1 = "EXEC [dbo].[ssp_FullAddress] @locID =".$consigneeLocationId.", @locAreaID = ".$consigneeAreaID."";
	
	//$r1 = odbc_exec($conn,$query1); 
	$r1 = sqlsrv_query($conn, $query1);
	
	//while ($res1=odbc_fetch_array($r1)) 
 	while ($res1 = sqlsrv_fetch_array($r1)) 
	{		
		$destination = $res1['Addres'];
	}
	
	// In metric unit. This is default	
	/*$distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?&origins='.urlencode($origin).'&destinations='.urlencode($destination).'&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E');
	$distance_arr = json_decode($distance_data);
	  
	// Get the elements as array	
	$elements = $distance_arr->rows[0]->elements;
	$distance = $elements[0]->distance->text;	
	$duration = $elements[0]->duration->text;*/
	$distance = 0; 
	$duration = 0; 
	  
	 // Waybill Entry Query	
	//$query2 = "EXEC [dbo].[ssp_CreateWayBill] @waybillNo = '" . $waybillNo .  "', waybillDate = '" . $waybillDate . ", @branchID = " . $branchID . ", @pickupID = ".$pickupID.", @pickupType = 'GODOWN', @customerID = ".$customerID.",@paymentMode = '".$paymentMode."',@pickupAreaId = ".$pickupAreaId.",@pickUpLocationId = ".$pickUpLocationId.",@consigneeID = ".$consigneeID.",@consigneeArea = ".$consigneeAreaID.",@consigneeLocationId = ".$consigneeLocationId.",@consigneeAddress = '".$consigneeAddress."',@eWaybillNo = '".$eWaybillNo."',@eWaybillDate = '".$eWaybillDate."',@ewayBillExpiryDate = NULL, @distance = 0,@mapDistance =".(int)$distance.",@TotalPrice = 0.0,@createdBy = ".$createdBy.",@createdDateTime = '".$createdDateTime."'";

	$query2 = "EXEC ssp_CreateWareHouseWayBill @wayBillNo ='".$waybillNo."',@WayBillDate='". $waybillDate ."', @PickUPId=" . $pickupID . ", @branchId=" . $branchID . ", @customerID =".$customerID.", @customerType = 'CORPORATE', @contactNo = '" . $contactNo . "', @emailID=NULL, @customerAddress='".$origin."', @telephoneNo=NULL, @customerLocID=".$pickUpLocationId.", @customerAreaID=".$pickupAreaId.", @paymentMode='".$paymentMode."', @pickUPLocId=".$pickUpLocationId.", @pickupAreaId=".$pickupAreaId.", @pickupType='GODOWN', @pickupAddress='".$origin."', @walkinCustId=NULL, @consigneeID=".$consigneeID.", @consigneeContactNo=".$consigneeContactNo.", @deliveryLocID=".$consigneeLocationId.", @deliveryAreaID=".$consigneeAreaID.", @consigneeAddress='".$consigneeAddress."', @pickupBranchID=".$branchID.", @IP_Address=NULL, @distance=NULL, @mapDistance=NULL, @TotalPrice=NULL, @userId=".$createdBy.", @createdDateTime='".$createdDateTime."'";

	//echo $query2;

	//$r2=odbc_exec($conn, $query2);
	$r2 = sqlsrv_query($conn, $query2);
	
	//while ($res2=odbc_fetch_array($r2))
	while ($res2 = sqlsrv_fetch_array($r2))
	{
		if ($res2['WayBillId']!=-1) 
		{
			$response['error'] = false;
		}
		else
		{
			$response['error'] = true;
		}
		$response['WayBillId'] = $res2['WayBillId'];
		$queryWayBill = "EXEC ssp_CreateWayBillMobile @WaybillId = '" . $res2['WayBillId'] . "' ";
		$rWayBill = sqlsrv_query($conn, $queryWayBill);
	}

	echo json_encode($response);
?>