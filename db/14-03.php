<?php 
    $con = mysqli_connect("localhost", "cookUser", "1234", "cookDB") or die("MySQL 접속 실패!!");
 
    $sql =
    " CREATE TABLE IF NOT EXISTS userTBL
    (userID CHAR(8) NOT NULL PRIMARY KEY, 
    userName VARCHAR(10) NOT NULL, 
    birthYear INT NOT NULL, 
    addr CHAR(2) NOT NULL, 
    mobile1 CHAR(3), 
    mobile2 CHAR(8), 
    height SMALLINT, 
    mDate DATE ) ";
 
    $ret = mysqli_query($con, $sql);
 
     if($ret) { 
        echo "userTBL이 성공적으로 생성됨..";
    } 
    else { 
    echo "userTBL 생성 실패!!!"."<BR>";
    echo "실패 원인 :".mysqli_error($con);
 }
 
 mysqli_close($con);
?> 