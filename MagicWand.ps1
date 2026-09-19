# Magic-Wand Function
function Magic-Wand {

    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $adminStatus = if ($isAdmin) { "🔓 ADMIN MODE" } else { "🔒 USER MODE (Limited)" }
    $adminColor = if ($isAdmin) { "Green" } else { "Red" }

    $choices = @{
        '1' = "📦 WinGet Management"
        '2' = "🔄 Windows & Defender Update"
        '3' = "🛠️ System & Store Scans"
        '4' = "🔋 Power Modes & Battery Report"
        '5' = "🌐 Network Adapter & Telemetry"
        '6' = "🧹 Deep Clean"
        '7' = "🔒 Pass Manager"
        '8' = "🗄️ Sync Manager"
        '9' = "📥 Offline Dependency Setup"
        'S' = "🛑 Shutdown / Restart"
        'Q' = "❌ Quit"
    }

    do {
        Clear-Host
        $header = "  --- ✨ MAGIC-WAND TOOL-KIT ---"
        Write-Host "`n $header ($adminStatus)" -ForegroundColor $adminColor
        $choices.GetEnumerator() | Sort-Object Name | ForEach-Object {
            Write-Host "  [$($_.Name)] $($_.Value)" -ForegroundColor Cyan
        }
        
        $mainChoice = Read-Host "`n  🎀 PRINCESS, Please Select an option:"

        switch ($mainChoice) {
                    1 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ WinGet Management ---" -ForegroundColor Magenta
                            Write-Host "a. 📦 Update All" -ForegroundColor Cyan
                            Write-Host "b. 📦 List Installed" -ForegroundColor Cyan
                            Write-Host "c. 📦 Remove App" -ForegroundColor Cyan
                            Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            if ($sub -eq 'a') { winget upgrade --all --include-unknown --verbose; Read-Host "`n ✅ PRINCESS, Update completed! Please Press Enter:" }
                            if ($sub -eq 'b') { winget list; Read-Host "`n ✅ PRINCESS, Installed apps listed! Please Press Enter:" }
                            if ($sub -eq 'c') { 
                                $id = Read-Host "🎀 PRINCESS, Please Enter App ID to remove:"
                                winget uninstall --id $id
                                Read-Host "`n ✅ PRINCESS, Task Accomplished! Please Press Enter:" 
                            }
                        } while ($sub -ne 'Q')
                    }
                    2 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ Windows Update ---" -ForegroundColor Magenta
                            Write-Host "a. 🔄 Check for Updates" -ForegroundColor Cyan
                            Write-Host "b. 🔄 Install (No Reboot)" -ForegroundColor Cyan
                            Write-Host "c. 🔄 Update 🛡️ Defender Signatures" -ForegroundColor Cyan
                            Write-Host "d. 📜 Update History" -ForegroundColor Cyan
                            Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            if ($sub -eq 'a') { Get-WindowsUpdate -Verbose; Read-Host "`n ✅ PRINCESS, These are the updates available for Windows! Please Press Enter:" }
                            if ($sub -eq 'b') { Install-WindowsUpdate -AcceptAll -IgnoreReboot -Verbose; Read-Host "`n ✅ PRINCESS, Windows has been updated! Please Press Enter:" }
                            if ($sub -eq 'c') {    
                                & "C:\Program Files\Windows Defender\MpCmdRun.exe" -SignatureUpdate
                                Read-Host "`n ✅ PRINCESS, Defender has been updated! Please Press Enter:"
                            }
                            if ($sub -eq 'd') { 
                                Write-Host "📜 PRINCESS, Showing your recent Update History:" -ForegroundColor Cyan
                                Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10 | Out-String
                                Read-Host "Press Enter:"
                            }
                        } while ($sub -ne 'Q')
                    }
                    3 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ System Scans ---" -ForegroundColor Magenta
                            Write-Host "a. 🛠️ SFC Scannow" -ForegroundColor Cyan
                            Write-Host "b. 🛠️ DISM Check Health" -ForegroundColor Cyan
                            Write-Host "c. 🛠️ DISM Scan Health" -ForegroundColor Cyan
                            Write-Host "d. 🛠️ DISM Repair Health" -ForegroundColor Cyan
                            Write-Host "e. 🧹 Component Cleanup" -ForegroundColor Cyan
                            Write-Host "f. 🔍 Live Drive Repair" -ForegroundColor Cyan
                            Write-Host "g. 💻 The Ultimate System Specs..." -ForegroundColor Cyan
                            Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            if ($sub -eq 'a') { cmd /c sfc /scannow; Read-Host "`n ✅ PRINCESS, SFC Scan completed! Please Press Enter:" }
                            if ($sub -eq 'b') { cmd /c DISM /Online /Cleanup-Image /CheckHealth; Read-Host "`n ✅ PRINCESS, DISM Health Chech completed! Please Press Enter:" }
                            if ($sub -eq 'c') { cmd /c DISM /Online /Cleanup-Image /ScanHealth; Read-Host "`n ✅ PRINCESS, DISM Health Scan completed! Please Press Enter:" }
                            if ($sub -eq 'd') { cmd /c DISM /Online /Cleanup-Image /RestoreHealth; Read-Host "`n ✅ PRINCESS, DISM Health Restore completed! Please Press Enter:" }
                            if ($sub -eq 'e') { cmd /c DISM /Online /Cleanup-Image /StartComponentCleanup; Read-Host "`n ✅ PRINCESS, Component clean-up completed! Please Press Enter:" }
                            if ($sub -eq 'f') {
                                Write-Host "🔍 PRINCESS, Running Live Volume Scan on C:..." -ForegroundColor Cyan
                                Repair-Volume -DriveLetter C -Scan
                                Read-Host "`n✅ Scan finished! Press Enter:"
                            }
                            if ($sub -eq 'g') {
                                Write-Host "`n💻 PRINCESS, Gathering the Ultimate Spec Sheet..." -ForegroundColor Cyan
                                $info = Get-ComputerInfo
                                $gpu = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name -ErrorAction SilentlyContinue
                                $ram = [math]::Round($info.CsTotalPhysicalMemory / 1GB, 2)

                                $Specs = [PSCustomObject]@{
                                    "👑 Device Name"  = $info.CsName
                                    "💻 Model"        = $info.CsModel
                                    "💿 OS Version"   = "$($info.OsName) ($($info.OsDisplayVersion))"
                                    "🚀 Processor"    = $info.CsProcessors[0].Name
                                    "🎮 Graphics"     = ($gpu -join ' | ')
                                    "🧠 Memory (RAM)" = "$ram GB"
                                    "📟 BIOS"         = $info.BiosVersion
                                    "📅 Install Date" = $info.OsInstallDate
                                }
                                
                                $Specs | Format-List
                                Read-Host "`n✅ PRINCESS, Specs retrieved! Press Enter:"
                            }
                        } while ($sub -ne 'Q')
                    }
                    4 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ Power Modes ---" -ForegroundColor Magenta
                            Write-Host "a. ⚡ Balanced Mode" -ForegroundColor Cyan
                            Write-Host "b. ⚡ High Performance" -ForegroundColor Cyan
                            Write-Host "c. 🔋 Generate Battery Report" -ForegroundColor Cyan
                            Write-Host "d. 🚀 Top 10 CPU Hugs" -ForegroundColor Cyan
                            Write-Host "e. 🔪 Kill a Process" -ForegroundColor Cyan
                            Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            if ($sub -eq 'a') { 
                                powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e 
                                Write-Host " ✅ PRINCESS, System switched to Balanced Mode." -ForegroundColor Green; Read-Host "Press Enter to continue:"
                            }
                            if ($sub -eq 'b') { 
                                powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                                powercfg /s SCHEME_MIN
                                Write-Host " 🚀 PRINCESS, High Performance Mode Activated." -ForegroundColor Green; Read-Host "Press Enter to continue:"
                            }
                            if ($sub -eq 'c') { 
                                $reportDir = "$HOME\Documents\BatteryReports"
                                if (!(Test-Path $reportDir)) { New-Item -ItemType Directory -Path $reportDir }
                                $reportPath = "$reportDir\battery_report.html"
                                powercfg /batteryreport /output $reportPath
                                Write-Host "✅ PRINCESS, Battery Report saved to: $reportPath" -ForegroundColor Green
                                Invoke-Item $reportPath
                                Read-Host "Press Enter to continue:"
                            }
                            if ($sub -eq 'd') {
                                Write-Host "`n🚀 PRINCESS, Here are the top 10 CPU Hogs:" -ForegroundColor Cyan
                                Get-Process | Where-Object {$_.Name -ne "Idle"} | Sort-Object CPU -Descending | Select-Object -First 10 -Property Name, CPU, WorkingSet | Format-Table -AutoSize
                                Read-Host "`n✅ Scan complete! Press Enter:"
                            }
                            if ($sub -eq 'e') {
                                $procName = Read-Host "🔪 PRINCESS, Enter Process Name to terminate (e.g., Chrome)"
                                try {
                                    Stop-Process -Name $procName -Force -ErrorAction Stop
                                    Write-Host "✅ Task Accomplished! $procName terminated." -ForegroundColor Green
                                } catch {
                                    Write-Host "⚠️ Couldn't find a process named '$procName'." -ForegroundColor Red
                                }
                                Read-Host "`nPress Enter to continue:"
                            }
                        } while ($sub -ne 'Q')
                    }
                    5 {
                    do {
                        Clear-Host
                        Write-Host "--- ✨ Network & Cache ---" -ForegroundColor Magenta
                        Write-Host "a. 🛰️  Adapter Configuration Info" -ForegroundColor Cyan
                        Write-Host "b. 🛰️ Restart Primary WiFi Adapter" -ForegroundColor Cyan
                        Write-Host "c. 🌐 Flush DNS Cache" -ForegroundColor Cyan
                        Write-Host "d. 🌐 Is My WiFi Good?" -ForegroundColor Cyan
                        Write-Host "e. 🌐 Stop Telemetry (DiagTrack)" -ForegroundColor Cyan
                        Write-Host "f. 🕵️ Privacy Audit" -ForegroundColor Cyan
                        Write-Host "g. 🔑 BitLocker Status" -ForegroundColor Cyan                       
                        Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                        $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                    
                        if ($sub -eq 'a') { Get-NetIPConfiguration | Out-String; Read-Host "🎀 PRINCESS, Please Enter to continue:" }
                        if ($sub -eq 'b') { 
                            Write-Host "🎀 PRINCESS, Resetting Wireless Hardware..." -ForegroundColor Cyan

                            # Find ANY physical WiFi adapter regardless of its name
                            $adapter = Get-NetAdapter | Where-Object { 
                                $_.PhysicalMediaType -like "*Native 802.11*" -and 
                                $_.Virtual -eq $false 
                            }

                            if ($adapter) {
                                foreach ($a in $adapter) {
                                    Write-Host "🔄 Restarting: $($a.InterfaceDescription)" -ForegroundColor DarkGray
                                    try {
                                        # Force restart without confirmation
                                        Restart-NetAdapter -Name $a.Name -Confirm:$false
                                        Write-Host "✅ PRINCESS, WiFi connection is back online!" -ForegroundColor Green
                                    } catch {
                                        Write-Host "❌ Error: Please ensure you ran the Terminal as ADMIN." -ForegroundColor Red
                                    }
                                }
                            } else {
                                Write-Host "⚠️ PRINCESS, No physical WiFi hardware was detected." -ForegroundColor Yellow
                            }
                            Read-Host "`n ✅ PRINCESS, Task Accomplished! Please Press Enter:" 
                            }
                        if ($sub -eq 'c') { ipconfig /flushdns; Read-Host "`n ✅ PRINCESS, DNS Cache flushed! Press Enter:" }
                        if ($sub -eq 'd') {
                            $targets = [ordered]@{ "Google" = "8.8.8.8"; "Google Backup" = "8.8.4.4"; "Cloudflare" = "1.1.1.1" }
                            Write-Host "`n📡 PRINCESS, Checking Global Connectivity..." -ForegroundColor Cyan
                            foreach ($name in $targets.Keys) {
                                $ip = $targets[$name]
                                Write-Host "`n✨ Testing $name ($ip)..." -ForegroundColor Magenta
                                Test-Connection -ComputerName $ip -Count 2 -ErrorAction SilentlyContinue
                            }
                            Read-Host "`n✅ Connectivity check complete! Press Enter:"
                        }
                        if ($sub -eq 'e') { 
                        Write-Host "🎀 PRINCESS, Killing Telemetry Services..." -ForegroundColor Magenta
                        Stop-Service DiagTrack -ErrorAction SilentlyContinue
                        Set-Service DiagTrack -StartupType Disabled
                        Write-Host "✅ PRINCESS, System privacy enhanced!" -ForegroundColor Green; Read-Host "Enter"
                        }
                        if ($sub -eq 'f') {
                            Write-Host "`n🕵️ PRINCESS, Here is who is talking to the Web right now:" -ForegroundColor Cyan
                            Get-NetTCPConnection -State Established | Select-Object `
                                LocalAddress, LocalPort, RemoteAddress, 
                                @{Name="ProcessName"; Expression={(Get-Process -Id $_.OwningProcess).ProcessName}}, 
                                OwningProcess | Format-Table -AutoSize
                                
                            Read-Host "`n✅ PRINCESS, Audit complete! Press Enter:"
                        }
                        if ($sub -eq 'g') { manage-bde -status; Read-Host "🔑 PRINCESS, This is the status of Bitlocker! Press Enter:" }
                        } while ($sub -ne 'Q')
                    }
                    6 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ Deep Clean & Defrag ---" -ForegroundColor Magenta
                            Write-Host "a. 🧹 Run Deep Clean (Temp/Prefetch)" -ForegroundColor Cyan
                            Write-Host "b. 🧹 Run Defragmenter (C:)" -ForegroundColor Cyan
                            Write-Host "c. 🗑️ Empty Recycle Bin" -ForegroundColor Cyan
                            Write-Host "Q. ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            if ($sub -eq 'a') {
                                $folders = "C:\Windows\Temp\*", "$env:TEMP\*", "C:\Windows\Prefetch\*"
                                foreach ($folder in $folders) {
                                    Write-Host "🎀 Scanning: $folder" -ForegroundColor Cyan
                                    Get-ChildItem $folder -ErrorAction SilentlyContinue | ForEach-Object {
                                        Write-Host "🎀 Deleting: $($_.Name)" -ForegroundColor DarkGray
                                        Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                                    }
                                }
                                Read-Host "`n ✅ PRINCESS, System cleanup completed! Press Enter:"
                            }
                            if ($sub -eq 'b') {
                                Optimize-Volume -DriveLetter C -Defrag -Verbose
                                Read-Host "`n ✅ PRINCESS, C Drive Defrag completed. Press Enter:"
                            }
                            if ($sub -eq 'c') {
                                Write-Host "🗑️ PRINCESS, Emptying all Recycle Bins..." -ForegroundColor Cyan
                                Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
                                Write-Host "✅ Trash has been vaporized!" -ForegroundColor Green
                                Read-Host "Press Enter:"
                            }
                        } while ($sub -ne 'Q')
                    }
                    7 {
                        do {
                            Clear-Host
                            Write-Host "--- ✨ Pass Manager Setup ---" -ForegroundColor Magenta
                            Write-Host "  [a] 🔒 Run Pass Manager" -ForegroundColor Cyan
                            Write-Host "  [b] 🛠️ Check/Install Dependencies (Python & Libs)" -ForegroundColor Cyan
                            Write-Host "  [Q] ❌ Back to Main Menu" -ForegroundColor DarkGray
                            $sub = Read-Host "`n 🎀 PRINCESS, Please Select sub-option:"
                            
                            if ($sub -eq 'a') {
                                $pythonPath = "C:\My Vault\Pass Manager.py"
                                if (Test-Path $pythonPath) {
                                    # Ensure we are in the correct directory for logo/data files
                                    Push-Location "C:\My Vault"
                                    python "Pass Manager.py"
                                    Copy-Item "C:\My Vault\data.json" -Destination "C:\My Vault\Pass Manager Bk\Pass_M_Backup.json" -Force
                                    Write-Host "✅ PRINCESS, Safely backed up passwords to Documents!" -ForegroundColor Cyan
                                    Pop-Location
                                } else {
                                    Write-Host "❌ Error: Pass Manager.py not found at C:\My Vault\" -ForegroundColor Red
                                }
                                Read-Host "`n ✅ PRINCESS, Session Ended. Press Enter:"
                            }
                                        
                            if ($sub -eq 'b') {
                                Write-Host "`n🔍 PRINCESS, Checking System..." -ForegroundColor Cyan
                                # 1. Check if Python is installed
                                if (!(Get-Command python -ErrorAction SilentlyContinue)) {
                                    Write-Host "❌ PRINCESS, Python is NOT installed." -ForegroundColor Red
                                    Write-Host "🎁 PRINCESS, Installing Python via WinGet..." -ForegroundColor Yellow
                                    winget install -e --id Python.Python.3 --silent
                                } else {
                                    Write-Host "✅ PRINCESS, Python is installed." -ForegroundColor Green
                                }
                                                    
                                # 2. Check and Install Pip Modules
                                $modules = @("pyperclip", "maskpass")
                                foreach ($module in $modules) {
                                    Write-Host "🔍 PRINCESS, Checking $module..." -ForegroundColor DarkGray
                                    python -m pip show $module > $null 2>&1
                                    if ($LASTEXITCODE -ne 0) {
                                        Write-Host "📦 PRINCESS, Installing $module..." -ForegroundColor Magenta
                                        python -m pip install $module
                                    } else {
                                        Write-Host "✅ PRINCESS, $module is already installed." -ForegroundColor Green
                                    }
                                }
                                Read-Host "`n ✨ PRINCESS, Setup Complete! Press Enter:"
                            }
                        } while ($sub -ne 'Q')
                    }
                    8 {
                        Clear-Host
                        Write-Host "--- ✨ Sync Manager ---" -ForegroundColor Magenta
                        $pythonPath = "C:\My Vault\Sync Tool.py"
                        if (Test-Path $pythonPath) {
                            Push-Location "C:\My Vault"
                            python "Sync Tool.py"
                            Pop-Location
                        } else {
                            Write-Host "❌ Error: Sync Tool.py not found at C:\My Vault\" -ForegroundColor Red
                            Read-Host "`nPress Enter to return:"
                        }
                    }
                    9 { 
                        Clear-Host
                        Write-Host "--- 📥 Dependency Setup ---" -ForegroundColor Magenta
                        if (!(Get-Module -ListAvailable PSWindowsUpdate)) {
                            Write-Host "📦 Installing PSWindowsUpdate..." -ForegroundColor Cyan
                            Install-Module -Name PSWindowsUpdate -Force -AllowClobber
                        } else { Write-Host "✅ PSWindowsUpdate already present." -ForegroundColor Green }
                        Read-Host "`n ✨ Setup Complete! Press Enter"
                    }
                    'S' { 
                        Clear-Host
                        Write-Host "--- 🛑 Power Control ---" -ForegroundColor Red
                        Write-Host "a. 🌑 Full Shutdown" -ForegroundColor Cyan
                        Write-Host "b. 🔄 Force Restart" -ForegroundColor Cyan
                        $sub = Read-Host "`n 🎀 Are you sure? (a/b)"
                        if ($sub -eq 'a') { shutdown /s /f /t 0 }
                        if ($sub -eq 'b') { shutdown /r /f /t 0 }
                    }
                }
            } while ($mainChoice -ne 'Q')
        }