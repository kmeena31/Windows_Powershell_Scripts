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
 $logfile += $((get-date).ToLocalTime()).ToString("yyyyMMddHHmmss")
 $logfile += ".log"
 
 Add-Content $logfile "Backups start at $(Get-Date)"
 robocopy $source $dest /E /FFT  /R:0 /W:0 /LOG:$logfile
 Add-Content $logfile "Backups complete at $(Get-Date)"
 
 try {
    (Get-Acl $Source).Access #Verify $Source Access
} catch [System.UnauthorizedAccessException] {
    $pathWithProblem = $_.TargetObject
    #do what you like with it after this
    $descriptionOfProblem = $_.Exception.Message
    Write-Warning "$descriptionOfProblem : $pathWithProblem"
    #throw
}

 #(Get-Acl $Source).Access #Verify $Source Access
#(Get-Acl $Target).Access #Verify $Target Access

$fsa = Get-ChildItem -Recurse -path $source
$fsb = Get-ChildItem -Recurse -path $dest
Compare-Object -Referenceobject $fsa -DifferenceObject $fsb


Get-ChildItem -Path $source -Recurse | Where-Object {

    [string] $toDiff = $_.FullName.Replace($source, $dest)
    # Determine what's in 2, but not 1
    [bool] $isDiff = (Test-Path -Path $toDiff) -eq $false
	#(Get-Acl $Source).Access #Verify $Source Access
    #(Get-Acl $Target).Access #Verify $Target Access

    if ($isDiff) {
        # Create destination path that contains folder structure
		
        $dest = $_.FullName.Replace($source, $dest)
        Copy-Item -Path $_.FullName -Destination $dest -Verbose -Force
		
    }
 }
 
}