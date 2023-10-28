import Data.List
--ROWS_VALUES = [[2], [4], [6], [4, 3], [5, 4], [2, 3, 2], [3, 5], [5], [3], [2], [2], [6]]
--COLS_VALUES = [[3], [5], [3, 2, 1], [5, 1, 1], [12], [3, 7], [4, 1, 1, 1], [3, 1, 1], [4], [2]]

--https://www.researchgate.net/figure/a-shows-an-example-of-a-Nonogram-Its-solution-is-shown-in-b-The-description-for_fig3_228862924

data State = Fill | Cross | Unk deriving (Show, Eq)
type Block = [Int]
type Line  = [Block]

rows,collumns :: Line
rows = [ [2,1],[1,3],[1,2],[3],[4],[1] ]
collumns = [ [1],[5],[2],[5],[2,1],[2] ]

crossPares []    = []
crossPares [a]   = [a]
crossPares (h:t) = (h ++ [Cross]) : crossPares t

makeFill = crossPares . map (`replicate` Fill)

delAll x l = [a | a <- l, a /= x]

extra  = flip take $ repeat [Cross]


-- filtro para manter a mesma ordem relativa usado apra gerar as permutações
--orel i = ( == i ) . delAll [cross]
orel = (. delAll [Cross]) . (==)


pack n l = l ++ replicate x [Cross]
    where x = n - (length $ concat l)


-- all possibel line states
perm n l = nub $ filter (orel l) $ permutations (pack n l) 


umequal (h:t) = all (h ==) t

eqcomm (i,l)
    | umequal l = (i,head l)
    | otherwise = (i, Unk )


commons = map eqcomm . zip [0..] . transpose . map concat

--commons ll = map eqcomm simple
--    where 
--        simple = zip [0..] $ transpose $ concat ll

gera n l = commons $ perm n $ makeFill l

--   linha possível, linha existente = 
--merge l1 l2 = 
