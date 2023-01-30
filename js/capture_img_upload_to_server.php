<?php

 if($_SERVER['REQUEST_METHOD'] == 'POST')
 {
 $DefaultId = 0;
 
 $ImageData = $_POST['image_path'];
 
 $ImageName = $_POST['image_name'];

 $DefaultId = $_POST['id'];

 }
 
 $ImagePath = "images\\$DefaultId.jpg";
 
 #echo dirname(__DIR__) . "\" . $ImagePath;
 $ImagePath = dirname(__DIR__, 1) . "\\" . $ImagePath; #dirname(__DIR__) . "/\" . $ImagePath; 
 
 file_put_contents($ImagePath, base64_decode($ImageData)); 

?>