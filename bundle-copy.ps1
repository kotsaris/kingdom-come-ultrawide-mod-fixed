if(Test-Path -Path "MyPak.pak") {
    Remove-Item -Path "MyPak.pak"
}

7z a -tzip -mx=0 MyPak.pak data\libs\*

cp .\MyPak.pak "C:\Program Files (x86)\Steam\steamapps\common\KingdomComeDeliverance\Mods\ultra_widescreen\data\data.pak"