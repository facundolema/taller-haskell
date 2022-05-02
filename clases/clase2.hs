module Class2 where

    import Data.List (findIndex)

    estanRelacionados :: Real a => a -> a -> Bool
    estanRelacionados x y = (x<=3 && y<=3) || (x>3 && x<=7 && y>3 && y<=7) || (x>7 && y>7)

    prodInt :: Real a => (a, a) -> (a, a) -> a
    prodInt (x1, y1) (x2, y2) = x1*x2 + y1*y2

    todoMenor :: Real a => (a, a) -> (a, a) -> Bool
    todoMenor (x1, y1) (x2, y2) = x1 < x2 && y1 < y2

    distanciaPuntos :: Floating a => (a, a) -> (a, a) -> a
    distanciaPuntos (x1, y1) (x2, y2) = sqrt((x1-x2)^2 + (y1-y2)^2)

    sumaTerna :: Integral a => (a, a, a) -> a
    sumaTerna (x, y, z) = x + y + z

    posicPrimerPar :: Integral a => (a, a, a) -> Int
    posicPrimerPar (x, y, z) | even x = 1
                             | even y = 2
                             | even z = 3
                             | otherwise = 4
    
    crearPar :: a -> b -> (a, b)
    crearPar x y = (x, y)

    invertir :: (a, b) -> (b, a)
    invertir (x, y) = (y, x)

    -- one-liner
    posicPrimerPar' :: Integral a => (a, a, a) -> Int
    posicPrimerPar' (x, y, z) = case findIndex even [x, y, z] of Just n -> n + 1; Nothing -> 4

    -- escalable
    posicPrimerPar'' :: [Int] -> Int
    posicPrimerPar'' a = case findIndex even a of Just n -> n+1; Nothing -> -1