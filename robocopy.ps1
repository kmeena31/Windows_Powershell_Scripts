param ($configFile)

$config = Import-Csv $configFile
$logDir = "C:\Users\%username%\robologs\"

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
 $logfile += ".log"

 robocopy $source $dest /E  /R:0 /W:0 /LOG:$logfile
}
