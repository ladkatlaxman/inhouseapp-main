<?php
	require_once 'DBConnect.php';
	$response = array();

	$pickupID = $_POST['pickupID'];
	$branchID = $_POST['branchID'];

	if (isset($pickupID)) 
	{
		//$query = "EXEC [dbo].[spMobileAppPickupDetail] @pickupID = '" . $pickupID . "'";
		$query = "EXEC [dbo].[ssp_GetPickUp] @pickupID = '" . $pickupID . "'";
		//$r=odbc_exec($conn,$query);
		//echo $query; 
		$r = sqlsrv_query($conn, $query);

		// HEADER DETAIL
		//while ($res=odbc_fetch_array($r))
		while ($res = sqlsrv_fetch_array($r))
		{
			// DETAIL DETAIL'S
			$query1 = "EXEC [dbo].[spMobileAppPickupDetailMaterial] @pickupID = '".$pickupID."'";
			//$r1=odbc_exec($conn,$query1);
			$r1 = sqlsrv_query($conn, $query1);

			$mat = array();
			//while ($res1=odbc_fetch_array($r1)) 
			while ($res1 = sqlsrv_fetch_array($r1))
			{
				//echo $res1;
				array_push($mat,array('materialID'=>$res1['materialID'],'materialName'=>$res1['materialName'],'packID'=>$res1['packID'],'typeOfPackage'=>$res1['typeOfPackage'],
				'unit'=>$res1['unit'],'length'=>$res1['length'],'breadth'=>$res1['breadth'],'height'=>$res1['height'],'CFT'=>$res1['CFT'],
				'actualWeight'=>$res1['actualWeight'],'noOfPackage'=>$res1['noOfPackage']));
			}
			

			// MATERIAL NAMES
			$materialNames = array();
			//$query2 = "EXEC [dbo].[spMobileAppMaterialNames]";
			$query2 = "EXEC [dbo].[ssp_GetMaterialNameList]";
			//$r2 = odbc_exec($conn,$query2);
			$r2 = sqlsrv_query($conn, $query2);
	
			//while ($res2=odbc_fetch_array($r2)) 
			while ($res2 = sqlsrv_fetch_array($r2))
			{
				//echo $res1;
				array_push($materialNames,array('materialID'=>$res2['materialID'],'materialName'=>$res2['materialName']));
			}
			

			// PACKAGE NAMES 
			$packageNames = array(); 
			$query3 = "EXEC [dbo].[ssp_GetPackageNameList]"; 
			//$r3 = odbc_exec($conn, $query3); 
			$r3 = sqlsrv_query($conn, $query3); 

			//while ($res3=odbc_fetch_array($r3)) 
			while ($res3 = sqlsrv_fetch_array($r3)) 
			{
				//echo $res1;
				array_push($packageNames,array('packID'=>$res3['packID'],'packageName'=>$res3['typeOfPackage']));
			}

			// PINCODE'S
			/*$pincodes = array();
			$query4 = "EXEC [dbo].[spMobileAppPincodeList]";
			//$r4=odbc_exec($conn, $query4);
			$r4 = sqlsrv_query($conn, $query4);
				
			//while ($res4=odbc_fetch_array($r4)) 
			while ($res4 = sqlsrv_fetch_array($r4))
			{
				//echo $res1;
				array_push($pincodes,array('locID'=>$res4['locID'],'locPincode'=>$res4['locPincode']));
			}*/

			// CONSIGNEE NAME LIST
			/*$consignee = array();
			$query5 = "EXEC [dbo].[spMobileAppConsigneeList] @branchID=".(int)$branchID."";
			//$r5=odbc_exec($conn, $query5);
			$r5 = sqlsrv_query($conn, $query5);

			//while ($res5=odbc_fetch_array($r5)) 
			while ($res5 = sqlsrv_fetch_array($r5))
			{
				//echo $res1;
				array_push($consignee,array('ConsigneeId'=>$res5['ConsigneeId'],'ConsigneeName'=>$res5['ConsigneeName'],'contactNo'=>$res5['contactNo'],'deliveryAddress'=>$res5['deliveryAddress'],'locAreaID'=>$res5['locAreaID'],'areaName'=>$res5['areaName'],'locID'=>$res5['locID'],'locPincode'=>$res5['locPincode']));
			}*/ 

			array_push($response,array('pickupID'=>$pickupID,'pickupDate'=>$res['pickupDate'],'customerID'=>$res['customerID'],'customerType'=>$res['customerType'],'customerName'=>$res['customerName'],'pickupLocID'=>$res['pickupLocID'],'pickupAreaID'=>$res['pickupAreaID'],'pickupAddress'=>$res['pickupAddress'],'customerType'=>$res['customerType'],'consigneeID'=>$res['consigneeID'],'consigneeName'=>$res['consigneeName'],'consigneeContactNo'=>$res['consigneeContactNo'],'deliveryLocID'=>$res['deliveryLocID'],
				'deliveryPincode'=>$res['deliveryPincode'],'deliveryAreaID'=>$res['deliveryAreaID'],'deliveryArea'=>$res['deliveryArea'],
				'consigneeAddress'=>$res['consigneeAddress'],'CFTRate'=>$res['CFTRate'],
				'Materials'=>$mat,'MaterialNames'=>$materialNames,'PackageNames'=>$packageNames
				//,'Pincodes'=>$pincodes,'Consignee'=>$consignee
			));
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}
	echo json_encode($response);
?>