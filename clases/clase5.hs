module Clase5 where

    import Data.Maybe (fromJust)
    import Data.List (find)
    import Data.Function (fix)
    import Clase4 (factorial)

    sumaDivisoresHasta :: Integral a => a -> a -> a
    sumaDivisoresHasta n 1 = 1
    sumaDivisoresHasta n d | mod n d == 0 = d + sumaDivisoresHasta n (d-1)
                           | otherwise = sumaDivisoresHasta n (d-1)
    
    sumaDivisores :: Integral a => a -> a
    sumaDivisores n = sumaDivisoresHasta n n
    
    menorDivisor :: Integral a => a -> a
    menorDivisor n = md n 2 where md n i | mod n i == 0 = i
                                         | otherwise = md n (i+1)

    esPrimo :: Integral a => a -> Bool
    esPrimo n = menorDivisor n == n

    primos :: Integral a => a -> a -> a -> a
    primos n i c | i==c = (n-1)
                 | esPrimo n = primos (n+1) i (c+1)
                 | otherwise = primos (n+1) i c

    nEsimoPrimo :: Integral a => a -> a
    nEsimoPrimo n = primos 2 n 0

    menorFactDesde n = fst $ fromJust $ find (\(x, y) -> y > n) [(x, factorial x) | x <- [1..]]
    fact n = foldl1 (*) [1..n]
    --------------------------------------------------------------------------
                                {- one-liners -}
    --------------------------------------------------------------------------

    -- con fix, lambda y recursión (también usa función auxiliar, pero anónima)
    sumaDivisores'' :: Integral a => a -> a
    sumaDivisores'' n = fix (\f n d -> if d==1 then 1 else if mod n d == 0 then d + f n (d-1) else f n (d-1)) n n

    -- one-liner
    menorDivisor' :: Integral a => a -> a
    menorDivisor' n = md n 2 where md n i = if mod n i == 0 then i else md n (i+1)

    -- usando sumaDivisores
    esPrimo' :: Integral a => a -> Bool
    esPrimo' n = sumaDivisores n == n+1

    nEsimoPrimo' :: Integral a => a -> a
    nEsimoPrimo' n = fix (\f n i c -> if (i==c) then (n-1) else if esPrimo n then f (n+1) i (c+1) else f (n+1) i c) 2 n 0

    nprimo :: Integral a => a -> a
    nprimo n = if n==1 then 2 else mp (1 + nprimo(n-1)) where mp n = if esPrimo n then n else mp(n+1)
    
    --------------------------------------------------------------------------
                    {- alternativas con list comprehension -}
    --------------------------------------------------------------------------

    -- divisores de n (sin el 1)
    divisores :: Integral a => a -> [a]
    divisores n = [d | d <- [2..n], mod n d == 0]

    -- divisores de n mayores a 1 y menores a sqrt(n)
    tdiv :: Integral a => a -> [a]
    tdiv n = [d | d <- [2..floor $ sqrt $ fromIntegral n], mod n d == 0]

    sumaDivisores_ :: Integral a => a -> a
    sumaDivisores_ n = 1 + (sum $ divisores n)

    menorDivisor_ :: Integral a => a -> a
    menorDivisor_ n = head $ divisores n

    esPrimo_ :: Integral a => a -> Bool
    esPrimo_ n = null $ tdiv n

    nEsimoPrimo_ :: Integral a => Int -> a
    nEsimoPrimo_ n = [p | p <- [2..], esPrimo_ p] !! (n-1)




