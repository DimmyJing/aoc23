import Data.Char (isDigit)
import Data.Function (on)
import Data.List (groupBy, sort)

parse :: [String] -> Int -> [(Int, [Int])]
parse [] _ = []
parse (x : r) n | null x || not (isDigit (head x)) = parse r (n + 1)
parse (x : r) n = (n, read <$> words x) : parse r n

conv :: [String] -> [[(Int, Int, Int)]]
conv s = sort . map (\(x, [i, j, k]) -> (j, j + k - 1, i - j)) <$> groupBy ((==) `on` fst) (parse s 0)

seeds :: String -> [Int]
seeds = map read . words . drop 7

trans :: [(Int, Int, Int)] -> (Int, Int) -> [(Int, Int)]
trans _ (a, b) | a > b = []
trans [] b = [b]
trans ((c, d, e) : r) (a, b) | a < c && c <= b = (a, c - 1) : (c + e, min b d + e) : trans r (min b d + 1, b)
trans ((c, d, e) : r) (a, b) | c <= a && a <= d = (a + e, min b d + e) : trans r (min b d + 1, b)
trans (_ : r) b = trans r b

transA :: ([Int] -> [(Int, Int)]) -> [String] -> Int
transA f s = fst $ minimum $ foldl (\b r -> b >>= trans r) (f $ seeds $ head s) (conv s)

part1 :: [String] -> Int
part1 = transA $ map (\x -> (x, x))

part2 :: [String] -> Int
part2 = transA (\e -> map (\((x, y), _) -> (x, x + y - 1)) $ filter (odd . snd) $ zip (zip e $ tail e) [1 ..])

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
