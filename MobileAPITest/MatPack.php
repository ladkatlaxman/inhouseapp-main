<?php
	require_once 'DBConnect.php';
	$response = array();
	// MATERIAL NAMES
	$materialNames = array();
	$query2 = "EXEC [dbo].[spMobileAppMaterialNames]";
	//$r2=odbc_exec($conn,$query2);
	$r2 = sqlsrv_query($conn, $query2);
		
	//while ($res2=odbc_fetch_array($r2)) 
	while ($res2 = sqlsrv_fetch_array($r2))
	{
		//echo $res1;
		array_push($materialNames,array('materialID'=>$res2['materialID'],'materialName'=>$res2['materialName']));
	}
	
	// PACKAGE NAMES
	$packageNames = array();
	$query3 = "EXEC [dbo].[spMobileAppPackageNames]";
	//$r3=odbc_exec($conn,$query3);
	$r3 = sqlsrv_query($conn, $query3);

	//while ($res3=odbc_fetch_array($r3)) 
	while ($res3 = sqlsrv_fetch_array($r3))
	{
		//echo $res1;
		array_push($packageNames,array('packID'=>$res3['packID'],'packageName'=>$res3['typeOfPackage']));
	}
	
	array_push($response,array('MaterialNames'=>$materialNames,'PackageNames'=>$packageNames));

	echo json_encode($response);
?>