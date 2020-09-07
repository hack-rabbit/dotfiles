Set-Alias v nvim
Set-Alias ll dir
Set-Alias htop ntop
Set-Alias ifconfig ipconfig
Set-Alias reboot Restart-Computer
Set-Alias which where.exe
Set-Alias wget wget.exe -Option AllScope
Set-Alias curl curl.exe -Option AllScope
Set-Alias jadx C:\jadx-1.1.0\bin\jadx-gui.bat
Set-Alias grep findstr.exe
Set-Alias python32 C:\Users\thegr\AppData\Local\Programs\Python\Python38-32\python.exe
Set-Alias ghidra ghidraRun.bat
Set-Alias windbg "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe"
Set-Alias cdb "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\cdb.exe"
Set-Alias windbg32 "C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\windbg.exe"
Set-Alias cdb32 "C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\cdb.exe"
Set-Alias python3 "C:\Python38\python.exe"
Set-Alias python2 "C:\Python27\python.exe"
Set-Alias python python2 -Option AllScope

function upper {
    Set-Location ..
}
Set-Alias .. upper

function home {
	Set-Location ~
}
Set-Alias ~ home

function root {
	Set-Location C:\
}
Set-Alias / root

function chrome {
	& 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe' --ignore-certificate-errors
}

function gdb {
	gdb.exe -q $args
}

function stop_pc {
	shutdown.exe /s /t 0
}
Set-Alias shutdown stop_pc -Option AllScope

# Amazon AWS
function ec2 {
	ssh -i C:\Users\thegr\.key\ec2-ubuntu-18.pem ubuntu@3.34.191.61
}

# virtual machines
function u16 {
	ssh user@192.168.71.128
}

function u18 {
	ssh user@192.168.71.129
}

function u20 {
	ssh user@192.168.71.130
}

function inco {
	ssh root@incognito.spr.io
}
