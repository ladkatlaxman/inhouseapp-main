<?php
	require_once 'DBConnect.php';
	$response = array();

	$locPincode = $_POST['locPincode'];

	if (isset($locPincode)) 
	{
		$pincodeAreas = array();
		$query5 = "EXEC [dbo].[ssp_GetPincodeAreaList] @locPincode=" . $locPincode; 
		//$r5 = odbc_exec($conn,$query5);
		$r5 = sqlsrv_query($conn, $query5);


		//while ($res5=odbc_fetch_array($r5)) 
		while ($res5 = sqlsrv_fetch_array($r5))
		{
			//echo $res1;
			array_push($pincodeAreas,array('locAreaID'=>$res5['locAreaID'],'locID'=>$res5['locID'],'areaName'=>$res5['areaName']));
		}
		$response['error'] = false; 
		$response['PincodeAreas'] = $pincodeAreas;
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}
	echo json_encode($response);
?>