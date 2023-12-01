import Data.Bifunctor (first)
import Data.List (find, isPrefixOf, isSuffixOf)

ns :: [String]
ns = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

nums :: [(String, Int)]
-- nums = zip (map show [0 .. 9]) [0 .. 9] -- part 1
nums = zip ns [0 ..] ++ zip (map show [0 .. 9]) [0 .. 9]

match :: [(String, Int)] -> String -> Int
match wd s = case find (flip isPrefixOf s . fst) wd of Just n -> snd n; Nothing -> match wd (drop 1 s)

calc :: [String] -> Int
calc l = sum (map (\s -> match nums s * 10 + match (map (first reverse) nums) (reverse s)) l)

main :: IO ()
main = interact ((++ "\n") . show . calc . lines)
