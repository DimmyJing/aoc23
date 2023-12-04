import Data.Char (isDigit)
import Data.List (groupBy, nub, sort)

get :: [String] -> Int -> Int -> Char
get s i j = if i >= 0 && i < length s && j >= 0 && j < length (head s) then s !! i !! j else '.'

search :: [String] -> Int -> Int -> [(Char, Int, Int)]
search s i j = [(v, i', j') | i' <- [i - 1 .. i + 1], j' <- [j - 1 .. j + 1], let v = get s i' j', v /= '.', not $ isDigit v]

takeN :: [String] -> Int -> Int -> (Int, [(Char, Int, Int)])
takeN s i j | not (isDigit (s !! i !! j)) = (0, [])
takeN s i j | j > 0 && isDigit (s !! i !! (j - 1)) = (0, [])
takeN s i j = let n = takeWhile isDigit (drop j (s !! i)) in (read n, concatMap (search s i) [j .. j + length n - 1])

takeAll :: [String] -> [(Int, [(Char, Int, Int)])]
takeAll s = [v | i <- [0 .. length s - 1], j <- [0 .. length (head s) - 1], let v = takeN s i j, snd v /= []]

part1 :: [String] -> Int
part1 s = sum (map fst (takeAll s))

gears :: [String] -> [(Int, Int, Int)]
gears s = [(i, j, v) | (v, lst) <- takeAll s, (_, i, j) <- nub (filter (\(x, _, _) -> x == '*') lst)]

groups :: [String] -> [[(Int, Int, Int)]]
groups s = groupBy (\(i, j, _) (k, l, _) -> i == k && j == l) (sort (gears s))

part2 :: [String] -> Int
part2 s = sum (map (\((_, _, i) : (_, _, j) : _) -> i * j) (filter ((==) 2 . length) (groups s)))

main :: IO ()
main = interact ((++ "\n") . show . part2 . lines)
