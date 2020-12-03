<?php
if(isset($btype) && isset($type)){
	if($btype==1){
	    	if($type==1){
			$name = HR_HELMETEXP1;
		    $item = "1";
		    $effect = "15";
				$title = sprintf(HR_HELMETEXPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==2){
			$name = HR_HELMETEXP2;
		    $item = "2";
		    $effect = "20";
				$title = sprintf(HR_HELMETEXPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==3){
			$name = HR_HELMETEXP3;
		    $item = "3";
		    $effect = "25";
				$title = sprintf(HR_HELMETEXPDESC,($effect*ITEMATTRSPEED));
			}
		if($type==4){
			$name = HR_HELMETREG1;
		    $item = "4";
		    $effect = "10";
				$title = sprintf(HR_HELMETREGDESC,($effect*ITEMATTRSPEED));
		}elseif($type==5){
			$name = HR_HELMETREG2;
		    $item = "5";
		    $effect = "15";
				$title = sprintf(HR_HELMETREGDESC,($effect*ITEMATTRSPEED));
		}elseif($type==6){
			$name = HR_HELMETREG3;
		    $item = "6";
		    $effect = "20";
				$title = sprintf(HR_HELMETREGDESC,($effect*ITEMATTRSPEED));
		}
		if($type==7){
			$name = HR_HELMETCP1;
		    $item = "7";
		    $effect = "100";
				$title = sprintf(HR_HELMETCPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==8){
			$name = HR_HELMETCP2;
		    $item = "8";
		    $effect = "400";
				$title = sprintf(HR_HELMETCPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==9){
			$name = HR_HELMETCP3;
		    $item = "9";
		    $effect = "800";
				$title = sprintf(HR_HELMETCPDESC,($effect*ITEMATTRSPEED));
			}
		if($type==10){
			$name = HR_HELMETCAV1;
		    $item = "10";
		    $effect = "10";
				$title = sprintf(HR_HELMETCAVDESC,($effect*ITEMATTRSPEED));
			}elseif($type==11){
			$name = HR_HELMETCAV2;
		    $item = "11";
		    $effect = "15";
				$title = sprintf(HR_HELMETCAVDESC,($effect*ITEMATTRSPEED));
			}elseif($type==12){
			$name = HR_HELMETCAV3;
		    $item = "12";
		    $effect = "20";
				$title = sprintf(HR_HELMETCAVDESC,($effect*ITEMATTRSPEED));
			}
		if($type==13){
			$name = HR_HELMETINF1;
		    $item = "13";
		    $effect = "10";
				$title = sprintf(HR_HELMETINFDESC,($effect*ITEMATTRSPEED));
			}elseif($type==14){
			$name = HR_HELMETINF2;
		    $item = "14";
		    $effect = "15";
				$title = sprintf(HR_HELMETINFDESC,($effect*ITEMATTRSPEED));
			}elseif($type==15){
			$name = HR_HELMETINF3;
		    $item = "15";
		    $effect = "20";
				$title = sprintf(HR_HELMETINFDESC,($effect*ITEMATTRSPEED));
			}
		
	}elseif($btype==2){
		if($type==82){
		$name = HR_ARMORREG1;
		$item = "82";
		    $effect = "20";
				$title = sprintf(HR_ARMORREGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==83){
			$name = HR_ARMORREG2;
		    $item = "83";
		    $effect = "30";
				$title = sprintf(HR_ARMORREGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==84){
			$name = HR_ARMORREG3;
		    $item = "84";
		    $effect = "40";
				$title = sprintf(HR_ARMORREGDESC,($effect*ITEMATTRSPEED));
			}
		if($type==85){
			$name = HR_ARMORSCA1;
		    $item = "85";
		    $effect = "10";
		    $effect2 = "4";
				$title = sprintf(HR_ARMORSCADESC,($effect*ITEMATTRSPEED),($effect2*ITEMATTRSPEED));
		}elseif($type==86){
			$name = HR_ARMORSCA2;
		    $item = "86";
		    $effect = "15";
		    $effect2 = "6";
				$title = sprintf(HR_ARMORSCADESC,($effect*ITEMATTRSPEED),($effect2*ITEMATTRSPEED));
		}elseif($type==87){
			$name = HR_ARMORSCA3;
		    $item = "87";
		    $effect = "20";
		    $effect2 = "8";
				$title = sprintf(HR_ARMORSCADESC,($effect*ITEMATTRSPEED),($effect2*ITEMATTRSPEED));
		}
		if($type==88){
			$name = HR_ARMORBPL1;
		    $item = "88";
		    $effect = "500";
				$title = sprintf(HR_ARMORBPLDESC,($effect));
			}elseif($type==89){
			$name = HR_ARMORBPL2;
		    $item = "89";
		    $effect = "1000";
				$title = sprintf(HR_ARMORBPLDESC,($effect));
			}elseif($type==90){
			$name = HR_ARMORBPL3;
		    $item = "90";
		    $effect = "1500";
				$title = sprintf(HR_ARMORBPLDESC,($effect));
			}
		if($type==91){
			$name = HR_ARMORSEG1;
		    $item = "91";
		    $effect = "3";
		    $effect2 = "250";
				$title = sprintf(HR_ARMORSEGDESC,($effect*ITEMATTRSPEED),($effect2));
			}elseif($type==92){
			$name = HR_ARMORSEG2;
		    $item = "92";
		    $effect = "4";
		    $effect2 = "500";
				$title = sprintf(HR_ARMORSEGDESC,($effect*ITEMATTRSPEED),($effect2));
			}elseif($type==93){
			$name = HR_ARMORSEG3;
		    $item = "93";
		    $effect = "5";
		    $effect2 = "750";
				$title = sprintf(HR_ARMORSEGDESC,($effect*ITEMATTRSPEED),($effect2));
			}
		
	}elseif($btype==3){
	    
			if($type==61){
			$name = HR_LEFTMAP1;
		    $item = "61";
		    $effect = "30";
				$title = sprintf(HR_LEFTMAPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==62){
			$name = HR_LEFTMAP2;
		    $item = "62";
		    $effect = "40";
				$title = sprintf(HR_LEFTMAPDESC,($effect*ITEMATTRSPEED));
			}elseif($type==63){
			$name = HR_LEFTMAP3;
		    $item = "63";
		    $effect = "50";
				$title = sprintf(HR_LEFTMAPDESC,($effect*ITEMATTRSPEED));
			}
		if($type==64){
			$name = HR_LEFTFLG1;
		    $item = "64";
		    $effect = "30";
				$title = sprintf(HR_LEFTFLGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==65){
			$name = HR_LEFTFLG2;
		    $item = "65";
		    $effect = "40";
				$title = sprintf(HR_LEFTFLGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==66){
			$name = HR_LEFTFLG3;
		    $item = "66";
		    $effect = "50";
				$title = sprintf(HR_LEFTFLGDESC,($effect*ITEMATTRSPEED));
			}
		if($type==67){
			$name = HR_LEFTFOF1;
		    $item = "67";
		    $effect = "15";
				$title = sprintf(HR_LEFTFOFDESC,($effect*ITEMATTRSPEED));
			}elseif($type==68){
			$name = HR_LEFTFOF2;
		    $item = "68";
		    $effect = "20";
				$title = sprintf(HR_LEFTFOFDESC,($effect*ITEMATTRSPEED));
			}elseif($type==69){
			$name = HR_LEFTFOF3;
		    $item = "69";
		    $effect = "25";
				$title = sprintf(HR_LEFTFOFDESC,($effect*ITEMATTRSPEED));
			}
		if($type==73){
			$name = HR_LEFTBAG1;
		    $item = "73";
		    $effect = "10";
				$title = sprintf(HR_LEFTBAGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==74){
			$name = HR_LEFTBAG2;
		    $item = "74";
		    $effect = "15";
				$title = sprintf(HR_LEFTBAGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==75){
			$name = HR_LEFTBAG3;
		    $item = "75";
		    $effect = "20";
				$title = sprintf(HR_LEFTBAGDESC,($effect*ITEMATTRSPEED));
			}
		if($type==76){
			$name = HR_RIGHTSLD1;
		    $item = "76";
		    $effect = "500";
				$title = sprintf(HR_RIGHTSLDDESC,($effect));
		}elseif($type==77){
			$name = HR_RIGHTSLD2;
		    $item = "77";
		    $effect = "1000";
				$title = sprintf(HR_RIGHTSLDDESC,($effect));
		}elseif($type==78){
			$name = HR_RIGHTSLD3;
		    $item = "78";
		    $effect = "1500";
				$title = sprintf(HR_RIGHTSLDDESC,($effect));
		}
		if($type==79){
			$name = HR_RIGHTNRH1;
		    $item = "79";
		    $effect = "25";
				$title = sprintf(HR_RIGHTNRHDESC,($effect*ITEMATTRSPEED));
			}elseif($type==80){
			$name = HR_RIGHTNRH2;
		    $item = "80";
		    $effect = "50";
				$title = sprintf(HR_RIGHTNRHDESC,($effect*ITEMATTRSPEED));
			}elseif($type==81){
			$name = HR_RIGHTNRH3;
		    $item = "81";
		    $effect = "75";
				$title = sprintf(HR_RIGHTNRHDESC,($effect*ITEMATTRSPEED));
			}
		
		}elseif($btype==4){
	    
			if($type==16){
			$name = HR_RIGHTU1S1;
		    $item = "16";
		    $effect = "500";
		    $effect2 = "3";
				$title = sprintf(HR_RIGHTU1SDESC,($effect),($effect2),($effect2));
			}elseif($type==17){
			$name = HR_RIGHTU1S2;
		    $item = "17";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU1SDESC,($effect),($effect2),($effect2));
			}elseif($type==18){
			$name = HR_RIGHTU1S3;
		    $item = "18";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU1SDESC,($effect),($effect2),($effect2));
			}
		if($type==19){
			$name = HR_RIGHTU2S1;
		    $item = "19";
				$effect2 = "3";
		    $effect = "500";
				$title = sprintf(HR_RIGHTU2SDESC,($effect),($effect2),($effect2));
		}elseif($type==20){
			$name = HR_RIGHTU2S2;
		    $item = "20";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU2SDESC,($effect),($effect2),($effect2));
		}elseif($type==21){
			$name = HR_RIGHTU2S3;
		    $item = "21";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU2SDESC,($effect),($effect2),($effect2));
		}
		if($type==22){
			$name = HR_RIGHTU3S1;
		    $item = "22";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU3SDESC,($effect),($effect2),($effect2));
			}elseif($type==23){
			$name = HR_RIGHTU3S2;
		    $item = "23";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU3SDESC,($effect),($effect2),($effect2));
			}elseif($type==24){
			$name = HR_RIGHTU3S3;
		    $item = "24";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU3SDESC,($effect),($effect2),($effect2));
			}
		if($type==25){
			$name = HR_RIGHTU5S1;
		    $item = "25";
		    $effect = "500";
				$effect2 = "9";
				$title = sprintf(HR_RIGHTU5SDESC,($effect),($effect2),($effect2));
			}elseif($type==26){
			$name = HR_RIGHTU5S2;
		    $item = "26";
		    $effect = "1000";
				$effect2 = "12";
				$title = sprintf(HR_RIGHTU5SDESC,($effect),($effect2),($effect2));
			}elseif($type==27){
			$name = HR_RIGHTU5S3;
		    $item = "27";
		    $effect = "1500";
				$effect2 = "15";
				$title = sprintf(HR_RIGHTU5SDESC,($effect),($effect2),($effect2));
			}
		if($type==28){
			$name = HR_RIGHTU6S1;
		    $item = "28";
		    $effect = "500";
				$effect2 = "12";
				$title = sprintf(HR_RIGHTU6SDESC,($effect),($effect2),($effect2));
		}elseif($type==29){
			$name = HR_RIGHTU6S2;
		    $item = "29";
		    $effect = "1000";
				$effect2 = "16";
				$title = sprintf(HR_RIGHTU6SDESC,($effect),($effect2),($effect2));
		}elseif($type==30){
			$name = HR_RIGHTU6S3;
		    $item = "30";
		    $effect = "1500";
				$effect2 = "20";
				$title = sprintf(HR_RIGHTU6SDESC,($effect),($effect2),($effect2));
		}
		if($type==31){
			$name = HR_RIGHTU21S1;
		    $item = "31";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU21SDESC,($effect),($effect2),($effect2));
			}elseif($type==32){
			$name = HR_RIGHTU21S2;
		    $item = "32";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU21SDESC,($effect),($effect2),($effect2));
			}elseif($type==33){
			$name = HR_RIGHTU21S3;
		    $item = "33";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU21SDESC,($effect),($effect2),($effect2));
			}
		if($type==34){
			$name = HR_RIGHTU22S1;
		    $item = "34";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU22SDESC,($effect),($effect2),($effect2));
		}elseif($type==35){
			$name = HR_RIGHTU22S2;
		    $item = "35";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU22SDESC,($effect),($effect2),($effect2));
		}elseif($type==36){
			$name = HR_RIGHTU22S3;
		    $item = "36";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU22SDESC,($effect),($effect2),($effect2));
		}
		if($type==37){
			$name = HR_RIGHTU24S1;
		    $item = "37";
		    $effect = "500";
				$effect2 = "6";
				$title = sprintf(HR_RIGHTU24SDESC,($effect),($effect2),($effect2));
			}elseif($type==38){
			$name = HR_RIGHTU24S2;
		    $item = "38";
		    $effect = "1000";
				$effect2 = "8";
				$title = sprintf(HR_RIGHTU24SDESC,($effect),($effect2),($effect2));
			}elseif($type==39){
			$name = HR_RIGHTU24S3;
		    $item = "39";
		    $effect = "1500";
				$effect2 = "10";
				$title = sprintf(HR_RIGHTU24SDESC,($effect),($effect2),($effect2));
			}
		if($type==40){
			$name = HR_RIGHTU25S1;
		    $item = "40";
		    $effect = "500";
				$effect2 = "6";
				$title = sprintf(HR_RIGHTU25SDESC,($effect),($effect2),($effect2));
			}elseif($type==41){
			$name = HR_RIGHTU25S2;
		    $item = "41";
		    $effect = "1000";
				$effect2 = "8";
				$title = sprintf(HR_RIGHTU25SDESC,($effect),($effect2),($effect2));
			}elseif($type==42){
			$name = HR_RIGHTU25S3;
		    $item = "42";
		    $effect = "1500";
				$effect2 = "10";
				$title = sprintf(HR_RIGHTU25SDESC,($effect),($effect2),($effect2));
			}
		if($type==43){
			$name = HR_RIGHTU26S1;
		    $item = "43";
		    $effect = "500";
				$effect2 = "9";
				$title = sprintf(HR_RIGHTU26SDESC,($effect),($effect2),($effect2));
		}elseif($type==44){
			$name = HR_RIGHTU26S2;
		    $item = "44";
		    $effect = "1000";
				$effect2 = "12";
				$title = sprintf(HR_RIGHTU26SDESC,($effect),($effect2),($effect2));
		}elseif($type==45){
			$name = HR_RIGHTU26S3;
		    $item = "45";
		    $effect = "1500";
				$effect2 = "15";
				$title = sprintf(HR_RIGHTU26SDESC,($effect),($effect2),($effect2));
		}
		if($type==46){
			$name = HR_RIGHTU11S1;
		    $item = "46";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU11SDESC,($effect),($effect2),($effect2));
			}elseif($type==47){
			$name = HR_RIGHTU11S2;
		    $item = "47";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU11SDESC,($effect),($effect2),($effect2));
			}elseif($type==48){
			$name = HR_RIGHTU11S3;
		    $item = "48";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU11SDESC,($effect),($effect2),($effect2));
			}
		if($type==49){
			$name = HR_RIGHTU12S1;
		    $item = "49";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU12SDESC,($effect),($effect2),($effect2));
		}elseif($type==50){
			$name = HR_RIGHTU12S2;
		    $item = "50";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU12SDESC,($effect),($effect2),($effect2));
		}elseif($type==51){
			$name = HR_RIGHTU12S3;
		    $item = "51";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU12SDESC,($effect),($effect2),($effect2));
		}
		if($type==52){
			$name = HR_RIGHTU13S1;
		    $item = "52";
		    $effect = "500";
				$effect2 = "3";
				$title = sprintf(HR_RIGHTU13SDESC,($effect),($effect2),($effect2));
			}elseif($type==53){
			$name = HR_RIGHTU13S2;
		    $item = "53";
		    $effect = "1000";
				$effect2 = "4";
				$title = sprintf(HR_RIGHTU13SDESC,($effect),($effect2),($effect2));
			}elseif($type==54){
			$name = HR_RIGHTU13S3;
		    $item = "54";
		    $effect = "1500";
				$effect2 = "5";
				$title = sprintf(HR_RIGHTU13SDESC,($effect),($effect2),($effect2));
			}
		if($type==55){
			$name = HR_RIGHTU15S1;
		    $item = "55";
				$effect2 = "6";
				$title = sprintf(HR_RIGHTU15SDESC,($effect),($effect2),($effect2));
			}elseif($type==56){
			$name = HR_RIGHTU15S2;
		    $item = "56";
				$effect2 = "8";
				$title = sprintf(HR_RIGHTU15SDESC,($effect),($effect2),($effect2));
			}elseif($type==57){
			$name = HR_RIGHTU15S3;
		    $item = "57";
				$effect2 = "10";
				$title = sprintf(HR_RIGHTU15SDESC,($effect),($effect2),($effect2));
			}
		if($type==58){
			$name = HR_RIGHTU16S1;
		    $item = "58";
		    $effect = "500";
				$effect2 = "9";
				$title = sprintf(HR_RIGHTU16SDESC,($effect),($effect2),($effect2));
		}elseif($type==59){
			$name = HR_RIGHTU16S2;
		    $item = "59";
		    $effect = "1000";
				$effect2 = "12";
				$title = sprintf(HR_RIGHTU16SDESC,($effect),($effect2),($effect2));
		}elseif($type==60){
			$name = HR_RIGHTU16S3;
		    $item = "60";
		    $effect = "1500";
				$effect2 = "15";
				$title = sprintf(HR_RIGHTU16SDESC,($effect),($effect2),($effect2));
		}
		
		}elseif($btype==5){
	    
			if($type==94){
			$name = HR_SHOEREG1;
		    $item = "94";
		    $effect = "10";
				$title = sprintf(HR_SHOEREGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==95){
			$name = HR_SHOEREG2;
		    $item = "95";
		    $effect = "15";
				$title = sprintf(HR_SHOEREGDESC,($effect*ITEMATTRSPEED));
			}elseif($type==96){
			$name = HR_SHOEREG3;
		    $item = "96";
		    $effect = "20";
				$title = sprintf(HR_SHOEREGDESC,($effect*ITEMATTRSPEED));
			}
		if($type==97){
			$name = HR_SHOEMER1;
		    $item = "97";
		    $effect = "25";
				$title = sprintf(HR_SHOEMERDESC,($effect*ITEMATTRSPEED));
		}elseif($type==98){
			$name = HR_SHOEMER2;
		    $item = "98";
		    $effect = "30";
				$title = sprintf(HR_SHOEMERDESC,($effect*ITEMATTRSPEED));
		}elseif($type==99){
			$name = HR_SHOEMER3;
		    $item = "99";
		    $effect = "35";
				$title = sprintf(HR_SHOEMERDESC,($effect*ITEMATTRSPEED));
		}
		if($type==100){
			$name = HR_SHOESPU1;
		    $item = "100";
		    $effect = "3";
				$title = sprintf(HR_SHOESPUDESC,($effect*INCREASE_SPEED));
			}elseif($type==101){
			$name = HR_SHOESPU2;
		    $item = "101";
		    $effect = "4";
				$title = sprintf(HR_SHOESPUDESC,($effect*INCREASE_SPEED));
			}elseif($type==102){
			$name = HR_SHOESPU3;
		    $item = "102";
		    $effect = "5";
				$title = sprintf(HR_SHOESPUDESC,($effect*INCREASE_SPEED));
			}
		
		}elseif($btype==6){
	    	if($type==103){
			$name = HR_HORSE1;
		    $item = "103";
		    $effect = "14";
				$title = sprintf(HR_HORSEDESC,($effect*INCREASE_SPEED));
			}elseif($type==104){
			$name = HR_HORSE2;
		    $item = "104";
		    $effect = "17";
				$title = sprintf(HR_HORSEDESC,($effect*INCREASE_SPEED));
			}elseif($type==105){
			$name = HR_HORSE3;
		    $item = "105";
		    $effect = "20";
				$title = sprintf(HR_HORSEDESC,($effect*INCREASE_SPEED));
			}
		
		}elseif($btype==7){
	    	$name = HR_SMALLBAND1;
			$item = "112";
			$title = HR_SMALLBANDDESC;
		}elseif($btype==8){
	    	$name = HR_BAND1;
			$item = "113";
			$title = HR_BANDDESC;
		}elseif($btype==9){
	    	$name = HR_CAGE1;
			$item = "114";
			$title = HR_CAGEDESC;
		}elseif($btype==10){
	    	$name = HR_SCROLLEXP1;
			$item = "107";
			$title = HR_SCROLLEXPDESC;
		}elseif($btype==11){
	    	$name = HR_OINMENT1;
			$item = "106";
			$title = HR_OINMENTDESC;
		}elseif($btype==12){
	    	$name = HR_BUCKET1;
		$item = "108";
			$title = HR_BUCKETDESC;
		}elseif($btype==13){
	    	$name = HR_BOOKWIS1;
			$title = HR_BOOKWISDESC;
		$item = "110";
		}elseif($btype==14){
	    	$name = HR_TABLETLAW1;
			$title = HR_TABLETLAWDESC;
			$item = "109";
		}elseif($btype==15){
	    	$name = HR_ARTWORK1;
		$item = "111";
			$title = HR_ARTWORKDESC;
		}
}
