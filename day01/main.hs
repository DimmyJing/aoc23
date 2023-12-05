import Data.Bifunctor (first)
import Data.List (find, isPrefixOf, isSuffixOf)

rn :: [(String, Int)]
rn = zip (show <$> [0 .. 9]) [0 ..]

match :: [(String, Int)] -> String -> Int
match wd s = maybe (match wd (drop 1 s)) snd (find (flip isPrefixOf s . fst) wd)

calc :: [(String, Int)] -> [String] -> Int
calc n l = sum $ (\s -> match n s * 10 + match (first reverse <$> n) (reverse s)) <$> l

part1 :: [String] -> Int
part1 = calc rn

part2 :: [String] -> Int
part2 = calc $ zip ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"] [0 ..] ++ rn

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
