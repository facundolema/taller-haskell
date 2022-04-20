module Clase3 where

    fib :: Integral a => a -> a
    fib 0 = 0; fib 1 = 1
    fib n = fib (n-1) + fib (n-2)

    parteEntera :: (Ord a, Floating a, Integral b) => a -> b
    parteEntera x | x < 1 && x > 0 = 0
                  | otherwise = 1 + parteEntera (x-1)

    mult3 :: Integral a => a -> Bool
    mult3 x | x == 3 = True
            | x > 3 = mult3 (x-3)
            | otherwise = False

    sumaImpares :: Int -> Int
    sumaImpares x | x < 0 = undefined
                  | x == 0 = 0
                  | otherwise = (2*x-1) + sumaImpares(x-1)

    medioFact :: Integer -> Integer
    medioFact 0 = 1
    medioFact 1 = 1
    medioFact x = x * medioFact(x-2)

    sumdig :: Integer -> Integer
    sumdig x | x < 10 = x
             | otherwise = x `mod` 10 + sumdig(x `div` 10)

    todosIguales :: Integer -> Bool
    todosIguales x | x < 0 = todosIguales (-x)
                   | x < 10 = True
                   | x `mod` 10 == (x `div` 10) `mod` 10 = todosIguales(x `div` 10)
                   | otherwise = False

    --------------------------------------------------------------------------
                                {- one-liners -}
    --------------------------------------------------------------------------

    fib' :: Integral a => a -> a
    fib' x = if elem x [0,1] then x else fib' (x-1) + fib' (x-2)

    parteEntera' :: (Ord a, Floating a, Integral b) => a -> b
    parteEntera' x = if x < 1 && x > 0 then 0 else 1 + parteEntera' (x-1)

    mult3' :: Integral a => a -> Bool
    mult3' x = x == 3 || if x > 3 then mult3' (x-3) else False

    sumaImpares' :: Int -> Int
    sumaImpares' x = if x==0 then 0 else (2*x-1) + sumaImpares' (x-1)

    medioFact' :: Integer -> Integer
    medioFact' x = if elem x [0,1] then x else x * medioFact' (x-2)

    sumdig' :: Integer -> Integer
    sumdig' x = if x < 10 then x else x `mod` 10 + sumdig' (x `div` 10)

    tigual :: Integer -> Bool
    tigual x = if x<0 then tigual(-x) else False || x < 10 || if mod x 10 == mod (div x 10) 10 then tigual(div x 10) else False