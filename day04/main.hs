import Data.List (intersect)

parse :: String -> Int
parse s = (\(x, y) f -> length ((f x :: [Int]) `intersect` f y)) (span ('|' /=) (dropWhile (':' /=) s)) (map read . words . drop 1)

part1 :: [String] -> Int
part1 = sum . map (flip div 2 . (2 ^) . parse)

part2rec :: [Int] -> [String] -> Int
part2rec lst [] = sum lst
part2rec (h : t) (s : r) = h + part2rec [v + fromEnum (idx < parse s) * h | (idx, v) <- zip [0 ..] t] r

part2 :: [String] -> Int
part2 s = part2rec (replicate (length s) 1) s

main :: IO ()
main = interact ((++ "\n") . show . part1 . lines)
