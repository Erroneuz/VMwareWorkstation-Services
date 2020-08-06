:: v1.0
:: Change following services to manually start via services.msc: VMware Authorization Service, VMware DHCP Service, VMware NAT Service, VMware USB Arbitration Service & VMware Workstation Server
:: Change path to vmware.exe if necessary
:: Batch file needs to run with Administrator privileges - Will add check in v1.1
@echo off
color 3f
echo Start/Stop VMware Workstation
echo.
echo 1. Start services and execute VMware Workstation
echo 2. Stop services and kill VMware Workstation
echo.
choice /c:12 /M "1 or 2?"

If errorlevel 1 if not errorlevel 2 goto start
If errorlevel 2 if not errorlevel 3 goto stop

:start
echo.
sc start VMnetDHCP
sc start "VMware NAT Service"
sc start VMwareHostd
Echo Waiting for services to start...
TIMEOUT 3
start "" "%PROGRAMFILES(x86)%\VMware\VMware Workstation\vmware.exe"
goto end

:stop
echo.
sc stop "VMware NAT Service"
sc stop VMnetDHCP
sc stop	VMwareHostd
sc stop VMUSBArbService
sc stop VMAuthdService
TIMEOUT 1
sc stop "VMware NAT Service"
sc stop VMnetDHCP
sc stop	VMwareHostd
sc stop VMUSBArbService
sc stop VMAuthdService
taskkill /IM vmware.exe
goto end

:end
::cya