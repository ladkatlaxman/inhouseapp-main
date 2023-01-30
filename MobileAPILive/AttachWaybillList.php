<?php
	require_once 'DBConnect.php';
	$response = array();

	$createdDate = $_POST['createdDate'];
	$branchID = $_POST['branchID'];


	if (isset($createdDate)) 
	{
		$query = "EXEC [dbo].[spMobileAppAttachWaybillList] @createdDate = '" . $createdDate . "',@branchID = ".$branchID."";
		$r=odbc_exec($conn,$query);

		while ($res=odbc_fetch_array($r))
		{
		
			array_push($response, array('waybillID'=>$res['waybillID'],'wayBillNo'=>$res['wayBillNo'],'createdDateTime'=>$res['createdDateTime']));
		}
	}
	
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>