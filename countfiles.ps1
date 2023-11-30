param ($configFile)

$config = Import-Csv $configFile
$logDir = "C:\Users\adm_mkande\robologs\"

Write-Output $configFile
$logfile =  $logDir 
 $logfile += Split-Path $configFile -Leaf
 $logfile += $((get-date).ToLocalTime()).ToString("yyyyMMddHHmmss")
 $logfile += ".log"

foreach ($line in $config)
{
 $source = $($line.SourceFolder)
 $dest = $($line.DestFolder)
 #$source = $($line.split(",")[0])
 #$dest = $($line.split(",")[1])
 Write-Output $source $dest
 
 
  $count = (Get-ChildItem $source -Recurse | Measure-Object).Count
  Add-content $logfile "$source = $count"
 
}
