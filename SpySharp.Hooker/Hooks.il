.assembly SpySharp.Hooker {}
.module SpySharp.Hooker.dll

.method public static pinvokeimpl("Kernel32.dll" cdecl)
native int LoadLibrary (string lpFileName) cil managed preservesig {}
