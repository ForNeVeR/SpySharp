module SpySharp.Core.Win32

open System
open System.Runtime.InteropServices

[<Literal>]
let WH_CALLWNDPROC : int32 = 4

let private checkHandle functionName handle =
    if handle = IntPtr.Zero then
        failwithf "%s error %d" functionName <| Marshal.GetLastWin32Error ()
    else
        handle

[<DllImport("User32")>]
extern uint32 GetWindowThreadProcessId(nativeint hWnd, nativeint lpdwProcessId)

let getWindowThreadId (windowHandle : nativeint) : uint32 =
    GetWindowThreadProcessId (windowHandle, IntPtr.Zero)

[<DllImport("Kernel32", SetLastError = true)>]
extern nativeint LoadLibrary(string lpFileName)

let loadLibrary (name : string) : nativeint =
    checkHandle "LoadLibrary" <| LoadLibrary name

[<DllImport("Kernel32", SetLastError = true)>]
extern nativeint GetProcAddress(nativeint hModule, string lpProcName)

let getProcAddress (moduleHandle : nativeint) (name : string) : nativeint =
    checkHandle "GetProcAddress" <| GetProcAddress (moduleHandle, name)

[<DllImport("User32", SetLastError = true)>]
extern nativeint SetWindowsHookEx(int32 idHook, nativeint lpfn, nativeint hMod, uint32 dwThreadId)

let setWindowsHookEx (hookId : int32)
                     (procHandle : nativeint)
                     (moduleHandle : nativeint)
                     (threadId : uint32) : nativeint =
    checkHandle "SetWindowsHookEx" <| SetWindowsHookEx (hookId, procHandle, moduleHandle, threadId)

[<DllImport("User32", SetLastError = true)>]
extern bool UnhookWindowsHookEx(nativeint hhk)

let unhookWindowsHookEx (hookHandle : nativeint) : unit =
    let fail = UnhookWindowsHookEx hookHandle
    if fail then
        failwithf "UnhookWindowsHookEx error %d" <| Marshal.GetLastWin32Error ()
