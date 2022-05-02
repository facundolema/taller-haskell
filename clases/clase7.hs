module Clase7 where
    
    import Clase6 (pertenece, eliminarRepetidosAlFinal, ultimo)
    import Data.List hiding (union)
    import Data.Ord
    import Control.Monad

    type Set a = [a]

    incluido :: Integral a => Set a -> Set a -> Bool
    incluido [] _ = True
    incluido (x:xs) s | pertenece x s = incluido xs s
                      | otherwise = False

    iguales :: Integral a => Set a -> Set a -> Bool
    iguales s1 s2 = incluido s1 s2 && incluido s2 s1

    union :: Integral a => Set a -> Set a -> Set a
    union s1 s2 = eliminarRepetidosAlFinal $ u s1 s2
                  where u [] s = s; u (x:xs) s = x:u xs s
    
    interseccion :: Integral a => Set a -> Set a -> Set a
    interseccion [] _ = []
    interseccion (x:xs) s | pertenece x s = x : interseccion xs s
                          | otherwise = interseccion xs s

    diferencia :: Integral a => Set a -> Set a -> Set a
    diferencia [] _ = []
    diferencia (x:xs) s | pertenece x s = diferencia xs s
                        | otherwise = x : diferencia xs s

    diferenciaSimetrica :: Integral a => Set a -> Set a -> Set a
    diferenciaSimetrica s1 s2 = union (diferencia s1 s2) (diferencia s2 s1)

    partes :: Integral a => Set a -> Set (Set a)
    partes [] = [[]]
    partes (x:xs) = sortBy (comparing length) (atoset x (partes xs) ++ partes xs)

    atoset :: Integral a => a -> Set (Set a) -> Set (Set a)
    atoset n [] = []
    atoset n (x:xs) = (n:x) : (atoset n xs)

    partesN :: Integral a => a -> Set (Set a)
    partesN n = partes [1..n]

    tlista :: Integral a => a -> Set a -> Set (a, a)
    tlista _ [] = []
    tlista n (x:xs) = (n,x) : tlista n xs

    productoCartesiano :: Integral a => Set a -> Set a -> Set (a, a)
    productoCartesiano [] s = []
    productoCartesiano (x:xs) s = tlista x s ++ productoCartesiano xs s

    --------------------------------------------------------------------------
                                {- one-liners -}
    --------------------------------------------------------------------------
    
    incluido' :: Integral a => Set a -> Set a -> Bool
    incluido' s1 s2 = all (`elem` s2) s1
    
    union' :: Integral a => Set a -> Set a -> Set a
    union' s1 s2 = nub (s1++s2)

    interseccion' :: Integral a => Set a -> Set a -> Set a
    interseccion' s1 s2 = filter (`elem` s2) s1

    diferencia' :: Integral a => Set a -> Set a -> Set a
    diferencia' s1 s2 = filter (not . (`elem` s2)) s1

    -- Monads
    partes' :: Integral a => Set a -> Set (Set a)
    partes' s = filterM (const [True, False]) s

    -- foldr y map
    partes'' :: Integral a => Set a -> Set (Set a)
    partes'' s = foldr (\n s -> s ++ map (n:) s) [[]] s

    productoCartesiano' :: Integral a => Set a -> Set a -> Set (a, a)
    productoCartesiano' s1 s2 = [(x, y) | x <- s1, y <- s2]