import Data.Char (isDigit)
import Data.List (isPrefixOf, tails)

get :: String -> String -> Int
get col s = if col `isPrefixOf` s then read $ reverse $ takeWhile isDigit (dropWhile (not . isDigit) s) else 0

proc :: String -> String -> Int
proc col = foldr (max . get (reverse col)) 0 . tails . reverse

procA :: String -> (Int, Int, Int)
procA s = (proc "red" s, proc "green" s, proc "blue" s)

part1 :: [String] -> Int
part1 = sum . zipWith (\idx (a, b, c) -> fromEnum (a <= 12 && b <= 13 && c <= 14) * idx) [1 ..] . map procA

part2 :: [String] -> Int
part2 = sum . map ((\(a, b, c) -> a * b * c) . procA)

main :: IO ()
main = interact $ (++ "\n") . show . part2 . lines
