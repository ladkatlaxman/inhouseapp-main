<?php
	require_once 'DBConnect.php';
	$userId = $_POST['userId'];
	$branchId = $_POST['branchId'];
	$mydate = new DateTime(null, new DateTimezone("Asia/Kolkata"));
	$mydate = $mydate->format('d/m/yy h:i:s');

	//$mydate = $mydate[mday] . "/" . date(m, strtotime($mydate)) . "/" . $mydate[year] . " " . $mydate[hours] . ":" . $mydate[minutes] . ":" . $mydate[seconds];

	if (isset($userId)) 
	{
		$query = "EXEC ssp_CreateUserActivity @userId = " . $userId . ", @branchId = " . $branchId . ", @ActivityId = 2, @creationDateTime = '" . $mydate . "' "; 
		//echo $query; 
		$result = sqlsrv_query($conn, $query); 

	} 
	else 
	{ 
		$response['error'] = true; 
		$response['message'] = 'Data Not Set...' . $userId; 
	}

	$response['error'] = false; //$userId . ":" . $mydate; 
	echo json_encode($response); 
?>