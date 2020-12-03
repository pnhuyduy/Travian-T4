<?php
/*~~~~=    YOU MUST NOT REMOVE OR CHANGE THIS NOTICE    =~~~~*\
|*~~~~= Developed by:SHadoW|CONTACT:Arctic_x2@yahoo.com =~~~~*|
\*~~~~= Project:TRAVIANv4 - Filename: ProtectionAll.php =~~~~*/

// if(ini_get('register_globals')) exit("<center><h3>Error: Turn that damned register globals off!</h3></center>");

// if (get_magic_quotes_gpc() == 0) {
// foreach ($_POST as $k => $v) {
// $_POST[$k] = addslashes($v);
// }
// foreach ($_GET as $k => $v) {
// $_GET[$k] = addslashes($v);
// }
// }

if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && substr_count($_SERVER['HTTP_ACCEPT_ENCODING'], "gzip")) {
    ob_implicit_flush(0);
    if (@ob_start(array("ob_gzhandler", 9))) {
        header("Content-Encoding: gzip");
    }
}

function file_fix_write($filename)
{
    if (!is_writable($filename)) {
        if (!chmod($filename, 0666)) {
            die("Cannot change the mode of file ($filename)");
        };
    }

}

function anti_inject($campo)
{
    foreach ($campo as $key => $val) {
        //remove words that contains syntax sql
        $val = preg_replace(sql_regcase("/(ascii|CONCAT|DROP|TABLE_SCHEMA|unhex|group_concat|load_file|information_schma|substring|Union|from|select|insert|delete|where|drop table|show tables|\*|--|\\\\)/"), "", $val);

        //Remove empty spaces
        // $val = trim($val);

        //Removes tags html/php
        // $val = strip_tags($val);

        //Add inverted bars to a string
        // $val = addslashes($val);

        // store it back into the array
        $campo[$key] = $val;
    }
    return $campo; //Returns the the var clean
}

if (!is_array($_POST) && !is_array($_GET)) {
    $_GET = anti_inject($_GET);
    $_POST = anti_inject($_POST);
}

function protect($string)
{
    if (ini_get('magic_quotes_gpc') == 'off') // check if magic_quotes_gpc is on and if not add slashes
    {
        $string = addslashes($string);
    }
// move html tages from inputs
    // $string = htmlentities($string, ENT_QUOTES);
//removing most known vulnerable words
    $codes = array("load_file", "script", "java", "applet", "iframe", "meta", "object", "html", "<", ">", ";", "'", "");
    $string = str_replace($codes, "", $string);
//return clean string
    return $string;
}

$_GET = protect($_GET);
$_POST = protect($_POST);

// $ids_checkpost = urldecode($_SERVER['QUERY_STRING']);
// if (eregi("[\'|'/'\''<'>'*'~'`']", $ids_checkpost) || strstr($ids_checkpost, 'union') || strstr($ids_checkpost, 'java') || strstr($ids_checkpost, 'script') || strstr($ids_checkpost, 'substring(') || strstr($ids_checkpost, 'ord()')
// || strstr($ids_checkpost, 'http') || strstr($ids_checkpost, 'https') || strstr($ids_checkpost, 'www')
// ) {
// $hack_attempt = 1;
// echo "<center><font color=red> Hack attempt <br/><br/>!!! WARNING !!! <br/>
// Malicious Code Detected! The Admin has been notified !<br/><br/>
// Your Ip Address Has Been Loged ! Your ip is : ".getIp()."</font></center>";
// header("Location:Hacking.php");
// }

function replace_meta_chars($string)
{
    return @eregi_replace("([<])|([>])|([*])|([|])|([;])|([`])|([-])|([\])|([{])|([}])|([+])|([UNION])|([SELECT])|([DROP])|([WHERE])|([EMPTY])|([FLUSH])|([INSERT])", "", $string);
}

reset($_REQUEST);
while (list($keyx, $valuex) = each($_REQUEST)) {
    ${$keyx} = replace_meta_chars($valuex);
}

while (list($keyx, $valuex) = each($_REQUEST)) {
    if (eregi("([<])|([>])|([*])|([|])|([;])|([`])|([-])|([\])|([{])|([}])|([+])", $valuex)) {
        $hack_attempt = 1;
        // echo $valuex;
        // exit;
        header("Location:Hacking.php");
    }
}


/*(	SECURITY SYSTEM CHECK ) */
$security_system = 1;

// if (file_exists(DIRNAME(DIRNAME(__FILE__)) . '/Security/Security.class.php')) {
// require DIRNAME(DIRNAME(__FILE__)) . '/Security/Security.class.php';
// Security::instance();
// } else {
// die('Security: Please activate security class!');
// }

//sql detector && log url's to file
// require(dirname(dirname(__FILE__)).'/Security/secmodule.php');

//flood checker
// require(dirname(dirname(__FILE__)).'/Security/class.floodblocker.php');
// $flb = new FloodBlocker ( dirname(dirname(__FILE__)).'/flood' );
// $flb->rules = array(
// seconde=>request
// 5=>30,    // rule 1 - maximum 10 requests in 5 secs
//10=>30,    // rule 2 - maximum 30 requests in 60 secs
//20=>50,   // rule 3 - maximum 50 requests in 300 secs
//30=>200  // rule 4 - maximum 200 requests in 3600 secs
// );
// if ( !$flb->CheckFlood())die ( 'Too many requests! Please try later.' );

//sql injectet class
// require(dirname(dirname(__FILE__)).'/GameEngine/phprotector/PhProtector.php');

/* TESTING environment (show all PHP errors!) */
// $prot= new PhProtector("phprotector/log.xml", true);

/* FINAL environment (do not show PHP errors!) */
// $prot = new PhProtector("phprotector/log.xml", false);

// if($prot->isMalicious()){
//if an atack is found, it will be redirected to this page :)
// header("location: hacking.php");die();
// }


/* If you're storing the HTMLSax3.php in the /classes directory, along with the safehtml.php script, define XML_HTMLSAX3 as a null string. */
// define('XML_HTMLSAX3', '');
// echo DIRNAME(__FILE__) . '/safehtml.php';
// require_once(DIRNAME(__FILE__) . '/safehtml.php'); // Include the class file.
// echo "S";

// Force browser to load only right files //

$PAGES = array('1.php', 'captcha.php', 'captcha.image.php', 'serverRegister.php', 'index.php', 'ajax.php', '403.php', '404.php', '500.php', 'activate.php', 'activator.php', 'agb.php', 'allianz.php', 'banned.php', 'berichte.php', 'build.php', 'cropfinder.php'
, 'dorf1.php', 'dorf2.php', 'dorf3.php', 'email.php', 'hacking.php', 'help.php', 'hero.php', 'hero_adventure.php', 'hero_auction.php', 'hero_body.php', 'hero_image.php'
, 'hero_inventory.php', 'karte.php', 'katibe.php', 'Linklist.php', 'login.php', 'logout.php', 'maintenece.php', 'map.php', 'nachrichten.php', 'options.php', 'payment.php'
, 'plus.php', 'production.php', 'spieler.php', 'spielregeln.php', 'statistiken.php', 'support.php', 'support_form.php', 'tutorial.php', 'winner.php', 'img.php', 'map_mark.php', 'map_block.php'
);


// Slim shady Cleaner //
foreach ($_POST as $k => $v) {
    if (!is_array($_POST[$k])) {
        if (strcasecmp($k, 'filter') == 0 || strcasecmp($k, 'page') == 0 || strcasecmp($k, 'order') == 0 || strcasecmp($k, 'orderby') == 0) {
            $v = str_ireplace(' ', '', $v);
        }
        $_POST[$k] = htmlspecialchars(get_magic_quotes_gpc() ? $v : addslashes($v));
    } else {
        foreach ($_POST[$k] as $subk => $subv) {
            if (!is_array($_POST[$k][$subk])) {
                if (strcasecmp($subk, 'filter') == 0 || strcasecmp($subk, 'page') == 0 || strcasecmp($subk, 'order') == 0 || strcasecmp($subk, 'orderby') == 0) {
                    $subv = str_ireplace(' ', '', $subv);
                }
                $_POST[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc() ? $subv : addslashes($subv));
            }
        }
    }
}
foreach ($_GET as $k => $v) {
    if (!is_array($_GET[$k])) {
        if (strcasecmp($k, 'filter') == 0 || strcasecmp($k, 'page') == 0 || strcasecmp($k, 'order') == 0 || strcasecmp($k, 'orderby') == 0) {
            $v = str_ireplace(' ', '', $v);
        }
        $_GET[$k] = htmlspecialchars(get_magic_quotes_gpc() ? $v : addslashes($v));
    } else {
        foreach ($_GET[$k] as $subk => $subv) {
            if (!is_array($_GET[$k][$subk])) {
                if (strcasecmp($subk, 'filter') == 0 || strcasecmp($subk, 'page') == 0 || strcasecmp($subk, 'order') == 0 || strcasecmp($subk, 'orderby') == 0) {
                    $subv = str_ireplace(' ', '', $subv);
                }
                $_GET[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc() ? $subv : addslashes($subv));
            }
        }
    }
}
foreach ($_COOKIE as $k => $v) {
    if (!is_array($_COOKIE[$k])) {
        if (strcasecmp($k, 'filter') == 0 || strcasecmp($k, 'page') == 0 || strcasecmp($k, 'order') == 0 || strcasecmp($k, 'orderby') == 0) {
            $v = str_ireplace(' ', '', $v);
        }
        $_COOKIE[$k] = htmlspecialchars(get_magic_quotes_gpc() ? $v : addslashes($v));
    } else {
        foreach ($_COOKIE[$k] as $subk => $subv) {
            if (!is_array($_COOKIE[$k][$subk])) {
                if (strcasecmp($subk, 'filter') == 0 || strcasecmp($subk, 'page') == 0 || strcasecmp($subk, 'order') == 0 || strcasecmp($subk, 'orderby') == 0) {
                    $subv = str_ireplace(' ', '', $subv);
                }
                $_COOKIE[$k][$subk] = htmlspecialchars(get_magic_quotes_gpc() ? $subv : addslashes($subv));
            }
        }
    }
}
if (isset($_SESSION)) {
    if (!is_array($_SESSION[$k])) {
        if (strcasecmp($k, 'filter') == 0 || strcasecmp($k, 'page') == 0 || strcasecmp($k, 'order') == 0 || strcasecmp($k, 'orderby') == 0) {
            $v = str_ireplace(' ', '', $v);
        }
        $_SESSION[$k] = addslashes($v);
    } else {
        foreach ($_SESSION[$k] as $subk => $subv) {
            if (!is_array($_SESSION[$k][$subk])) {
                if (strcasecmp($subk, 'filter') == 0 || strcasecmp($subk, 'page') == 0 || strcasecmp($subk, 'order') == 0 || strcasecmp($subk, 'orderby') == 0) {
                    $subv = str_ireplace(' ', '', $subv);
                }
                $_SESSION[$k][$subk] = addslashes($subv);
            }
        }
    }
}
// end of slim shady
// First clean inputs
if (isset($_GET)) {
    foreach ($_GET as $key => $value) {
        $_GET[$key] = clean($value);
        // $value = trim($value);
        $_GET[$key] = filterphp($value);
        $_GET[$key] = filterz($_GET[$key]);
        $_GET[$key] = xss_clean($_GET[$key]);
        $_GET[$key] = anti_injection($_GET[$key]);
        $_GET[$key] = cleaner($_GET[$key]);
        // $_GET[$key] = mysql_real_escape_string($_GET[$key]);
        $_GET[$key] = transform_HTML($_GET[$key]);
        // $_GET[$key] = safehtml($_GET[$key]);
    }
}

if (isset($_POST) && !isset($_POST['message'])) {
    if (isset($_POST) && isset($_POST['cmd'])) {
        $_POST[$key] = cleaner($value);
        $_POST[$key] = xss_clean($_POST[$key]);
    } else {
        foreach ($_POST as $key => $value) {
            if (!isset($_POST['ft']) && !isset($_POST['t']) && !isset($_POST['slot'])) {
                $_POST[$key] = clean($value);
                $_POST[$key] = mysql_real_escape_string($value);
                $_POST[$key] = filterphp($value);
                $value = trim($value);
                $_POST[$key] = filterz($value);
                $_POST[$key] = xss_clean($_POST[$key]);
                $_POST[$key] = transform_HTML($value);
                // $_POST[$key] = safehtml($value);
                $_POST[$key] = anti_injection($_POST[$key]);
                $_POST[$key] = cleaner($_POST[$key]);
            } else {
                $_POST[$key] = anti_injection($_POST[$key]);
                $_POST[$key] = cleaner($_POST[$key]);
            }
        }
    }
}
if (isset($_SESSION)) {
    foreach ($_SESSION as $key => $value) {
        // $_SESSION[$key]=clean($value);
        // $value = trim($value);
        $_SESSION[$key] = filterphp($value);
        $_SESSION[$key] = filterz($_SESSION[$key]);
        $_SESSION[$key] = xss_clean($_SESSION[$key]);
        $_SESSION[$key] = anti_injection($_SESSION[$key]);
        $_SESSION[$key] = cleaner($_SESSION[$key]);
        $_SESSION[$key] = transform_HTML($_SESSION[$key]);
        // $_SESSION[$key] = safehtml($_SESSION[$key]);
    }
}
if (isset($_COOKIE)) {
    foreach ($_COOKIE as $key => $value) {
        // $_COOKIE[$key]=clean($value);
        // $value = trim($value);
        $_COOKIE[$key] = filterphp($value);
        $_COOKIE[$key] = filterz($_COOKIE[$key]);
        $_COOKIE[$key] = xss_clean($_COOKIE[$key]);
        $_COOKIE[$key] = anti_injection($_COOKIE[$key]);
        $_COOKIE[$key] = cleaner($_COOKIE[$key]);
        $_COOKIE[$key] = transform_HTML($_COOKIE[$key]);
        // $_COOKIE[$key] = safehtml($_COOKIE[$key]);
    }
}
if (isset($_SERVER)) {
    foreach ($_SERVER as $key => $value) {
        //$_SERVER[$key]=clean($value);
        // $value = trim($value);
        $_SERVER[$key] = filterphp($value);
        $_SERVER[$key] = filterz($_SERVER[$key]);
        $_SERVER[$key] = xss_clean($_SERVER[$key]);
        $_SERVER[$key] = anti_injection($_SERVER[$key]);
        $_SERVER[$key] = cleaner($_SERVER[$key]);
        $_SERVER[$key] = transform_HTML($_SERVER[$key]);
        // $_SERVER[$key] = safehtml($_SERVER[$key]);
    }
}
function clean($string)
{
    $search = array(
        '@<script[^>]*?>.*?</script>@si', // Strip out javascript
        '@<[\/\!]*?[^<>]*?>@si', // Strip out HTML tags
        '@<style[^>]*?>.*?</style>@siU', // Strip style tags properly
        '@<![\s\S]*?--[ \t\n\r]*>@' // Strip multi-line comments
    );
    $string = preg_replace($search, '', $string);
    // $link = mysql_connect('localhost', 't4_farsi', 't4_farsi');
    #Clean inputs for XSS and SQLI
    $string = trim($string);
    $string = htmlspecialchars($string);
    $string = strip_tags($string);
    // $string = mysql_real_escape_string($string ,$link);
    // mysql_close();
    return $string;
}

function filterphp($php)
{
    return preg_replace('/<.*?>/', '', $php);
}


function filterz($txt)
{
    $arr_simboliu = array('applet', 'alert', 'cookie', 'base64', 'javascript', 'script', "../", "%3c", "%253c", "%3e", "%0e", "%26", "([\"'])?data\s*:[^\\1]*?base64[^\\1]*?,[^\\1]*?\\1?", 'Redirect\s+302', 'vbscript\s*:', 'expression\s*(\(|&\#40;)', 'javascript\s*:', 'document.cookie', 'document.write', '.parentNode', '.innerHTML', 'window.location', '-moz-binding', '<!--', '-->', '<![CDATA[', '<comment>', '$', '!', '\'', '%', '^', '<', '>', '{', '}', "'", '\x1a', '\x00', '"', ')', '(');
    $arr_kodu = array('&#35;', '&#36;', '&#33;', '&quot;', '&#37;', '&#94;', '&#63;', '&#95;', '&#45;', '&#43;', '&#124;', '&lt;', '&gt;', '&#123;', '&#125;', '&#91;', '&#93;', '&#44;', '&#039;');
    return str_replace($arr_simboliu, $arr_kodu, $txt);
}

function safehtml($data)
{
    $safehtml = new safehtml();
    $safe_data = $safehtml->parse($data);
    return $safe_data;
}

function xss_clean($data)
{
    // global $security;
    // If its empty there is no point cleaning it :\
    if (empty($data)) return $data;
    // Recursive loop for arrays
    if (is_array($data)) {
        // foreach($data as $key => $value){ $data[$key] = $this->xss_clean($data); }
        return $data;
    }
    // Fix &entity\n;
    $data = str_replace(array('<?', '?' . '>'), array('&lt;?', '?&gt;'), $data);
    $data = str_replace(array('>', '<'), array('&gt;', '&lt;'), $data);
    // $data = str_replace(array('&','<','>'), array('&','<','>'), $data);
    $data = preg_replace('/(&#*\w+)[\x00-\x20]+;/u', '$1;', $data);
    $data = preg_replace('/(&#x*[0-9A-F]+);*/iu', '$1;', $data);
    $data = html_entity_decode($data, ENT_COMPAT, 'UTF-8');

    //fix href's
    $data = preg_replace('#href=.*?(alert\(|alert&\#40;|javascript\:|livescript\:|mocha\:|charset\=|window\.|document\.|\.cookie|<script|<xss|data\s*:)#si', '', $data);
    // Remove any attribute starting with "on" or xmlns
    $data = preg_replace('#(<[^>]+?[\x00-\x20"\'])(?:on|xmlns)[^>]*+>#iu', '$1>', $data);

    // Remove javascript: and vbscript: protocols
    $data = preg_replace('#([a-z]*)[\x00-\x20]*=[\x00-\x20]*([`\'"]*)[\x00-\x20]*j[\x00-\x20]*a[\x00-\x20]*v[\x00-\x20]*a[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2nojavascript...', $data);
    $data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*v[\x00-\x20]*b[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2novbscript...', $data);
    $data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*-moz-binding[\x00-\x20]*:#u', '$1=$2nomozbinding...', $data);

    // Only works in IE: <span style="width: expression(alert('Ping!'));"></span>
    $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?expression[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
    $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?behaviour[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
    $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:*[^>]*+>#iu', '$1>', $data);

    // Remove namespaced elements (we do not need them)
    $data = preg_replace('#</*\w+:\w[^>]*+>#i', '', $data);

    do {
        // Remove really unwanted tags
        $old_data = $data;
        $data = preg_replace('#</*(?:applet|b(?:ase|gsound|link)|embed|frame(?:set)?|i(?:frame|layer)|l(?:ayer|ink)|meta|object|s(?:cript|tyle)|title|xml)[^>]*+>#i', '', $data);
    } while ($old_data !== $data);
    // $data = $security->xss_clean($data);
    return $data;
}

function anti_injection($value)
{
    $value = preg_replace("/(%00|version|users|database|table_schema|into|information_schema|join|create|truncate|convert|char|applet|audio|basefont|base|behavior|bgsound|blink|body|embed|expression|form|frameset|frame|head|html|ilayer|iframe|input|isindex|link|meta|object|plaintext|style|script|textarea|title|video|xml|xss|alert|cmd|passthru|eval|exec|expression|system|fopen|fsockopen|file_get_contents|readfile|unlink|from|select|union|exec|varchar|cast|update|set|insert|delete|where|drop table|show tables|\*|--|\\\\)/", '', $value);
    // $value = trim($value);
    // $value = strip_tags($value);
    // $value = addslashes($value);
    $value = str_replace("'", "''", $value);
    return ($value);
}

// clean again & again
if (isset($_POST)) {
    // $_POST = array_map('htmlspecialchars', $_POST);
    // $_POST = array_map('stripslashes', $_POST);
    // $_POST = array_map('addslashes', $_POST);
}
$_GET = array_map('htmlspecialchars', $_GET);
$_GET = array_map('stripslashes', $_GET);
$_GET = array_map('addslashes', $_GET);

$_COOKIE = array_map('htmlspecialchars', $_COOKIE);
$_COOKIE = array_map('stripslashes', $_COOKIE);
$_COOKIE = array_map('addslashes', $_COOKIE);

// if inputs still dirty and have dangerous commands THEN convert it to NULL->
function cleaner($value)
{
    $filchars = array('.tk', '.info', '.ac', '.net', '.org', '{', '}', '\'', '*', "'", '<', '>', '!', '$', '%', '^', '*'
    , '../', 'column_name', 'order', 'information_schema', 'information_schema.tables', 'table_schema', 'table_name', 'group_concat',
        'database()', 'union', 'x:\#', 'delete ', '///', 'from|xp_|execute|exec|sp_executesql|sp_|select| insert|delete|where|drop table|show tables|#|\*|',
        'DELETE', 'insert', "," | "x'; U\PDATE Character S\ET level=99;-\-", "x';U\PDATE Account S\ET ugradeid=255;-\-",
        "x';U\PDATE Account D\ROP ugradeid=255;-\-", "x';U\PDATE Account D\ROP ", ",W\\HERE 1=1;-\\-",
        "z'; U\PDATE Account S\ET ugradeid=char", 'update', 'drop', 'sele', 'memb', 'set', '$', 'res3t', '%',
        '--', '666.php', '/(shutdown|from|select|update|character|clan|set|insert|delete|where|drop table|show tables|#|\*|--|\\\\)/',
        'c99.php', 'shutdown', 'from', 'select', 'update', 'character', 'UPDATE', 'where', 'show tables', 'alter');
    return str_replace($filchars, '', $value);
}

function transform_HTML($string, $length = null)
{
    // Helps prevent XSS attacks
    // Remove dead space.
    $string = $string;
    // Prevent potential Unicode codec problems.
    // $string = utf8_decode($string);
    // HTMLize HTML-specific characters.
    // $string = htmlentities($string, ENT_NOQUOTES);
    // $string = str_replace('#', '&#35;', $string);
    // $string = str_replace('%', '&#37;', $string);
    $length = intval($length);
    if ($length > 0) {
        $string = substr($string, 0, $length);
    }
    return $string;
}


// if inputs still dirty and have dangerous commands THEN just block it->
//filter_var_array//
$euristic = array('shexit()', 'myshellexec', 'll oFileSys.D', 'read', 'run', 'function', "fopen", "file_get_contents", "sql", "opendir", "perms", "eval", "system", "exec", "rename", "copy", "delete", "hack", "(\$_", "phpinfo", "uname", "glob", "is_writable", "is_readable", "get_magic_quotes_gpc()", "move_uploaded_file", "\$dir", "& 00",);

$badurl = array('.com', '.ir', '.tk', '.info', '.ac', '.net', '.org');
$badChars = array('{', '}', '\'', '*', "'", '\'', '<', '>', ',', '!', '$', '%', '^', '*', '(', ')');
$badwords = array('../', 'column_name', 'order', 'information_schema', 'information_schema.tables', 'table_schema', 'table_name', 'group_concat',
    'database()', 'union', 'x:\#', 'delete ', '///', 'from|xp_|execute|exec|sp_executesql|sp_|select| insert|delete|where|drop table|show tables|#|\*|',
    'DELETE', 'insert', "," | "x'; U\PDATE Character S\ET level=99;-\-", "x';U\PDATE Account S\ET ugradeid=255;-\-",
    "x';U\PDATE Account D\ROP ugradeid=255;-\-", "x';U\PDATE Account D\ROP ", ",W\\HERE 1=1;-\\-",
    "z'; U\PDATE Account S\ET ugradeid=char", 'update', 'drop', 'sele', 'memb', 'set', '$', 'res3t', '%',
    '--', '666.php', '/(shutdown|from|select|update|character|clan|set|insert|delete|where|drop table|show tables|#|\*|--|\\\\)/'
, 'LOAD', 'DATA', 'LOCAL', 'INFILE', '<pre>', 'filemanager', 'explorer', 'dir', 'Tables', 'viewSchema', '?action=');

//search inside post & get global//
foreach ($_POST as $value) {
    break;
    foreach ($badwords as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
    foreach ($badChars as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
    foreach ($euristic as $word) {
        if (substr_count($value, $word) > 0) {
            echo $word;
            die();
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
}
foreach ($_GET as $value) {
    break;
    foreach ($badwords as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
    foreach ($badChars as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
    foreach ($badurl as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
    foreach ($euristic as $word) {
        if (substr_count($value, $word) > 0) {
            $block_INPUT = $value;
            // echo ("<script>alert('&#1575;&#1581;&#1578;&#1605;&#1575;&#1604;&#1575; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1576;&#1607; &#1583;&#1604;&#1610;&#1604; &#1587;&#1593;&#1610; &#1588;&#1605;&#1575; &#1583;&#1585; &#1606;&#1601;&#1608;&#1584; &#1576;&#1607; &#1587;&#1610;&#1587;&#1578;&#1605; &#1583;&#1575;&#1583;&#1607; &#1588;&#1583;&#1607; &#1575;&#1587;&#1578; . &#1583;&#1585; &#1589;&#1608;&#1585;&#1578; &#1578;&#1705;&#1585;&#1575;&#1585; &#1575;&#1610;&#1606; &#1662;&#1610;&#1575;&#1605; &#1605;&#1582;&#1586;&#1606; (cache) &#1605;&#1585;&#1608;&#1585;&#1711;&#1585; &#1582;&#1608;&#1583; &#1585;&#1575; &#1662;&#1575;&#1705; &#1705;&#1606;&#1610;&#1583; &#1608; &#1583;&#1608;&#1576;&#1575;&#1585;&#1607; &#1587;&#1593;&#1610; &#1705;&#1606;&#1610;&#1583;.'); location='logout.php'</script>");
        }
    }
}

// if (isset($block_INPUT) && !empty($block_INPUT)) {
// echo("<script>location='hacking.php'</script>");
// setcookie('COOKUID', $_COOKIE['COOKUID'] + 1, time() + 600);
// if ($_COOKIE['COOKUID'] >= 5) {
// $reason = 'forcing to hack , input: {' . $block_INPUT . '}, url: {' . $_SERVER['REQUEST_URI'] . '}';
// $fp = fopen('black.list', 'a+');
// fwrite($fp, "LOG [" . date('d/m/Y') . " " . date('G/i/s') . "] [" . $_SERVER['REMOTE_ADDR'] . "] [" . $reason . "]\n" . $_SERVER['REMOTE_ADDR'] . "\n");
// }
// if ($_COOKIE['COOKUID'] >= 10) {
// $reason = 'forcing to hack , input: {' . $block_INPUT . '}, url: {' . $_SERVER['REQUEST_URI'] . '}';
// $fp = fopen('black.list', 'a+');
// fwrite($fp, "LOG [" . date('d/m/Y') . " " . date('G/i/s') . "] [" . $_SERVER['REMOTE_ADDR'] . "] [" . $reason . "]\n" . $_SERVER['REMOTE_ADDR'] . "\n");
// }
// }

// function getIp()
// {
// $http_client_ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : null;
// $http_x_forwarded_for = isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : null;

// if (!empty($http_client_ip)) {
// $host_addr = $http_client_ip;
// } elseif (!empty($http_x_forwarded_for)) {
// $host_addr = $http_x_forwarded_for;
// } else {
// $remote_addr = $_SERVER['REMOTE_ADDR'];
// $host_addr = $remote_addr;
// }
// return $host_addr;
// }

//BLOCK IP/s FROM BLACK list
// define ('BLACKLIST', 'black.list');
// if (file_exists(BLACKLIST)) {
// $list = file(BLACKLIST);
// foreach ($list as $addr) {
// $addr = trim($addr);
// $host_addr = getIp();
// Semplice indirizzo IP
// if ($host_addr == $addr) die ("Your IP address, {$addr} has been blocked.\n");
// Subnet di classe C
// else if (preg_match('/(\d+\.\d+\.\d+)\.0\/24/', $addr, $sub)) {
// $subnet = trim($sub[1]);
// if (preg_match("/^{$subnet}/", $host_addr))
// die ("Your IP address, {$host_addr} has been blocked.\n");
// } // Subnet di classe B
// else if (preg_match('/(\d+\.\d+)\.0\.0\/16/', $addr, $sub)) {
// $subnet = trim($sub[1]);
// if (preg_match("/^{$subnet}/", $host_addr))
// die ("Your IP address, {$host_addr} has been blocked.\n");
// } // Subnet di classe A
// else if (preg_match('/(\d+)\.0\.0\.0\/8/', $addr, $sub)) {
// $subnet = trim($sub[1]);
// if (preg_match("/^{$subnet}/", $host_addr))
// die ("Your IP address, {$host_addr} has been blocked.\n");
// }
// }
// }
// END OF BLOCKER //
?>