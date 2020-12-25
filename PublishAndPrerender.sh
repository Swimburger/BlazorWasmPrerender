#!/bin/bash
rm -rf Prerender/output
dotnet publish Client/BlazorWasmPrerender.csproj -c Release -o Prerender/output --nologo
pushd Prerender
npx react-snap
find ./output -name "*.html" | while read htmlFile; do
    #sed -i 's/<base href="\/"/<base href="\/BlazorWasmPrerender\/"/g' $htmlFile
    sed -i 's/<script type="text\/javascript">var Module; window.__wasmmodulecallback__(); delete window.__wasmmodulecallback__;<\/script><script src="_framework\/dotnet.5.0.1.js" defer="" integrity="sha256-SWZOE2EsCqc\/7dPgJrcFqUvVvdeJ9cipeZ2NFMC9v2s=" crossorigin="anonymous"><\/script>//g' $htmlFile
done
popd