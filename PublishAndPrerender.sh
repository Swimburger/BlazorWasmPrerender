#!/bin/bash
rm -rf Prerender/output
dotnet publish Client/BlazorWasmPrerender.csproj -c Release -o Prerender/output
pushd Prerender
npx react-snap
find . -name "*.html" | while read htmlFile; do
    sed -i 's/<base href="\/"/<base href="\/GitHubPagesDemo\/"/g' $htmlFile
done
popd