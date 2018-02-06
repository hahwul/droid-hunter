<img src="https://cloud.githubusercontent.com/assets/13212227/26283637/397918c4-3e67-11e7-9026-21c16e0b3759.png">


            .---.        .-----------
           /     \  __  /    ------
          / /     \(  )/    -----     ╔╦╗╦═╗╔═╗╦╔╦╗   ╦ ╦╦ ╦╔╗╔╔╦╗╔═╗╦═╗
         //////   ' \/ `   ---         ║║╠╦╝║ ║║ ║║───╠═╣║ ║║║║ ║ ║╣ ╠╦╝
        //// / // :    : ---          ═╩╝╩╚═╚═╝╩═╩╝   ╩ ╩╚═╝╝╚╝ ╩ ╚═╝╩╚═
       // /   /  /`    '--                         By HaHwul
      //          //..\\                         www.hahwul.com
             ====UU====UU====         https://github.com/hahwul/droid-hunter
                 '//||\\`
                   ''``
________________________________________________
# DROID-HUNTER
## 1. DROID-HUNTER
Android application vulnerability analysis and Android pentest tool<br>

<br>
A. Support<br>
> App info check<br>
> Baksmaling android app<br>
> Decompile android app<br>
> Extract class file<br>
> Extract java code<br>
> Pattern base Information Leakage<br>

## 2. How to Install?
A. Download(clone) & Unpack DROID-HUNTER
> git clone https://github.com/hahwul/droid-hunter.git<br>
> cd droid-hunter<br>

B. Install Ruby GEM<br>
> gem install html-table<br>
> gem install colorize<br>

C. Set external tools
> Editing "./config/config.rb"
```
# Tool path
$p_adb = "/usr/bin/adb"     
$p_aapt = "/usr/bin/aapt"   # Path aapt
                            # macOS > (https://github.com/hahwul/droid-hunter/issues/12)
$p_dex2jar = File.dirname(__FILE__)+"/../ex_tool/dex2jar-0.0.9.15/dex2jar.sh"
$p_apktool = File.dirname(__FILE__)+"/../ex_tool/apktool/apktool_2.3.1.jar"
$p_jad = File.dirname(__FILE__)+"/../ex_tool/jad/jad"
$p_grep = "/bin/grep"
$p_unzip = "/usr/bin/unzip"
$p_sfilter = File.dirname(__FILE__)+"/../string_filter"
```


D. Run DROID-HUNTER<br>
> ruby dhunter.rb

## 3. How to Use?

    Usage: ruby dhunter.rb [APK]
    Command
    -a, --apk : Analysis android APK file.
     + APK Analysis
       => dhunter -a 123.apk[apk file]
       => dhunter --apk 123.apk aaa.apk test.apk hwul.apk
    -p, --pentest : Penetration testing Device
     + Pentest Android
       => dhunter -p device[device code]
       => dhunter --pentest device
    -v, --version : Show this droid-hunter version
    -h, --help : Show help page

## 4. Support
Bug: Add issue(github)<br>
Contact: hahwul@gmail.com<br>
<br>

## 5. TO-DO List
> Add Vulnerability Scanning module<br>
> Update string pattern<br>
> Intent diagram<br>
<br>
## 6. Screen shot
<img src="https://cloud.githubusercontent.com/assets/13212227/17181679/e8b9b448-545b-11e6-9bb9-ee1cc2f5e28b.png">
<img src="https://cloud.githubusercontent.com/assets/13212227/17219286/cae365d4-5525-11e6-82c8-ccf9d135f3e2.png">
