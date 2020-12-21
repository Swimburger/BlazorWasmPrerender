Remove-Item -Path .\Prerender\output -Recurse
dotnet publish -c Release -o Prerender/output
Push-Location .\Prerender
npx react-snap
Pop-Location