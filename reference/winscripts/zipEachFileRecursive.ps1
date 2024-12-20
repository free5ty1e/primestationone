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
Usage: .\FilesToZip.ps1 [-FolderPath <FolderPath>] [-SevenZipPath <SevenZipPath>] [-Help]

Options:
  -FolderPath    Specify the folder to process. If not provided, defaults to the current directory.
  -SevenZipPath  Specify the path to the 7-Zip executable. If not provided, defaults to 'C:\Program Files\7-Zip\7z.exe'.
  -Help          Displays this help information.

Description:
  This script recursively iterates through every file in the specified folder and its subfolders,
  compresses each file individually into a .zip archive with maximum compression, and names the
  archive with the original file name (including extension).

Examples:
  1. Process a specific folder:
     .\FilesToZip.ps1 -FolderPath "C:\Path\To\Your\Folder"

  2. Specify a custom 7-Zip location:
     .\FilesToZip.ps1 -SevenZipPath "D:\CustomPath\7z.exe"

  3. Display help information:
     .\FilesToZip.ps1 -Help
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

# Function to process a single file
function Compress-File {
    param (
        [string]$filePath
    )

    Write-Host "Processing file: $filePath"

    # Prepare the ZIP file name (including the original file extension)
    $zipFilePath = "$filePath.zip"

    # Compress the file using 7-Zip
    $sevenZipArgs = @(
        "a",          # Add command
        "-tzip",      # Use .zip format
        "-mx=9",      # Maximum compression
        "`"$zipFilePath`"",  # Output ZIP file path (quoted)
        "`"$filePath`""       # Input file path (quoted)
    )

    Start-Process -FilePath $SevenZipPath -ArgumentList $sevenZipArgs -Wait -NoNewWindow

    # Confirm the ZIP file was created
    if (Test-Path -LiteralPath $zipFilePath) {
        Write-Host "Created: $zipFilePath"
    } else {
        Write-Warning "Failed to create ZIP for: $filePath"
    }
}

# Traverse the folder and process all files
Get-ChildItem -Path $FolderPath -Recurse -File | ForEach-Object {
    Compress-File -filePath $_.FullName
}

Write-Host "`nProcessing complete."
