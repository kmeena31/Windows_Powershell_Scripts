#$compress = @{
$LiteralPath= "X:\users\ninfante"
#CompressionLevel = "Fastest"
$DestinationPath = "X:\users\ninfante.zip"
#}
#Compress-Archive @compress

Add-Type -Assembly "System.IO.Compression.FileSystem" ;
[System.IO.Compression.ZipFile]::CreateFromDirectory( $LiteralPath, $DestinationPath) ;