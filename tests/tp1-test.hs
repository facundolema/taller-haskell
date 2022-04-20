
color :: Bool -> String
color True = "\ESC[38;5;83m"
color False = "\ESC[38;5;210m"

d = "\ESC[0m"

main = do
    let e1 = satisfaceCollatz 13 10 && not (satisfaceCollatz 1121 35) && satisfaceCollatz 1 2
    let e2 = not (satisfaceCollatzHasta 88 50) && satisfaceCollatzHasta 26 100 && satisfaceCollatzHasta 1 2
    let e3 = cantidadTerminosPares 13 == 7 && cantidadTerminosPares 88 == 13 && cantidadTerminosPares 1121 == 31
    let e4 = largoSecuencia 13 == 9 && largoSecuencia 5 == 5 && largoSecuencia 27 == 111 && largoSecuencia 1121 == 44
    let e5 = secuenciaMasLargaHasta 13 == 9 && secuenciaMasLargaHasta 30 == 27 && secuenciaMasLargaHasta 88 == 73 && secuenciaMasLargaHasta 1121 == 871
    putStrLn $ "Ejercicio 1: " ++ color e1 ++ show (e1) ++ d;
    putStrLn $ "Ejercicio 2: " ++ color e2 ++ show (e2) ++ d;
    putStrLn $ "Ejercicio 3: " ++ color e3 ++ show (e3) ++ d;
    putStrLn $ "Ejercicio 4: " ++ color e4 ++ show (e4) ++ d;
    putStrLn $ "Ejercicio 5: " ++ color e5 ++ show (e5) ++ d;