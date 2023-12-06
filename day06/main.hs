test :: [(Int, Int)] -> Int
test = product . map (\(a, b) -> sum [1 | i <- [0 .. a - 1], i * (a - i) > b])

part1 :: [String] -> Int
part1 = test . uncurry zip . (\[a, b] -> (a, b)) . map (map read . words . dropWhile (' ' /=))

part2 :: [String] -> Int
part2 = test . (\[a, b] -> [(a, b)]) . map (read . filter (`elem` ['0' .. '9']))

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
