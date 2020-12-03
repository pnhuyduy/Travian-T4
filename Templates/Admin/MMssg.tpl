<?php
if($session->uid > 2 && $session->uid != 4) die('Hacking attemp!');
include('Templates/html.tpl');

if(!isset($_GET['action'])){
$prefix = ''.TB_PREFIX.'mdata';
$sql = mysql_query("SELECT `id` FROM $prefix ORDER BY time DESC");
$query = mysql_num_rows($sql); // &#1583;&#1585;&#1740;&#1575;&#1601;&#1578; &#1578;&#1593;&#1583;&#1575;&#1583; &#1705;&#1608;&#1574;&#1585;&#1740; &#1607;&#1575; &#1575;&#1586; &#1583;&#1740;&#1578;&#1575;&#1576;&#1740;&#1587;

if (isset($_GET['page'])){$page = preg_replace('#[^0-9]#i', '', $_GET['page']);}else{$page = 1;} 

$itemsPerPage = 10;
$lastPage = ceil($query / $itemsPerPage);

if ($page < 1){$page = 1;}elseif($page > $lastPage){$page = $lastPage;} 

$centerPages = '';
$sub1 = $page - 1;
$sub2 = $page - 2;
$sub3 = $page - 3;
$add1 = $page + 1;
$add2 = $page + 2;
$add3 = $page + 3;

if ($page <= 1 && $lastPage <= 1){$centerPages .= '<span class="number currentPage">1</span>';

}elseif ($page == 1 && $lastPage == 2){
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=2">2</a>';
	
}elseif ($page == 1 && $lastPage == 3){
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=2">2</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=3">3</a>';

}elseif ($page == 1){
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $add1 . '">' . $add1 . '</a> ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $add2 . '">' . $add2 . '</a> ... ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page == $lastPage && $lastPage == 2){
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == $lastPage && $lastPage == 3){
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=2">2</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == $lastPage){
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub2 . '">' . $sub2 . '</a> ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span>';

} else if ($page == ($lastPage - 1) && $lastPage == 3){
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page > 2 && $page < ($lastPage - 1)){
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $add1 . '">' . $add1 . '</a> ... ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '">' . $lastPage . '</a>';

}else if ($page == ($lastPage - 1)){
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1">1</a> ... ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '">' . $lastPage . '</a>';

} else if ($page > 1 && $page < $lastPage && $lastPage == 3){
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $add1 . '">' . $add1 . '</a>';

} else if ($page > 1 && $page < $lastPage){
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $sub1 . '">' . $sub1 . '</a> ';
    $centerPages .= '<span class="number currentPage">' . $page . '</span> ';
    $centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $add1 . '">' . $add1 . '</a> ... ';
	$centerPages .= '<a class="number" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '">' . $lastPage . '</a>';
}

$limit = 'LIMIT ' .($page - 1) * $itemsPerPage .',' .$itemsPerPage; 
$result2 = mysql_query("SELECT * FROM $prefix ORDER BY time DESC $limit");
$paginationDisplay = '';
$nextPage = $_GET['page'] + 1;
$previous = $_GET['page'] - 1;

if ($page == '1' && $lastPage == '1'){
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1575;&#1608;&#1604;" src="img/x.gif" class="first disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1602;&#1576;&#1604;" src="img/x.gif" class="previous disabled">';
$paginationDisplay .= $centerPages;
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1576;&#1593;&#1583;" src="img/x.gif" class="next disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1570;&#1582;&#1585;" src="img/x.gif" class="last disabled">';

}elseif ($lastPage == 0){
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1575;&#1608;&#1604;" src="img/x.gif" class="first disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1602;&#1576;&#1604;" src="img/x.gif" class="previous disabled">';
$paginationDisplay .= $centerPages;
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1576;&#1593;&#1583;" src="img/x.gif" class="next disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1570;&#1582;&#1585;" src="img/x.gif" class="last disabled">';

}elseif ($page == '1' && $lastPage != '1'){
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1575;&#1608;&#1604;" src="img/x.gif" class="first disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1602;&#1576;&#1604;" src="img/x.gif" class="previous disabled">';
$paginationDisplay .= $centerPages;
$paginationDisplay .=  '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $nextPage . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1576;&#1593;&#1583;" src="img/x.gif"></a> ';
$paginationDisplay .=  '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1570;&#1582;&#1585;" src="img/x.gif"></a>';

}elseif ($page != '1' && $page != $lastPage){
$paginationDisplay .=  '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1"><img alt="&#1589;&#1601;&#1581;&#1607; &#1575;&#1608;&#1604;" src="img/x.gif"></a> ';
$paginationDisplay .=  '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $previous . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1602;&#1576;&#1604;" src="img/x.gif"></a>';
$paginationDisplay .= $centerPages;
$paginationDisplay .=  '<a class="next" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $nextPage . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1576;&#1593;&#1583;" src="img/x.gif"></a> ';
$paginationDisplay .=  '<a class="last" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $lastPage . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1570;&#1582;&#1585;" src="img/x.gif"></a>';

}elseif ($page == $lastPage){
$paginationDisplay .=  '<a class="first" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=1"><img alt="&#1589;&#1601;&#1581;&#1607; &#1575;&#1608;&#1604;" src="img/x.gif"></a> ';
$paginationDisplay .=  '<a class="previous" href="' . $_SERVER['PHP_SELF'] . '?tid=3&page=' . $previous . '"><img alt="&#1589;&#1601;&#1581;&#1607; &#1602;&#1576;&#1604;" src="img/x.gif"></a>';
$paginationDisplay .= $centerPages;
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1576;&#1593;&#1583;" src="img/x.gif" class="next disabled"> ';
$paginationDisplay .=  '<img alt="&#1589;&#1601;&#1581;&#1607; &#1570;&#1582;&#1585;" src="img/x.gif" class="last disabled">';
}?>
 </table>
 <table cellpadding="0" cellspacing="1"  border="0" >
 <tr><td>&#1578;&#1606;&#1592;&#1740;&#1605;&#1575;&#1578;</td><td>&#1601;&#1585;&#1587;&#1578;&#1606;&#1583;&#1607;</td><td>&#1711;&#1610;&#1585;&#1606;&#1583;&#1607;</td><td>&#1605;&#1608;&#1590;&#1608;&#1593;</td><td>&#1662;&#1610;&#1575;&#1605;</td><td>&#1608;&#1590;&#1593;&#1610;&#1578;</td><td>&#1586;&#1605;&#1575;&#1606;</td></tr>
<?php
while($rowss1=mysql_fetch_array($result2)){
	$ids=$rowss1['id'];
	$fromplayername=$rowss1['owner'];
	$toplayername=$rowss1['target'];
	$msgtitle=$rowss1['topic'];
	$msgbody=$rowss1['message'];
	$isreaded=$rowss1['viewed'];
	$time=$rowss1['time'];
	$delowner=$rowss1['delowner'];
	$deltarget=$rowss1['deltarget'];
	if($delowner == 1){$Fcolor = 'red';}else{$Fcolor = 'black';}
	if($deltarget == 1){$Tcolor = 'red';}else{$Tcolor = 'black';}
	$date = $generator->procMtime($time);
	$fromplayername = mysql_fetch_array(mysql_query("SELECT `username` FROM ".TB_PREFIX."users WHERE id = $fromplayername LIMIT 1"));
	$toplayername = mysql_fetch_array(mysql_query("SELECT `username` FROM ".TB_PREFIX."users WHERE id = $toplayername LIMIT 1"));
	$msgbody = preg_replace('/\[message\]/', '', $msgbody);
	$msgbody = preg_replace('/\[\/message\]/', '', $msgbody);
	if ($isreaded==0 ){$read="<img src=\"../img/admin/merror.png\" height=\"20\" title=\"&#1582;&#1608;&#1575;&#1606;&#1583;&#1607; &#1606;&#1588;&#1583;&#1607;\">";}elseif ($isreaded==1 ){$read="<img src=\"../img/admin/msuccess.gif\" height=\"20\" title=\"&#1582;&#1608;&#1575;&#1606;&#1583;&#1607; &#1588;&#1583;&#1607;\">";}
	echo'<tr>'.'<td>'
     .
	 '<a href="?action=del&did='.$ids.'" onClick="return del(\'did\','.$ids.');"><img src="../img/admin/del.gif" class="del" title="&#1581;&#1584;&#1601;"></a> '.
	 '<a href="?action=edit&did='.$ids.'" onClick="return edit(\'did\','.$ids.');"><img src="../img/admin/edit.gif" class="edit" title="&#1608;&#1740;&#1585;&#1575;&#1740;&#1588;"></a>'.
     '</td>'.'<td>'
     .'<font color="'.$Fcolor.'">'.$fromplayername['username'].'</font>'.
     '</td>'.'<td>'
     .'<font color="'.$Tcolor.'">'.$toplayername['username'].'</font>'.
     '</td>'.'<td>'
     .'<textarea title='.$msgtitle.' readonly="readonly" style=" width:80px;  height:60px; text-align:right; ">',$msgtitle,' </textarea>'.
     '</td>'.'<td>'
     .'<textarea title='.$msgbody.' readonly="readonly" style=" width:80px;  height:60px; text-align:right;  ">',stripslashes(nl2br($msgbody)),' </textarea>'.
     '</td>'.'<td>'
     .$read.
     '</td>'
	 ."<td class=\"dat\">".$date[0]."".date('H:i',$time)."".'</tr>';
} echo '</table>';
}elseif(isset($_GET['action']) && $_GET['action'] == 'edit'){
$did = filter_var($_GET['did'], FILTER_SANITIZE_NUMBER_INT);
$prefix = ''.TB_PREFIX.'mdata';
$sqlz = mysql_query("SELECT * FROM $prefix WHERE id = $did LIMIT 1");
$rowss2 = mysql_fetch_array($sqlz);
	$ids=$rowss2['id'];
	$fromplayername=$rowss2['owner'];
	$toplayername=$rowss2['target'];
	$msgtitle=$rowss2['topic'];
	$msgbody=$rowss2['message'];
	$msgbody = preg_replace('/\[message\]/', '', $msgbody);
	$msgbody = preg_replace('/\[\/message\]/', '', $msgbody);
?>
<form action="?action=edit&done=edit" method="POST">
<input type="hidden" name="id" id="id" value="<?php echo $ids; ?>">
<table cellpadding="0" cellspacing="1"  border="0" >
<tr><td></td><td>&#1601;&#1585;&#1587;&#1578;&#1606;&#1583;&#1607;</td><td>&#1711;&#1610;&#1585;&#1606;&#1583;&#1607;</td><td>&#1605;&#1608;&#1590;&#1608;&#1593;</td><td>&#1662;&#1610;&#1575;&#1605;</td></tr>
<?php
echo'<tr>'.'<td>'.
	 '<a href="'.$_SERVER['HTTP_REFERER'].'"><img src="../img/admin/mreturn.png" title="&#1576;&#1575;&#1586;&#1711;&#1588;&#1578;"></a>'.
     '</td>'.'<td>'
     .'<input name="from" value="'.$fromplayername.'" size = 3>'.
     '</td>'.'<td>'
     .'<input name="to" value="'.$toplayername.'" size = 3>'.
     '</td>'.'<td>'
     .'<textarea name ="msgtitle" title='.$msgtitle.' style=" width:150px;  height:300px; text-align:right; ">',$msgtitle,' </textarea>'.
     '</td>'.'<td>'
     .'<textarea name ="msgbody" title='.$msgbody.' style=" width:150px;  height:300px; text-align:right;  ">',stripslashes(nl2br($msgbody)),' </textarea>'.
     '</td>'.'</tr>';
if(isset($_GET['action']) && isset($_GET['done']) && $_GET['done'] = 'edit'){
$id = filter_var($_POST['id'], FILTER_SANITIZE_NUMBER_INT);
$from = filter_var($_POST['from'], FILTER_SANITIZE_NUMBER_INT);
$to = filter_var($_POST['to'], FILTER_SANITIZE_NUMBER_INT);
$msgtitle = filter_var($_POST['msgtitle'], FILTER_SANITIZE_MAGIC_QUOTES);
$msgbody = filter_var($_POST['msgbody'], FILTER_SANITIZE_MAGIC_QUOTES);
mysql_query("UPDATE ".TB_PREFIX."mdata set target = ".$to.", owner = ".$from.", topic = '".$msgtitle."' , message = '".$msgbody."' WHERE id = ".$id."")or die(mysql_error());
header('Location: MMssg.php');
Exit();
}
?>
</table><br /><br />
<center>
<input type='image' src='../img/admin/b/ok1.gif' value='submit'>
</center>
</form>
<?php
}else
if(isset($_GET['action']) && $_GET['action'] = 'del' && isset($_GET['did'])){
$id = filter_var($_GET['did'], FILTER_SANITIZE_NUMBER_INT);

mysql_query("UPDATE ".TB_PREFIX."mdata set deltarget = 1, delowner = 1 WHERE id = ".$id."")or die(mysql_error());
header('Location: MMssg.php');
exit();
}
?>
<div class='paginator'>
<?php echo $paginationDisplay; ?>
</div>