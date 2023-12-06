import Data.List (elemIndex, intersect)

parse :: String -> Int
parse s = length $ uncurry intersect $ splitAt (sum $ elemIndex "|" $ words s) (words s)

rec :: [Int] -> [String] -> Int
rec lst [] = 0
rec (h : t) (s : r) = h + rec [v + sum [h | idx < parse s] | (idx, v) <- zip [0 ..] t] r

part1 :: [String] -> Int
part1 = sum . map (flip div 2 . (2 ^) . parse)

part2 :: [String] -> Int
part2 s = rec (1 <$ [1 .. length s]) s

main :: IO ()
main = interact ((++ "\n") . show . part2 . lines)
