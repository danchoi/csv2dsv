{-# LANGUAGE OverloadedStrings, RecordWildCards #-} 

module Main where

import Data.Conduit
import Data.Conduit.Binary (sourceFile, sinkFile)
import Data.Conduit.List as CL
import Data.CSV.Conduit
import Data.Text (Text)

-- Just reverse te columns
myProcessor :: Monad m => Conduit (Row Text) m (Row Text)
myProcessor = CL.map reverse

main :: IO ()
main = runResourceT $ 
  transformCSV defCSVSettings 
               (sourceFile "input.csv") 
               myProcessor
               (sinkFile "output.csv")



{- 

https://hackage.haskell.org/package/conduit-extra
https://hackage.haskell.org/package/conduit-extra-1.1.9.2/docs/Data-Conduit-Binary.html
https://hackage.haskell.org/package/conduit

-}

