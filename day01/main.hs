import Data.Bifunctor (first)
import Data.List (find, isPrefixOf, isSuffixOf)

rn :: [(String, Int)]
rn = zip (map show [0 .. 9]) [0 ..]

match :: [(String, Int)] -> String -> Int
match wd s = case find (flip isPrefixOf s . fst) wd of Just n -> snd n; Nothing -> match wd (drop 1 s)

calc :: [(String, Int)] -> [String] -> Int
calc n l = sum $ map (\s -> match n s * 10 + match (map (first reverse) n) (reverse s)) l

part1 :: [String] -> Int
part1 = calc rn

part2 :: [String] -> Int
part2 = calc $ zip ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"] [0 ..] ++ rn

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
