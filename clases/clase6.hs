module Clase6 where

    -- Sumatoria de todos los elementos de una lista
    sumatoria :: Integral a => [a] -> a
    sumatoria [] = 0
    sumatoria (x:xs) = x + sumatoria xs

    -- Cantidad de elementos de una lista
    longitud :: Integral a => [a] -> a
    longitud [] = 0
    longitud (_:xs) = 1 + longitud xs

    -- Comprueba si pertenece un número a una lista
    pertenece :: Integral a => a -> [a] -> Bool
    pertenece _ [] = False
    pertenece n (x:xs) | x == n = True
                       | otherwise = pertenece n xs

    productoria :: Integral a => [a] -> a
    productoria [] = 1
    productoria (x:xs) = x * productoria xs

    -- Suma n a cada elemento de la lista
    sumarN :: Integral a => a -> [a] -> [a]
    sumarN _ [] = []
    sumarN n (x:xs) = n+x : sumarN n xs

    -- Encuentra el último número de una lista
    ultimo :: [a] -> a
    ultimo [x] = x
    ultimo (x:xs) = ultimo xs

    sumarElPrimero :: Integral a => [a] -> [a]
    sumarElPrimero (x:xs) = sumarN x (x:xs)

    sumarElUltimo :: [Int] -> [Int]
    sumarElUltimo [x] = [2*x]
    sumarElUltimo (x:xs) = x + (ultimo xs) : sumarElUltimo xs

    -- Suma el último elemento de la lista todos los elementos de la lista
    sumaUltimo' :: [Int] -> [Int]
    sumaUltimo' [] = []
    sumaUltimo' l = sumarN (ultimo l) l 

    -- Elimina los numeros impares
    pares :: Integral a => [a] -> [a]
    pares [] = []
    pares (x:xs) | even x = x : pares xs
                 | otherwise = pares xs

    -- Remueve la primer aparición de un elemento en una lista
    quitar :: Integral a => a -> [a] -> [a]
    quitar _ [] = []
    quitar n (x:xs) | x == n = xs
                    | otherwise = x : quitar n xs
    
    -- Remueve todas las apariciónes de un elemento en una lista
    quitarTodas :: Integral a => a -> [a] -> [a]
    quitarTodas _ [] = []
    quitarTodas n (x:xs) | x == n = quitarTodas n xs
                         | otherwise = x : quitarTodas n xs

    -- Evalúa si hay elementos repetidos en la lista
    hayRepetidos :: Integral a => [a] -> Bool
    hayRepetidos [] = False
    hayRepetidos (x:xs) | pertenece x xs = True
                        | otherwise = hayRepetidos xs

    -- Deja la primera aparición del elemento repetido
    eliminarRepetidosAlFinal :: Integral a => [a] -> [a]
    eliminarRepetidosAlFinal [] = []
    eliminarRepetidosAlFinal (x:xs) | pertenece x xs = x : (eliminarRepetidosAlFinal $ quitarTodas x xs)
                                    | otherwise = x : eliminarRepetidosAlFinal xs
    
    -- Deja la última aparición del elemento repetido
    eliminarRepetidosAlInicio :: Integral a => [a] -> [a]
    eliminarRepetidosAlInicio [] = []
    eliminarRepetidosAlInicio (x:xs) | pertenece x xs = eliminarRepetidosAlInicio xs 
                                     | otherwise = x : eliminarRepetidosAlInicio xs
    maximo :: Integral a => [a] -> a
    maximo [x] = x
    maximo (x:xs) | x > maximo xs = x
                  | otherwise = maximo xs
    maximo'' :: Integral a => [a] -> a
    maximo'' [x] = x
    maximo'' (x:xs) | x > head xs = maximo'' (x: tail xs)
                    | otherwise = maximo'' xs

    ordenar :: Integral a => [a] -> [a]
    ordenar [] = []
    ordenar l = ml : (ordenar $ quitar ml l) where ml = minimo l

    -- Devuelve una lista con su orden invertido
    reverso :: Integral a => [a] -> [a]
    reverso [] = []
    reverso (x:xs) = reverso xs ++ [x]

    -- Concatena dos listas
    concatenar :: Integral a => [a] -> [a] -> [a]
    concatenar [] l = l
    concatenar (x:xs) l = x : concatenar xs l

    zipi [] _ = []; zipi _ [] = []
    zipi (x:xs) (y:ys) = (x, y) : zipi xs ys

    sultimo l = s (longitud l - 1) l 0 where s n l c = if n==c then [] else head l : (s n (tail l) (c+1))

    --------------------------------------------------------------------------
                                {- one-liners -}
    --------------------------------------------------------------------------

    sumatoria' :: Integral a => [a] -> a
    sumatoria' l = if null l then 0 else (head l + sumatoria' (tail l))
    
    -- asumiendo que la longitud es > 0
    longitud' :: Integral a => [a] -> a
    longitud' l = if null l then 0 else (1 + longitud' (tail l))

    pertenece' :: Integral a => a -> [a] -> Bool
    pertenece' n l = if null l then False else n == head l || pertenece' n (tail l)

    pm45345 :: Integral a => [a] -> a
    pm45345 (x:xs) = if mod x 45345 == 0 then x else pm45345 xs

    productoria' :: Integral a => [a] -> a
    productoria' (x:xs) = if null xs then x else x * productoria' xs

    sumarN' :: Integral a => a -> [a] -> [a]
    sumarN' n (x:xs) = if null xs then [x+n] else n+x : sumarN' n xs
    
    sumarN'' :: Integral a => a -> [a] -> [a]
    sumarN'' n (x:xs) = map (n+) (x:xs)

    ultimo' :: [a] -> a
    ultimo' (x:xs) = if null xs then x else ultimo' xs

    sumarElPrimero' :: Integral a => [a] -> [a]
    sumarElPrimero' (x:xs) = sumarN' x (x:xs)

    sumarElUltimo' :: [Int] -> [Int]
    sumarElUltimo' (x:xs) = if null xs then [x*2] else x+(ultimo' xs):sumarElUltimo' xs

    pares' :: Integral a => [a] -> [a]
    pares' (x:xs) = if null (x:xs) then [] else if even x then x : pares' xs else pares' xs

    quitar' :: Integral a => a -> [a] -> [a]
    quitar' n (x:xs) = if null (x:xs) then [] else if x==n then xs else x : quitar' n xs

    quitarTodas' :: Integral a => a -> [a] -> [a]
    quitarTodas' n (x:xs) = if null (x:xs) then [] else if x==n then quitarTodas' n xs else x:quitarTodas' n xs

    hayRepetidos' :: Integral a => [a] -> Bool
    hayRepetidos' (x:xs) = if null (x:xs) then False else pertenece x xs || hayRepetidos xs

    maximo' :: Integral a => [a] -> a
    maximo' l = m l 0 where m [] n = n; m (x:xs) n = if n > x then m xs n else m xs x

    minimo :: Integral a => [a] -> a
    minimo l = m l (head l) where m [] n = n; m (x:xs) n = if n < x then m xs n else m xs x

    ordenar' :: Integral a => [a] -> [a]
    ordenar' l = if null l then [] else ml : (ordenar' $ quitar ml l) where ml = minimo l

    reverso' :: Integral a => [a] -> [a]
    reverso' (x:xs) = if null xs then [x] else reverso' xs ++ [x]

    concatenar' :: Integral a => [a] -> [a] -> [a]
    concatenar' (x:xs) l = if null (x:xs) then l else x : concatenar' xs l