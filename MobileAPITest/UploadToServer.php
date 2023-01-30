<?php
	if($_SERVER['REQUEST_METHOD'] == 'POST')
	{
		$DefaultId = 0;
 
 		$ImageData = $_POST['image_path'];
 
 		$ImageName = $_POST['image_name'];

 		$DefaultId = $_POST['id'];

 	}
 
	$ImagePath = $_FILES[dirname(__DIR__, 1) . "\\" . "images\\$DefaultId.jpg";
 
	#echo dirname(__DIR__) . "\" . $ImagePath; 
	$ImagePath = dirname(__DIR__, 1) . "\\" . $ImagePath; #dirname(__DIR__) . "/\" . $ImagePath; 
	move_uploaded_file($_FILES['file']['tmp_name'], magePath); 
?>