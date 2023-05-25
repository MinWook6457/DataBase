<?php 
   $db_host = "localhost";
   $db_user = "cookUser";
   $db_password = "1234";
   $db_name = "";
   $con = mysqli_connect($db_host, $db_user, $db_password, $db_name);
   if($con){
       echo "MySQL 접속 완전히 성공!!","."; 
     }
      else{
       die( "접속 실패: " . mysqli_error($con) ); 
     }
  mysqli_close($con);
?>
