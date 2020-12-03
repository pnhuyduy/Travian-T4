<div class="contentNavi subNavi">
    <div class="container active">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><a href="dorf3.php"><span class="tabItem"><?php echo AL_OVERVIEW; ?></span></a></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo VL_RESOURCE; ?></span></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo B10; ?></span></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo BL_CULTUREPOINTS; ?></span></div>
    </div>
    <div class="container normal">
        <div class="background-start">&nbsp;</div>
        <div class="background-end">&nbsp;</div>
        <div class="content"><span class="tabItem"><?php echo AT_TROOPS; ?></span></div>
    </div>
    <div class="clear"></div>
</div>
<table cellpadding="1" cellspacing="1" id="overview">
    <thead>
    <tr>
        <td><?php echo VL_VILLAGE; ?></td>
        <td><?php echo AT_ATTACKS; ?></td>
        <td><?php echo FD_BUILDINGS; ?></td>
        <td><?php echo AT_TROOPS; ?></td>
        <td><?php echo MK_MERCHANTS; ?></td>
    </tr>
    </thead>
    <tbody>
    <?php
        $varray = $database->getProfileVillages($session->uid);
        foreach ($varray as $vil) {
            $vid = $vil['wref'];
            $vdata = $database->getVillage($vid);
            if ($vdata['capital'] == 1) {
                $class = 'hl';
            } else {
                $class = '';
            }
            $vname = $vdata['name'];
            $cVName = constant($vname);
            echo '
  <tr class="' . $class . '">
		   <td class="vil fc"><a href="dorf1.php?newdid=' . $vid . '">' . ($cVName ? $cVName : $vname) . '</a></td>
		   <td class="att"><span class="none">?</span></td>
		   <td class="bui"><span class="none">?</span></td> 
		   <td class="tro"><span class="none">?</span></td>
		   <td class="tra lc"><a href="build.php?gid=17">?/?</a></td>
	</tr> 
  ';
        }
    ?>
    </tbody>
</table>
