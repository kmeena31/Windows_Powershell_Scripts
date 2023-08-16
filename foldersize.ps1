$folder = "X:\<foldername>"  
$outputFile = "C:\Users\<username>\bitome-users-foldersize\<csv_name>.csv"  
Out-File -FilePath $outputFile -Encoding utf8 -InputObject "FolderName,Size"  
$subfolders = Get-ChildItem $folder -Directory | Sort-Object  
foreach ($folderItem in $subfolders) {  
    $subFolderItems = Get-ChildItem $folderItem.FullName -Recurse -Force -Depth 2 -File | Measure-Object -Property Length -Sum | Select-Object Sum
    #Write-Output $subFolderItems.sum
    #$folderItem.FullName + ”,” + “{0:N3}” -f ($subFolderItems.sum / 1MB) + ” MB” | Out-File -FilePath $outputFile -Append -Encoding utf8  
    $SizeInTb = ($subFolderItems.sum / 1TB )
    $SizeInGb = ($subFolderItems.sum / 1GB )
    $SizeInMb = ($subFolderItems.sum / 1MB )
    #Write-Output $SizeInTb
    if ($sizeInGb -ge 1){
    $folderItem.FullName + ”,” + “{0:N3}” -f ($SizeInGb) + ” GB” | Out-File -FilePath $outputFile -Append -Encoding utf8
    }
    elseif ($SizeInMb -ge 1 ){
    $folderItem.FullName + ”,” + “{0:N3}” -f ($SizeInMb) + ” MB” | Out-File -FilePath $outputFile -Append -Encoding utf8  
    }
    elseif ($SizeInTb -ge 1 ){
    #Write-Output $SizeInTb
    $folderItem.FullName + ”,” + “{0:N3}” -f ($SizeInTb) + ” TB” | Out-File -FilePath $outputFile -Append -Encoding utf8  
    }
}
