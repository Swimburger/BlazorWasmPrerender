#!/bin/bash
rm -rf Prerender/output
dotnet publish Client/BlazorWasmPrerender.csproj -c Release -o Prerender/output --nologo
pushd Prerender
npx react-snap
find . -name "*.html" | while read htmlFile; do
    sed -i 's/<base href="\/"/<base href="\/BlazorWasmPrerender\/"/g' $htmlFile
done
popd