<?php
$active = $this->model->getUserActive(); 
?>
<div align="center">
	<ul class="tabs"><center>
		<li>Online players (<?php echo count($active);?>)</li>
        </center>
	</ul>
</div>
<table id="member" border="1" cellpadding="3" align="center" dir="ltr"> 
    <tr style="height:30px;">
        <td dir="ltr"><center>Name [<b>access</b>]</center></td>
        <td><b>time</b></td>
        <td><b>tribe</b></td> 
        <td><b>population</b></td> 
        <td><b>villages</b></td> 
        <td><b>gold</b></td>  
        <td><b>gold balance</b></td>  
        <td><b>silver</b></td>
        <td><b>silver balance</b></td>
        <td></td>
    </tr>
<?php
	$time = time() - (60*5);
	$sql = mysql_query("SELECT * FROM ".TB_PREFIX."users where timestamp > $time and id > 3 ORDER BY username ASC $limit");
	$query = mysql_num_rows($sql);
	if (isset($_GET['page'])) { // دریافت شماره صفحه
		$page = preg_replace('#[^0-9]#i', '', $_GET['page']); // فیلتر کردن همه چیز به جز اعداد
	} else {
		$page = 1;
	}
	
	$itemsPerPage = 10; //تعداد آیتم های قابل نمایش در هر صفحه
	$lastPage = ceil($query / $itemsPerPage); // دریافت مقدار آخرین صفحه
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
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=2">2</a>';
		
	}elseif ($page == 1 && $lastPage == 3) {
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=2">2</a> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=3">3</a>';
		
	}elseif ($page == 1) {
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $add1 . '">' . $add1 . '</a> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $add2 . '">' . $add2 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $lastPage . '">' . $lastPage . '</a>';
		
	} else if ($page == $lastPage && $lastPage == 2) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == $lastPage && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=2">2</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == $lastPage) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub2 . '">' . $sub2 . '</a> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span>';
		
	} else if ($page == ($lastPage - 1) && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $lastPage . '">' . $lastPage . '</a>';
	
	} else if ($page > 2 && $page < ($lastPage - 1)) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $add1 . '">' . $add1 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $lastPage . '">' . $lastPage . '</a>';
		
	}else if ($page == ($lastPage - 1)) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=1">1</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $lastPage . '">' . $lastPage . '</a>';
	
	} else if ($page > 1 && $page < $lastPage && $lastPage == 3) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $add1 . '">' . $add1 . '</a>';
		
	} else if ($page > 1 && $page < $lastPage) {
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $sub1 . '">' . $sub1 . '</a> ';
		$centerPages .= '<span class="number currentPage">' . $page . '</span> ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $add1 . '">' . $add1 . '</a> ... ';
		$centerPages .= '<a class="number" href="index.php?p=onlines&page=' . $lastPage . '">' . $lastPage . '</a>';
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
		$paginationDisplay .=  '<a class="next" href="index.php?p=onlines&page=' . $nextPage . '"><img alt="صفحه بعد" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="last" href="index.php?p=onlines&page=' . $lastPage . '"><img alt="صفحه آخر" src="../img/x.gif"></a>';
	
	}elseif ($page != "1" && $page != $lastPage){
		$paginationDisplay .=  '<a class="first" href="index.php?p=onlines&page=1"><img alt="صفحه اول" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="previous" href="index.php?p=onlines&page=' . $previous . '"><img alt="صفحه قبل" src="../img/x.gif"></a>';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<a class="next" href="index.php?p=onlines&page=' . $nextPage . '"><img alt="صفحه بعد" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="last" href="index.php?p=onlines&page=' . $lastPage . '"><img alt="صفحه آخر" src="../img/x.gif"></a>';
	
	}elseif ($page == $lastPage){
		$paginationDisplay .=  '<a class="first" href="index.php?p=onlines&page=1"><img alt="صفحه اول" src="../img/x.gif"></a> ';
		$paginationDisplay .=  '<a class="previous" href="index.php?p=onlines&page=' . $previous . '"><img alt="صفحه قبل" src="../img/x.gif"></a>';
		$paginationDisplay .= $centerPages;
		$paginationDisplay .=  '<img alt="صفحه بعد" src="../img/x.gif" class="next disabled"> ';
		$paginationDisplay .=  '<img alt="صفحه آخر" src="../img/x.gif" class="last disabled">';
	}
	
	$limit = 'LIMIT ' .($page - 1) * $itemsPerPage .',' .$itemsPerPage; 
	$time = time() - (60*5);
	$sql2 = mysql_query("SELECT * FROM ".TB_PREFIX."users where timestamp > $time and id > 3 ORDER BY username ASC $limit");

if($query>0){
	while($row = mysql_fetch_array($sql2)){
		$uid = $row['id'];
		$sql3 = mysql_query("SELECT * FROM ".TB_PREFIX."vdata where owner = $uid");
		$vil = $database->mysql_fetch_all($sql3);
		$totalpop = 0;

		foreach($vil as $varray) {
			$totalpop += $varray['pop'];
		}
		if($row['tribe'] == 1){
			$tribe = "رومی ها";
		} else if($row['tribe'] == 2){
			$tribe = "توتن ها";
		} else if($row['tribe'] == 3){
			$tribe = "گول ها";
		}
		if($row['access'] == 9){
			$access = "[<b>مدیر</b>]";
        } elseif($row['access'] == 8){
			$access = "[<b>مولتی هانتر</b>]";
        } elseif($row['access'] == 0){
			$access = "[<b>بازداشت</b>]";
        }else{ $access = ""; }
		$gcolor = $scolor = '#00000';
		$row['gbalance'] = ($row['boughtgold']+$row['giftgold']+$row['seggold']+$row['transferedgold']-$row['usedgold']);
		if($row['gbalance']<$row['gold']){$gcolor='#bb0000';} elseif($row['gbalance']>$row['gold']){$gcolor='#aa5500';} 
		$row['sbalance'] = ($row['giftsilver']+$row['gessilver']+$row['sisilver']-$row['bisilver']);
		if($row['sbalance']<$row['silver']){$scolor='#bb0000';} elseif($row['silver']>$row['silver']){$scolor='#aa5500';} 
		echo '
				<tr>
					<td dir="ltr"><a href="?p=player&uid='.$uid.'">'.$row['username'].'</a> '.$access.'</td>
					<td>'.date("d/m/Y H:i",$row['timestamp']).'</td>
					<td>'.$tribe.'</td>
					<td>'.$totalpop.'</td>
					<td>'.count($vil).'</td>
					<td><img src="../img/admin/gold.gif" class="gold" alt="Gold" title="این بازیکن '.$row['gold'].' طلا دارد"/> '.$row['gold'].'</td>
					<td><img src="../img/admin/gold.gif" class="gold" alt="Gold" title="بالانس طلای این بازیکن '.$row['gbalance'].' است"/> <font color="'.$gcolor.'">'.$row['gbalance'].'</font></td>
					<td><img src="../img/admin/silver.gif" class="gold" alt="Silver" title="این بازیکن '.$row['silver'].' نقره دارد"/> '.$row['silver'].'</td>
					<td><img src="../img/admin/silver.gif" class="gold" alt="Silver" title="بالانس نقره این بازیکن '.$row['sbalance'].' است"/> <font color="'.$scolor.'">'.$row['sbalance'].'</font></td>
					<td><a href="?p=Users&uid='.$uid.'"><img title="ویرایش بازیکن" border="0" src="../img/admin/edit.gif"></a></td>
				</tr>  
			';
	}
}else{
	echo '<tr><td colspan="8" align="center">هیچ بازیکنی آنلاین نیست</td></tr>';
} 

?>    

</table>
<div class="footer">
	<div class="paginator">
    <?php echo $paginationDisplay; ?>
    </div>
    <div class="clear"></div>
</div>