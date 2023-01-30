<?php
	require_once 'DBConnect.php';
	$response = array();

	$waybillID = $_POST['waybillID'];


	if (isset($waybillID)) 
	{
		$query = "EXEC [dbo].[spMobileAppAttachWaybillListDetail] @waybillID = '" . $waybillID . "'";
		$r=odbc_exec($conn,$query);

		while ($res=odbc_fetch_array($r))
		{
		
			array_push($response, array('WayBillItemId'=>$res['WayBillItemId'],'materialId'=>$res['materialId'],'materialName'=>$res['materialName'],'packId'=>$res['packId'],'typeOfPackage'=>$res['typeOfPackage'],'valueL'=>$res['valueL'],'valueB'=>$res['valueB'],'valueH'=>$res['valueH'],'valueActualWt'=>$res['valueActualWt'],'itemQty'=>$res['itemQty']));
		}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>