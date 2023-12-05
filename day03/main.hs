import Data.Char (isDigit)
import Data.List (groupBy, nub, sort)

get :: [String] -> Int -> Int -> Char
get s i j = if i >= 0 && i < length s && j >= 0 && j < length (head s) then s !! i !! j else '.'

search :: [String] -> Int -> Int -> [(Char, Int, Int)]
search s i j = [(v, k, l) | k <- [i - 1 .. i + 1], l <- [j - 1 .. j + 1], let v = get s k l, v /= '.', not $ isDigit v]

takeN :: [String] -> Int -> Int -> (Int, [(Char, Int, Int)])
takeN s i j | not (isDigit $ s !! i !! j) || (j > 0 && isDigit (s !! i !! (j - 1))) = (0, [])
takeN s i j = let n = takeWhile isDigit $ drop j $ s !! i in (read n, [j .. j + length n - 1] >>= search s i)

takeAll :: [String] -> [(Int, [(Char, Int, Int)])]
takeAll s = [v | i <- [0 .. length s - 1], j <- [0 .. length (head s) - 1], let v = takeN s i j, snd v /= []]

part1 :: [String] -> Int
part1 = sum . map fst . takeAll

gears :: [String] -> [(Int, Int, Int)]
gears s = [(i, j, v) | (v, lst) <- takeAll s, (_, i, j) <- nub $ filter (\(x, _, _) -> x == '*') lst]

groups :: [String] -> [[(Int, Int, Int)]]
groups = groupBy (\(i, j, _) (k, l, _) -> i == k && j == l) . sort . gears

part2 :: [String] -> Int
part2 = sum . map (\((_, _, i) : (_, _, j) : _) -> i * j) . filter ((==) 2 . length) . groups

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
