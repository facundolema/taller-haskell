module Clase8 where

    import Clase4 (factorial)
    import Clase6 (longitud)
    import Clase7 (atoset, partes)
    import Data.List (nub)

    type Set a = [a]

    combinatorio' :: Integral a => a -> a -> a
    combinatorio' n k = factorial n `div` (factorial (n-k) * factorial k)
    
    combinatorio n k | k == 0 || n == k = 1
                     | k == 1 || k == n-1 = n
                     | otherwise = combinatorio (n-1) k + combinatorio (n-1) (k-1)


    variaciones xs 1 = v xs [[]] 
    variaciones xs n = v xs (variaciones xs (n-1))

    v [a] l = atoset a l
    v (x:xs) l = atoset x l ++ v xs l

    insertarEn :: [Int] -> Int -> Int -> [Int]
    insertarEn (x:xs) n i | longitud (x:xs) < i = (x:xs) ++ [n]
                          | i == 1 = n : x : xs
                          | otherwise = x : insertarEn xs n (i-1)

    -- Elimina un elemento de un conjunto
    eliminar :: Integral a => a -> Set a -> Set a
    eliminar x xs = filter (/= x) xs

    {-- explicación de permutaciones: 
        permutaciones [a] = [ [a] ]
        permutaciones [b,a] = [ [a,b], [b,a] ]
        permutaciones [c,b,a] = [ [c,a,b], [c,b,a], [b,c,a], [b,a,c], [a,b,c], [a,c,b] ]

        es decir, las permutaciones de [a,b,c] son las permutaciones de:
        [a] ++ permutaciones [b,c] ++
        [b] ++ permutaciones [a,c] ++
        [c] ++ permuactiones [a,b]

        o, en general, para una lista A = [a1, a2, a3, a4, ..., aN], las permutaciones de:
        [a1] ++ permutaciones (A sin a1) ++
        [a2] ++ permutaciones (A sin a2) ++
        ...
        [aN] ++ permutaciones (A sin aN)

        atoset añade x a cada elemento (lista) de una conjunto (lista de listas).
        per se encarga de ejecutar atoset para cada a en [a1..aN] sobre ([a1..aN] - a)
    --}

    -- Genera todas las permutaciones posibles de los elementos de un conjunto
    permutaciones :: Integral a => Set a -> Set (Set a)
    permutaciones [] = [[]]
    permutaciones s = per s (length s - 1)

    -- Añade n a permutaciones ( (x:xs) - n ) para cada n en (x:xs)
    per :: Integral a => Set a -> Int -> Set (Set a)
    per (x:xs) 0 = atoset x (permutaciones xs)
    per s i = atoset (s!!i) (permutaciones $ eliminar (s!!i) s) ++ per s (i-1)

    subconjuntos :: Integral a => Set a -> Int -> Set (Set a)
    subconjuntos s n = filter (\x -> length x == n) (partes s)

    permutaciones' :: Integral a => Set a -> Set (Set a)
    permutaciones' xs = [[x,y,z] | x <- xs, y <- xs, z <- xs]