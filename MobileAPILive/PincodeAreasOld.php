<?php
	require_once 'DBConnect.php';
	$response = array();

	$locPincode = $_POST['locPincode'];

	if (isset($locPincode)) 
	{
			$pincodeAreas = array();

			$query1 = "EXEC [dbo].[spMobileAppPincodeCheck] @locPincode=".$locPincode."";
			//$r1 = odbc_exec($conn,$query1);
			$r1 = sqlsrv_query($conn, $query1);

			//while($res1=odbc_fetch_array($r1))
			while ($res1 = sqlsrv_fetch_array($r1))
			{
				if ($res1['c']==1) 
				{
					$query5 = "EXEC [dbo].[spMobileAppPincodeAreaList] @locPincode=".$locPincode."";
					//$r5 = odbc_exec($conn,$query5);
					$r5 = sqlsrv_query($conn, $query5);


					//while ($res5=odbc_fetch_array($r5)) 
					while ($res5 = sqlsrv_fetch_array($r5))
					{
						//echo $res1;
						array_push($pincodeAreas,array('error'=>false,'locAreaID'=>$res5['locAreaID'],'locID'=>$res5['locID'],'areaName'=>$res5['areaName']));
					}
				}
				else
				{
					array_push($pincodeAreas,array('error'=>true));
				}
				array_push($response,array('PincodeAreas'=>$pincodeAreas));
			}
	}
	else
	{
		$response['error'] = true;
		$response['message'] = 'Data Not Set...';
	}

	echo json_encode($response);
?>