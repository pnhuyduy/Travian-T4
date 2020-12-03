<div id='village_map'>
<?php
    $tx = $_SESSION['wid'];
    if ($building->walling()) {
        $wtitle = $building->procResType($building->walling()) . ' Level ' . $village->resarray['f40'];
    } else {
        $wtitle = ($village->resarray['f40'] == 0) ? 'Building site' : $building->procResType($village->resarray['f40t'], 0) . ' Level ' . $village->resarray['f40'];
    }

    if (DIRECTION == 'ltr') {
        echo "<map name='clickareas' id='clickareas'>";
        $coords = array(19 => "110,135,132,120,132,121,160,122,179,136,179,151,158,163,128,163,109,149",
            "202,93,223,79,223,79,251,80,271,95,271,109,249,121,220,121,200,108",
            "290,76,311,61,311,62,339,63,359,77,359,92,337,104,308,104,289,90",
            "384,105,406,91,406,91,434,92,453,106,453,121,432,133,402,133,383,120",
            "458,147,479,133,479,133,507,134,527,149,527,164,505,175,476,175,457,162",
            "71,184,92,170,92,171,120,172,140,186,139,201,118,213,88,213,69,199",
            "516,196,538,182,538,182,566,183,585,198,585,212,564,224,534,224,515,211",
            "280,113,301,98,301,99,329,100,349,114,348,169,327,181,298,181,278,168",
            "97,320,118,306,118,307,146,308,166,322,165,337,144,349,114,349,95,335",
            "59,244,80,230,80,230,108,231,128,246,128,260,106,272,77,272,57,259",
            "477,249,498,235,498,235,526,236,546,251,545,265,524,277,494,277,475,264",
            "181,259,202,245,202,245,230,246,250,261,250,275,228,287,199,287,180,274",
            "182,189,203,175,203,175,231,176,251,190,251,205,229,217,200,217,181,204",
            "254,308,276,294,276,294,304,295,324,309,323,324,302,336,272,336,253,323",
            "505,317,526,303,526,303,554,304,574,319,573,333,552,345,522,345,503,332",
            "182,379,204,365,204,365,232,366,251,380,251,395,230,407,200,407,181,394",
            "324,370,345,356,345,357,373,358,393,372,392,387,371,398,341,398,322,385",
            "433,334,454,320,454,321,482,322,502,336,502,351,480,362,451,362,432,349",
            "271,412,292,398,292,399,320,400,340,414,339,429,318,440,289,440,269,427",
            "396,396,417,381,417,382,445,383,465,397,464,412,443,424,413,424,394,410",
            "398,212,412,250,369,301,394,323,445,286,453,233,427,183",
            "71,450,2,374,3,374,-10,243,13,142,120,81,214,34,340,18,500,43,615,130,641,239,643,350,601,425,534,494,358,534,282,532,180,526,77,456,117,378,163,413,242,442,331,454,425,443,499,417,576,344,596,304,598,221,571,157,481,90,385,61,313,56,217,72,135,113,77,165,46,217,44,269,65,326,119,379");

    } else {
echo "<map name='clickareas' id='clickareas'>";

		$coords = array(19=>"518,135,496,120,496,121,468,122,449,136,449,151,470,163,500,163,519,149",
			"426,53,405,39,405,39,377,40,357,55,357,110,379,121,408,121,428,108",
			"338,36,317,21,317,22,289,23,269,37,269,92,291,104,320,104,339,91",
			"244,65,222,51,222,51,194,52,175,67,175,121,196,133,226,133,245,120",
			"170,107,149,93,149,94,121,95,101,109,101,164,123,176,152,176,172,162",
			"557,184,536,170,536,171,508,172,488,186,489,201,510,213,540,213,559,199",
			"112,156,90,142,90,142,62,144,43,158,43,213,65,224,94,224,113,211",
			"348,113,327,98,327,99,299,100,279,114,280,169,301,181,330,181,350,168",
			"531,320,510,306,510,307,482,308,462,322,463,337,484,349,514,349,533,335",
			"569,244,548,230,548,230,520,231,500,246,500,260,522,272,551,272,571,259",
			"151,249,130,235,130,235,102,236,82,251,83,265,104,277,134,277,153,264",
			"447,259,426,245,426,245,398,246,378,261,378,275,400,287,429,287,448,274",
			"446,189,425,175,425,175,397,176,377,190,377,205,399,217,428,217,447,204",
			"374,268,352,254,352,254,324,255,304,270,305,324,326,336,356,336,375,323",
			"123,317,102,303,102,303,74,304,54,319,55,333,76,345,106,345,125,332",
			"446,379,424,365,424,365,396,366,377,380,377,395,398,407,428,407,447,394",
			"304,370,283,356,283,357,255,358,235,372,236,387,257,398,287,398,306,385",
			"195,334,174,320,174,321,146,322,126,336,126,351,148,362,177,362,196,349",
			"357,412,336,398,336,399,308,400,288,414,289,429,310,440,339,440,359,427",
			"232,396,211,381,211,382,183,383,163,397,164,412,185,424,215,424,234,410",
			"230,212,216,250,259,301,234,323,183,286,175,233,201,183",
			"557,450,626,374,625,374,638,243,615,142,508,81,414,34,288,18,128,43,13,130,-13,239,-15,350,27,425,94,494,270,534,346,532,448,526,551,456,511,378,465,413,386,442,297,454,203,443,129,417,52,344,32,304,30,221,57,157,147,90,243,61,315,56,411,72,493,113,551,165,582,217,584,269,563,326,509,379");



    }

    for ($t = 19; $t <= 40; $t++) {
        $loopsame = $building->isCurrent($t) ? 1 : 0;
        if ($loopsame > 0 && $building->isLoop($t)) {
            $doublebuild = 1;
        }
        $lev = $village->resarray['f' . $t] + ($loopsame > 0 ? 2 : 1) + $doublebuild;
        $lvl = $lev - 1;
        $uprequire = $building->resourceRequired($t, $village->resarray['f' . $t . 't'], ($loopsame > 0 ? 2 : 1) + $doublebuild);
        if (($village->resarray['f99t'] == 40 AND ($t) == '26') or ($village->resarray['f99t'] == 40 AND ($t) == '30') or ($village->resarray['f99t'] == 40 AND ($t) == '31') or ($village->resarray['f99t'] == 40 AND ($t) == '32')) {
            echo "<area href=\"build.php?id=99\" title=\"<div style=color:#FFF><b>Wonder</b></div> Level " . $village->resarray['f99'] . "\" coords=\"$coords[$t]\" shape=\"poly\"/>";
        } else {
            $bindicate = $building->canBuild($t,$village->resarray['f'.$t.'t']);
            if($bindicate == 8 && isset($_COOKIE['fsbuilder']) && $village->resarray['f'.$t.'t'] != 0 ){
                $href = "dorf2.php?a=$t&c=$session->checker";
            }else{
                $href = "build.php?id=$t";
            }
            if ($village->resarray['f' . $t] <= 19) {
                echo "<area id= \"Build2Status".$t."\" href=\"$href\" alt= \"صبر کنید..\" title=\"صبر کنید..\" coords=\"$coords[$t]\" shape=\"poly\"/>";
            } else {
                echo "<area id= \"Build2Status".$t."\" href=\"$href\" alt= \"صبر کنید..\" title=\"صبر کنید..\" coords=\"$coords[$t]\" shape=\"poly\"/>";
            }
        }
        if ($village->resarray['f' . $t] > 20) {
            $ids = 'f' . $t;
            mysql_query("UPDATE " . TB_PREFIX . "fdata SET $ids = 20 WHERE vref=" . $village->wid);
        }
        ?>

        <script type="text/javascript">
            window.addEvent('domready', function () {
                var element = $('Build2Status<?php echo $t;?>');
                if (!element) {
                    return;
                }
                var fnbuildTitle = function () {
                    element.removeEvent('mouseover', fnbuildTitle);
                    Travian.ajax({
                        data: {cmd: 'getFieldStatus2', data: {id:<?php echo $t;?>}},
                        onSuccess: function (data) {
                            element.setTitle(data.getFieldStatus);
                        }
                    });
                };
                element.addEvent('mouseover', fnbuildTitle);
            });
        </script>
    <?php
    }
    if ($village->resarray['f40'] == 0) {
        if ($building->walling()) {
            $wtitle = $building->procResType($building->walling()) . " Level " . $village->resarray['f40'];
            echo "<img src=\"img/x.gif\" class=\"wall g3" . $session->tribe . "Top \" alt=\"$wtitle level " . $village->resarray['f40'] . "\">";
            echo "<img src=\"img/x.gif\" class=\"wall g3" . $session->tribe . "bBottom \" alt=\"$wtitle level " . $village->resarray['f40'] . "\">";
        }
    } else {
        $wtitle = $building->procResType($building->walling()) . " Level " . $village->resarray['f40'];
        echo "<img src=\"img/x.gif\" class=\"wall g3" . $session->tribe . "Top \" alt=\"$wtitle level " . $village->resarray['f40'] . "\">";
        echo "<img src=\"img/x.gif\" class=\"wall g3" . $session->tribe . "Bottom \" alt=\"$wtitle level " . $village->resarray['f40'] . "\">";
    }
    echo "</map>";
    for ($i = 1; $i <= 20; $i++) {
        if (($village->resarray['f99t'] == 40 AND ($i + 18) == '26') or ($village->resarray['f99t'] == 40 AND ($i + 18) == '30') or ($village->resarray['f99t'] == 40 AND ($i + 18) == '31') or ($village->resarray['f99t'] == 40 AND ($i + 18) == '32')) {
        } else {
            $text = 'Building site';
            $img = 'iso';
            if ($village->resarray['f' . ($i + 18) . 't'] != 0) {
                $text = $building->procResType($village->resarray['f' . ($i + 18) . 't']) . ' Level ' . $village->resarray['f' . ($i + 18)];
                $img = 'g' . $village->resarray['f' . ($i + 18) . 't'];
            }
            foreach ($building->buildArray as $job) {
                if ($job['field'] == ($i + 18)) {
                    $img = 'g' . $job['type'] . 'b';
                    $text = $building->procResType($job['type']) . ' Level ' . $village->resarray['f' . $job['field']];
                }
            }

            if (DIRECTION == 'ltr') {
                $style = array("",
                    "left:81px; top:56px; z-index:19",
                    "left:174px; top:14px; z-index:17",
                    "left:261px; top:-4px; z-index:15",
                    "left:354px; top:25px; z-index:17",
                    "left:428px; top:68px; z-index:20",
                    "left:42px; top:106px; z-index:23",
                    "left:485px; top:118px; z-index:24",
                    "left:249px; top:70px; z-index:20",
                    "left:68px; top:240px; z-index:32",
                    "left:31px; top:166px; z-index:27",
                    "left:448px; top:169px; z-index:27",
                    "left:153px; top:182px; z-index:28",
                    "left:155px; top:109px; z-index:23",
                    "left:227px; top:229px; z-index:32",
                    "left:476px; top:237px; z-index:32",
                    "left:153px; top:299px; z-index:36",
                    "left:295px; top:290px; z-index:36",
                    "left:404px; top:253px; z-index:33",
                    "left:241px; top:332px; z-index:39",
                    "left:365px; top:317px; z-index:38"
                );
            } else {

                $style = array("",
	"right:81px; top:57px; z-index:19",
	"right:174px; top:15px; z-index:17",
	"right:261px; top:-3px; z-index:15",
	"right:354px; top:26px; z-index:17",
	"right:428px; top:69px; z-index:20",
	"right:42px; top:107px; z-index:23",
	"right:485px; top:119px; z-index:24",
	"right:249px; top:71px; z-index:20",
	"right:68px; top:241px; z-index:32",
	"right:31px; top:167px; z-index:27",
	"right:448px; top:170px; z-index:27",
	"right:153px; top:183px; z-index:28",
	"right:155px; top:110px; z-index:23",
	"right:227px; top:230px; z-index:32",
	"right:476px; top:238px; z-index:32",
	"right:153px; top:300px; z-index:36",
	"right:295px; top:291px; z-index:36",
	"right:404px; top:254px; z-index:33",
	"right:241px; top:333px; z-index:39",
	"right:365px; top:318px; z-index:38"

                );
            }
            echo "<img style='" . $style[$i] . "' src=\"img/x.gif\" class=\"building d$i $img\" alt=\"$text\" />";
            //set event last quest firework..hooooray!!
            if ($_SESSION['qst'] == 38) {
                if ($i < 8) {
                    $dte = array("rocket_green", "rocket_red", "rocket_purp", "rocket_yell", "rocket_oran", "rocket_tur", "", "");
                    $im = $dte[$i];
                    echo "<img src=\"img/x.gif\" class=\"building d$i rocket $im\" alt=\"$text\" />";
                }
            }
        }
    }
    if ($_SESSION['qst'] == 38) {
        $database->updateUserField($_SESSION['username'], 'quest', '40', 0);
        $_SESSION['qst'] = 40;
    }
    if ($village->resarray['f39'] == 0) {
        if ($building->rallying()) {
            if ($village->resarray['f99t'] == 40) {
                echo "<img src=\"img/x.gif\" class=\"building g16b_ww\" alt=\"Rally point Level " . $village->resarray['f39'] . "\" />";
            } else {
                echo "<img src=\"img/x.gif\" class=\"building g16b\" alt=\"Rally point Level " . $village->resarray['f39'] . "\" />";
            }
        } else {
            if ($village->resarray['f99t'] == 40) {
                echo "<img src=\"img/x.gif\" class=\"building g16e_ww\" alt=\"building site\" />";
            } else {
                echo "<img src=\"img/x.gif\" class=\"building g16e\" alt=\"building site\" />";
            }
        }
    } else {
        if ($village->resarray['f99t'] == 40) {
            echo "<img src=\"img/x.gif\" class=\"building g16_ww\" alt=\"Rally point Level " . $village->resarray['f39'] . "\" />";
        } else {
            echo "<img src=\"img/x.gif\" class=\"building g16\" alt=\"Rally point Level " . $village->resarray['f39'] . "\" />";
        }
    }

    if ($village->resarray['f99t'] == 40) {
        if ($village->resarray['f99'] >= 0 && $village->resarray['f99'] <= 9) {
            echo '<img class="ww g40 g40_0" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 10 && $village->resarray['f99'] <= 19) {
            echo '<img class="ww g40 g40_1" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 20 && $village->resarray['f99'] <= 29) {
            echo '<img class="ww g40 g40_2" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 30 && $village->resarray['f99'] <= 39) {
            echo '<img class="ww g40 g40_3" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 40 && $village->resarray['f99'] <= 49) {
            echo '<img class="ww g40 g40_4" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 50 && $village->resarray['f99'] <= 59) {
            echo '<img class="ww g40 g40_5" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 60 && $village->resarray['f99'] <= 69) {
            echo '<img class="ww g40 g40_6" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 70 && $village->resarray['f99'] <= 79) {
            echo '<img class="ww g40 g40_7" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 80 && $village->resarray['f99'] <= 89) {
            echo '<img class="ww g40 g40_8" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 90 && $village->resarray['f99'] <= 94) {
            echo '<img class="ww g40 g40_9" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] >= 95 && $village->resarray['f99'] <= 99) {
            echo '<img class="ww g40 g40_10" src="img/x.gif" alt="Wonder">';
        } elseif ($village->resarray['f99'] == 100) {
            echo '<img class="ww g40 g40_11" src="img/x.gif" alt="Wonder">';
        }
    }

?>
<div id="levels" <?php if (isset($_COOKIE['t4level'])) {
    echo 'class=\'t44\'';
}
                $stylez = array("",
	"right:132px; top:108px",
	"right:225px; top:66px",
	"right:312px; top:48px",
	"right:405px; top:77px",
	"right:479px; top:120px",
	"right:93px; top:158px",
	"right:536px; top:170px",
	"right:300px; top:122px",
	"right:119px; top:292px",
	"right:82px; top:218px",
	"right:499px; top:221px",
	"right:204px; top:234px",
	"right:206px; top:161px",
	"right:278px; top:281px",
	"right:527px; top:289px",
	"right:204px; top:351px",
	"right:346px; top:342px",
	"right:455px; top:305px",
	"right:292px; top:384px",
	"right:416px; top:369px",


                );
 ?>>
    <?php
        for ($i = 1; $i <= 20; $i++) {
            if ($database->getBuildingByField($tx, $i + 18)) {
                ?>
                <script>
                    document.getElementById('levels').setAttribute('id', levels2)
                </script>
            <?php
                echo "<div class=\"l$i\"><div class=\"labelLayer\">" . $village->resarray['f' . ($i + 18)] . "</div></div>";
                }else{
                if ($village->resarray['f' . ($i + 18)] != 0){
            ?>
                <script>
                    document.getElementById('levels2').setAttribute('id', levels)
                </script>
                <?php
                $bindicate = $building->canBuild(($i + 18), $village->resarray['f' . ($i + 18) . 't']);
                echo "<div class=\"colorLayer ".(($village->resarray['f' . ($i + 18)] == 0) ? 'good' : ($bindicate == 1 ? 'maxLevel' : 'notNow'))." l$i\" style=\"$stylez[$i]\"><div class=\"labelLayer\">" . $village->resarray['f' . ($i + 18)] . "</div></div>";
            }
            }
        }
        if ($village->resarray['f39'] != 0) {
            echo "<div class=\"colorLayer ".(($village->resarray['f39'] == 0) ? 'good' : ($village->resarray['f39'] == 20 ? 'maxLevel' : 'notNow'))." l39\"  style=\"right:406px; top:225px\"><div class=\"labelLayer\">" . $village->resarray['f39'] . "</div></div>";
        }
        if ($village->resarray['f40'] != 0) {
            echo "<div class=\"colorLayer ".(($village->resarray['f40'] == 0) ? 'good' : ($village->resarray['f40'] == 20 ? 'maxLevel' : 'notNow'))." aid40\"><div class=\"labelLayer\">" . $village->resarray['f40'] . "</div></div>";
        }
        echo "</div>";
    ?>
    <div id="fswitcher" <?php if (isset($_COOKIE['fsbuilder'])) {
        echo 'class=\'on\'';
    } ?>></div>
    <img src="img/x.gif" id="fswitch" <?php if (isset($_COOKIE['fsbuilder'])) {
        echo "class=\"fastbuilderON\" title=\"Set Fast Builder Off\" ";
    } else {
        echo "class=\"fastbuilderOFF\" title=\"Set Fast Builder On\" ";
    } ?> onclick="
$('fswitch').toggleClass('fastbuilderOFF');
$('fswitch').toggleClass('fastbuilderON');
if ($('fswitcher').toggleClass('on').hasClass('on')){
	document.cookie = 'fsbuilder=1; expires=Wed, 1 Jan 2020 00:00:00 GMT';
}else{
	document.cookie = 'fsbuilder=1; expires=Thu, 01-Jan-1970 00:00:01 GMT';
}
document.location.href='dorf2.php';
"/>

    <img src="img/x.gif" id="lswitch" <?php if (isset($_COOKIE['t4level'])) {
        echo "class=\"lswitchMinus\"";
    } else {
        echo "class=\"lswitchPlus\"";
    } ?> onclick="
$('lswitch').toggleClass('lswitchMinus');
$('lswitch').toggleClass('lswitchPlus');
if ($('levels').toggleClass('on').hasClass('on')){
	document.cookie = 't4level=1; expires=Wed, 1 Jan 2020 00:00:00 GMT';
}else{
	document.cookie = 't4level=1; expires=Thu, 01-Jan-1970 00:00:01 GMT';
}
"/>
    <img class='clickareas' usemap='#clickareas' src='img/x.gif' alt=''/>
</div>