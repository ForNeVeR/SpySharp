module SpySharp.Tests.HookerTests

open System
open System.Diagnostics
open System.IO
open System.Reflection

open Xunit

open SpySharp.Hooker

[<Fact>]
let ``HookWindow should be executed successfully`` () =
    let directory =
        Assembly.GetExecutingAssembly().CodeBase
        |> Uri
        |> (fun x -> x.AbsolutePath)
        |> Path.GetDirectoryName
        |> Path.GetFullPath
    let file = Path.Combine (directory, "SpySharp.Tests.App.exe")
    use ``process`` = Process.Start file
    try
        let handle = ``process``.MainWindowHandle
        let hook = Hook.Create handle

        Assert.NotNull hook
    finally
        ``process``.Kill ()
