$file=$args[0]

$bytes  = [System.IO.File]::ReadAllBytes($file)
$offset = 02

if($bytes[$offset]-13 -ge 0)
{
	$lol = $bytes[$offset]-13
	$bytes[$offset]   = $lol
}
elseif($bytes[$offset]-13 -le 0)
{
	$lol = 255+$bytes[$offset]+$bytes[$offset+1]-13
	$bytes[$offset]   = $lol
	$bytes[$offset+1]   = 00
}

[System.IO.File]::WriteAllBytes($file, $bytes)