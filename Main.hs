{-# LANGUAGE OverloadedStrings, RecordWildCards #-} 

module Main where
import Data.ByteString (ByteString)
import Data.Conduit
import Data.Conduit.Binary (sourceHandle, sinkHandle)
import Data.Conduit.List as CL
import Data.CSV.Conduit
import Data.Text (Text)
import System.Environment
import System.IO (stdout, stdin, Handle, openFile, IOMode(..))
import Options.Applicative
import Control.Applicative

process :: Monad m => Conduit (Row Text) m (Row Text)
process = CL.map id

data Conf = Conf {
    delimiter :: Char
  , source :: String
  }

main :: IO ()
main = do
  Conf{..} <- execParser opts
  let outCSVSettings = CSVSettings delimiter Nothing
  source' <- case source of
              "-" -> return stdin
              f -> openFile f ReadMode
  runResourceT $ 
      transformCSV' defCSVSettings 
                  outCSVSettings
                   (sourceHandle source') 
                   process
                   (sinkHandle stdout)

opts = info (helper <*> parseOpts)
          (fullDesc 
            <> progDesc "Converts CSV to DSV format"
            <> header "csv2dsv"
            <> footer "See https://github.com/danchoi/csv2dsv for more information.")

parseOpts :: Parser Conf 
parseOpts = Conf 
    <$> (Prelude.head <$>  
          strOption (value "\t" 
                <> short 'd'
                <> long "delimiter"
                <> metavar "CHAR"
                <> help "Delimiter characters. Defaults to \\t."))
    <*> strArgument (metavar "FILE" <> help "Source CSV file. '-' for STDIN")
   



{- 

https://hackage.haskell.org/package/conduit-extra
https://hackage.haskell.org/package/conduit-extra-1.1.9.2/docs/Data-Conduit-Binary.html
https://hackage.haskell.org/package/conduit
http://hackage.haskell.org/package/csv-conduit

-}

