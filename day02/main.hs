import Data.Char (isDigit)
import Data.List (isPrefixOf, tails)

get :: String -> String -> Int
get col s = if col `isPrefixOf` s then read (reverse (takeWhile isDigit (dropWhile (not . isDigit) s))) else 0

proc :: String -> String -> Int
proc col s = foldr (max . get (reverse col)) 0 (tails (reverse s))

procA :: String -> (Int, Int, Int)
procA s = (proc "red" s, proc "green" s, proc "blue" s)

part1 :: [String] -> Int
part1 s = sum (zipWith (\idx (a, b, c) -> if a <= 12 && b <= 13 && c <= 14 then idx else 0) [1 ..] (map procA s))

part2 :: [String] -> Int
part2 s = sum (map ((\(a, b, c) -> a * b * c) . procA) s)

main :: IO ()
main = interact ((++ "\n") . show . part2 . lines)
