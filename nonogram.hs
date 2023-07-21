import Data.List
--ROWS_VALUES = [[2], [4], [6], [4, 3], [5, 4], [2, 3, 2], [3, 5], [5], [3], [2], [2], [6]]
--COLS_VALUES = [[3], [5], [3, 2, 1], [5, 1, 1], [12], [3, 7], [4, 1, 1, 1], [3, 1, 1], [4], [2]]

--https://www.researchgate.net/figure/a-shows-an-example-of-a-Nonogram-Its-solution-is-shown-in-b-The-description-for_fig3_228862924

type State = Bool
type Block = [Int]
type Line  = [Block]

-- TIPO EMPTY? mudar o state

fill,cross :: State
fill  = True
cross = False

-- (0,0) is the top left corner
rows,collumns :: Line
rows = [ [2,1],[1,3],[1,2],[3],[4],[1] ]
collumns = [ [1],[5],[2],[5],[2,1],[2] ]

delAll x l = [a | a <- l, a /= x]

extra  = flip take $ repeat [cross]

-- filtro para manter a mesma ordem relativa
-- usado apra gerar as permutações

--orel i = ( == i ) . delAll [cross]
orel = (. delAll [cross]) . (==)


perm n l = filter (orel l) $ permutations (pack n l) 

pack n l = l ++ replicate x [cross]
    where x = n - (length $ concat l)


crossPares []    = []
crossPares [a]   = [a]
crossPares (h:t) = (h ++ [cross]) : crossPares t

makeFill = crossPares . map (`replicate` fill)

--inserir espaços a toa para gerar todas as cenas

-- all possibilities
--ap :: Line -> Int -> [Line]
ap line n = makeFill line
