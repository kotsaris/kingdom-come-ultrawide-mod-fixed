Param (
    [switch]$copyToGameDir = $false,
    [switch]$createPublicRelease = $false
)

if (Test-Path -Path "MyPak.pak") {
    Remove-Item -Path "MyPak.pak"
}

Push-Location -Path ".\data"

7z a -tzip -mx=0 ..\MyPak.pak libs\*

Pop-Location

if ($copyToGameDir) {
    Write-Host "Copying to game directory..."
    cp .\MyPak.pak "C:\Program Files (x86)\Steam\steamapps\common\KingdomComeDeliverance\Mods\ultra_widescreen\data\data.pak" -Force
}

if ($createPublicRelease) {
    Write-Host "Creating public release..."

    if (Test-Path -Path ".\ultra_widescreen.zip") {
        Remove-Item -Path ".\ultra_widescreen.zip"
    }

    if (-not (Test-Path -Path ".\ultra_widescreen\data")) {
        Write-Host "Creating ultra_widescreen\data directory..."
        New-Item -ItemType Directory -Path ".\ultra_widescreen\data"
    }

    cp .\MyPak.pak .\ultra_widescreen\data\data.pak -Force

    # Copy disclaimer to release folder
    if (Test-Path -Path ".\DISCLAIMER.md") {
        cp .\DISCLAIMER.md .\ultra_widescreen\DISCLAIMER.md -Force
    }

    Compress-Archive .\ultra_widescreen\ ultra_widescreen.zip
}


rm .\MyPak.pak