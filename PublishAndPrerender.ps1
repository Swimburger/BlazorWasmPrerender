If(Test-Path .\Prerender\output)
{
    Remove-Item -Path .\Prerender\output -Recurse
}

dotnet publish .\Client\BlazorWasmPrerender.csproj -c Release -o Prerender/output
Push-Location .\Prerender
npx react-snap
Get-ChildItem ".\output\wwwroot\*.html" -Recurse | ForEach-Object { 
    (Get-Content -Path $_.FullName -Raw) `
        -replace '<base href="/"','<base href="/GitHubPagesDemo/"' | `
        Set-Content -Path $_.FullName
}
Pop-Location