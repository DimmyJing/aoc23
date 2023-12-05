import Data.List (intersect)

parse :: String -> Int
parse s = (\(x, y) f -> length ((f x :: [Int]) `intersect` f y)) (span ('|' /=) (dropWhile (':' /=) s)) (map read . words . drop 1)

part1 :: [String] -> Int
part1 = sum . map (flip div 2 . (2 ^) . parse)

rec :: [Int] -> [String] -> Int
rec lst [] = 0
rec (h : t) (s : r) = h + rec [v + sum [h | idx < parse s] | (idx, v) <- zip [0 ..] t] r

part2 :: [String] -> Int
part2 s = rec (1 <$ [1 .. length s]) s

main :: IO ()
main = interact ((++ "\n") . show . part2 . lines)
