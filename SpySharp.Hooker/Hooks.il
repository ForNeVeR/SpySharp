.assembly SpySharp.Hooker {}
.module SpySharp.Hooker.dll

.method public static pinvokeimpl("Kernel32.dll" cdecl)
native int LoadLibrary (string lpFileName) cil managed preservesig {}

.namespace SpySharp.Hooker {
    .class public Hook {
        .method public static class SpySharp.Hooker.Hook Create(native int handle) {
            ldnull
            ret
        }
    }
}
