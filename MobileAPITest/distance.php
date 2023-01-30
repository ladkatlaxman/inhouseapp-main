<?php

  require_once 'DBConnect.php';
  
  $locID = $_POST['locID'];
  $locAreaID = $_POST['locAreaID'];
  $query = "EXEC [dbo].[ssp_FullAddress] @locID =".$locID.", @locAreaID = ".$locAreaID."";

  $r=odbc_exec($conn,$query);
  
  while ($res=odbc_fetch_array($r)) 
  {
    $origin = $res['Addres'];
  }

  $locID1 = $_POST['locID1'];
  $locAreaID1 = $_POST['locAreaID1'];
  $query1 = "EXEC [dbo].[ssp_FullAddress] @locID =".$locID1.", @locAreaID = ".$locAreaID1."";

  $r1=odbc_exec($conn,$query1);
  
  while ($res1=odbc_fetch_array($r1)) 
  {
    $destination = $res1['Addres'];
  }

  //$origin = $_POST['origin'];
  //$destination = $_POST['destination'];



   /* In imperial unit
  $distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins='.urlencode($origin).'&destinations='.urlencode($destination).'&key=AIzaSyD6YkF-BVV1LNLOz5n3zeL9bi1farzUX8k');
  */
   // In metric unit. This is default
  $distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?&origins='.urlencode($origin).'&destinations='.urlencode($destination).'&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E');
  $distance_arr = json_decode($distance_data);
  if ($distance_arr->status=='OK') 
  {
    $destination_addresses = $distance_arr->destination_addresses[0];
    $origin_addresses = $distance_arr->origin_addresses[0];
  } 
  else 
  {
    echo "<p>The request was Invalid</p>";
    exit();
  }
  if ($origin_addresses=="" or $destination_addresses=="") 
  {
    echo "<p>Destination or origin address not found</p>";
    exit();
  }
   // Get the elements as array
  $elements = $distance_arr->rows[0]->elements;
  $distance = $elements[0]->distance->text;
  $duration = $elements[0]->duration->text;
  echo "From: ".$origin_addresses."<br/> To: ".$destination_addresses."<br/> Distance: <strong>".$distance ."</strong><br/>";
  echo "Duration: <strong>".$duration."";
 ?>