<?php
/* Security Filter for server variables , must stop Dangerouse Requests populary in WEB attacks*/
/*Is not right way make sites, but fast and easy method for stop virus and script-kiddie activity today*/
/* Code by Roman Shneer 20090707*/
/*usage:just include this file to header of site*/
/*about new types of attacks or wanted changes write to shaman33@gmail.com*/
/*v 1.2*/
//must stop php remote including if have code like: include $_GET['file'];
ini_set('allow_url_fopen',false);
ini_set('allow_url_include',false);
//recommend disable error reporting
ini_set('display_errors',false);


Class SecModule
{
 /*debugger flag;set true for viewing broken request (info viewing in <!--#--> tags)*/
 var $debug=false;
 /*loggin flag;set true for write broken request in mylogs folder(be sure that your apache have permissions write to failsystem, another :mkdir mylogs;chown apache mylogs;)*/
 var $log_wrong_request=true;
/*logs directory*/
 var $log_path="mylogs";
/*logs max filesize in MB*/
 var $log_max_size=1;
 var $log_cache;
 //setting:which variables to check, set false if need disable checking of some one
	var $options=array('GET'=>true,
			   'POST'=>true,
			   'COOKIE'=>false,
			   'REQUEST'=>true);
   /*RegExp Patterns*/
	var $patterns=array('SQL'=>'/(["]|[\'])/i',
                    'SQLinjection'=>'/select|union|concat|char/i',
                    'Crosssite'=>'/(\.\.)/',
                    'HEX'=>'/0x/',
                    'cmd'=>'/base64_decode|system/',
                    'XSS'=>'/<script>/');
	function SecModule()
	{
	$this->log_max_size*=1048576;
	foreach($this->options as $k=>$int)
		{
		if($int)
			{
			/*disable from there pattern if broked site work*/
			//check sql injection
			$this->load_objects($k,$this->patterns['SQL']);
			$this->load_objects($k,$this->patterns['SQLinjection']);
			//crosssite
			$this->load_objects($k,$this->patterns['Crosssite']);
			//hexademicaly encoded
			$this->load_objects($k,$this->patterns['HEX']);
			//javascript injection (reccomended for post)
			$this->load_objects($k,$this->patterns['XSS']);
			//filter some php command
			$this->load_objects($k,$this->patterns['cmd']);
			}
		}
	$this->write_request_log($this->log_cache);
	}
	function load_objects($objname,$pattern)
	{
		switch($objname)
		{
			case 'GET':
			$obj=$_GET;
			break;
			case 'POST':
			$obj=$_POST;
			break;
			case 'COOKIE':
			$obj=$_COOKIE;
			break;
			case 'REQUEST':
			$obj=$_REQUEST;
			break;
		}
	foreach($obj as $key=>$value)
		{
		$value=$this->check_object($pattern,$value,'$_'.$objname."[".$key."]");
				switch($objname)
				{
				case 'GET':
				$_GET[$key]=$value;
				break;
				case 'POST':
				$_POST[$key]=$value;
				break;
				case 'COOKIE':
				$_COOKIE[$key]=$value;
				break;
				case 'REQUEST':
				$_REQUEST[$key]=$value;
				break;
				}

		}
	}
	/*return value if not finded via pattern of kill value;if array recursivy open*/
	function check_object($pattern,$value,$varname)
	{
    if(is_array($value))
    	{
    	foreach($value as $k=>$v)
    		{
    			$new_value[$k]=$this->check_object($pattern,$v,$varname."[".$k."]");
    		}
    	return $new_value;
    	}
	preg_match($pattern,$value,$result);
	if(!empty($result[0]))
		{
			if($this->debug)
			{
				print $this->print_wrong($pattern,$result[1],$value,$varname,true);
			}
			if($this->log_wrong_request)
			{
			//collect to cache var
            $this->log_cache.=$this->print_wrong($pattern,$result[1],$value,$varname,false);
			}

        $value=false;
		}
	return $value;
	}
	function write_request_log($content)
	{
	$log_file=$this->rotate_log($this->log_path);
    $f=fopen($log_file,"a");
    fwrite($f,$content." Time=".date("H:i d/m/Y")." Request=".$_SERVER['REQUEST_URI']."\n");
    fclose($f);
	}
	function rotate_log($log_path)
	{
	    if(!is_dir($log_path))mkdir($log_path,0755);
	    $logfiles=glob($log_path."/log".date("Ymd.")."*.log");
	    if(count($logfiles))
	    {
	    $logfiles=array_reverse($logfiles);
	    $logfile=array_shift($logfiles);
	    }
	    if((filesize($logfile)>$this->log_max_size)||(!isset($logfile)))
	    {
	    	$logfile=$log_path."/log".date("Ymd.").time().".log";
	    }
   		 return $logfile;
	}
	function prepare_dir($path)
	{
  		if(!is_dir($path))mkdir($path,0755);
	}
	function print_wrong($pattern,$frag,$value,$varname,$use_tags)
	{
		return ($use_tags?"\n"."<!-- Stoped ":"").$varname."=".$value." becouse containts ".$frag." by pattern ".$this->pattern2name($pattern).($use_tags?"-->"."\n":"");
	}
	function pattern2name($pattern)
	{
    foreach($this->patterns as $k=>$pat)
    	{
    		if($pat==$pattern)return $k;
    	}
	}
}

$SM=new SecModule;
?>