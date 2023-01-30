<?php
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL); 

	require_once 'DBConnect.php';
	$response = array();

	$WayBillId = $_POST['WaybillId']; 
	$RateTypeId = $_POST['RateTypeId']; 
	$Value = $_POST['Value']; 

	$query = "EXEC [dbo].[ssp_CreateWaybillInvoice] @RateTypeId =".$RateTypeId.", @WayBillId = ".$WayBillId.", @Value = ".$Value ; 
//echo($query); 
	$r = sqlsrv_query($conn, $query); 
 
	//if (sqlsrv_has_rows($r)) 
	//if ($r) 
	{ 
		//echo($r['WayBillInvoiceDetailsId']);
		//while ($res = sqlsrv_fetch_object($r))
		while ($res = sqlsrv_fetch_array($r))
		{ 
			echo('here');
			if ($res['WayBillInvoiceDetailsId'] != -1) 
			{
				$response['success'] = true;
				$response['WayBillInvoiceDetailsId'] = $res['WayBillInvoiceDetailsId']; 
			}
			else
			{
				$response['success'] = false;
				$response['WayBillInvoiceDetailsId'] = -1;
			}
		}
	}
	sqlsrv_free_stmt($r);
	$response['success'] = true;
	echo json_encode($response);
?>
