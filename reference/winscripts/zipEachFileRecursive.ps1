[CmdletBinding(DefaultParameterSetName = "Process")]
param (
    [Parameter(ParameterSetName = "Process", Position = 0)]
    [string]$FolderPath = (Get-Location).Path,

    [Parameter(ParameterSetName = "Process", Position = 1)]
    [string]$SevenZipPath = "C:\Program Files\7-Zip\7z.exe",

    [Parameter(ParameterSetName = "Help", HelpMessage = "Displays usage information.")]
    [switch]$Help
)

if ($PSCmdlet.ParameterSetName -eq "Help") {
    Write-Host @"
Usage: .\zipEachFileRecursive.ps1 [-FolderPath <FolderPath>] [-SevenZipPath <SevenZipPath>] [-Help]

Options:
  -FolderPath    Specify the folder to process. Defaults to the current directory.
  -SevenZipPath  Specify the path to the 7-Zip executable. Defaults to 'C:\Program Files\7-Zip\7z.exe'.
  -Help          Displays this help information.

Description:
  Recursively compresses all files in a folder into .zip archives, skipping files with .zip extensions. 
  Replaces existing .zip files and shows space savings for each file and overall.

Examples:
  .\zipEachFileRecursive.ps1 -FolderPath "C:\Path\To\Your\Files"
"@
    exit
}

if (-not (Test-Path $SevenZipPath)) {
    Write-Error "7-Zip is not installed or not found at $SevenZipPath. Please specify the correct path using -SevenZipPath."
    exit
}

if (-not (Test-Path $FolderPath)) {
    Write-Error "The folder path '$FolderPath' does not exist."
    exit
}

Write-Host "Processing folder: $FolderPath"
Write-Host "Using 7-Zip at: $SevenZipPath"

# Initialize totals for size calculations
$totalOriginalSize = 0
$totalCompressedSize = 0

# Function to process a single file
function Compress-File {
    param (
        [string]$filePath
    )

    # Skip files with a .zip extension
    if ($filePath.EndsWith(".zip", [StringComparison]::InvariantCultureIgnoreCase)) {
        Write-Host "Skipping file (already a .zip): $filePath"
        return
    }

    Write-Host "Processing file: $filePath"

    $zipFilePath = "$filePath.zip"

    # Remove existing .zip file if it exists
    if (Test-Path $zipFilePath) {
        Remove-Item -Path $zipFilePath -Force
    }

    # Get the original file size
    $originalSize = (Get-Item $filePath).Length
    $global:totalOriginalSize += $originalSize

    # Compress the file using 7-Zip
    $sevenZipArgs = @(
        "a",          # Add command
        "-tzip",      # Use .zip format
        "-mx=9",      # Maximum compression
        "`"$zipFilePath`"",  # Output ZIP file path (quoted)
        "`"$filePath`""       # Input file path (quoted)
    )
    Start-Process -FilePath $SevenZipPath -ArgumentList $sevenZipArgs -Wait -NoNewWindow

    # Get the compressed file size
    if (Test-Path -LiteralPath $zipFilePath) {
        $compressedSize = (Get-Item $zipFilePath).Length
        $global:totalCompressedSize += $compressedSize

        # Calculate and display size savings
        $sizeSavings = $originalSize - $compressedSize
        $percentageSavings = ($sizeSavings / $originalSize) * 100
        Write-Host "Created: $zipFilePath"
        Write-Host "Original Size: $($originalSize / 1MB) MB | Compressed Size: $($compressedSize / 1MB) MB"
        Write-Host "Savings: $($sizeSavings / 1MB) MB ($([math]::Round($percentageSavings, 2))%)"
    } else {
        Write-Warning "Failed to create ZIP for: $filePath"
    }
}

# Traverse the folder and process all files
Get-ChildItem -Path $FolderPath -Recurse -File | ForEach-Object {
    Compress-File -filePath $_.FullName
}

# Calculate overall savings
$totalSavings = $totalOriginalSize - $totalCompressedSize
$percentageTotalSavings = ($totalSavings / $totalOriginalSize) * 100

# Display summary
Write-Host "`nSummary:"
Write-Host "Total Original Size: $($totalOriginalSize / 1GB) GB"
Write-Host "Total Compressed Size: $($totalCompressedSize / 1GB) GB"
Write-Host "Total Savings: $($totalSavings / 1GB) GB ($([math]::Round($percentageTotalSavings, 2))%)"
