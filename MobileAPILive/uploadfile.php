<?php
 if($_SERVER['REQUEST_METHOD']=='POST')
 {
  	// echo $_SERVER["DOCUMENT_ROOT"];  // /home1/demonuts/public_html
	  //including the database connection file
  	include_once("DBConnect.php");
  	  	
  	//$_FILES['image']['name']   give original name from parameter where 'image' == parametername eg. city.jpg
  	//$_FILES['image']['tmp_name']  temporary system generated name
  
    $originalImgName= $_FILES['filename']['name'];
    $tempName= $_FILES['filename']['tmp_name'];
    
    //$url = "http://dexpro.co.in/InHousePro/FileUpload/".$originalImgName;
    $url = "https://www.dexters.co.in/app/FileUpload/".$originalImgName;
    
    if(move_uploaded_file($tempName,$originalImgName))
    {
      $query = "INSERT INTO tblImg VALUES ('$url')";
      if(sqlsrv_query($con,$query))
      {
      
      	 $query= "SELECT * FROM tblImg WHERE imgName = '$url'";
         $result= sqlsrv_query($con, $query);
         $emparray = array();
         if(sqlsrv_num_rows($result) > 0)
         {  
           while ($row=sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) 
           {
              $emparray[] = $row;
           }
           echo json_encode(array( "status" => "true","message" => "Successfully file added!" , "data" => $emparray) );
         }
         else
         {
         		echo json_encode(array( "status" => "false","message" => "Failed!") );
         }
      }
      else
      {
      	echo json_encode(array( "status" => "false","message" => "Failed!") );
      }
    	//echo "moved to ".$url;
    }
    else
    {
    	echo json_encode(array( "status" => "false","message" => "Failed!") );
    }
  }
?>