[CmdletBinding(DefaultParameterSetName = "Process")]
param (
    # FolderPath parameter to specify the folder to process
    [Parameter(ParameterSetName = "Process", Position = 0)]
    [string]$FolderPath = (Get-Location).Path,

    # Help parameter to display usage information
    [Parameter(ParameterSetName = "Help", HelpMessage = "Displays usage information.")]
    [switch]$Help
)

# Display help information if the -Help parameter is used
if ($PSCmdlet.ParameterSetName -eq "Help") {
    Write-Host @"
Usage: .\zipsTo7z.ps1 [-FolderPath <FolderPath>] [-Help]

Options:
  -FolderPath    Specify the folder to process. If not provided, defaults to the current directory.
  -Help          Displays this help information.

Description:
  This script traverses the specified folder (and its subfolders) to find .zip files,
  extracts their contents, recompresses them to .7z format using maximum compression,
  and calculates the size savings.

Examples:
  1. Process a specific folder:
     .\zipsTo7z.ps1 -FolderPath "C:\Path\To\Your\Folder"

  2. Process the current folder:
     .\zipsTo7z.ps1

  3. Display help information:
     .\zipsTo7z.ps1 -Help
"@
    exit
}

# Path to the 7z.exe executable
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Ensure 7-Zip is installed
if (-not (Test-Path $sevenZipPath)) {
    Write-Error "7-Zip is not installed or not found at $sevenZipPath."
    exit
}

# Validate the folder path
if (-not (Test-Path $FolderPath)) {
    Write-Error "The folder path '$FolderPath' does not exist."
    exit
}

Write-Host "Processing folder: $FolderPath"

# Initialize variables for size calculations
$totalOriginalSize = 0
$totalCompressedSize = 0

# Function to process a .zip file
function Process-ZipFile {
    param (
        [string]$zipFile
    )

    Write-Host "Processing file: $zipFile"
    if (-not (Test-Path $zipFile)) {
        Write-Warning "File does not exist or is inaccessible: $zipFile"
        return
    }

    # Get file size
    $originalSize = (Get-Item $zipFile).Length
    $global:totalOriginalSize += $originalSize

    # Create a temporary folder for extraction
    $tempFolder = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    New-Item -ItemType Directory -Path $tempFolder | Out-Null

    try {
        # Extract the .zip file
        Expand-Archive -Path $zipFile -DestinationPath $tempFolder -Force

        # Compress the extracted contents into a .7z file
        $sevenZipFile = "$zipFile.7z"
        $sevenZipArgs = @(
            "a",          # Add command
            "-t7z",       # Use .7z format
            "-mx=9",      # Maximum compression
            "`"$sevenZipFile`"",  # Output file path (quoted)
            "`"$tempFolder\*`""   # Input files path (quoted)
        )

        Start-Process -FilePath $sevenZipPath -ArgumentList $sevenZipArgs -Wait -NoNewWindow

        # Get compressed file size
        $compressedSize = (Get-Item $sevenZipFile).Length
        $global:totalCompressedSize += $compressedSize

        # Calculate size savings
        $sizeSavings = $originalSize - $compressedSize
        $percentageSavings = ($sizeSavings / $originalSize) * 100
        Write-Host "Processed: $zipFile"
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
    Process-ZipFile -zipFile $_.FullName
}

# Display total savings
$totalSavings = $totalOriginalSize - $totalCompressedSize
$percentageTotalSavings = ($totalSavings / $totalOriginalSize) * 100
Write-Host "`nSummary:"
Write-Host "Total Original Size: $($totalOriginalSize / 1GB) GB"
Write-Host "Total Compressed Size: $($totalCompressedSize / 1GB) GB"
Write-Host "Total Savings: $($totalSavings / 1GB) GB ($([math]::Round($percentageTotalSavings, 2))%)"
