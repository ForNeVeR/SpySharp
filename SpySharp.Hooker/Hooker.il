.assembly extern mscorlib { auto }
.assembly extern System { auto }
.assembly SpySharp.Hooker {}
.module SpySharp.Hooker.dll

.method public static pinvokeimpl("Kernel32.dll" cdecl)
native int LoadLibrary (string lpFileName) cil managed preservesig {}

.namespace SpySharp.Hooker {
    .class public Hook {
        .method public static class SpySharp.Hooker.Hook Create(native int handle) {
            ldstr "SpySharp.Hooker.dll"
            call native int LoadLibrary (string)
            box native int
            call void [System]System.Diagnostics.Debug::WriteLine (object)
            // TODO: Call GetProcAddress
            // TODO: Call SetWindowsHookEx
            // TODO: Unload library?
            ldnull
            ret
        }

        // TODO: Define hook function
    }
}
