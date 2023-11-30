param ($configFile)

$config = Import-Csv $configFile
$logDir = "C:\Users\adm_mkande\robologs\"

Write-Output $configFile

foreach ($line in $config)
{
 $source = $($line.SourceFolder)
 $dest = $($line.DestFolder)
 #$source = $($line.split(",")[0])
 #$dest = $($line.split(",")[1])
 Write-Output $source $dest
 $logfile =  $logDir 
 #$logfile += Split-Path $source -Leaf
 $logfile += "size" + $((get-date).ToLocalTime()).ToString("yyyyMMddHHmmss")
 $logfile += ".log"
 

 $sourceLen = (gci -force $source -Recurse -ErrorAction SilentlyContinue | measure Length -s).sum / 1Gb
 $destLen = (gci -force $dest -Recurse -ErrorAction SilentlyContinue | measure Length -s).sum / 1Gb
 Add-Content $logfile " $source Size in Gb: $sourceLen, $dest Size in Gb :$destLen "
}

