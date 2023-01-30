<?php
	require_once 'DBConnect.php';
	if($_SERVER['REQUEST_METHOD'] == 'POST')
	{
		//$DefaultId = 0;
		//$ImageData = $_POST['image_path'];
		//$ImageName = $_POST['image_name'];
		$DefaultId = $_POST['WayBillNo'];
	}
	//$response = array(); 

	// Checks if Waybill is Present. 
	// Checks if the Waybill has been Delivered. 
	// Does not Check if POD has been already Uploaded. 

	$query = "EXEC dbo.ssp_ViewWayBillPODStatus @wayBillNo ='" . $DefaultId . "'";
	$r=sqlsrv_query($conn,$query); 
	while ($res = sqlsrv_fetch_array($r))
	{
		$response['result'] = $res['RESULT']; 
	}
	echo (json_encode($response)); 
?>