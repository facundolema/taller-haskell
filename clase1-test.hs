
color :: Bool -> String
color True = "\ESC[38;5;83m"
color False = "\ESC[38;5;210m"

main = do
  let d = "\ESC[0m"
  let abs = absoluto (-1) == 1 && absoluto 1 == 1 && absoluto 0 == 0
  let mabs = maximoabsoluto (-1) (-2) == 2 && maximoabsoluto 1 (-2) == 2 &&
             maximoabsoluto 1 2 == 2 && maximoabsoluto 0 0 == 0
  let max3 = maximo3 1 2 3 == 3 && maximo3 (-2) 3 1 == 3 && maximo3 1 (-3) (-2) == 1
  let es0 = algunoEs0 0 1 && algunoEs0 1 0 && algunoEs0 0 0 && not (algunoEs0 1 1)
  let son0 = ambosSon0 0 0 && not (ambosSon0 1 0) && not (ambosSon0 0 1) && not (ambosSon0 1 1)
  let mult = esMultiploDe 9 3 && not (esMultiploDe 3 9) && not (esMultiploDe 9 2)
  let dunidad = digitoUnidades 12345 == 5 && digitoUnidades 123456 == 6
  let ddecenas = digitoDecenas 12345 == 4 && digitoDecenas 1234567 == 6
  putStrLn ("absoluto: " ++ color abs ++ show(abs) ++ d)
  putStrLn ("maximoabsoluto: " ++ color mabs ++ show(mabs) ++ d)
  putStrLn ("maximo3: " ++ color max3 ++ show(max3) ++ d)
  putStrLn ("algunoEs0: " ++ color es0 ++ show(es0) ++ d)
  putStrLn ("ambosSon0: " ++ color son0 ++ show(son0) ++ d)
  putStrLn ("esMultiploDe: " ++ color mult ++ show(mult) ++ d)
  putStrLn ("digitoUnidades: " ++ color dunidad ++ show(dunidad) ++ d)
  putStrLn ("digitoDecenas: " ++ color ddecenas ++ show(ddecenas) ++ d)