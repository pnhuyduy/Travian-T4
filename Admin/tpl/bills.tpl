<?php
$sql = mysql_query("SELECT * FROM ".TB_PREFIX."bill where true ORDER BY `invoicenumber` ASC");
$queryCount = mysql_num_rows($sql);
if (isset($_GET['page'])) { // دریافت شماره صفحه
	$page = preg_replace('#[^0-9]#i', '', $_GET['page']); // فیلتر کردن همه چیز به جز اعداد
} else {
	$page = 1;
}

$itemsPerPage = 20; //تعداد آیتم های قابل نمایش در هر صفحه
$lastPage = ceil($queryCount / $itemsPerPage); // دریافت مقدار آخرین صفحه
?>
<div align="center">
	<ul class="tabs"><center>
		<li>Bills (<?php echo $queryCount;?>)</li>
        </center>
	</ul>
</div>
<table id="member" border="1" cellpadding="3" align="center" dir="ltr"> 
    <tr style="height:30px;">
        <td dir="ltr"><center>Invoicenumber</center></td>
        <td><b>Price USD</b></td>
        <td><b>Price IRR</b></td> 
        <td><b>Date</b></td> 
        <td><b>TRID</b></td> 
        <td><b>Gold Count</b></td>  
        <td><b>Username [access]</b></td>  
        <td><b>Approved?</b></td>
        <td><b>Approval Date</b></td>
        <td><b>Payed By</b></td>
    </tr>
<?php
	if ($page < 1) {
		$page = 1;
	} else if ($page > $lastPage) {
		$page = $lastPage;
	}
	$centerPages = "";
	$sub1 = $page - 1;
	$sub2 = $page - 2;
	$sub3 = $page - 3;
	$add1 = $page + 1;
	$add2 = $page + 2;
	$add3 = $page + 3;
	if ($page <= 1 && $lastPage <= 1) {
		$centerPages .= '<span class="number currentPage">1</span>';
		
	}elseif ($page == 1 && $lastPage == 2) {
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=2">2</a>';
		
	}elseif ($page == 1 && $lastPage == 3) {
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=2">2</a> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=3">3</a>';
		
	}elseif ($page == 1) {
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $add1 . '">' . $add1 . '</a> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $add2 . '">' . $add2 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $lastPage . '">' . $lastPage . '</a>';
		
	} else if ($page == $lastPage && $lastPage == 2) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == $lastPage && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=2">2</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == $lastPage) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub2 . '">' . $sub2 . '</a> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == ($lastPage - 1) && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $lastPage . '">' . $lastPage . '</a>';
	
	} else if ($page > 2 && $page < ($lastPage - 1)) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $add1 . '">' . $add1 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $lastPage . '">' . $lastPage . '</a>';
		
	}else if ($page == ($lastPage - 1)) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $lastPage . '">' . $lastPage . '</a>';
	
	} else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $add1 . '">' . $add1 . '</a>';
		
	} else if ($page > 1 && $page < $lastPage) {
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $add1 . '">' . $add1 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=bills&page=' . $lastPage . '">' . $lastPage . '</a>';
	}
	$paginationDisplay = "";
	$nextPage = $_GET['page'] + 1;
	$previous = $_GET['page'] - 1;
	if ($page == "1" && $lastPage == "1"){
		$paginationDisplay .=  '<img alt="صفحه اول" src="../img/x.gif" class="first disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه قبل" src="../img/x.gif" class="previous disabled">';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<img alt="صفحه بعد" src="../img/x.gif" class="next disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه آخر" src="../img/x.gif" class="last disabled">';
		
	}elseif ($lastPage == 0){
		$paginationDisplay .=  '<img alt="صفحه اول" src="../img/x.gif" class="first disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه قبل" src="../img/x.gif" class="previous disabled">';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<img alt="صفحه بعد" src="../img/x.gif" class="next disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه آخر" src="../img/x.gif" class="last disabled">';
		
	}elseif ($page == "1" && $lastPage != "1"){
		$paginationDisplay .=  '<img alt="صفحه اول" src="../img/x.gif" class="first disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه قبل" src="../img/x.gif" class="previous disabled">';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<a class="next" href="index.php?p=bills&page=' . $nextPage . '"><img alt="صفحه بعد" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="last" href="index.php?p=bills&page=' . $lastPage . '"><img alt="صفحه آخر" src="../img/x.gif"></a>';
	
	}elseif ($page != "1" && $page != $lastPage){
		$paginationDisplay .=  '<a class="first" href="index.php?p=bills&page=1"><img alt="صفحه اول" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="previous" href="index.php?p=bills&page=' . $previous . '"><img alt="صفحه قبل" src="../img/x.gif"></a>';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<a class="next" href="index.php?p=bills&page=' . $nextPage . '"><img alt="صفحه بعد" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="last" href="index.php?p=bills&page=' . $lastPage . '"><img alt="صفحه آخر" src="../img/x.gif"></a>';
	
	}elseif ($page == $lastPage){
		$paginationDisplay .=  '<a class="first" href="index.php?p=bills&page=1"><img alt="صفحه اول" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="previous" href="index.php?p=bills&page=' . $previous . '"><img alt="صفحه قبل" src="../img/x.gif"></a>';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<img alt="صفحه بعد" src="../img/x.gif" class="next disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه آخر" src="../img/x.gif" class="last disabled">';
	}
	
	$limit = 'LIMIT ' .($page - 1) * $itemsPerPage .',' .$itemsPerPage; 
	$time = time() - (60*5);
	$sql2 = mysql_query("SELECT * FROM ".TB_PREFIX."bill WHERE true ORDER BY `invoicenumber` ASC $limit");

if($queryCount>0){
	while($row = mysql_fetch_array($sql2)){
		$uid = $row['uid'];
		$username = $database->getUserField($uid, 'username', 0);
		$accessID = $database->getUserField($uid, 'access', 0);

		if($accessID == 9){
			$access = "[<b>مدیر</b>]";
        } elseif($accessID == 8){
			$access = "[<b>مولتی هانتر</b>]";
        } elseif($accessID == 0){
			$access = "[<b>بازداشت</b>]";
        }else{ $access = ""; }
		echo '
				<tr>
					<td>'.$row['invoicenumber'].'</td>
					<td>'.$row['invoiceamountusd'].'</td>
					<td>'.$row['invoiceamount'].'</td>
					<td>'.date("d/m/Y H:i",$row['invoicedate']).'</td>
					<td>'.$row['transactionreferenceid'].'</td>
					<td>'.$row['goldcount'].'</td>
					<td><a href="?p=player&uid='.$uid.'">'.$username.'</a> '.$access.'</td>
					<td>'.($row['approved']==1?'<font color="#00dd00">Yes</font>':'<font color="#dd0000">No</font>').'</td>
					<td>'.($row['approved']==1?date("d/m/Y H:i",$row['approvedate']):'-').'</td>
					<td>'.$row['payedby'].'</td>
				</tr>  
			';
	}
}else{
	echo '<tr><td colspan="10" align="center">هیچ بازیکنی ثبت نام نکرده است</td></tr>';
} 

?>    

</table>
<div class="footer">
	<div class="paginator">
    <?php echo $paginationDisplay; ?>
    </div>
    <div class="clear"></div>
</div>