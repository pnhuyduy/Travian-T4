<?php


$AppConfig = array (

	'plus'			=> array (
		'packages'	=> array (
			array ( 
				'id' 		  => 1,
				'name'		=> 'بسته A',
				'gold'		=> '100',
				'cost'		=> '25000',
				'currency'	=> 'تومان',
				'image'		=> 'package_a.jpg'
			),
			array ( 
				'id' 		  => 2,
				'name'		=> 'بسته B',
				'gold'		=> '250',
				'cost'		=> '50000',
				'currency'	=> 'تومان',
				'image'		=> 'package_b.jpg'
			),
				array ( 
				'id' 		  => 3,
				'name'		=> 'بسته C',
				'gold'		=> '600',
				'cost'		=> '80000',
				'currency'	=> 'تومان',
				'image'		=> 'package_c.jpg'
			),	
			array ( 
				'id' 		  => 4,
				'name'		=> 'بسته D',
				'gold'		=> '1400',
				'cost'		=> '120000',
				'currency'	=> 'تومان',
				'image'		=> 'package_d.jpg'
			),	
			array ( 
				'id' 		  => 5,
				'name'		=> 'بسته برنزی',
				'gold'		=> '3200',
				'cost'		=> '250000',
				'currency'	=> 'تومان',
				'image'		=> 'package_f.jpg'
			),
			array ( 
				'id' 		  => 6,
				'name'		=> 'بسته نقره ای',
				'gold'		=> '8000',
				'cost'		=> '500000',
				'currency'	=> 'تومان',
				'image'		=> 'package_f.jpg'
			),

			array ( 
				'id' 		  => 7,
				'name'		=> 'بسته طلایی',
				'gold'		=> '16000',
				'cost'		=> '900000',
				'currency'	=> 'تومان',
				'image'		=> 'package_f.jpg'
			),
			array ( 
				'id' 		  => 8,
				'name'		=> 'بسته الماس',
				'gold'		=> '50000',
				'cost'		=> '1500000',
				'currency'	=> 'تومان',
				'image'		=> 'package_f.jpg'
			),	
		),

		'payments' => array (
		'payline'	=> array (
				'testMode'		=> FALSE,
				'name'			=> ' پرداخت از طريق شتاب',
				'image'			=> 'cashu.gif',
				'serviceName'    	=> 'tatar.dboor',
				'api'   	        => '50c9abb0-b27c-4c96-963a-6ed35ee8aeb5',
				'key'			=> '5248910',
				'returnKey'		=> '548fhmr847470',
                                'Link'		        => 'http://travian5.net/e/demo/tgpay.php?back=2,',
				'currency'		=> 'Tomans'
			),

			'parspal'	=> array (
				'testMode'		=> FALSE,
				'name'			=> ' پرداخت از طريق شتاب',
				'image'			=> 'parspal.gif',
				'serviceName' 	        => 'tatar.dboor',
				'MerchantID'      	=> '1331011',
				'password'		=> '5skdUpXdF',
				'testKey'		=> '',
				'returnKey'		=> '',
                                'Link'		        => 'http://travian5.net/e/demo/tgpay.php?pid=1&verify=',
				'currency'		=> 'Tomans'
			)
			
		)			
		
	)
);
?>