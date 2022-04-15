module Clase4 where
    
    import Data.Function (fix)

    sumatoria :: Integral a => a -> a
    sumatoria 1 = 1
    sumatoria n = n + sumatoria (n-1)
     
    factorial :: Integral a => a -> a
    factorial 0 = 1
    factorial n = n * factorial (n-1)

    eAprox :: Integer -> Float
    eAprox 0 = 1
    eAprox n = (1 / fromIntegral (factorial n)) + eAprox (n-1)

    e :: Float
    e = eAprox 10

    f1 :: Integral a => a -> a
    f1 0 = 1
    f1 n = 2^n + f1 (n-1)

    f2 :: (Integral a, Real b) => a -> b -> b
    f2 1 q = q
    f2 n q = q^n + f2 (n-1) q

    f3 :: (Integral a, Real b) => a -> b -> b
    f3 1 q = q^2 + q
    f3 n q = q^(2*n) + q^(2*n-1) + f3 (n-1) q

    f4 :: (Integral a, Real b) => a -> b -> b
    f4 1 q = q^2
    f4 n q = q^(2*n) + q^(2*n-1) - q^n + f4 (n-1) q

    f5 :: Integral a => a -> a -> a
    f5 1 m = f2 m 1
    f5 n m = f2 m n + f5 (n-1) m

    f6 :: Integral a => a -> a -> a -> a
    f6 q 0 m = 0
    f6 q n m = f q (n+1) (n+m) + f6 q (n-1) m where f q n m = if n==m then q^n else q^m + f q n (m-1)

    f7 :: (Eq a, Fractional a) => a -> a -> a
    f7 0 m = 0
    f7 n m = d n m + f7 (n-1) m where d p q = if q==1 then p else p/q + d p (q-1)

    g1 :: Integral a => a -> a -> a
    g1 i n = if n == i then i^n else i^n + g1 i (n-1)

    g2 :: Integral a => a -> a
    g2 n = g2a n n

    g2a :: Integral a => a -> a -> a
    g2a 1 n = n
    g2a i n = g1 i n + g2a (i-1) n

    g3 :: Integral a => a -> a
    g3 n | n < 1 = 0
         | even n = 2^n + g3 (n-2)
         | otherwise = g3 (n-1)

    g4 :: Integral a => a -> a
    g4 n | n < 10 = sumatoria n
         | g4a n = n + g4 (n-1)
         | otherwise = g4 (n-1)

    g4a :: Integral a => a -> Bool
    g4a n | n < 10 = True
          | mod n 10 == div (mod n 100) 10 = g4a (div n 10)
          | otherwise = False

    {-- one-liners --}

    sumatoria' :: Integral a => a -> a
    sumatoria' n = if n == 1 then 1 else n + sumatoria' (n-1)

    factorial' :: Integral a => a -> a
    factorial' n = if n == 1 then 1 else n * factorial' (n-1)

    eAprox' :: Integer -> Float
    eAprox' n = if n == 0 then 1 else (1/fromIntegral(factorial n)) + eAprox' (n-1)

    -- f1 es un caso especial de f2
    f1' :: (Integral a, Real b) => a -> b
    f1' n = f2' n 2 + 1

    f2' :: (Integral a, Real b) => a -> b -> b
    f2' n q = if n == 1 then q else q^n + f2' (n-1) q 

    f3' :: (Integral a, Real b) => a -> b -> b
    f3' n q = if n == 0 then 0 else q^(2*n) + q^(2*n-1) + f3' (n-1) q
    
    -- f4 es f3 - f2
    f4' :: (Integral a, Real b) => a -> b -> b
    f4' n q = f3' n q - f2' n q

    f5' :: Integral a => a -> a -> a
    f5' n m = if n == 0 then 0 else f2' m n + f5' (n-1) m

    -- if, fixed point, lambda y recursion. https://bit.ly/3rry0ZL
    f6' :: Integral a => a -> a -> a -> a
    f6' q n m = if n==0 then 0 else fix (\f q n m -> if n==m then q^n else q^m + f q n (m-1)) q (n+1) (n+m) + f6' q (n-1) m

    -- f6 como f2 desde n hasta n+m (f2 a n+m - f2 a n)
    f6' :: Integral a => a -> a -> a -> a
    f6'' q n m = if n==0 then 0 else f2 (n+m) q - f2 n q + f6'' q (n-1) m

    f7' :: (Eq a, Enum a, Fractional a) => a -> a -> a
    f7' n m = if m==0 then 0 else sum (map (\x -> x/m) [1..n]) + f7' n (m-1) 

    g1' :: Integral a => a -> a -> a
    g1' i n = if n == i then i^n else i^n + g1' i (n-1)

    g2' :: Integral a => a -> a
    g2' n = f n n where f i n = if i==1 then n else g1' i n + f (i-1) n

    -- alternativa con fix y lambda
    g2'' :: Integral a => a -> a
    g2'' n = fix (\f i n -> if i==1 then n else g1' i n + f (i-1) n) n n

    -- antes de nestear ifs es peferible usar guardas
    g3' :: Integral a => a -> a
    g3' n = if n < 1 then 0 else (if even n then 2^n + g3' (n-2) else g3' (n-1))

    g4' :: Integral a => a -> a
    g4' n = if n<10 then sumatoria n else (if f n then n + g4' (n-1) else g4' (n-1)) where f n = n<10 || (if mod n 10 == div (mod n 100) 10 then f (div n 10) else False)