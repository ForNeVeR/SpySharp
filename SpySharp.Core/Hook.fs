namespace SpySharp.Core

open System

type Hook private (hookHandle : nativeint) =
    static member create (windowHandle : nativeint) =
        let thread = Win32.getWindowThreadId windowHandle
        let library = Win32.loadLibrary "SpySharp.Hooker.dll"
        let procedure = Win32.getProcAddress library "HookProc"
        // TODO: Unload library?
        let hookHandle = Win32.setWindowsHookEx Win32.WH_CALLWNDPROC procedure library thread

        new Hook (hookHandle)

    interface IDisposable with
        member __.Dispose () =
            Win32.unhookWindowsHookEx hookHandle
