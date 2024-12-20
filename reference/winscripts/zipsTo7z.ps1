[CmdletBinding(DefaultParameterSetName = "Process")]
param (
    # FolderPath parameter to specify the folder to process
    [Parameter(ParameterSetName = "Process", Position = 0)]
    [string]$FolderPath = (Get-Location).Path,

    # Optional parameter to specify the location of 7-Zip
    [Parameter(ParameterSetName = "Process", Position = 1)]
    [string]$SevenZipPath = "C:\Program Files\7-Zip\7z.exe",

    # Help parameter to display usage information
    [Parameter(ParameterSetName = "Help", HelpMessage = "Displays usage information.")]
    [switch]$Help
)

# Display help information if the -Help parameter is used
if ($PSCmdlet.ParameterSetName -eq "Help") {
    Write-Host @"
Usage: .\zipsTo7z.ps1 [-FolderPath <FolderPath>] [-SevenZipPath <SevenZipPath>] [-Help]

Options:
  -FolderPath    Specify the folder to process. If not provided, defaults to the current directory.
  -SevenZipPath  Specify the path to the 7-Zip executable. If not provided, defaults to 'C:\Program Files\7-Zip\7z.exe'.
  -Help          Displays this help information.

Description:
  This script traverses the specified folder (and its subfolders) to find .zip files,
  extracts their contents, recompresses them to .7z format using maximum compression,
  and calculates the size savings.

Examples:
  1. Process a specific folder:
     .\zipsTo7z.ps1 -FolderPath "C:\Path\To\Your\Folder"

  2. Specify a custom 7-Zip location:
     .\zipsTo7z.ps1 -SevenZipPath "D:\CustomPath\7z.exe"

  3. Display help information:
     .\zipsTo7z.ps1 -Help
"@
    exit
}

# Ensure 7-Zip is installed
if (-not (Test-Path $SevenZipPath)) {
    Write-Error "7-Zip is not installed or not found at $SevenZipPath. Please specify the correct path using -SevenZipPath."
    exit
}

# Validate the folder path
if (-not (Test-Path $FolderPath)) {
    Write-Error "The folder path '$FolderPath' does not exist."
    exit
}

Write-Host "Processing folder: $FolderPath"
Write-Host "Using 7-Zip at: $SevenZipPath"

# Initialize variables for size calculations
$totalOriginalSize = 0
$totalCompressedSize = 0

# Function to process a .zip file
function Process-ZipFile {
    param (
        [string]$zipFilePath
    )

    Write-Host "Processing file: $zipFilePath"

    # Use Get-Item to safely retrieve the file object
    $zipFile = Get-Item -LiteralPath $zipFilePath
    if (-not $zipFile) {
        Write-Warning "File does not exist or is inaccessible: $zipFilePath"
        return
    }

    # Get file size
    $originalSize = $zipFile.Length
    $global:totalOriginalSize += $originalSize

    # Create a temporary folder for extraction
    $tempFolder = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    New-Item -ItemType Directory -Path $tempFolder | Out-Null

    try {
        # Extract the .zip file
        Expand-Archive -LiteralPath $zipFile.FullName -DestinationPath $tempFolder -Force

        # Compress the extracted contents into a .7z file
        $sevenZipFile = "$($zipFile.FullName).7z"
        $sevenZipArgs = @(
            "a",          # Add command
            "-t7z",       # Use .7z format
            "-mx=9",      # Maximum compression
            "`"$sevenZipFile`"",  # Output file path (quoted)
            "`"$tempFolder\*`""   # Input files path (quoted)
        )

        Start-Process -FilePath $SevenZipPath -ArgumentList $sevenZipArgs -Wait -NoNewWindow

        # Get compressed file size
        $compressedSize = (Get-Item -LiteralPath $sevenZipFile).Length
        $global:totalCompressedSize += $compressedSize

        # Calculate size savings
        $sizeSavings = $originalSize - $compressedSize
        $percentageSavings = ($sizeSavings / $originalSize) * 100
        Write-Host "Processed: $zipFile.FullName"
        Write-Host "Original Size: $($originalSize / 1MB) MB | Compressed Size: $($compressedSize / 1MB) MB"
        Write-Host "Savings: $($sizeSavings / 1MB) MB ($([math]::Round($percentageSavings, 2))%)"
    }
    finally {
        # Cleanup temporary folder
        Remove-Item -Path $tempFolder -Recurse -Force
    }
}

# Traverse the folder and process all .zip files
Get-ChildItem -Path $FolderPath -Recurse -Filter "*.zip" | ForEach-Object {
    Process-ZipFile -zipFilePath $_.FullName
}

# Display total savings
# $totalSavings = $totalOriginalSize - $totalCompressedSize
# $percentageTotalSavings = ($totalSavings / $totalOriginalSize) * 100
# Write-Host "`nSummary:"
# Write-Host "Total Original Size: $($totalOriginalSize / 1GB) GB"
# Write-Host "Total Compressed Size: $($totalCompressedSize / 1GB) GB"
# Write-Host "Total Savings: $($totalSavings / 1GB) GB ($([math]::Round($percentageTotalSavings, 2))%)"

$totalSavings = $totalOriginalSize - $totalCompressedSize

# Safeguard against divide-by-zero
if ($totalOriginalSize -ne 0) {
    $percentageTotalSavings = ($totalSavings / $totalOriginalSize) * 100
} else {
    $percentageTotalSavings = 0
}

Write-Host "`nSummary:"
Write-Host "Total Original Size: $($totalOriginalSize / 1GB) GB"
Write-Host "Total Compressed Size: $($totalCompressedSize / 1GB) GB"
Write-Host "Total Savings: $($totalSavings / 1GB) GB ($([math]::Round($percentageTotalSavings, 2))%)"
