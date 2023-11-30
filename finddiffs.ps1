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
 $logfile += Split-Path $source -Leaf
 $logfile += "Diff" + $((get-date).ToLocalTime()).ToString("yyyyMMddHHmmss")
 $logfile += ".log"
 

 $sourceLen = (gci -force $source -Recurse -ErrorAction SilentlyContinue | measure Length -s).sum / 1Gb
 $destLen = (gci -force $dest -Recurse -ErrorAction SilentlyContinue | measure Length -s).sum / 1Gb
 Add-Content $logfile " Source Size in Gb $sourceLen "
 Add-Content $logfile " Dest Size in Gb  $destLen "


$fsa = Get-ChildItem -Recurse -path $source
$fsb = Get-ChildItem -Recurse -path $dest
$fsc = Compare-Object -Referenceobject $fsa -DifferenceObject $fsb
Add-Content $logfile $fsc

 
}

