# Aliases
Set-Alias v nvim
Set-Alias ll dir
Set-Alias l ll
Set-Alias la dir -Force
Set-Alias htop ntop
Set-Alias ifconfig ipconfig
Set-Alias reboot Restart-Computer
Set-Alias which where.exe
Set-Alias open explorer.exe
Set-Alias wget wget.exe -Option AllScope
Set-Alias curl curl.exe -Option AllScope
Set-Alias jadx-gui C:\jadx-1.2.0\bin\jadx-gui.bat
Set-Alias grep findstr.exe
Set-Alias ghidra ghidraRun.bat
Set-Alias windbg "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe"
Set-Alias cdb "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\cdb.exe"
Set-Alias windbg32 "C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\windbg.exe"
Set-Alias cdb32 "C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\cdb.exe"
Set-Alias bash "C:\Program Files\Git\git-bash.exe"

function upper {
    Set-Location ..
}
Set-Alias .. upper

function upper2 {
    Set-Location ..\..
}
Set-Alias ... upper2

function home {
    Set-Location ~
}
Set-Alias ~ home

function root {
    Set-Location C:\
}
Set-Alias / root

function chrome {
    & 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe' --ignore-certificate-errors --disable-web-security --disable-gpu --user-data-dir=~/chromeTemp
}

function gdb {
    gdb.exe -q $args
}

function StopPC {
    shutdown.exe /s /t 0
}
Set-Alias shutdown StopPC -Option AllScope
Set-Alias poweroff shutdown

# Generate acmicpc.net template
function ex([String]$num) {
    cp -r $HOME/study/algorithm/acmicpc.net/template $num
        code $num
}

# Go to previous directory
[System.Collections.Stack]$GLOBAL:dirStack = @()
$GLOBAL:oldDir = ''
$GLOBAL:addToStack = $true
function prompt {
    $p = Split-Path -leaf -path (Get-Location)
        Write-Host "PS $p>"  -NoNewLine
        $GLOBAL:nowPath = (Get-Location).Path
        if (($nowPath -ne $oldDir) -AND $GLOBAL:addToStack) {
            $GLOBAL:dirStack.Push($oldDir)
                $GLOBAL:oldDir = $nowPath
        }
    $GLOBAL:AddToStack = $true
        return ' '
}

function BackOneDir {
    $lastDir = $GLOBAL:dirStack.Pop()
        $GLOBAL:addToStack = $false
        cd $lastDir
}

function CustomCd {
    if ($args.Count -eq 0) {
        $tmpPath = ${HOME}
    }
    elseif ($args[0] -eq '-') {
        BackOneDir
    }
    else {
        $tmpPath= $args[0]
    }
    if ($tmpPath) {
        Set-Location $tmpPath
    }
}
Set-Alias cd CustomCd -Option AllScope

# rm -rf equivalent in Windows
function CustomRm {
	Remove-Item -Recurse -Force $args
}
Set-Alias rm CustomRm -Option AllScope
