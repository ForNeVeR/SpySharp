.assembly extern mscorlib { auto }
.assembly extern System { auto }
.assembly SpySharp.Hooker {}
.module SpySharp.Hooker.dll

.method assembly static native int modopt ([mscorlib]System.Runtime.CompilerServices.CallConvStdcall) HookProc(
    int32 nCode,
    native int lParam,
    native int wParam) {
    .vtentry 1 : 1
    .export [1] as HookProc

    ldc.i4.0
    ret
}
