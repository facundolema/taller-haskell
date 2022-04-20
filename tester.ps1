# Lee los command-line arguments
param ( [Parameter()] [String]$archivo,
        [Parameter()] [Int]$clase,
        [Parameter()] [Switch]$module,
        [Parameter()] [Switch]$help,
        [Parameter()] [Switch]$tp1)

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

function Run {
    param ([Parameter()] [Switch]$m)
    ghc --make tmp.hs; .\tmp.exe;
    if ($m) {Remove-Item -Force *.o, *.hi}
    Remove-Item -Force tmp*}

if ($tp1) {Copy-Item "tp1.hs" -destination "tmp.hs"; Get-Content "tp1test.txt" >> tmp.hs; Run}

Read-Host "Presiona cualquier tecla para terminar"

[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

if ($help) {
    Write-Host "
    $([char]27)[0;30;103m Test de funciones del Taller de Haskell para Algebra I $([char]27)[0m

    Uso: .\tester.ps1 -archivo archivo.hs -clase n [-module | -m]

    $([char]27)[4;93mArgumentos$([Char]27)[0;93m:$([Char]27)[0m tester.ps1 toma dos argumentos obligatorios, -archivo (-a) y 
    -clase (-c).

    $([char]27)[0;93m-archivo$([char]27)[0m: el nombre del archivo de haskell (.hs) el cual se quiere verificar,
    incluyendo su extension.
    
    $([char]27)[0;93m-clase$([char]27)[0m: el numero de la clase a la cual el archivo corresponde. Es necesario
    para saber que funciones evaluar. Este argumento es de tipo [Int].

    $([char]27)[4;93mFlags$([char]27)[0;93m$([char]27)[0m: tester.ps1 tiene una flag, -module (-m). Si el archivo a testear es
    un modulo (es decir, si el archivo contiene 'module ModuleName where'), es
    es necesario usar la flag -modulo (-m).

    Ejemplo: dado un archivo Clase4.hs, correspondiente a los ejercicios de la
    clase 4, el cual contiene un modulo llamado Clase4 con todas las funciones,
    deberia usarse:
        
        $([char]27)[0;93m.\tester.ps1 -archivo Clase4.hs -clase 4 -m $([char]27)[0m

    Si las funciones de Clase4.hs estan contenidas en un modulo, entonces:
    
        $([char]27)[0;93m.\tester.ps1 -archivo Clase4.hs -clase -m $([char]27)[0m

    Para ver este mensaje de nuevo: .\tester.ps1 -h | .\tester.ps1 -help
    
    Para mas informacion: https://github.com/FacundoLema/taller-haskell`n"
    exit 1}
    
# Warning
if ($module) {Write-Host "El modulo y el archivo deben tener el mismo nombre!" -f "yellow"}

# Obtiene el nombre del archivo y a que clase pertenece si argc = 0
if (!$archivo) {$archivo = Read-Host "Nombre de tu archivo (ej. Clase1.hs)";}
if (!$clase) {$clase = Read-Host "Numero de clase contra la cual comparar";}

# Reconstruye el nombre del test a partir de la clase
[String]$clase = "clase" + $clase + "-test.hs"

<#  Si alguien tiene otra forma (mejor) que no sea if ($?) {...} else {...}
    para chequear si la funcion anterior fue exitosa y ejecutar la siguiente
    en consecuencia, es bienvenido   #>

if ($module) {
    "import " + (Get-Culture).TextInfo.ToTitleCase($archivo.Replace(".hs", "")) > tmp.hs
    if ($?) {Get-Content $clase >> tmp.hs} else {Write-Host "E01: Algo salio mal" -n; Read-Host; exit 1}
    if ($?) {Run -m} else {Write-Host "E02: Algo salio mal" -n}; Read-Host; exit 2}

Copy-Item $archivo -destination "tmp.hs"
if ($?) {Get-Content $clase >> tmp.hs} else {Write-Host "E03: Algo salio mal" -n; Read-Host; exit 3}
if ($?) {Run} else {Write-Host "E04: Algo salio mal" -n; Read-Host; exit 4}

Read-Host "Presiona cualquier tecla para terminar"