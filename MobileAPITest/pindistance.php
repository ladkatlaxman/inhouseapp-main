<?php

   $from = $_GET['from']; 
   $to = $_GET['to']; 
   /* In imperial unit
  	$distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=482001&destinations=400001&key=AIzaSyD6YkF-BVV1LNLOz5n3zeL9bi1farzUX8k');
  */
   // In metric unit. This is default
  //$distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?&origins='.urlencode($origin).'&destinations='.urlencode($destination).'&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E');
  $distance_data = file_get_contents('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins='.$from.'&destinations='.$to.'&key=AIzaSyCf3AeB-YHUsLg12VhfIt8yFK5FLmP0yFE');
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
   // Get the elements as array
  $elements = $distance_arr->rows[0]->elements;
  $distance = $elements[0]->distance->text;
  $duration = $elements[0]->duration->text;
  echo "From: ".$origin_addresses."<br/> To: ".$destination_addresses."<br/> Distance: <strong>".$distance ."</strong><br/>";
  echo "Duration: <strong>".$duration."";
 ?>