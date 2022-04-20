# Lee los command-line arguments
param ( [Parameter()] [String]$archivo,
[Parameter()] [Int]$clase,
[Parameter()] [Switch]$module,
[Parameter()] [Switch]$help,
[Parameter()] [String]$t)

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

$e = ([char]27)

function main {
    if ($help) { hmsg }
    if ($t) { Copy-Item ("tp"+$t+".hs") "tmp.hs"
              if ($?) {Get-Content ("tests/tp"+$t+"-test.hs") >> tmp.hs} else {exit 1}
              if ($?) {run; exit 0} else {exit 1}}
    
    if (!$archivo) {$archivo = Read-Host "Nombre de tu archivo (ej. Clase1.hs)";}
    if (!$clase) {$clase = Read-Host "Numero de clase contra la cual comparar";}

    # Reconstruye el nombre del test a partir de la clase
    [String]$clase = "clase" + $clase + "-test.hs"

    if ($module) {
        "import " + (Get-Culture).TextInfo.ToTitleCase($archivo.Replace(".hs", "")) > tmp.hs
        if ($?) {Get-Content $clase >> tmp.hs} else {Write-Host "E01: Algo salio mal" -n; Read-Host; exit 1}
        if ($?) {Run -m} else {Write-Host "E02: Algo salio mal" -n}; Read-Host; exit 2}

    Copy-Item $archivo -destination "tmp.hs"
    if ($?) {Get-Content $clase >> tmp.hs} else {Write-Host "E03: Algo salio mal" -n; Read-Host; exit 3}
    if ($?) {Run} else {Write-Host "E04: Algo salio mal" -n; Read-Host; exit 4}

    Read-Host "Presiona cualquier tecla para terminar"}

function run {
    param ([Parameter()] [Switch]$m)
    ghc --make tmp.hs; .\tmp.exe;
    if ($m) {Remove-Item -Force *.o, *.hi}
    Remove-Item -Force tmp*}
    
function hmsg { Write-Host "
    $e[0;30;103m Test de funciones del Taller de Haskell para Algebra I $e[0m`n
    $e[38;5;11mUso: ./tester.sh -a archivo.hs -c n [-m]$e[0m
    $e[0;93m-a$e[0m: el nombre del archivo de haskell (.hs) el cual se quiere verificar.
    $e[0;93m-c$e[0m: el numero de la clase a la cual el archivo corresponde.
    $e[0;93m-m$e[0m: Si el archivo a testear es un modulo, es necesario usar -m.

    Ejemplo: $e[0;93m./tester.ps1 -a Clase4.hs -c 4 $e[0m
    Si las funciones estan contenidas en un modulo: $e[0;93m./tester.ps1 -a Clase4.hs -c 4 -m $e[0m

    Para mas informacion: https://github.com/FacundoLema/taller-haskell`n"
    exit 0; }

main