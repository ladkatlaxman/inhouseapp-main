<?php
	require_once 'DBConnect.php';
	$Materials = array();

	$CustomerId = $_POST['CustomerId'];

	$query = "EXEC ssp_GetMaterialNameList "; 
	if (isset($CustomerId)) $query = $query . " @CustomerId = '" . $CustomerId . "' "; 
	$r = sqlsrv_query($conn, $query); 

	while ($res = sqlsrv_fetch_array($r)) 
	{
		array_push($Materials, array('materialId'=>$res['materialID'], 'materialName'=>$res['materialName'], 'L'=>$res['L'], 'B'=>$res['B'], 'H'=>$res['H'], 'CFTValue'=>$res['CFTValue'], 'UOM'=>$res['UOM'])); 
	}

	$response['Materials'] = $Materials;

	echo json_encode($response);
?>