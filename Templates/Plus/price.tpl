<?php


$AppConfig = array (

	'plus'			=> array (
		'packages'	=> array (
			array ( 
				'id' 		  => 1,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; A',
				'gold'		=> '100',
				'cost'		=> '25000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_a.jpg'
			),
			array ( 
				'id' 		  => 2,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; B',
				'gold'		=> '250',
				'cost'		=> '50000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_b.jpg'
			),
				array ( 
				'id' 		  => 3,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; C',
				'gold'		=> '600',
				'cost'		=> '80000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_c.jpg'
			),	
			array ( 
				'id' 		  => 4,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; D',
				'gold'		=> '1400',
				'cost'		=> '120000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_d.jpg'
			),	
			array ( 
				'id' 		  => 5,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; &#1576;&#1585;&#1606;&#1586;&#1740;',
				'gold'		=> '3200',
				'cost'		=> '250000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_f.jpg'
			),
			array ( 
				'id' 		  => 6,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; &#1606;&#1602;&#1585;&#1607; &#1575;&#1740;',
				'gold'		=> '8000',
				'cost'		=> '500000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_f.jpg'
			),

			array ( 
				'id' 		  => 7,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; &#1591;&#1604;&#1575;&#1740;&#1740;',
				'gold'		=> '16000',
				'cost'		=> '900000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_f.jpg'
			),
			array ( 
				'id' 		  => 8,
				'name'		=> '&#1576;&#1587;&#1578;&#1607; &#1575;&#1604;&#1605;&#1575;&#1587;',
				'gold'		=> '50000',
				'cost'		=> '1500000',
				'currency'	=> '&#1578;&#1608;&#1605;&#1575;&#1606;',
				'image'		=> 'package_f.jpg'
			),	
		),

		'payments' => array (
		'payline'	=> array (
				'testMode'		=> FALSE,
				'name'			=> ' &#1662;&#1585;&#1583;&#1575;&#1582;&#1578; &#1575;&#1586; &#1591;&#1585;&#1610;&#1602; &#1588;&#1578;&#1575;&#1576;',
				'image'			=> 'cashu.gif',
				'serviceName'    	=> 'tatar.dboor',
				'api'   	        => 'd947c-f5dd3-898b6-c106b-001cdc5cd48f38fd5abc865d0a61',
				'key'			=> '5248910',
				'returnKey'		=> '548fhmr847470',
                                'Link'		        => 'http://vikings.ir/vs1/tgpay.php?back=2,',
				'currency'		=> 'Tomans'
			),

			'parspal'	=> array (
				'testMode'		=> FALSE,
				'name'			=> ' &#1662;&#1585;&#1583;&#1575;&#1582;&#1578; &#1575;&#1586; &#1591;&#1585;&#1610;&#1602; &#1588;&#1578;&#1575;&#1576;',
				'image'			=> 'parspal.gif',
				'serviceName' 	        => 'tatar.dboor',
				'MerchantID'      	=> '1331007',
				'password'		=> '6a0HOuT7f',
				'testKey'		=> '',
				'returnKey'		=> '',
                                'Link'		        => 'http://vikings.ir/vs1/tgpay.php?pid=1&verify=',
				'currency'		=> 'Tomans'
			)
			
		)			
		
	)
);
?>