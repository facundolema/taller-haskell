module Clase1 where

    -- Valor absoluto de un número entero
    absoluto :: Integral a => a -> a
    absoluto x = if x < 0 then -x else x

    -- Valor absoluto de un número entero (guards)
    absoluto' :: Integral a => a -> a
    absoluto' x | x < 0 = -x
                | otherwise = x

    {-- Para maximoabsoluto uso where para evitar calcular 
    absoluto del mismo número dos veces. No es necesario,
    pero ahorra tiempo (es una computación menos para hacer).
    En una sola vuelta, la diferencia es insignificante,
    pero si mapean la función sobre una lista larga, se nota --}

    -- Máximo entre el valor absoluto de dos números enteros
    maximoabsoluto :: Integral a => a -> a -> a
    maximoabsoluto x y = if a >= b then a else b where a = absoluto x; b = absoluto y

    -- Máximo entre el valor absoluto de dos números enteros (guards)
    maximoabsoluto' :: Integral a => a -> a -> a
    maximoabsoluto' x y | a >= b = a
                        | otherwise = b
                        where a = absoluto x
                              b = absoluto y

    -- Máximo entre tres números enteros
    maximo3 :: Integral a => a -> a -> a -> a
    maximo3 x y z | x >= y && y >= z = x
                  | y > z = y
                  | otherwise = z

    -- Verifica si alguno de los dos números es cero
    algunoEs0 :: RealFrac a => a -> a -> Bool
    algunoEs0 x y = x == 0 || y == 0

    -- Verifica si alguno de los dos números es cero usando pattern matching
    algunoEs0' :: RealFrac a => a -> a -> Bool
    algunoEs0' 0 _ = True
    algunoEs0' _ 0 = True
    algunoEs0' _ _ = False

    -- Verifica si ambos números son cero
    ambosSon0 :: RealFrac a => a -> a -> Bool
    ambosSon0 x y = x == 0 && y == 0

    -- Verifica si ambos números son cero usando pattern mathing
    ambosSon0' :: RealFrac a => a -> a -> Bool
    ambosSon0' 0 0 = True
    ambosSon0' _ _ = False

    -- Verifica si el primer número es multiplo del segundo
    esMultiploDe :: Integral a => a -> a -> Bool
    esMultiploDe x y = x `mod` y == 0

    -- Extrae digito unidades
    digitoUnidades :: Integral a => a -> a
    digitoUnidades x = mod x 10

    -- Extrae digito decenas
    digitoDecenas :: Integral a => a -> a
    digitoDecenas x = div (mod x 100) 10