 <?php 
 $con = mysqli_connect("localhost", "cookUser", "1234", "cookDB") or die("MySQL 접속 실패!!");
 
 $userID = $_POST["userID"];
 $userName = $_POST["userName"];
 $birthYear = $_POST["birthYear"];
 $addr = $_POST["addr"];
 $mobile1 = $_POST["mobile1"];
 $mobile2 = $_POST["mobile2"];
 $height = $_POST["height"];
 $mDate = date("Y-m-j");
 
 $sql =" INSERT INTO userTBL VALUES ('".$userID."','".$userName."',".$birthYear;
 $sql = $sql.",'".$addr."','".$mobile1."','".$mobile2."',".$height.",'".$mDate."')";
 
 $ret = mysqli_query($con, $sql);
 
 echo "<H1>신규 회원 입력 결과</H1>";
 if($ret) { 
 echo "데이터가 성공적으로 입력됨.";
 }
 else { 
 echo "데이터 입력 실패!!!"."<BR>";
 echo "실패 원인 :".mysqli_error($con);
 }
 mysqli_close($con);
 
 echo "<BR> <A HREF='main.html'> <--초기 화면</A> ";
?>