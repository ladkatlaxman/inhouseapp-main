<?php
	require_once 'DBConnect.php'; 
	$response = array(); 
	$DList = array(); 

	$BranchId = $_POST['BranchId']; 
	$StateId = $_POST['StateId']; 
	$DistrictId = $_POST['DistrictId']; 

	$query = "EXEC [dbo].[ssp_GetLocations] "; 

	if ($BranchId != "") 
	{ 
		$query = $query . " @BranchId='" . $BranchId . "',"; 
	}
	else 
	{
		$query = $query . "@BranchId=NULL,"; 
	}
	if ($StateId != "") 
	{ 
		$query = $query . "@StateId='" . $StateId . "',"; 
	}
	else 
	{
		$query = $query . "@StateId = NULL,"; 
	}
	if ($DistrictId != "") 
	{ 
		$query = $query . "@DistrictId='" . $DistrictId . "'"; 
	}
	else 
	{
		$query = $query . "@DistrictId=NULL"; 
	}

	//$r = odbc_exec($conn,$query); 
	$r = sqlsrv_query($conn, $query); 

	//while($res=odbc_fetch_array($r)) 
	while ($res = sqlsrv_fetch_array($r)) 
	{ 
		array_push($DList, array('PinCode'=>$res['locPincode'], 'City'=>$res['cityName'], 'District'=>$res['districtName'], 'State'=>$res['stateName'], 'Branch'=>$res['branchName'], 'Service'=>$res['Service'])); 
	} 
	$response['Locations'] = $DList; 
	echo json_encode($response);
?>