<?php

	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	require_once 'DBConnect.php';
	$response = array();

	$waybillNo = $_POST['waybillNo'];
	$waybillDate = $_POST['waybillDate']; 
	$pickupID = 'NULL';
	customerCode = $_POST['CustCode'];

	$consigneeName = $_POST['consigneeName'];
	$consigneeAddress = $_POST['consigneeAddress'];
	$consigneeCity = $_POST['consigneeCity'];
	$consigneeArea = $_POST['consigneeArea']; //Optional 
	$consigneeContactNo = $_POST['consigneeContactNo']; 

	$queryCustCode = "EXEC dbo.ssp_CreateOrGetCustomerDetails " . customerCode; 
	$rCustCode = sqlsrv_query($conn, $queryCustCode); 

	while ($resCustCode = sqlsrv_fetch_array($rCustCode))
	{
		//Get Customer Details from the Customer Code 
		$branchID = $resCustCode['WayBillId']; 
		$customerID = $resCustCode['CustomerId']; 
		$contactNo = $resCustCode['ContactNo']; 
		$paymentMode = 'CREDIT';
		$pickUpLocationId = $resCustCode['locId']; 
		$pickupAreaId = $resCustCode['AreaId']; 
		$customerAddress = $resCustCode['Address']; 
		$customerLocID = $resCustCode['locId']; 
		$customerAreaID = $resCustCode['AreaId']; 
		$pickUPLocId = $resCustCode['LocId']; 
		$pickupAreaId = $resCustCode['AreaId']; 
		$pickupAddress = $resCustCode['Address']; 
	}
	//Get Consignee Details 
	//$consigneeID = $_POST['consigneeID'];
	//$consigneeAreaID  =(int) $_POST['consigneeAreaID'];
	//$consigneeLocationId =(int) $_POST['consigneeLocationId'];
	//$consigneeAddress = $_POST['consigneeAddress'];
	//$consigneeContactNo = $_POST['consigneeContactNo']; 

	$eWaybillNo = ""; 
	$eWaybillDate = ""; 
	$createdBy = (int) $_POST['createdBy']; 
	$createdDateTime = $_POST['createdDateTime']; 
	$PickUpAddress = ""; 

	$distance = 0; 
	$duration = 0; 
	  
	$query2 = "EXEC ssp_CreateWareHouseWayBill @wayBillNo ='".$waybillNo."',@WayBillDate='". $waybillDate ."', @PickUPId=NULL, @branchId=" . $branchID . ", @customerID =".$customerID.", @customerType = 'CORPORATE', @contactNo = '" . $contactNo . "', @emailID=NULL, @customerAddress='".$origin."', @telephoneNo=NULL, @customerLocID=".$pickUpLocationId.", @customerAreaID=".$pickupAreaId.", @paymentMode='".$paymentMode."', @pickUPLocId=".$pickUpLocationId.", @pickupAreaId=".$pickupAreaId.", @pickupType='GODOWN', @pickupAddress='".$PickUpAddress."', @walkinCustId=NULL, @consigneeID=".$consigneeID.", @consigneeContactNo=".$consigneeContactNo.", @deliveryLocID=".$consigneeLocationId.", @deliveryAreaID=".$consigneeAreaID.", @consigneeAddress='".$consigneeAddress."', @pickupBranchID=".$branchID.", @IP_Address=NULL, @distance=NULL, @mapDistance=NULL, @TotalPrice=NULL, @userId='AUTO', @createdDateTime='".$createdDateTime."'";

	//echo $query2;

	//$r2=odbc_exec($conn, $query2);
	$r2 = sqlsrv_query($conn, $query2);
	
	$WayBillId = ""; 
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
		//$queryWayBill = "EXEC ssp_CreateWayBillMobile @WaybillId = '" . $res2['WayBillId'] . "' "; 
		$queryWayBill = "EXEC ssp_CreateWayBillItem @WaybillId = '" . $res2['WayBillId'] . "' "; 
		$WayBillId = sqlsrv_query($conn, $queryWayBill);
	}

	echo json_encode($response);
	if($WayBillId == "")
	{
		$response['Error'] = "TRUE" ;
		$response['Message'] = "Waybill Could not be Entered" ;
		break
	}
?>
