@echo off
title Optimize RAM Usage
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Clearing standby memory list...
PowerShell -Command "& { $code = @'
using System;
using System.Runtime.InteropServices;
public class MemClear {
    [DllImport(\"ntdll.dll\")] public static extern int NtSetSystemInformation(int InfoClass, IntPtr Info, int Length);
    public static void ClearStandby() { var gc = GCHandle.Alloc(1, GCHandleType.Pinned); NtSetSystemInformation(80, gc.AddrOfPinnedObject(), 4); gc.Free(); }
}
'@; Add-Type -TypeDefinition $code; [MemClear]::ClearStandby() }" >nul 2>&1

echo Adjusting virtual memory settings...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul 2>&1

echo Setting processor scheduling to Programs...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul

echo.
echo RAM optimization applied.
pause
