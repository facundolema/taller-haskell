# Lee los command-line arguments
param ( [Parameter()] [String]$archivo,
        [Parameter()] [Int]$clase,
        [Parameter()] [Switch]$module,
        [Parameter()] [Switch]$help)

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

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

if ($module) {
    # El nombre del módulo es el mismo que el del archivo sin la extensión (.hs)
    $moduleName = $archivo.Substring(0, $archivo.Length - 3)
    # Pone la primera letra del módulo en mayuscula y lo importa
    "import " + (Get-Culture).TextInfo.ToTitleCase($moduleName) > tmp.hs;
    # Incluye el test correspondiente
    Get-Content $clase >> tmp.hs}
else {Copy-Item $archivo -destination "tmp.hs"; Get-Content $clase >> tmp.hs}

# Compila y ejecuta tmp.hs
ghc --make tmp.hs
.\tmp.exe

# Clean-up
Remove-Item -force tmp.hs, tmp.o, tmp.hi, tmp.exe
if ($module) {Remove-Item -force clase1.o, clase1.hi}

Read-Host "Presiona cualquier tecla para terminar"