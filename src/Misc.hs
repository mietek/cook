module Misc where
  
import System.Environment (getArgs)

interactArgs :: ([String] -> String -> String) -> IO ()
interactArgs f = do
    args <- getArgs
    s <- getContents
    putStr (f args s)
