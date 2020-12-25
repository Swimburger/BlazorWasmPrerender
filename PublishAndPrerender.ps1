If(Test-Path .\Prerender\output)
{
    Remove-Item -Path .\Prerender\output -Recurse
}

dotnet publish .\Client\BlazorWasmPrerender.csproj -c Release -o Prerender/output --nologo
Push-Location .\Prerender
npx react-snap
Get-ChildItem ".\output\wwwroot\*.html" -Recurse | ForEach-Object { 
    $HtmlFileContent = (Get-Content -Path $_.FullName -Raw);
    #$HtmlFileContent = $HtmlFileContent.Replace('<base href="/"','<base href="/BlazorWasmPrerender/"')
    $HtmlFileContent = $HtmlFileContent.Replace('<script type="text/javascript">var Module; window.__wasmmodulecallback__(); delete window.__wasmmodulecallback__;</script><script src="_framework/dotnet.5.0.1.js" defer="" integrity="sha256-SWZOE2EsCqc/7dPgJrcFqUvVvdeJ9cipeZ2NFMC9v2s=" crossorigin="anonymous"></script>','')
    Set-Content -Path $_.FullName -Value $HtmlFileContent
}
Pop-Location