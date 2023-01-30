<?php
	require_once 'DBConnect.php';
	$response = array();

	$WaybillId = $_POST['WaybillId'];
	$RateTypeId = $_POST['RateTypeId'];
	$Value = $_POST['Value'];

	if (isset($WaybillId) && isset($RateTypeId) && isset($Value)) 
	{
		$query = "EXEC [dbo].[ssp_CreateWaybillInvoice] @RateTypeId =".$RateTypeId.", @WayBillId = ".$WaybillId.", @Value = ".$Value ; 
		$r = sqlsrv_query($conn, $query);

		while ($res = sqlsrv_fetch_array($r))
		{
			//echo('here');
			$response['WayBillInvoiceDetailsId'] = $res['WayBillInvoiceDetailsId']; 
		}
	}
	else
	{
		$response['success'] = false;
		$response['message'] = 'Data Not Set...';
	}
	$response['success'] = true;
	echo json_encode($response);
?>